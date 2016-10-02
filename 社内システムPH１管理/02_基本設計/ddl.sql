CREATE OR REPLACE TABLE users ( /* ��`���` */
  user_id varchar(10) NOT NULL COMMENT '��`���`ID',
  employee_id varchar(10) NOT NULL UNIQUE KEY COMMENT '��TID',
  name varchar(20) NOT NULL UNIQUE KEY COMMENT '��`���`��',
  pwd varchar(256) NOT NULL COMMENT '�ѥ���`��',
  auth_id varchar(10) NOT NULL UNIQUE KEY COMMENT '����ID',
  last_login_at datetime NOT NULL COMMENT '������h�r�g',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`user_id`)
);

CREATE OR REPLACE TABLE authority ( /* ���� */
  authority_id varchar(10) NOT NULL COMMENT '����ID',
  name varchar(20) NOT NULL COMMENT '����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`authority_id`)
);

CREATE OR REPLACE TABLE employees ( /* ��T */
  employee_id varchar(10) NOT NULL COMMENT '��TID',
  name_in_law varchar(20) NOT NULL COMMENT '������',
  name_cn varchar(20) NOT NULL COMMENT '�й��Z��',
  name_en varchar(20) NOT NULL COMMENT 'Ӣ�Z��',
  name_jp varchar(20) NOT NULL COMMENT '�ձ��Z��',
  name_kana varchar(20) NOT NULL COMMENT '������',
  resident_spot_id varchar(10) NOT NULL COMMENT 'ס��ID',
  mobile varchar(11) NOT NULL COMMENT 'Я������',
  mobile_cn varchar(11) COMMENT 'Я�����ţ��й���',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`employee_id`)
);

CREATE OR REPLACE TABLE departments ( /* �� */
  department_id varchar(10) NOT NULL COMMENT '��ID',
  name varchar(100) NOT NULL COMMENT '����',
  chief_employee_id varchar(10) NOT NULL COMMENT '���LID',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`department_id`)
);

CREATE OR REPLACE TABLE sections ( /* �n */
  section_id varchar(10) NOT NULL COMMENT '�nID',
  department_id varchar(10) NOT NULL COMMENT '��ID',
  name varchar(100) NOT NULL COMMENT '����',
  chief_employee_id varchar(10) NOT NULL COMMENT '�n�LID',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`section_id`)
);

CREATE OR REPLACE TABLE dispatches ( /* ��ǲ */
  dispatch_id varchar(10) NOT NULL COMMENT '��ǲID',
  employee_id varchar(10) NOT NULL UNIQUE KEY COMMENT '��TID',
  customer_id varchar(10) NOT NULL COMMENT '�ID',
  site_id tinyint(10) NOT NULL COMMENT '�F��ID',
  start_date date NOT NULL UNIQUE KEY COMMENT '��ǲ�_ʼ��',
  end_date date NOT NULL UNIQUE KEY COMMENT '��ǲ�K����',
  fixed_monthly_hours int(3) COMMENT '�̶��ڄՕr�g',
  report_day int(2) NOT NULL COMMENT '�ڄ������',
  work_start_time char(4) NOT NULL COMMENT '���ڕr�g',
  work_end_time char(4) NOT NULL COMMENT '���ڕr�g',
  day_break_start_time char(4) NOT NULL COMMENT '������_ʼ�r�g',
  day_break_minutes int(3) NOT NULL COMMENT '��������',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`dispatch_id`)
);

CREATE OR REPLACE TABLE attendances ( /* �ڄ� */
  dispatch_id varchar(10) NOT NULL COMMENT '��ǲID',
  date date NOT NULL COMMENT '�ո�',
  employee_id varchar(10) NOT NULL COMMENT '��TID',
  start_time datetime NOT NULL COMMENT '���ڕr�g',
  report_start_time datetime NOT NULL COMMENT '��ݩ`�ȳ��ڕr�g',
  start_longitude decimal NOT NULL COMMENT '���ڽU��',
  start_latitude decimal NOT NULL COMMENT '���ھ���',
  end_time datetime NOT NULL COMMENT '���ڕr�g',
  report_end_time datetime NOT NULL COMMENT '��ݩ`�����ڕr�g',
  end_longitude decimal NOT NULL COMMENT '���ڽU��',
  end_latitude decimal NOT NULL COMMENT '���ھ���',
  exclusive_minutes int NOT NULL COMMENT '�س�����',
  total_minutes int NOT NULL COMMENT '��Ӌ����',
  vacation_id varchar(10) COMMENT '���ID',
  modification_log varchar(4000) COMMENT '�����Ěs',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`dispatch_id`, `date`)
);

