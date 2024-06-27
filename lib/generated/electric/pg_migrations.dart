// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_use_package_imports, depend_on_referenced_packages
// ignore_for_file: prefer_double_quotes

import 'package:electricsql/electricsql.dart';

const kPostgresMigrations = <Migration>[
  Migration(
    statements: [
      'CREATE TABLE workspaces (\n    id uuid NOT NULL,\n    electric_user_id uuid NOT NULL,\n    name text,\n    CONSTRAINT workspaces_pkey PRIMARY KEY (id)\n)',
      'INSERT INTO "public"."_electric_trigger_settings" ("namespace", "tablename", "flag")\nVALUES (\'public\', \'workspaces\', 1)\nON CONFLICT DO NOTHING;\n',
      'DROP TRIGGER IF EXISTS update_ensure_public_workspaces_primarykey ON "public"."workspaces";',
      '        CREATE OR REPLACE FUNCTION update_ensure_public_workspaces_primarykey_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          IF OLD."id" IS DISTINCT FROM NEW."id" THEN\n            RAISE EXCEPTION \'Cannot change the value of column id as it belongs to the primary key\';\n          END IF;\n          RETURN NEW;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER update_ensure_public_workspaces_primarykey\n          BEFORE UPDATE ON "public"."workspaces"\n            FOR EACH ROW\n              EXECUTE FUNCTION update_ensure_public_workspaces_primarykey_function();\n      ',
      'DROP TRIGGER IF EXISTS insert_public_workspaces_into_oplog ON "public"."workspaces";',
      '        CREATE OR REPLACE FUNCTION insert_public_workspaces_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'workspaces\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'workspaces\',\n                \'INSERT\',\n                json_strip_nulls(json_build_object(\'id\', new."id")),\n                jsonb_build_object(\'electric_user_id\', new."electric_user_id", \'id\', new."id", \'name\', new."name"),\n                NULL,\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER insert_public_workspaces_into_oplog\n          AFTER INSERT ON "public"."workspaces"\n            FOR EACH ROW\n              EXECUTE FUNCTION insert_public_workspaces_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS update_public_workspaces_into_oplog ON "public"."workspaces";',
      '        CREATE OR REPLACE FUNCTION update_public_workspaces_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'workspaces\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'workspaces\',\n                \'UPDATE\',\n                json_strip_nulls(json_build_object(\'id\', new."id")),\n                jsonb_build_object(\'electric_user_id\', new."electric_user_id", \'id\', new."id", \'name\', new."name"),\n                jsonb_build_object(\'electric_user_id\', old."electric_user_id", \'id\', old."id", \'name\', old."name"),\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER update_public_workspaces_into_oplog\n          AFTER UPDATE ON "public"."workspaces"\n            FOR EACH ROW\n              EXECUTE FUNCTION update_public_workspaces_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS delete_public_workspaces_into_oplog ON "public"."workspaces";',
      '        CREATE OR REPLACE FUNCTION delete_public_workspaces_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'workspaces\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'workspaces\',\n                \'DELETE\',\n                json_strip_nulls(json_build_object(\'id\', old."id")),\n                NULL,\n                jsonb_build_object(\'electric_user_id\', old."electric_user_id", \'id\', old."id", \'name\', old."name"),\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER delete_public_workspaces_into_oplog\n          AFTER DELETE ON "public"."workspaces"\n            FOR EACH ROW\n              EXECUTE FUNCTION delete_public_workspaces_into_oplog_function();\n      ',
    ],
    version: '20240624030117',
  ),
  Migration(
    statements: [
      'CREATE TABLE drafts (\n    id uuid NOT NULL,\n    workspace_id uuid NOT NULL,\n    electric_user_id uuid NOT NULL,\n    content text,\n    flag boolean NOT NULL,\n    status smallint NOT NULL,\n    created_at timestamp without time zone,\n    updated_at timestamp without time zone,\n    CONSTRAINT drafts_pkey PRIMARY KEY (id),\n    CONSTRAINT drafts_workspace_id_fkey FOREIGN KEY (workspace_id) REFERENCES workspaces(id) ON DELETE CASCADE\n)',
      'INSERT INTO "public"."_electric_trigger_settings" ("namespace", "tablename", "flag")\nVALUES (\'public\', \'drafts\', 1)\nON CONFLICT DO NOTHING;\n',
      'DROP TRIGGER IF EXISTS update_ensure_public_drafts_primarykey ON "public"."drafts";',
      '        CREATE OR REPLACE FUNCTION update_ensure_public_drafts_primarykey_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          IF OLD."id" IS DISTINCT FROM NEW."id" THEN\n            RAISE EXCEPTION \'Cannot change the value of column id as it belongs to the primary key\';\n          END IF;\n          RETURN NEW;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER update_ensure_public_drafts_primarykey\n          BEFORE UPDATE ON "public"."drafts"\n            FOR EACH ROW\n              EXECUTE FUNCTION update_ensure_public_drafts_primarykey_function();\n      ',
      'DROP TRIGGER IF EXISTS insert_public_drafts_into_oplog ON "public"."drafts";',
      '        CREATE OR REPLACE FUNCTION insert_public_drafts_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'drafts\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'drafts\',\n                \'INSERT\',\n                json_strip_nulls(json_build_object(\'id\', new."id")),\n                jsonb_build_object(\'content\', new."content", \'created_at\', new."created_at", \'electric_user_id\', new."electric_user_id", \'flag\', new."flag", \'id\', new."id", \'status\', new."status", \'updated_at\', new."updated_at", \'workspace_id\', new."workspace_id"),\n                NULL,\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER insert_public_drafts_into_oplog\n          AFTER INSERT ON "public"."drafts"\n            FOR EACH ROW\n              EXECUTE FUNCTION insert_public_drafts_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS update_public_drafts_into_oplog ON "public"."drafts";',
      '        CREATE OR REPLACE FUNCTION update_public_drafts_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'drafts\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'drafts\',\n                \'UPDATE\',\n                json_strip_nulls(json_build_object(\'id\', new."id")),\n                jsonb_build_object(\'content\', new."content", \'created_at\', new."created_at", \'electric_user_id\', new."electric_user_id", \'flag\', new."flag", \'id\', new."id", \'status\', new."status", \'updated_at\', new."updated_at", \'workspace_id\', new."workspace_id"),\n                jsonb_build_object(\'content\', old."content", \'created_at\', old."created_at", \'electric_user_id\', old."electric_user_id", \'flag\', old."flag", \'id\', old."id", \'status\', old."status", \'updated_at\', old."updated_at", \'workspace_id\', old."workspace_id"),\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER update_public_drafts_into_oplog\n          AFTER UPDATE ON "public"."drafts"\n            FOR EACH ROW\n              EXECUTE FUNCTION update_public_drafts_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS delete_public_drafts_into_oplog ON "public"."drafts";',
      '        CREATE OR REPLACE FUNCTION delete_public_drafts_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'drafts\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'drafts\',\n                \'DELETE\',\n                json_strip_nulls(json_build_object(\'id\', old."id")),\n                NULL,\n                jsonb_build_object(\'content\', old."content", \'created_at\', old."created_at", \'electric_user_id\', old."electric_user_id", \'flag\', old."flag", \'id\', old."id", \'status\', old."status", \'updated_at\', old."updated_at", \'workspace_id\', old."workspace_id"),\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER delete_public_drafts_into_oplog\n          AFTER DELETE ON "public"."drafts"\n            FOR EACH ROW\n              EXECUTE FUNCTION delete_public_drafts_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS compensation_insert_public_drafts_workspace_id_into_oplog ON "public"."drafts";',
      '        CREATE OR REPLACE FUNCTION compensation_insert_public_drafts_workspace_id_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n            meta_value INTEGER;\n          BEGIN\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'drafts\';\n    \n            SELECT value INTO meta_value FROM "public"._electric_meta WHERE key = \'compensations\';\n    \n            IF flag_value = 1 AND meta_value = 1 THEN\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              SELECT\n                \'public\',\n                \'workspaces\',\n                \'COMPENSATION\',\n                json_strip_nulls(json_strip_nulls(json_build_object(\'id\', "id"))),\n                jsonb_build_object(\'id\', "id"),\n                NULL,\n                NULL\n              FROM "public"."workspaces"\n              WHERE "id" = NEW."workspace_id";\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n        ',
      '          CREATE TRIGGER compensation_insert_public_drafts_workspace_id_into_oplog\n            AFTER INSERT ON "public"."drafts"\n              FOR EACH ROW\n                EXECUTE FUNCTION compensation_insert_public_drafts_workspace_id_into_oplog_function();\n        ',
      'DROP TRIGGER IF EXISTS compensation_update_public_drafts_workspace_id_into_oplog ON "public"."drafts";',
      '        CREATE OR REPLACE FUNCTION compensation_update_public_drafts_workspace_id_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n            meta_value INTEGER;\n          BEGIN\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'drafts\';\n    \n            SELECT value INTO meta_value FROM "public"._electric_meta WHERE key = \'compensations\';\n    \n            IF flag_value = 1 AND meta_value = 1 THEN\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              SELECT\n                \'public\',\n                \'workspaces\',\n                \'COMPENSATION\',\n                json_strip_nulls(json_strip_nulls(json_build_object(\'id\', "id"))),\n                jsonb_build_object(\'id\', "id"),\n                NULL,\n                NULL\n              FROM "public"."workspaces"\n              WHERE "id" = NEW."workspace_id";\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n        ',
      '          CREATE TRIGGER compensation_update_public_drafts_workspace_id_into_oplog\n            AFTER UPDATE ON "public"."drafts"\n              FOR EACH ROW\n                EXECUTE FUNCTION compensation_update_public_drafts_workspace_id_into_oplog_function();\n        ',
    ],
    version: '20240624030127',
  ),
  Migration(
    statements: [
      'CREATE TABLE tags (\n    id uuid NOT NULL,\n    workspace_id uuid NOT NULL,\n    electric_user_id uuid NOT NULL,\n    name text,\n    related_num integer,\n    CONSTRAINT tags_pkey PRIMARY KEY (id),\n    CONSTRAINT tags_workspace_id_fkey FOREIGN KEY (workspace_id) REFERENCES workspaces(id) ON DELETE CASCADE\n)',
      'CREATE TABLE draft_tags (\n    id uuid NOT NULL,\n    electric_user_id uuid NOT NULL,\n    tag_id uuid NOT NULL,\n    draft_id uuid NOT NULL,\n    CONSTRAINT draft_tags_pkey PRIMARY KEY (id),\n    CONSTRAINT draft_tags_draft_id_fkey FOREIGN KEY (draft_id) REFERENCES drafts(id) ON DELETE CASCADE,\n    CONSTRAINT draft_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE\n)',
      'INSERT INTO "public"."_electric_trigger_settings" ("namespace", "tablename", "flag")\nVALUES (\'public\', \'tags\', 1)\nON CONFLICT DO NOTHING;\n',
      'DROP TRIGGER IF EXISTS update_ensure_public_tags_primarykey ON "public"."tags";',
      '        CREATE OR REPLACE FUNCTION update_ensure_public_tags_primarykey_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          IF OLD."id" IS DISTINCT FROM NEW."id" THEN\n            RAISE EXCEPTION \'Cannot change the value of column id as it belongs to the primary key\';\n          END IF;\n          RETURN NEW;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER update_ensure_public_tags_primarykey\n          BEFORE UPDATE ON "public"."tags"\n            FOR EACH ROW\n              EXECUTE FUNCTION update_ensure_public_tags_primarykey_function();\n      ',
      'DROP TRIGGER IF EXISTS insert_public_tags_into_oplog ON "public"."tags";',
      '        CREATE OR REPLACE FUNCTION insert_public_tags_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'tags\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'tags\',\n                \'INSERT\',\n                json_strip_nulls(json_build_object(\'id\', new."id")),\n                jsonb_build_object(\'electric_user_id\', new."electric_user_id", \'id\', new."id", \'name\', new."name", \'related_num\', new."related_num", \'workspace_id\', new."workspace_id"),\n                NULL,\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER insert_public_tags_into_oplog\n          AFTER INSERT ON "public"."tags"\n            FOR EACH ROW\n              EXECUTE FUNCTION insert_public_tags_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS update_public_tags_into_oplog ON "public"."tags";',
      '        CREATE OR REPLACE FUNCTION update_public_tags_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'tags\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'tags\',\n                \'UPDATE\',\n                json_strip_nulls(json_build_object(\'id\', new."id")),\n                jsonb_build_object(\'electric_user_id\', new."electric_user_id", \'id\', new."id", \'name\', new."name", \'related_num\', new."related_num", \'workspace_id\', new."workspace_id"),\n                jsonb_build_object(\'electric_user_id\', old."electric_user_id", \'id\', old."id", \'name\', old."name", \'related_num\', old."related_num", \'workspace_id\', old."workspace_id"),\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER update_public_tags_into_oplog\n          AFTER UPDATE ON "public"."tags"\n            FOR EACH ROW\n              EXECUTE FUNCTION update_public_tags_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS delete_public_tags_into_oplog ON "public"."tags";',
      '        CREATE OR REPLACE FUNCTION delete_public_tags_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'tags\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'tags\',\n                \'DELETE\',\n                json_strip_nulls(json_build_object(\'id\', old."id")),\n                NULL,\n                jsonb_build_object(\'electric_user_id\', old."electric_user_id", \'id\', old."id", \'name\', old."name", \'related_num\', old."related_num", \'workspace_id\', old."workspace_id"),\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER delete_public_tags_into_oplog\n          AFTER DELETE ON "public"."tags"\n            FOR EACH ROW\n              EXECUTE FUNCTION delete_public_tags_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS compensation_insert_public_tags_workspace_id_into_oplog ON "public"."tags";',
      '        CREATE OR REPLACE FUNCTION compensation_insert_public_tags_workspace_id_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n            meta_value INTEGER;\n          BEGIN\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'tags\';\n    \n            SELECT value INTO meta_value FROM "public"._electric_meta WHERE key = \'compensations\';\n    \n            IF flag_value = 1 AND meta_value = 1 THEN\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              SELECT\n                \'public\',\n                \'workspaces\',\n                \'COMPENSATION\',\n                json_strip_nulls(json_strip_nulls(json_build_object(\'id\', "id"))),\n                jsonb_build_object(\'id\', "id"),\n                NULL,\n                NULL\n              FROM "public"."workspaces"\n              WHERE "id" = NEW."workspace_id";\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n        ',
      '          CREATE TRIGGER compensation_insert_public_tags_workspace_id_into_oplog\n            AFTER INSERT ON "public"."tags"\n              FOR EACH ROW\n                EXECUTE FUNCTION compensation_insert_public_tags_workspace_id_into_oplog_function();\n        ',
      'DROP TRIGGER IF EXISTS compensation_update_public_tags_workspace_id_into_oplog ON "public"."tags";',
      '        CREATE OR REPLACE FUNCTION compensation_update_public_tags_workspace_id_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n            meta_value INTEGER;\n          BEGIN\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'tags\';\n    \n            SELECT value INTO meta_value FROM "public"._electric_meta WHERE key = \'compensations\';\n    \n            IF flag_value = 1 AND meta_value = 1 THEN\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              SELECT\n                \'public\',\n                \'workspaces\',\n                \'COMPENSATION\',\n                json_strip_nulls(json_strip_nulls(json_build_object(\'id\', "id"))),\n                jsonb_build_object(\'id\', "id"),\n                NULL,\n                NULL\n              FROM "public"."workspaces"\n              WHERE "id" = NEW."workspace_id";\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n        ',
      '          CREATE TRIGGER compensation_update_public_tags_workspace_id_into_oplog\n            AFTER UPDATE ON "public"."tags"\n              FOR EACH ROW\n                EXECUTE FUNCTION compensation_update_public_tags_workspace_id_into_oplog_function();\n        ',
      'INSERT INTO "public"."_electric_trigger_settings" ("namespace", "tablename", "flag")\nVALUES (\'public\', \'draft_tags\', 1)\nON CONFLICT DO NOTHING;\n',
      'DROP TRIGGER IF EXISTS update_ensure_public_draft_tags_primarykey ON "public"."draft_tags";',
      '        CREATE OR REPLACE FUNCTION update_ensure_public_draft_tags_primarykey_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          IF OLD."id" IS DISTINCT FROM NEW."id" THEN\n            RAISE EXCEPTION \'Cannot change the value of column id as it belongs to the primary key\';\n          END IF;\n          RETURN NEW;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER update_ensure_public_draft_tags_primarykey\n          BEFORE UPDATE ON "public"."draft_tags"\n            FOR EACH ROW\n              EXECUTE FUNCTION update_ensure_public_draft_tags_primarykey_function();\n      ',
      'DROP TRIGGER IF EXISTS insert_public_draft_tags_into_oplog ON "public"."draft_tags";',
      '        CREATE OR REPLACE FUNCTION insert_public_draft_tags_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'draft_tags\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'draft_tags\',\n                \'INSERT\',\n                json_strip_nulls(json_build_object(\'id\', new."id")),\n                jsonb_build_object(\'draft_id\', new."draft_id", \'electric_user_id\', new."electric_user_id", \'id\', new."id", \'tag_id\', new."tag_id"),\n                NULL,\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER insert_public_draft_tags_into_oplog\n          AFTER INSERT ON "public"."draft_tags"\n            FOR EACH ROW\n              EXECUTE FUNCTION insert_public_draft_tags_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS update_public_draft_tags_into_oplog ON "public"."draft_tags";',
      '        CREATE OR REPLACE FUNCTION update_public_draft_tags_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'draft_tags\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'draft_tags\',\n                \'UPDATE\',\n                json_strip_nulls(json_build_object(\'id\', new."id")),\n                jsonb_build_object(\'draft_id\', new."draft_id", \'electric_user_id\', new."electric_user_id", \'id\', new."id", \'tag_id\', new."tag_id"),\n                jsonb_build_object(\'draft_id\', old."draft_id", \'electric_user_id\', old."electric_user_id", \'id\', old."id", \'tag_id\', old."tag_id"),\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER update_public_draft_tags_into_oplog\n          AFTER UPDATE ON "public"."draft_tags"\n            FOR EACH ROW\n              EXECUTE FUNCTION update_public_draft_tags_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS delete_public_draft_tags_into_oplog ON "public"."draft_tags";',
      '        CREATE OR REPLACE FUNCTION delete_public_draft_tags_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n          BEGIN\n            -- Get the flag value from _electric_trigger_settings\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'draft_tags\';\n    \n            IF flag_value = 1 THEN\n              -- Insert into _electric_oplog\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              VALUES (\n                \'public\',\n                \'draft_tags\',\n                \'DELETE\',\n                json_strip_nulls(json_build_object(\'id\', old."id")),\n                NULL,\n                jsonb_build_object(\'draft_id\', old."draft_id", \'electric_user_id\', old."electric_user_id", \'id\', old."id", \'tag_id\', old."tag_id"),\n                NULL\n              );\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n      ',
      '        CREATE TRIGGER delete_public_draft_tags_into_oplog\n          AFTER DELETE ON "public"."draft_tags"\n            FOR EACH ROW\n              EXECUTE FUNCTION delete_public_draft_tags_into_oplog_function();\n      ',
      'DROP TRIGGER IF EXISTS compensation_insert_public_draft_tags_draft_id_into_oplog ON "public"."draft_tags";',
      '        CREATE OR REPLACE FUNCTION compensation_insert_public_draft_tags_draft_id_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n            meta_value INTEGER;\n          BEGIN\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'draft_tags\';\n    \n            SELECT value INTO meta_value FROM "public"._electric_meta WHERE key = \'compensations\';\n    \n            IF flag_value = 1 AND meta_value = 1 THEN\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              SELECT\n                \'public\',\n                \'drafts\',\n                \'COMPENSATION\',\n                json_strip_nulls(json_strip_nulls(json_build_object(\'id\', "id"))),\n                jsonb_build_object(\'id\', "id"),\n                NULL,\n                NULL\n              FROM "public"."drafts"\n              WHERE "id" = NEW."draft_id";\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n        ',
      '          CREATE TRIGGER compensation_insert_public_draft_tags_draft_id_into_oplog\n            AFTER INSERT ON "public"."draft_tags"\n              FOR EACH ROW\n                EXECUTE FUNCTION compensation_insert_public_draft_tags_draft_id_into_oplog_function();\n        ',
      'DROP TRIGGER IF EXISTS compensation_update_public_draft_tags_draft_id_into_oplog ON "public"."draft_tags";',
      '        CREATE OR REPLACE FUNCTION compensation_update_public_draft_tags_draft_id_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n            meta_value INTEGER;\n          BEGIN\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'draft_tags\';\n    \n            SELECT value INTO meta_value FROM "public"._electric_meta WHERE key = \'compensations\';\n    \n            IF flag_value = 1 AND meta_value = 1 THEN\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              SELECT\n                \'public\',\n                \'drafts\',\n                \'COMPENSATION\',\n                json_strip_nulls(json_strip_nulls(json_build_object(\'id\', "id"))),\n                jsonb_build_object(\'id\', "id"),\n                NULL,\n                NULL\n              FROM "public"."drafts"\n              WHERE "id" = NEW."draft_id";\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n        ',
      '          CREATE TRIGGER compensation_update_public_draft_tags_draft_id_into_oplog\n            AFTER UPDATE ON "public"."draft_tags"\n              FOR EACH ROW\n                EXECUTE FUNCTION compensation_update_public_draft_tags_draft_id_into_oplog_function();\n        ',
      'DROP TRIGGER IF EXISTS compensation_insert_public_draft_tags_tag_id_into_oplog ON "public"."draft_tags";',
      '        CREATE OR REPLACE FUNCTION compensation_insert_public_draft_tags_tag_id_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n            meta_value INTEGER;\n          BEGIN\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'draft_tags\';\n    \n            SELECT value INTO meta_value FROM "public"._electric_meta WHERE key = \'compensations\';\n    \n            IF flag_value = 1 AND meta_value = 1 THEN\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              SELECT\n                \'public\',\n                \'tags\',\n                \'COMPENSATION\',\n                json_strip_nulls(json_strip_nulls(json_build_object(\'id\', "id"))),\n                jsonb_build_object(\'id\', "id"),\n                NULL,\n                NULL\n              FROM "public"."tags"\n              WHERE "id" = NEW."tag_id";\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n        ',
      '          CREATE TRIGGER compensation_insert_public_draft_tags_tag_id_into_oplog\n            AFTER INSERT ON "public"."draft_tags"\n              FOR EACH ROW\n                EXECUTE FUNCTION compensation_insert_public_draft_tags_tag_id_into_oplog_function();\n        ',
      'DROP TRIGGER IF EXISTS compensation_update_public_draft_tags_tag_id_into_oplog ON "public"."draft_tags";',
      '        CREATE OR REPLACE FUNCTION compensation_update_public_draft_tags_tag_id_into_oplog_function()\n        RETURNS TRIGGER AS \$\$\n        BEGIN\n          DECLARE\n            flag_value INTEGER;\n            meta_value INTEGER;\n          BEGIN\n            SELECT flag INTO flag_value FROM "public"._electric_trigger_settings WHERE namespace = \'public\' AND tablename = \'draft_tags\';\n    \n            SELECT value INTO meta_value FROM "public"._electric_meta WHERE key = \'compensations\';\n    \n            IF flag_value = 1 AND meta_value = 1 THEN\n              INSERT INTO "public"._electric_oplog (namespace, tablename, optype, "primaryKey", "newRow", "oldRow", timestamp)\n              SELECT\n                \'public\',\n                \'tags\',\n                \'COMPENSATION\',\n                json_strip_nulls(json_strip_nulls(json_build_object(\'id\', "id"))),\n                jsonb_build_object(\'id\', "id"),\n                NULL,\n                NULL\n              FROM "public"."tags"\n              WHERE "id" = NEW."tag_id";\n            END IF;\n    \n            RETURN NEW;\n          END;\n        END;\n        \$\$ LANGUAGE plpgsql;\n        ',
      '          CREATE TRIGGER compensation_update_public_draft_tags_tag_id_into_oplog\n            AFTER UPDATE ON "public"."draft_tags"\n              FOR EACH ROW\n                EXECUTE FUNCTION compensation_update_public_draft_tags_tag_id_into_oplog_function();\n        ',
    ],
    version: '20240624030134',
  ),
];
