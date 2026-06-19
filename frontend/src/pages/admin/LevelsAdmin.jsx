import { Check, Pencil, Plus, Trash2, X } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import api from '../../api/api.js';

const emptyForm = { part_id: '', title: '', description: '', level_order: 1, is_paid: false, passing_score: 70 };
const pageSize = 6;

export default function LevelsAdmin() {
  const [levels, setLevels] = useState([]);
  const [modules, setModules] = useState([]);
  const [form, setForm] = useState(emptyForm);
  const [editingId, setEditingId] = useState(null);
  const [filterPartId, setFilterPartId] = useState('');
  const [page, setPage] = useState(1);
  const [error, setError] = useState('');

  useEffect(() => {
    loadAll();
  }, []);

  const parts = useMemo(
    () => modules.flatMap((module) => module.parts.map((part) => ({ ...part, module_title: module.title }))),
    [modules],
  );
  const filteredLevels = filterPartId ? levels.filter((level) => level.part_id === filterPartId) : levels;
  const rows = filteredLevels.slice((page - 1) * pageSize, page * pageSize);

  async function loadAll() {
    try {
      const [levelsRes, modulesRes] = await Promise.all([api.get('/api/admin/levels'), api.get('/api/admin/modules')]);
      setLevels(levelsRes.data);
      setModules(modulesRes.data);
      const firstPartId = modulesRes.data[0]?.parts[0]?.id || '';
      setForm((current) => ({ ...current, part_id: current.part_id || firstPartId }));
    } catch (err) {
      setError(err.message);
    }
  }

  async function submit(event) {
    event.preventDefault();
    setError('');

    try {
      if (editingId) await api.put(`/api/admin/levels/${editingId}`, form);
      else await api.post('/api/admin/levels', form);
      setForm({ ...emptyForm, part_id: form.part_id, level_order: levels.length + 1 });
      setEditingId(null);
      loadAll();
    } catch (err) {
      setError(err.message);
    }
  }

  async function remove(id) {
    setError('');
    try {
      await api.delete(`/api/admin/levels/${id}`);
      loadAll();
    } catch (err) {
      setError(err.message);
    }
  }

  function edit(level) {
    setEditingId(level.id);
    setForm({
      part_id: level.part_id || parts[0]?.id || '',
      title: level.title,
      description: level.description || '',
      level_order: level.level_order,
      is_paid: Boolean(level.is_paid),
      passing_score: level.passing_score,
    });
  }

  return (
    <section className="stack">
      <div className="page-title">
        <h1>Quiz admin</h1>
        <p>Creer les quiz par partie. L'ordre correspond au niveau du quiz dans la progression.</p>
      </div>

      {error && <p className="error">{error}</p>}

      <article className="panel admin-table-panel">
        <div className="analytics-header">
          <div>
            <h2>Quiz par partie</h2>
            <p>Ajoutez ou modifiez les quiz directement dans le tableau.</p>
          </div>
          <label>
            Filtrer par partie
            <select value={filterPartId} onChange={(event) => { setFilterPartId(event.target.value); setPage(1); }}>
              <option value="">Toutes les parties</option>
              {parts.map((part) => (
                <option key={part.id} value={part.id}>{part.module_title} / {part.title}</option>
              ))}
            </select>
          </label>
        </div>

        <div className="admin-table">
          <div className="table-head quiz-table-row">
            <span>Niveau</span>
            <span>Partie</span>
            <span>Titre</span>
            <span>Score</span>
            <span>Acces</span>
            <span>Actions</span>
          </div>

          <form className="table-edit-row quiz-table-row" onSubmit={submit}>
            <input type="number" value={form.level_order} onChange={(e) => setForm({ ...form, level_order: Number(e.target.value) })} />
            <select value={form.part_id} onChange={(e) => setForm({ ...form, part_id: e.target.value })}>
              {parts.map((part) => <option key={part.id} value={part.id}>{part.module_title} / {part.title}</option>)}
            </select>
            <div className="split-inputs">
              <input placeholder="Titre du quiz" value={form.title} onChange={(e) => setForm({ ...form, title: e.target.value })} />
              <input placeholder="Description" value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} />
            </div>
            <input type="number" value={form.passing_score} onChange={(e) => setForm({ ...form, passing_score: Number(e.target.value) })} />
            <label className="checkbox-line">
              <input type="checkbox" checked={form.is_paid} onChange={(e) => setForm({ ...form, is_paid: e.target.checked })} />
              Payant
            </label>
            <div className="row-actions">
              <button type="submit" aria-label={editingId ? 'Sauvegarder' : 'Ajouter'}>{editingId ? <Check size={17} /> : <Plus size={17} />}</button>
              {editingId && (
                <button className="secondary-btn" type="button" onClick={() => { setEditingId(null); setForm({ ...emptyForm, part_id: parts[0]?.id || '' }); }}>
                  <X size={17} />
                </button>
              )}
            </div>
          </form>

          {rows.map((level) => (
            <div className="table-data-row quiz-table-row" key={level.id}>
              <span>{level.level_order}</span>
              <span>{level.module_title ? `${level.module_title} / ${level.part_title}` : 'Non classe'}</span>
              <strong>{level.title}</strong>
              <span>{level.passing_score}%</span>
              <span>{level.is_paid ? 'Payant' : 'Gratuit'}</span>
              <div className="row-actions">
                <button type="button" onClick={() => edit(level)}><Pencil size={17} /></button>
                <button className="danger" type="button" onClick={() => remove(level.id)}><Trash2 size={17} /></button>
              </div>
            </div>
          ))}
        </div>

        <Pagination page={page} total={filteredLevels.length} onPageChange={setPage} />
      </article>
    </section>
  );
}

function Pagination({ page, total, onPageChange }) {
  const pages = Math.max(1, Math.ceil(total / pageSize));
  return (
    <div className="pagination">
      {Array.from({ length: pages }, (_, index) => index + 1).map((item) => (
        <button className={item === page ? 'active' : 'secondary-btn'} type="button" key={item} onClick={() => onPageChange(item)}>
          {item}
        </button>
      ))}
    </div>
  );
}