CREATE OR REPLACE TABLE attendance_supervision ( /* �ڄճ��J */
  dispatch_id varchar(10) NOT NULL COMMENT '��ǲID',
  month date NOT NULL COMMENT '��',
  status_id varchar(10) NOT NULL COMMENT '���Ʃ`����ID',
  remark varchar(200) COMMENT '�俼',
  report_path varchar(200) COMMENT '�ڄձ�ѥ�',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`dispatch_id`, `month`)
);

CREATE OR REPLACE TABLE customers ( /* � */
  id varchar(10) NOT NULL COMMENT 'ID',
  spot_id varchar(10) NOT NULL COMMENT '���ݥå�ID',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE sites ( /* �F�� */
  id varchar(10) NOT NULL COMMENT 'ID',
  spot_id varchar(10) NOT NULL COMMENT '���ݥå�ID',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE spots ( /* ���ݥå� */
  spot_id varchar(10) NOT NULL COMMENT '���ݥå�ID',
  type_id varchar(10) NOT NULL COMMENT '�N�ID',
  name varchar(100) NOT NULL COMMENT '����',
  name_kana varchar(200) NOT NULL COMMENT '��������',
  district_id varchar(10) NOT NULL COMMENT '��ID',
  addr_detail varchar(200) NOT NULL COMMENT 'ס��Ԕ��',
  post_code varchar(7) NOT NULL COMMENT '�]�㷬��',
  tel varchar(10) COMMENT '�Ԓ',
  start_longitude decimal NOT NULL COMMENT '�_ʼ�U��',
  start_latitude decimal NOT NULL COMMENT '�_ʼ����',
  end_longitude decimal NOT NULL COMMENT '�K�˽U��',
  end_latitude decimal NOT NULL COMMENT '�K�˾���',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`spot_id`)
);

CREATE OR REPLACE TABLE prefectures ( /* �h */
  prefecture_id varchar(10) NOT NULL COMMENT '�hID',
  name varchar(100) NOT NULL COMMENT '����',
  name_kana varchar(200) NOT NULL COMMENT '��������',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`prefecture_id`)
);

CREATE OR REPLACE TABLE districts ( /* �� */
  district_id varchar(10) NOT NULL COMMENT '��ID',
  prefecture_id varchar(10) NOT NULL COMMENT '�hID',
  name varchar(100) NOT NULL COMMENT '����',
  name_kana varchar(200) NOT NULL COMMENT '��������',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`district_id`)
);

CREATE OR REPLACE TABLE vacations ( /* ��� */
  vacation_id varchar(10) NOT NULL COMMENT '���ID',
  name varchar(20) NOT NULL COMMENT '����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`vacation_id`)
);

CREATE OR REPLACE TABLE modifications ( /* ���� */
  modification_id varchar(10) NOT NULL COMMENT '����ID',
  name varchar(20) NOT NULL COMMENT '����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`modification_id`)
);

CREATE OR REPLACE TABLE status ( /* ���Ʃ`���� */
  status_id varchar(10) NOT NULL COMMENT '���Ʃ`����ID',
  name varchar(20) NOT NULL COMMENT '����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`status_id`)
);

CREATE OR REPLACE TABLE codes ( /* ���`�� */
  code_id varchar(10) NOT NULL COMMENT '���`��ID',
  type varchar(20) NOT NULL COMMENT '�N�',
  code varchar(20) NOT NULL COMMENT '��',
  name varchar(100) NOT NULL COMMENT '��',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`code_id`)
);

CREATE OR REPLACE TABLE holidays ( /* ף�� */
  date date NOT NULL COMMENT '�ո�',
  no int(2) NOT NULL COMMENT '֦��',
  type_id varchar(10) NOT NULL COMMENT '�N�ID',
  name varchar(20) NOT NULL COMMENT '����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`date`, `no`)
);

