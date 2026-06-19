import { Check, ImagePlus, Pencil, Plus, Trash2, X } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import api from '../../api/api.js';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:4000';
const pageSize = 6;

const questionTypes = [
  'qcm_single',
  'qcm_multiple',
  'true_false',
  'text_answer',
  'fill_blank',
  'diagram_choice',
  'diagram_labeling',
  'matching',
  'ordering',
];

const emptyQuestion = {
  level_id: '',
  type: 'qcm_single',
  question_text: '',
  explanation: '',
  points: 1,
  image_url: '',
  options: [
    { option_text: '', is_correct: true, option_order: 1 },
    { option_text: '', is_correct: false, option_order: 2 },
  ],
  items: [{ label: '', correct_answer: '', item_order: 1 }],
};

function defaultsForType(type, levelId = '') {
  const base = {
    level_id: levelId,
    type,
    question_text: '',
    explanation: '',
    points: 1,
    image_url: '',
    options: [],
    items: [],
  };

  if (type === 'qcm_single' || type === 'diagram_choice') {
    return {
      ...base,
      options: [
        { option_text: '', is_correct: true, option_order: 1 },
        { option_text: '', is_correct: false, option_order: 2 },
      ],
    };
  }

  if (type === 'qcm_multiple') {
    return {
      ...base,
      options: [
        { option_text: '', is_correct: true, option_order: 1 },
        { option_text: '', is_correct: true, option_order: 2 },
        { option_text: '', is_correct: false, option_order: 3 },
      ],
    };
  }

  if (type === 'true_false') {
    return {
      ...base,
      options: [
        { option_text: 'Vrai', is_correct: true, option_order: 1 },
        { option_text: 'Faux', is_correct: false, option_order: 2 },
      ],
    };
  }

  return {
    ...base,
    items: [{ label: '', correct_answer: '', position_x: '', position_y: '', item_order: 1 }],
  };
}

