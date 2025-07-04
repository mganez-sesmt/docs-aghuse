Também será necessário a população de algumas tabelas para produção de acordo como está no desenvolvimento.
- agh.agh_processo_agenda
# Scripts
Aqui estarei deixando público os scripts que foram necessários para o funcionamento da versão compilada. Estes sciprts envolvem todas as questões por mim trabalhadas na seguinte versão:
* 13.232-STABLE.bb64d70
* 11 de Março

ALTER TABLE agh.sce_e660nfc_forn ADD infcpl varchar(500) NULL;
ALTER TABLE agh.sce_cfops ADD ind_cfop_venda_opme varchar(1) NULL;


ALTER TABLE agh.sco_pontos_parada_solicitacoes ADD ind_gera_parcela_sc varchar(1) NULL;
ALTER TABLE agh.afa_medicamentos_jn ADD emp_alteracao int NULL;
ALTER TABLE agh.ael_exames_material_analise ADD just_exa_sem_vinc_sus varchar(200) NULL;

ALTER TABLE agh.ael_exames_material_analise ADD ser_matricula_ativado int4 NULL;
ALTER TABLE agh.ael_exames_material_analise ADD ser_vin_codigo_ativado int2 NULL;
ALTER TABLE agh.ael_exames_material_analise ADD CONSTRAINT ael_exames_material_analise_rap_servidores_fk FOREIGN KEY (ser_matricula_ativado,ser_vin_codigo_ativado) REFERENCES agh.rap_servidores(matricula,vin_codigo);

ALTER TABLE agh.fso_verbas_gestao ADD ind_sc_automatica_cum_conv varchar(1) DEFAULT 'N'::character varying NOT NULL;
ALTER TABLE agh.fso_verbas_gestao ADD ind_sc_automatica_cum_sus varchar(1) DEFAULT 'N'::character varying NOT NULL;
UPDATE agh.sco_pontos_parada_solicitacoes SET tipo = NULL WHERE tipo = '';

ALTER TABLE agh.sce_item_rmps ADD dt_liberacao_aut timestamp NULL;
ALTER TABLE agh.sce_item_rmps ADD desc_erro_liberacao_aut varchar(200) NULL;
ALTER TABLE agh.sce_item_rmps ADD ind_status_liberacao_aut varchar(1) NULL;
ALTER TABLE agh.sce_item_rmps ADD slc_numero int4 NULL;
ALTER TABLE agh.sce_item_rmps ADD CONSTRAINT sce_item_rmps_sco_solicitacoes_de_compras_fk FOREIGN KEY (slc_numero) REFERENCES agh.sco_solicitacoes_de_compras(numero);

ALTER TABLE agh.sce_item_nrs ADD irm_eal_seq int4 NULL;
ALTER TABLE agh.sce_item_nrs ADD irm_rms_seq int4 NULL;
ALTER TABLE agh.sce_item_nrs ADD CONSTRAINT sce_item_nrs_sce_item_rms_fk FOREIGN KEY (irm_rms_seq,irm_eal_seq) REFERENCES agh.sce_item_rms(rms_seq,eal_seq);

ALTER TABLE agh.fat_conv_saude_planos ADD cd_cor_prim_prazo_envio_cta varchar(15) NULL;
ALTER TABLE agh.fat_conv_saude_planos ADD cd_cor_seg_prazo_envio_cta varchar(15) NULL;
ALTER TABLE agh.fat_conv_saude_planos ADD nr_dias_prim_prazo_envio_cta numeric(2) NULL;
ALTER TABLE agh.fat_conv_saude_planos ADD nr_dias_seg_prazo_envio_cta numeric(2) NULL;
ALTER TABLE agh.fat_convenios_saude ADD ind_gera_solicitacao_hemoterapica varchar(1) DEFAULT 'N'::character varying NOT NULL;

ALTER TABLE agh.sce_lote_x_documentos ADD ind_teste varchar(1) NULL;
ALTER TABLE agh.sce_lote_x_documentos ADD ser_vin_codigo_teste int2 NULL;
ALTER TABLE agh.sce_lote_x_documentos ADD ser_matricula_teste int4 NULL;
ALTER TABLE agh.sce_lote_x_documentos ADD CONSTRAINT sce_lote_x_documentos_rap_servidores_fk FOREIGN KEY (ser_matricula_teste,ser_vin_codigo_teste) REFERENCES agh.rap_servidores(matricula,vin_codigo);

ALTER TABLE agh.sce_motivo_movimentos ADD ind_ajuste_estoque_dispensario varchar NULL;

ALTER TABLE agh.sce_transferencias ADD dt_ult_impressao timestamp NULL;
ALTER TABLE agh.sce_transferencias ADD ind_impresso varchar(1) NOT NULL;
ALTER TABLE agh.sce_transferencias ADD nome_impressora varchar NULL;

ALTER TABLE agh.sce_item_trs_lote ADD ds_justificativa varchar(50) NULL;
ALTER TABLE agh.sce_item_trs_lote_aud ADD ds_justificativa varchar(50) NULL;

ALTER TABLE agh.sce_dispensarios ADD frn_numero int4 NULL;
ALTER TABLE agh.sce_dispensarios ADD CONSTRAINT sce_dispensarios_sco_fornecedores_fk FOREIGN KEY (frn_numero) REFERENCES agh.sco_fornecedores(numero);
ALTER TABLE agh.sce_dispensarios ADD ind_armario varchar(1) NULL;
ALTER TABLE agh.sce_dispensarios ADD ind_imp_trf varchar(1) NOT NULL;
ALTER TABLE agh.sce_dispensarios ADD ind_tp_equip varchar(1) NOT NULL;

--
ALTER TABLE agh.sco_contratos ADD nro_processo_sei int8 NULL;


