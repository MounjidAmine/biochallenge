import { Check, Pencil, Plus, Trash2, X } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import api from '../../api/api.js';

const moduleEmpty = { title: '', description: '', module_order: 1 };
const partEmpty = { module_id: '', title: '', description: '', part_order: 1, source_files: '', keywords: '' };
const pageSize = 5;

export default function ModulesAdmin() {
  const [modules, setModules] = useState([]);
  const [moduleForm, setModuleForm] = useState(moduleEmpty);
  const [partForm, setPartForm] = useState(partEmpty);
  const [editingModuleId, setEditingModuleId] = useState(null);
  const [editingPartId, setEditingPartId] = useState(null);
  const [modulePage, setModulePage] = useState(1);
  const [partPage, setPartPage] = useState(1);
  const [error, setError] = useState('');

  useEffect(() => {
    loadModules();
  }, []);

  const parts = useMemo(
    () => modules.flatMap((module) => module.parts.map((part) => ({ ...part, module_id: module.id, module_title: module.title }))),
    [modules],
  );

  const moduleRows = paginate(modules, modulePage);
  const partRows = paginate(parts, partPage);

  async function loadModules() {
    try {
      const { data } = await api.get('/api/admin/modules');
      setModules(data);
      setPartForm((current) => ({ ...current, module_id: current.module_id || data[0]?.id || '' }));
    } catch (err) {
      setError(err.message);
    }
  }

  async function saveModule(event) {
    event.preventDefault();
    setError('');

    try {
      if (editingModuleId) await api.put(`/api/admin/modules/${editingModuleId}`, moduleForm);
      else await api.post('/api/admin/modules', moduleForm);
      setModuleForm({ ...moduleEmpty, module_order: modules.length + 1 });
      setEditingModuleId(null);
      loadModules();
    } catch (err) {
      setError(err.message);
    }
  }

  async function savePart(event) {
    event.preventDefault();
    setError('');

    const payload = {
      ...partForm,
      source_files: splitList(partForm.source_files),
      keywords: splitList(partForm.keywords),
    };

    try {
      if (editingPartId) await api.put(`/api/admin/parts/${editingPartId}`, payload);
      else await api.post('/api/admin/parts', payload);
      setPartForm({ ...partEmpty, module_id: modules[0]?.id || '', part_order: parts.length + 1 });
      setEditingPartId(null);
      loadModules();
    } catch (err) {
      setError(err.message);
    }
  }

  async function remove(kind, id) {
    setError('');
    try {
      await api.delete(kind === 'module' ? `/api/admin/modules/${id}` : `/api/admin/parts/${id}`);
      loadModules();
    } catch (err) {
      setError(err.message);
    }
  }

  function editModule(module) {
    setEditingModuleId(module.id);
    setModuleForm({
      title: module.title,
      description: module.description || '',
      module_order: module.module_order || modules.findIndex((item) => item.id === module.id) + 1,
    });
  }

  function editPart(part) {
    setEditingPartId(part.id);
    setPartForm({
      module_id: part.module_id,
      title: part.title,
      description: part.description || '',
      part_order: part.part_order || parts.findIndex((item) => item.id === part.id) + 1,
      source_files: part.sources?.map((source) => source.name).join(', ') || '',
      keywords: part.keywords?.join(', ') || part.slug,
    });
  }

  return (
    <section className="stack">
      <div className="page-title">
        <h1>Modules admin</h1>
        <p>Creer les modules, leurs parties, puis rattacher les quiz a chaque partie.</p>
      </div>

      {error && <p className="error">{error}</p>}

      <AdminTable
        title="Modules"
        columns={['Ordre', 'Module', 'Description', 'Parties', 'Actions']}
        page={modulePage}
        total={modules.length}
        onPageChange={setModulePage}
      >
        <form className="table-edit-row module-table-row" onSubmit={saveModule}>
          <input type="number" value={moduleForm.module_order} onChange={(e) => setModuleForm({ ...moduleForm, module_order: Number(e.target.value) })} />
          <input placeholder="Nom du module" value={moduleForm.title} onChange={(e) => setModuleForm({ ...moduleForm, title: e.target.value })} />
          <input placeholder="Description" value={moduleForm.description} onChange={(e) => setModuleForm({ ...moduleForm, description: e.target.value })} />
          <span>{editingModuleId ? 'Edition' : 'Nouveau'}</span>
          <RowButtons editing={editingModuleId} onCancel={() => { setEditingModuleId(null); setModuleForm(moduleEmpty); }} />
        </form>

        {moduleRows.map((module, index) => (
          <div className="table-data-row module-table-row" key={module.id}>
            <span>{(modulePage - 1) * pageSize + index + 1}</span>
            <strong>{module.title}</strong>
            <span>{module.description}</span>
            <span>{module.parts.length}</span>
            <ActionButtons onEdit={() => editModule(module)} onDelete={() => remove('module', module.id)} />
          </div>
        ))}
      </AdminTable>

      <AdminTable
        title="Parties"
        columns={['Ordre', 'Module', 'Partie', 'Fichiers / mots cles', 'Actions']}
        page={partPage}
        total={parts.length}
        onPageChange={setPartPage}
      >
        <form className="table-edit-row part-table-row" onSubmit={savePart}>
          <input type="number" value={partForm.part_order} onChange={(e) => setPartForm({ ...partForm, part_order: Number(e.target.value) })} />
          <select value={partForm.module_id} onChange={(e) => setPartForm({ ...partForm, module_id: e.target.value })}>
            {modules.map((module) => <option key={module.id} value={module.id}>{module.title}</option>)}
          </select>
          <input placeholder="Nom de la partie" value={partForm.title} onChange={(e) => setPartForm({ ...partForm, title: e.target.value })} />
          <div className="split-inputs">
            <input placeholder="fichiers: proteines.html" value={partForm.source_files} onChange={(e) => setPartForm({ ...partForm, source_files: e.target.value })} />
            <input placeholder="mots cles: proteines, protein" value={partForm.keywords} onChange={(e) => setPartForm({ ...partForm, keywords: e.target.value })} />
          </div>
          <RowButtons editing={editingPartId} onCancel={() => { setEditingPartId(null); setPartForm({ ...partEmpty, module_id: modules[0]?.id || '' }); }} />
        </form>

        {partRows.map((part, index) => (
          <div className="table-data-row part-table-row" key={part.id}>
            <span>{(partPage - 1) * pageSize + index + 1}</span>
            <span>{part.module_title}</span>
            <strong>{part.title}</strong>
            <span>{part.sources?.map((source) => source.name).join(', ') || part.slug}</span>
            <ActionButtons onEdit={() => editPart(part)} onDelete={() => remove('part', part.id)} />
          </div>
        ))}
      </AdminTable>
    </section>
  );
}