export default function QuestionsAdmin() {
  const [searchParams] = useSearchParams();
  const [levels, setLevels] = useState([]);
  const [modules, setModules] = useState([]);
  const [questions, setQuestions] = useState([]);
  const [form, setForm] = useState(emptyQuestion);
  const [editingId, setEditingId] = useState(null);
  const [partFilter, setPartFilter] = useState(searchParams.get('part') || '');
  const [levelFilter, setLevelFilter] = useState('');
  const [page, setPage] = useState(1);
  const [error, setError] = useState('');

  useEffect(() => {
    Promise.all([api.get('/api/admin/levels'), api.get('/api/admin/modules')])
      .then(([levelRes, moduleRes]) => {
        setLevels(levelRes.data);
        setModules(moduleRes.data);
        setForm((current) => ({ ...current, level_id: levelRes.data[0]?.id || '' }));
      })
      .catch((err) => setError(err.message));
  }, []);

  useEffect(() => {
    loadQuestions(partFilter);
  }, [partFilter, modules.length]);

  const parts = useMemo(
    () => modules.flatMap((module) => module.parts.map((part) => ({ ...part, module_title: module.title }))),
    [modules],
  );

  const visibleQuestions = levelFilter
    ? questions.filter((question) => question.level_id === levelFilter)
    : questions;
  const rows = visibleQuestions.slice((page - 1) * pageSize, page * pageSize);

  async function loadQuestions(nextPartFilter = partFilter) {
    try {
      const part = findPartBySlugOrId(modules, nextPartFilter);
      const query = part ? `?part_id=${part.id}` : '';
      const { data } = await api.get(`/api/admin/questions${query}`);
      setQuestions(data);
      setPage(1);
    } catch (err) {
      setError(err.message);
    }
  }

  async function submit(event) {
    event.preventDefault();
    setError('');

    try {
      if (editingId) await api.put(`/api/admin/questions/${editingId}`, form);
      else await api.post('/api/admin/questions', form);
      setForm({ ...emptyQuestion, level_id: levels[0]?.id || '' });
      setEditingId(null);
      loadQuestions();
    } catch (err) {
      setError(err.message);
    }
  }

  async function remove(id) {
    setError('');

    try {
      await api.delete(`/api/admin/questions/${id}`);
      loadQuestions();
    } catch (err) {
      setError(err.message);
    }
  }

  function edit(question) {
    setEditingId(question.id);
    setForm(normalizeQuestionForEdit(question));
  }

  function cancelEdit() {
    setEditingId(null);
    setForm({ ...emptyQuestion, level_id: levels[0]?.id || '' });
  }

  return (
    <section className="stack">
      <div className="page-title">
        <h1>Questions admin</h1>
        <p>Ajoutez, modifiez et filtrez les questions directement dans un tableau pagine.</p>
      </div>

      {error && <p className="error">{error}</p>}

      <article className="panel admin-table-panel">
        <div className="analytics-header">
          <div>
            <h2>Questions</h2>
            <p>La ligne verte sert a creer ou modifier une question.</p>
          </div>
          <div className="filter-pair">
            <label>
              Partie
              <select value={partFilter} onChange={(event) => { setPartFilter(event.target.value); setLevelFilter(''); }}>
                <option value="">Toutes</option>
                {parts.map((part) => (
                  <option key={part.id} value={part.id}>
                    {part.module_title} / {part.title}
                  </option>
                ))}
              </select>
            </label>
            <label>
              Quiz
              <select value={levelFilter} onChange={(event) => { setLevelFilter(event.target.value); setPage(1); }}>
                <option value="">Tous</option>
                {levels
                  .filter((level) => !partFilter || level.part_id === findPartBySlugOrId(modules, partFilter)?.id)
                  .map((level) => (
                    <option key={level.id} value={level.id}>{level.title}</option>
                  ))}
              </select>
            </label>
          </div>
        </div>

        <div className="admin-table">
          <div className="table-head question-table-row">
            <span>Type</span>
            <span>Quiz</span>
            <span>Question</span>
            <span>Points</span>
            <span>Actions</span>
          </div>

          <form className="table-edit-row question-table-row" onSubmit={submit}>
            <select value={form.type} onChange={(event) => setForm({
              ...defaultsForType(event.target.value, form.level_id),
              question_text: form.question_text,
              explanation: form.explanation,
              points: form.points,
              image_url: form.image_url,
            })}>
              {questionTypes.map((type) => <option key={type}>{type}</option>)}
            </select>
            <select value={form.level_id} onChange={(event) => setForm({ ...form, level_id: event.target.value })}>
              {levels.map((level) => <option key={level.id} value={level.id}>{level.title}</option>)}
            </select>
            <textarea
              placeholder="Texte de la question"
              value={form.question_text}
              onChange={(event) => setForm({ ...form, question_text: event.target.value })}
            />
            <input type="number" value={form.points} onChange={(event) => setForm({ ...form, points: Number(event.target.value) })} />
            <div className="row-actions">
              <button type="submit" aria-label={editingId ? 'Sauvegarder' : 'Ajouter'}>
                {editingId ? <Check size={17} /> : <Plus size={17} />}
              </button>
              {editingId && (
                <button className="secondary-btn" type="button" onClick={cancelEdit} aria-label="Annuler">
                  <X size={17} />
                </button>
              )}
            </div>
          </form>

          <div className="table-edit-details">
            <label>
              Explication
              <textarea value={form.explanation} onChange={(event) => setForm({ ...form, explanation: event.target.value })} />
            </label>
            <ImageUploader required={requiresImage(form.type)} form={form} setForm={setForm} />
            <DynamicAnswerEditor form={form} setForm={setForm} />
          </div>

          {rows.map((question) => (
            <div className="table-data-row question-table-row" key={question.id}>
              <strong>{question.type}</strong>
              <span>{question.level_title || 'Quiz'}</span>
              <span>{question.part_title ? `${question.part_title} · ` : ''}{question.question_text}</span>
              <span>{question.points}</span>
              <div className="row-actions">
                <button type="button" onClick={() => edit(question)}><Pencil size={17} /></button>
                <button className="danger" type="button" onClick={() => remove(question.id)}><Trash2 size={17} /></button>
              </div>
            </div>
          ))}
        </div>

        <Pagination page={page} total={visibleQuestions.length} onPageChange={setPage} />
      </article>
    </section>
  );
}