CREATE OR REPLACE TABLE employments ( /* ���� */
  employment_id varchar(10) NOT NULL COMMENT '����ID',
  employee_id varchar(10) NOT NULL COMMENT '��TID',
  section_id varchar(10) COMMENT '�nID',
  start_date date NOT NULL COMMENT '�_ʼ��',
  end_date date NOT NULL COMMENT '�K����',
  type_id varchar(10) NOT NULL COMMENT '�N�ID',
  monthly_salary decimal NOT NULL COMMENT '�½o',
  monthly_fee decimal(10) COMMENT '���~',
  bonus_id varchar(10) COMMENT '�pID',
  penalty_id varchar(10) COMMENT '�PID',
  ensurance_id varchar(10) NOT NULL COMMENT '���ID',
  exclusive_id varchar(10) COMMENT '�س�ID',
  payroll_id varchar(10) NOT NULL COMMENT '֧�BID',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`employment_id`)
);

CREATE OR REPLACE TABLE bonus_penalty ( /* �p�P */
  bonus_penalty_id varchar(10) NOT NULL COMMENT '�p�PID',
  type tinyint(1) NOT NULL COMMENT '�N�',
  name varchar(100) NOT NULL COMMENT '����',
  start_date date NOT NULL COMMENT '�_ʼ��',
  end_date date NOT NULL COMMENT '�K����',
  amount decimal NOT NULL COMMENT '�~',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`bonus_penalty_id`)
);

CREATE OR REPLACE TABLE exclusives ( /* �س� */
  exclusive_id varchar(10) NOT NULL COMMENT '�س�ID',
  name varchar(100) NOT NULL COMMENT '����',
  start_date date NOT NULL COMMENT '�_ʼ��',
  end_date date NOT NULL COMMENT '�K����',
  amount decimal NOT NULL COMMENT '�~',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`exclusive_id`)
);

CREATE OR REPLACE TABLE ensurance ( /* ��� */
  ensurance_id varchar(10) NOT NULL COMMENT '���ID',
  name varchar(100) NOT NULL COMMENT '����',
  start_date date NOT NULL COMMENT '�_ʼ��',
  end_date date NOT NULL COMMENT '�K����',
  amount decimal NOT NULL COMMENT '�~',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`ensurance_id`)
);

CREATE OR REPLACE TABLE payroll ( /* ֧�B */
  payroll_id varchar(10) NOT NULL COMMENT '֧�BID',
  branch_id varchar(10) NOT NULL COMMENT '֧��ID',
  card_no varchar(30) NOT NULL COMMENT '���`�ɷ���',
  card_sign varchar(20) NOT NULL COMMENT '���`�����x',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`payroll_id`)
);

CREATE OR REPLACE TABLE branches ( /* ֧�� */
  branch_id varchar(10) NOT NULL COMMENT '֧��ID',
  bank_id varchar(10) NOT NULL COMMENT '�y��ID',
  name varchar(100) NOT NULL COMMENT '����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`branch_id`)
);

CREATE OR REPLACE TABLE banks ( /* �y�� */
  bank_id varchar(10) NOT NULL COMMENT '�y��ID',
  name varchar(100) NOT NULL COMMENT '����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`bank_id`)
);

CREATE OR REPLACE TABLE notifications ( /* ֪ͨ */
  notification_id varchar(10) NOT NULL COMMENT '֪ͨID',
  title varchar(50) NOT NULL COMMENT '�����ȥ�',
  content varchar(1000) NOT NULL COMMENT '����',
  start_date date COMMENT '�_ʼ��',
  end_date date COMMENT '�K����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`notification_id`)
);

CREATE OR REPLACE TABLE votes ( /* ͶƱ */
  vote_id varchar(10) NOT NULL COMMENT 'ͶƱID',
  title varchar(50) NOT NULL COMMENT '�����ȥ�',
  content varchar(1000) NOT NULL COMMENT '����',
  options varchar(1000) NOT NULL COMMENT '�x�k֫',
  start_date date COMMENT '�_ʼ��',
  end_date date COMMENT '�K����',
  vote_start_date date COMMENT 'ͶƱ�_ʼ��',
  vote_end_date date COMMENT 'ͶƱ�K����',
  valid tinyint(1) NOT NULL DEFAULT 1 COMMENT '�Є�',
  create_by varchar(10) NOT NULL COMMENT '���h��',
  create_at datetime NOT NULL DEFAULT now() COMMENT '���h�r�g',
  update_by varchar(10) NOT NULL COMMENT '������',
  update_at datetime NOT NULL DEFAULT now() COMMENT '���r�g',
  update_cnt int(5) NOT NULL DEFAULT 1 COMMENT '���»���',
  PRIMARY KEY(`vote_id`)
);