function AdminTable({ title, columns, page, total, onPageChange, children }) {
  return (
    <article className="panel admin-table-panel">
      <div className="section-head">
        <h2>{title}</h2>
        <Pagination page={page} total={total} onPageChange={onPageChange} />
      </div>
      <div className="admin-table">
        <div className={`table-head ${title === 'Modules' ? 'module-table-row' : 'part-table-row'}`}>
          {columns.map((column) => <span key={column}>{column}</span>)}
        </div>
        {children}
      </div>
    </article>
  );
}

function RowButtons({ editing, onCancel }) {
  return (
    <div className="row-actions">
      <button type="submit" aria-label={editing ? 'Sauvegarder' : 'Ajouter'}>
        {editing ? <Check size={17} /> : <Plus size={17} />}
      </button>
      {editing && (
        <button className="secondary-btn" type="button" onClick={onCancel} aria-label="Annuler">
          <X size={17} />
        </button>
      )}
    </div>
  );
}

function ActionButtons({ onEdit, onDelete }) {
  return (
    <div className="row-actions">
      <button type="button" onClick={onEdit}><Pencil size={17} /></button>
      <button className="danger" type="button" onClick={onDelete}><Trash2 size={17} /></button>
    </div>
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

function paginate(items, page) {
  return items.slice((page - 1) * pageSize, page * pageSize);
}

function splitList(value) {
  return String(value || '').split(',').map((item) => item.trim()).filter(Boolean);
}