function normalizeQuestionForEdit(question) {
  const normalized = defaultsForType(question.type, question.level_id);

  return {
    ...normalized,
    ...question,
    options: question.options?.length ? question.options : normalized.options,
    items: question.items?.length ? question.items : normalized.items,
  };
}

function findPartBySlugOrId(modules, value) {
  if (!value) return null;
  return modules.flatMap((module) => module.parts).find((part) => part.id === value || part.slug === value);
}

function requiresImage(type) {
  return type === 'diagram_choice' || type === 'diagram_labeling';
}

function usesOptions(type) {
  return ['qcm_single', 'qcm_multiple', 'true_false', 'diagram_choice'].includes(type);
}

function usesItems(type) {
  return ['text_answer', 'fill_blank', 'diagram_labeling', 'matching', 'ordering'].includes(type);
}

function DynamicAnswerEditor({ form, setForm }) {
  if (usesOptions(form.type)) return <OptionEditor form={form} setForm={setForm} />;
  if (usesItems(form.type)) return <ItemEditor form={form} setForm={setForm} />;
  return null;
}

function ImageUploader({ required, form, setForm }) {
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState('');
  const previewUrl = form.image_url ? `${API_URL}${form.image_url}` : '';

  async function uploadFile(file) {
    if (!file) return;

    setUploading(true);
    setError('');

    try {
      const data = new FormData();
      data.append('image', file);
      const response = await api.post('/api/admin/upload', data);
      setForm({ ...form, image_url: response.data.image_url });
    } catch (err) {
      setError(err.message);
    } finally {
      setUploading(false);
    }
  }

  return (
    <div className={required ? 'file-drop required' : 'file-drop'}>
      <label>
        <ImagePlus size={20} />
        <span>{required ? 'Image/schema requis' : 'Image/schema optionnel'}</span>
        <input type="file" accept="image/*" onChange={(event) => uploadFile(event.target.files[0])} />
      </label>
      {uploading && <small>Upload en cours...</small>}
      {error && <small className="error">{error}</small>}
      {form.image_url && <small>{form.image_url}</small>}
      {previewUrl && <img className="image-preview" src={previewUrl} alt="Preview schema" />}
    </div>
  );
}

function OptionEditor({ form, setForm }) {
  const isSingleCorrect = form.type === 'qcm_single' || form.type === 'diagram_choice' || form.type === 'true_false';

  function update(index, patch) {
    setForm({
      ...form,
      options: form.options.map((option, optionIndex) => {
        if (patch.is_correct && isSingleCorrect) return { ...option, is_correct: optionIndex === index };
        return optionIndex === index ? { ...option, ...patch } : option;
      }),
    });
  }

  function addOption() {
    setForm({
      ...form,
      options: [...form.options, { option_text: '', is_correct: false, option_order: form.options.length + 1 }],
    });
  }

  function removeOption(index) {
    setForm({
      ...form,
      options: form.options
        .filter((_, optionIndex) => optionIndex !== index)
        .map((option, optionIndex) => ({ ...option, option_order: optionIndex + 1 })),
    });
  }

  return (
    <div className="sub-editor">
      <div className="section-head">
        <div>
          <strong>{form.type === 'true_false' ? 'Bonne valeur' : 'Options de reponse'}</strong>
          <p>{isSingleCorrect ? 'Une seule bonne reponse.' : 'Plusieurs bonnes reponses possibles.'}</p>
        </div>
        {form.type !== 'true_false' && <button type="button" onClick={addOption}>Ajouter</button>}
      </div>
      {form.options.map((option, index) => (
        <div className="editor-line" key={index}>
          <input
            disabled={form.type === 'true_false'}
            placeholder={`Option ${index + 1}`}
            value={option.option_text || ''}
            onChange={(event) => update(index, { option_text: event.target.value })}
          />
          <label className="checkbox-line">
            <input
              type={isSingleCorrect ? 'radio' : 'checkbox'}
              name={`correct-${form.type}`}
              checked={Boolean(option.is_correct)}
              onChange={(event) => update(index, { is_correct: event.target.checked })}
            />
            Correct
          </label>
          {form.type !== 'true_false' && (
            <button className="danger" type="button" onClick={() => removeOption(index)}>
              <Trash2 size={16} />
            </button>
          )}
        </div>
      ))}
    </div>
  );
}

