CREATE TABLE patients(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);


CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  admitted_at TIMESTAMP,
  status VARCHAR(100),
  patient_id INT NOT NULL REFERENCES patients(id)
);
-- Add foreign key index
CREATE INDEX fk_medical_histories_patient_id_idx ON medical_histories(patient_id);


CREATE TABLE treatments (
  id INT NOT NULL REFERENCES medical_histories(id) PRIMARY KEY,
  type VARCHAR(100) NOT NULL,
  name VARCHAR(100) NOT NULL
);
-- Add foreign key index
CREATE INDEX fk_treatments_id_idx ON treatments(id);


CREATE TABLE medical_history_treatments (
  medical_history_id INTEGER NOT NULL REFERENCES medical_histories(id),
  treatment_id INTEGER NOT NULL REFERENCES treatments(id),
  PRIMARY KEY (medical_history_id, treatment_id)
);
-- Add foreign key indexes
CREATE INDEX fk_medical_history_treatments_medical_history_id_idx ON medical_history_treatments(medical_history_id);
CREATE INDEX fk_medical_history_treatments_treatment_id_idx ON medical_history_treatments(treatment_id);


CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INTEGER REFERENCES medical_histories(id)
);
-- Add foreign key index
CREATE INDEX fk_invoices_medical_history_id_idx ON invoices(medical_history_id);


CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price DECIMAL,
  quantity INTEGER,
  total_price DECIMAL,
  invoice_id INTEGER REFERENCES invoices(id),
  treatment_id INTEGER REFERENCES treatments(id)
);
-- Add foreign key indexes
CREATE INDEX fk_invoice_items_invoice_id_idx ON invoice_items(invoice_id);
CREATE INDEX fk_invoice_items_treatment_id_idx ON invoice_items(treatment_id);