function ItemEditor({ form, setForm }) {
  const config = itemEditorConfig(form.type);

  function update(index, patch) {
    setForm({ ...form, items: form.items.map((item, itemIndex) => (itemIndex === index ? { ...item, ...patch } : item)) });
  }

  function addItem() {
    setForm({
      ...form,
      items: [...form.items, { label: '', correct_answer: '', position_x: '', position_y: '', item_order: form.items.length + 1 }],
    });
  }

  function removeItem(index) {
    setForm({
      ...form,
      items: form.items
        .filter((_, itemIndex) => itemIndex !== index)
        .map((item, itemIndex) => ({ ...item, item_order: itemIndex + 1 })),
    });
  }

  return (
    <div className="sub-editor">
      <div className="section-head">
        <div>
          <strong>{config.title}</strong>
          <p>{config.help}</p>
        </div>
        <button type="button" onClick={addItem}>Ajouter</button>
      </div>
      {form.items.map((item, index) => (
        <div className={form.type === 'diagram_labeling' ? 'editor-line diagram-line' : 'editor-line'} key={index}>
          <input placeholder={config.labelPlaceholder} value={item.label || ''} onChange={(event) => update(index, { label: event.target.value })} />
          <input placeholder={config.answerPlaceholder} value={item.correct_answer || ''} onChange={(event) => update(index, { correct_answer: event.target.value })} />
          {form.type === 'diagram_labeling' && (
            <>
              <input type="number" min="0" max="100" placeholder="position_x %" value={item.position_x ?? ''} onChange={(event) => update(index, { position_x: event.target.value })} />
              <input type="number" min="0" max="100" placeholder="position_y %" value={item.position_y ?? ''} onChange={(event) => update(index, { position_y: event.target.value })} />
            </>
          )}
          <button className="danger" type="button" onClick={() => removeItem(index)}>
            <Trash2 size={16} />
          </button>
        </div>
      ))}
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

function itemEditorConfig(type) {
  const configs = {
    text_answer: {
      title: 'Reponses acceptees',
      help: 'Ajoutez une ou plusieurs formulations correctes.',
      labelPlaceholder: 'Variante',
      answerPlaceholder: 'Reponse correcte',
    },
    fill_blank: {
      title: 'Blancs a completer',
      help: 'Ajoutez les reponses attendues dans l ordre des blancs.',
      labelPlaceholder: 'Blanc 1, Blanc 2...',
      answerPlaceholder: 'Reponse attendue',
    },
    diagram_labeling: {
      title: 'Numeros du schema',
      help: 'Ajoutez chaque numero, sa reponse, puis sa position X/Y en pourcentage.',
      labelPlaceholder: 'Numero ou etiquette',
      answerPlaceholder: 'Reponse attendue',
    },
    matching: {
      title: 'Associations',
      help: 'Ajoutez le terme a gauche et sa reponse correcte.',
      labelPlaceholder: 'Terme',
      answerPlaceholder: 'Reponse correcte',
    },
    ordering: {
      title: 'Etapes dans le bon ordre',
      help: 'Ajoutez les etapes deja dans l ordre attendu.',
      labelPlaceholder: 'Etape',
      answerPlaceholder: 'Valeur attendue ou rappel',
    },
  };

  return configs[type] || configs.text_answer;
}
