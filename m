From: David =?utf-8?b?SMOkcmRlbWFu?= <david@hardeman.nu>
Subject: [PATCH 2/4] ir-core: centralize sysfs raw decoder enabling/disabling
Date: Sat, 24 Apr 2010 23:14:06 +0200
Message-ID: <20100424211406.11570.96241.stgit@localhost.localdomain>
References: <20100424210843.11570.82007.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100424210843.11570.82007.stgit@localhost.localdomain>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@redhat.com
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

With the current logic, each raw decoder needs to add a copy of the exa=
ct
same sysfs code. This is both unnecessary and also means that (re)loadi=
ng
an IR driver after raw decoder modules have been loaded won't work as
expected.

This patch moves that logic into ir-raw-event and adds a single sysfs
file per device.

Reading that file returns something like:

	"rc5 [rc6] nec jvc [sony]"

(with enabled protocols in [] brackets)

Writing either "+protocol" or "-protocol" to that file will
enable or disable the according protocol decoder.

An additional benefit is that the disabling of a decoder will be
remembered across module removal/insertion so a previously
disabled decoder won't suddenly be activated again. The default
setting is to enable all decoders.

This is also necessary for the next patch which moves even more decoder
state into the central raw decoding structs.

Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
---
 drivers/media/IR/ir-core-priv.h    |    3=20
 drivers/media/IR/ir-jvc-decoder.c  |   64 ---------
 drivers/media/IR/ir-nec-decoder.c  |   64 ---------
 drivers/media/IR/ir-raw-event.c    |  112 +++++++++-------
 drivers/media/IR/ir-rc5-decoder.c  |   64 ---------
 drivers/media/IR/ir-rc6-decoder.c  |   64 ---------
 drivers/media/IR/ir-sony-decoder.c |   64 ---------
 drivers/media/IR/ir-sysfs.c        |  252 +++++++++++++++++++++-------=
--------
 8 files changed, 231 insertions(+), 456 deletions(-)

diff --git a/drivers/media/IR/ir-core-priv.h b/drivers/media/IR/ir-core=
-priv.h
index 04962a6..821d012 100644
--- a/drivers/media/IR/ir-core-priv.h
+++ b/drivers/media/IR/ir-core-priv.h
@@ -21,6 +21,7 @@
 struct ir_raw_handler {
 	struct list_head list;
=20
+	u64 protocols; /* which are handled by this handler */
 	int (*decode)(struct input_dev *input_dev, struct ir_raw_event event)=
;
 	int (*raw_register)(struct input_dev *input_dev);
 	int (*raw_unregister)(struct input_dev *input_dev);
@@ -32,6 +33,7 @@ struct ir_raw_event_ctrl {
 	ktime_t				last_event;	/* when last event occurred */
 	enum raw_event_type		last_type;	/* last event type */
 	struct input_dev		*input_dev;	/* pointer to the parent input_dev */
+	u64				enabled_protocols; /* enabled raw protocol decoders */
 };
=20
 /* macros for IR decoders */
@@ -76,6 +78,7 @@ void ir_unregister_class(struct input_dev *input_dev)=
;
 /*
  * Routines from ir-raw-event.c to be used internally and by decoders
  */
+u64 ir_raw_get_allowed_protocols(void);
 int ir_raw_event_register(struct input_dev *input_dev);
 void ir_raw_event_unregister(struct input_dev *input_dev);
 int ir_raw_handler_register(struct ir_raw_handler *ir_raw_handler);
diff --git a/drivers/media/IR/ir-jvc-decoder.c b/drivers/media/IR/ir-jv=
c-decoder.c
index 0b80494..1055de4 100644
--- a/drivers/media/IR/ir-jvc-decoder.c
+++ b/drivers/media/IR/ir-jvc-decoder.c
@@ -41,7 +41,6 @@ enum jvc_state {
 struct decoder_data {
 	struct list_head	list;
 	struct ir_input_dev	*ir_dev;
-	int			enabled:1;
=20
 	/* State machine control */
 	enum jvc_state		state;
@@ -72,53 +71,6 @@ static struct decoder_data *get_decoder_data(struct =
 ir_input_dev *ir_dev)
 	return data;
 }
=20
-static ssize_t store_enabled(struct device *d,
-			     struct device_attribute *mattr,
-			     const char *buf,
-			     size_t len)
-{
-	unsigned long value;
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (strict_strtoul(buf, 10, &value) || value > 1)
-		return -EINVAL;
-
-	data->enabled =3D value;
-
-	return len;
-}
-
-static ssize_t show_enabled(struct device *d,
-			     struct device_attribute *mattr, char *buf)
-{
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (data->enabled)
-		return sprintf(buf, "1\n");
-	else
-	return sprintf(buf, "0\n");
-}
-
-static DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR, show_enabled, store_ena=
bled);
-
-static struct attribute *decoder_attributes[] =3D {
-	&dev_attr_enabled.attr,
-	NULL
-};
-
-static struct attribute_group decoder_attribute_group =3D {
-	.name	=3D "jvc_decoder",
-	.attrs	=3D decoder_attributes,
-};
-
 /**
  * ir_jvc_decode() - Decode one JVC pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
@@ -135,7 +87,7 @@ static int ir_jvc_decode(struct input_dev *input_dev=
, struct ir_raw_event ev)
 	if (!data)
 		return -EINVAL;
=20
-	if (!data->enabled)
+	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_JVC))
 		return 0;
=20
 	if (IS_RESET(ev)) {
@@ -253,21 +205,12 @@ static int ir_jvc_register(struct input_dev *inpu=
t_dev)
 {
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
 	struct decoder_data *data;
-	int rc;
-
-	rc =3D sysfs_create_group(&ir_dev->dev.kobj, &decoder_attribute_group=
);
-	if (rc < 0)
-		return rc;
=20
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
+	if (!data)
 		return -ENOMEM;
-	}
=20
 	data->ir_dev =3D ir_dev;
-	data->enabled =3D 1;
-
 	spin_lock(&decoder_lock);
 	list_add_tail(&data->list, &decoder_list);
 	spin_unlock(&decoder_lock);
@@ -284,8 +227,6 @@ static int ir_jvc_unregister(struct input_dev *inpu=
t_dev)
 	if (!data)
 		return 0;
=20
-	sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
-
 	spin_lock(&decoder_lock);
 	list_del(&data->list);
 	spin_unlock(&decoder_lock);
@@ -294,6 +235,7 @@ static int ir_jvc_unregister(struct input_dev *inpu=
t_dev)
 }
=20
 static struct ir_raw_handler jvc_handler =3D {
+	.protocols	=3D IR_TYPE_JVC,
 	.decode		=3D ir_jvc_decode,
 	.raw_register	=3D ir_jvc_register,
 	.raw_unregister	=3D ir_jvc_unregister,
diff --git a/drivers/media/IR/ir-nec-decoder.c b/drivers/media/IR/ir-ne=
c-decoder.c
index ba79233..2cc2b92 100644
--- a/drivers/media/IR/ir-nec-decoder.c
+++ b/drivers/media/IR/ir-nec-decoder.c
@@ -43,7 +43,6 @@ enum nec_state {
 struct decoder_data {
 	struct list_head	list;
 	struct ir_input_dev	*ir_dev;
-	int			enabled:1;
=20
 	/* State machine control */
 	enum nec_state		state;
@@ -71,53 +70,6 @@ static struct decoder_data *get_decoder_data(struct =
 ir_input_dev *ir_dev)
 	return data;
 }
=20
-static ssize_t store_enabled(struct device *d,
-			     struct device_attribute *mattr,
-			     const char *buf,
-			     size_t len)
-{
-	unsigned long value;
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (strict_strtoul(buf, 10, &value) || value > 1)
-		return -EINVAL;
-
-	data->enabled =3D value;
-
-	return len;
-}
-
-static ssize_t show_enabled(struct device *d,
-			     struct device_attribute *mattr, char *buf)
-{
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (data->enabled)
-		return sprintf(buf, "1\n");
-	else
-	return sprintf(buf, "0\n");
-}
-
-static DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR, show_enabled, store_ena=
bled);
-
-static struct attribute *decoder_attributes[] =3D {
-	&dev_attr_enabled.attr,
-	NULL
-};
-
-static struct attribute_group decoder_attribute_group =3D {
-	.name	=3D "nec_decoder",
-	.attrs	=3D decoder_attributes,
-};
-
 /**
  * ir_nec_decode() - Decode one NEC pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
@@ -136,7 +88,7 @@ static int ir_nec_decode(struct input_dev *input_dev=
, struct ir_raw_event ev)
 	if (!data)
 		return -EINVAL;
=20
-	if (!data->enabled)
+	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_NEC))
 		return 0;
=20
 	if (IS_RESET(ev)) {
@@ -260,21 +212,12 @@ static int ir_nec_register(struct input_dev *inpu=
t_dev)
 {
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
 	struct decoder_data *data;
-	int rc;
-
-	rc =3D sysfs_create_group(&ir_dev->dev.kobj, &decoder_attribute_group=
);
-	if (rc < 0)
-		return rc;
=20
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
+	if (!data)
 		return -ENOMEM;
-	}
=20
 	data->ir_dev =3D ir_dev;
-	data->enabled =3D 1;
-
 	spin_lock(&decoder_lock);
 	list_add_tail(&data->list, &decoder_list);
 	spin_unlock(&decoder_lock);
@@ -291,8 +234,6 @@ static int ir_nec_unregister(struct input_dev *inpu=
t_dev)
 	if (!data)
 		return 0;
=20
-	sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
-
 	spin_lock(&decoder_lock);
 	list_del(&data->list);
 	spin_unlock(&decoder_lock);
@@ -301,6 +242,7 @@ static int ir_nec_unregister(struct input_dev *inpu=
t_dev)
 }
=20
 static struct ir_raw_handler nec_handler =3D {
+	.protocols	=3D IR_TYPE_NEC,
 	.decode		=3D ir_nec_decode,
 	.raw_register	=3D ir_nec_register,
 	.raw_unregister	=3D ir_nec_unregister,
diff --git a/drivers/media/IR/ir-raw-event.c b/drivers/media/IR/ir-raw-=
event.c
index ea68a3f..eeca8a8 100644
--- a/drivers/media/IR/ir-raw-event.c
+++ b/drivers/media/IR/ir-raw-event.c
@@ -21,8 +21,9 @@
 #define MAX_IR_EVENT_SIZE      512
=20
 /* Used to handle IR raw handler extensions */
-static LIST_HEAD(ir_raw_handler_list);
 static DEFINE_SPINLOCK(ir_raw_handler_lock);
+static LIST_HEAD(ir_raw_handler_list);
+static u64 available_protocols;
=20
 /**
  * RUN_DECODER()	- runs an operation on all IR decoders
@@ -65,52 +66,6 @@ static void ir_raw_event_work(struct work_struct *wo=
rk)
 		RUN_DECODER(decode, raw->input_dev, ev);
 }
=20
-int ir_raw_event_register(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
-	int rc;
-
-	ir->raw =3D kzalloc(sizeof(*ir->raw), GFP_KERNEL);
-	if (!ir->raw)
-		return -ENOMEM;
-
-	ir->raw->input_dev =3D input_dev;
-	INIT_WORK(&ir->raw->rx_work, ir_raw_event_work);
-
-	rc =3D kfifo_alloc(&ir->raw->kfifo, sizeof(s64) * MAX_IR_EVENT_SIZE,
-			 GFP_KERNEL);
-	if (rc < 0) {
-		kfree(ir->raw);
-		ir->raw =3D NULL;
-		return rc;
-	}
-
-	rc =3D RUN_DECODER(raw_register, input_dev);
-	if (rc < 0) {
-		kfifo_free(&ir->raw->kfifo);
-		kfree(ir->raw);
-		ir->raw =3D NULL;
-		return rc;
-	}
-
-	return rc;
-}
-
-void ir_raw_event_unregister(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
-
-	if (!ir->raw)
-		return;
-
-	cancel_work_sync(&ir->raw->rx_work);
-	RUN_DECODER(raw_unregister, input_dev);
-
-	kfifo_free(&ir->raw->kfifo);
-	kfree(ir->raw);
-	ir->raw =3D NULL;
-}
-
 /**
  * ir_raw_event_store() - pass a pulse/space duration to the raw ir de=
coders
  * @input_dev:	the struct input_dev device descriptor
@@ -204,6 +159,66 @@ void ir_raw_event_handle(struct input_dev *input_d=
ev)
 }
 EXPORT_SYMBOL_GPL(ir_raw_event_handle);
=20
+/* used internally by the sysfs interface */
+u64
+ir_raw_get_allowed_protocols()
+{
+	u64 protocols;
+	spin_lock(&ir_raw_handler_lock);
+	protocols =3D available_protocols;
+	spin_unlock(&ir_raw_handler_lock);
+	return protocols;
+}
+
+/*
+ * Used to (un)register raw event clients
+ */
+int ir_raw_event_register(struct input_dev *input_dev)
+{
+	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
+	int rc;
+
+	ir->raw =3D kzalloc(sizeof(*ir->raw), GFP_KERNEL);
+	if (!ir->raw)
+		return -ENOMEM;
+
+	ir->raw->input_dev =3D input_dev;
+	INIT_WORK(&ir->raw->rx_work, ir_raw_event_work);
+	ir->raw->enabled_protocols =3D ~0;
+	rc =3D kfifo_alloc(&ir->raw->kfifo, sizeof(s64) * MAX_IR_EVENT_SIZE,
+			 GFP_KERNEL);
+	if (rc < 0) {
+		kfree(ir->raw);
+		ir->raw =3D NULL;
+		return rc;
+	}
+
+	rc =3D RUN_DECODER(raw_register, input_dev);
+	if (rc < 0) {
+		kfifo_free(&ir->raw->kfifo);
+		kfree(ir->raw);
+		ir->raw =3D NULL;
+		return rc;
+	}
+
+	return rc;
+}
+
+void ir_raw_event_unregister(struct input_dev *input_dev)
+{
+	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
+
+	if (!ir->raw)
+		return;
+
+	cancel_work_sync(&ir->raw->rx_work);
+	RUN_DECODER(raw_unregister, input_dev);
+
+	kfifo_free(&ir->raw->kfifo);
+	kfree(ir->raw);
+	ir->raw =3D NULL;
+}
+
 /*
  * Extension interface - used to register the IR decoders
  */
@@ -212,7 +227,9 @@ int ir_raw_handler_register(struct ir_raw_handler *=
ir_raw_handler)
 {
 	spin_lock(&ir_raw_handler_lock);
 	list_add_tail(&ir_raw_handler->list, &ir_raw_handler_list);
+	available_protocols |=3D ir_raw_handler->protocols;
 	spin_unlock(&ir_raw_handler_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL(ir_raw_handler_register);
@@ -221,6 +238,7 @@ void ir_raw_handler_unregister(struct ir_raw_handle=
r *ir_raw_handler)
 {
 	spin_lock(&ir_raw_handler_lock);
 	list_del(&ir_raw_handler->list);
+	available_protocols &=3D ~ir_raw_handler->protocols;
 	spin_unlock(&ir_raw_handler_lock);
 }
 EXPORT_SYMBOL(ir_raw_handler_unregister);
diff --git a/drivers/media/IR/ir-rc5-decoder.c b/drivers/media/IR/ir-rc=
5-decoder.c
index 23cdb1b..1be8981 100644
--- a/drivers/media/IR/ir-rc5-decoder.c
+++ b/drivers/media/IR/ir-rc5-decoder.c
@@ -45,7 +45,6 @@ enum rc5_state {
 struct decoder_data {
 	struct list_head	list;
 	struct ir_input_dev	*ir_dev;
-	int			enabled:1;
=20
 	/* State machine control */
 	enum rc5_state		state;
@@ -76,53 +75,6 @@ static struct decoder_data *get_decoder_data(struct =
 ir_input_dev *ir_dev)
 	return data;
 }
=20
-static ssize_t store_enabled(struct device *d,
-			     struct device_attribute *mattr,
-			     const char *buf,
-			     size_t len)
-{
-	unsigned long value;
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (strict_strtoul(buf, 10, &value) || value > 1)
-		return -EINVAL;
-
-	data->enabled =3D value;
-
-	return len;
-}
-
-static ssize_t show_enabled(struct device *d,
-			     struct device_attribute *mattr, char *buf)
-{
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (data->enabled)
-		return sprintf(buf, "1\n");
-	else
-	return sprintf(buf, "0\n");
-}
-
-static DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR, show_enabled, store_ena=
bled);
-
-static struct attribute *decoder_attributes[] =3D {
-	&dev_attr_enabled.attr,
-	NULL
-};
-
-static struct attribute_group decoder_attribute_group =3D {
-	.name	=3D "rc5_decoder",
-	.attrs	=3D decoder_attributes,
-};
-
 /**
  * ir_rc5_decode() - Decode one RC-5 pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
@@ -141,7 +93,7 @@ static int ir_rc5_decode(struct input_dev *input_dev=
, struct ir_raw_event ev)
 	if (!data)
 		return -EINVAL;
=20
-	if (!data->enabled)
+	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_RC5))
 		return 0;
=20
 	if (IS_RESET(ev)) {
@@ -256,21 +208,12 @@ static int ir_rc5_register(struct input_dev *inpu=
t_dev)
 {
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
 	struct decoder_data *data;
-	int rc;
-
-	rc =3D sysfs_create_group(&ir_dev->dev.kobj, &decoder_attribute_group=
);
-	if (rc < 0)
-		return rc;
=20
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
+	if (!data)
 		return -ENOMEM;
-	}
=20
 	data->ir_dev =3D ir_dev;
-	data->enabled =3D 1;
-
 	spin_lock(&decoder_lock);
 	list_add_tail(&data->list, &decoder_list);
 	spin_unlock(&decoder_lock);
@@ -287,8 +230,6 @@ static int ir_rc5_unregister(struct input_dev *inpu=
t_dev)
 	if (!data)
 		return 0;
=20
-	sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
-
 	spin_lock(&decoder_lock);
 	list_del(&data->list);
 	spin_unlock(&decoder_lock);
@@ -297,6 +238,7 @@ static int ir_rc5_unregister(struct input_dev *inpu=
t_dev)
 }
=20
 static struct ir_raw_handler rc5_handler =3D {
+	.protocols	=3D IR_TYPE_RC5,
 	.decode		=3D ir_rc5_decode,
 	.raw_register	=3D ir_rc5_register,
 	.raw_unregister	=3D ir_rc5_unregister,
diff --git a/drivers/media/IR/ir-rc6-decoder.c b/drivers/media/IR/ir-rc=
6-decoder.c
index 2bf479f..5e940a8 100644
--- a/drivers/media/IR/ir-rc6-decoder.c
+++ b/drivers/media/IR/ir-rc6-decoder.c
@@ -61,7 +61,6 @@ enum rc6_state {
 struct decoder_data {
 	struct list_head	list;
 	struct ir_input_dev	*ir_dev;
-	int			enabled:1;
=20
 	/* State machine control */
 	enum rc6_state		state;
@@ -93,53 +92,6 @@ static struct decoder_data *get_decoder_data(struct =
 ir_input_dev *ir_dev)
 	return data;
 }
=20
-static ssize_t store_enabled(struct device *d,
-			     struct device_attribute *mattr,
-			     const char *buf,
-			     size_t len)
-{
-	unsigned long value;
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (strict_strtoul(buf, 10, &value) || value > 1)
-		return -EINVAL;
-
-	data->enabled =3D value;
-
-	return len;
-}
-
-static ssize_t show_enabled(struct device *d,
-			     struct device_attribute *mattr, char *buf)
-{
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (data->enabled)
-		return sprintf(buf, "1\n");
-	else
-	return sprintf(buf, "0\n");
-}
-
-static DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR, show_enabled, store_ena=
bled);
-
-static struct attribute *decoder_attributes[] =3D {
-	&dev_attr_enabled.attr,
-	NULL
-};
-
-static struct attribute_group decoder_attribute_group =3D {
-	.name	=3D "rc6_decoder",
-	.attrs	=3D decoder_attributes,
-};
-
 static enum rc6_mode rc6_mode(struct decoder_data *data) {
 	switch (data->header & RC6_MODE_MASK) {
 	case 0:
@@ -171,7 +123,7 @@ static int ir_rc6_decode(struct input_dev *input_de=
v, struct ir_raw_event ev)
 	if (!data)
 		return -EINVAL;
=20
-	if (!data->enabled)
+	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_RC6))
 		return 0;
=20
 	if (IS_RESET(ev)) {
@@ -352,21 +304,12 @@ static int ir_rc6_register(struct input_dev *inpu=
t_dev)
 {
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
 	struct decoder_data *data;
-	int rc;
-
-	rc =3D sysfs_create_group(&ir_dev->dev.kobj, &decoder_attribute_group=
);
-	if (rc < 0)
-		return rc;
=20
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
+	if (!data)
 		return -ENOMEM;
-	}
=20
 	data->ir_dev =3D ir_dev;
-	data->enabled =3D 1;
-
 	spin_lock(&decoder_lock);
 	list_add_tail(&data->list, &decoder_list);
 	spin_unlock(&decoder_lock);
@@ -383,8 +326,6 @@ static int ir_rc6_unregister(struct input_dev *inpu=
t_dev)
 	if (!data)
 		return 0;
=20
-	sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
-
 	spin_lock(&decoder_lock);
 	list_del(&data->list);
 	spin_unlock(&decoder_lock);
@@ -393,6 +334,7 @@ static int ir_rc6_unregister(struct input_dev *inpu=
t_dev)
 }
=20
 static struct ir_raw_handler rc6_handler =3D {
+	.protocols	=3D IR_TYPE_RC6,
 	.decode		=3D ir_rc6_decode,
 	.raw_register	=3D ir_rc6_register,
 	.raw_unregister	=3D ir_rc6_unregister,
diff --git a/drivers/media/IR/ir-sony-decoder.c b/drivers/media/IR/ir-s=
ony-decoder.c
index 9f440c5..8afd16a 100644
--- a/drivers/media/IR/ir-sony-decoder.c
+++ b/drivers/media/IR/ir-sony-decoder.c
@@ -38,7 +38,6 @@ enum sony_state {
 struct decoder_data {
 	struct list_head	list;
 	struct ir_input_dev	*ir_dev;
-	int			enabled:1;
=20
 	/* State machine control */
 	enum sony_state		state;
@@ -66,53 +65,6 @@ static struct decoder_data *get_decoder_data(struct =
 ir_input_dev *ir_dev)
 	return data;
 }
=20
-static ssize_t store_enabled(struct device *d,
-			     struct device_attribute *mattr,
-			     const char *buf,
-			     size_t len)
-{
-	unsigned long value;
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (strict_strtoul(buf, 10, &value) || value > 1)
-		return -EINVAL;
-
-	data->enabled =3D value;
-
-	return len;
-}
-
-static ssize_t show_enabled(struct device *d,
-			     struct device_attribute *mattr, char *buf)
-{
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	struct decoder_data *data =3D get_decoder_data(ir_dev);
-
-	if (!data)
-		return -EINVAL;
-
-	if (data->enabled)
-		return sprintf(buf, "1\n");
-	else
-	return sprintf(buf, "0\n");
-}
-
-static DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR, show_enabled, store_ena=
bled);
-
-static struct attribute *decoder_attributes[] =3D {
-	&dev_attr_enabled.attr,
-	NULL
-};
-
-static struct attribute_group decoder_attribute_group =3D {
-	.name	=3D "sony_decoder",
-	.attrs	=3D decoder_attributes,
-};
-
 /**
  * ir_sony_decode() - Decode one Sony pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
@@ -131,7 +83,7 @@ static int ir_sony_decode(struct input_dev *input_de=
v, struct ir_raw_event ev)
 	if (!data)
 		return -EINVAL;
=20
-	if (!data->enabled)
+	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_SONY))
 		return 0;
=20
 	if (IS_RESET(ev)) {
@@ -245,21 +197,12 @@ static int ir_sony_register(struct input_dev *inp=
ut_dev)
 {
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
 	struct decoder_data *data;
-	int rc;
-
-	rc =3D sysfs_create_group(&ir_dev->dev.kobj, &decoder_attribute_group=
);
-	if (rc < 0)
-		return rc;
=20
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
+	if (!data)
 		return -ENOMEM;
-	}
=20
 	data->ir_dev =3D ir_dev;
-	data->enabled =3D 1;
-
 	spin_lock(&decoder_lock);
 	list_add_tail(&data->list, &decoder_list);
 	spin_unlock(&decoder_lock);
@@ -276,8 +219,6 @@ static int ir_sony_unregister(struct input_dev *inp=
ut_dev)
 	if (!data)
 		return 0;
=20
-	sysfs_remove_group(&ir_dev->dev.kobj, &decoder_attribute_group);
-
 	spin_lock(&decoder_lock);
 	list_del(&data->list);
 	spin_unlock(&decoder_lock);
@@ -286,6 +227,7 @@ static int ir_sony_unregister(struct input_dev *inp=
ut_dev)
 }
=20
 static struct ir_raw_handler sony_handler =3D {
+	.protocols	=3D IR_TYPE_SONY,
 	.decode		=3D ir_sony_decode,
 	.raw_register	=3D ir_sony_register,
 	.raw_unregister	=3D ir_sony_unregister,
diff --git a/drivers/media/IR/ir-sysfs.c b/drivers/media/IR/ir-sysfs.c
index facca11..2efb475 100644
--- a/drivers/media/IR/ir-sysfs.c
+++ b/drivers/media/IR/ir-sysfs.c
@@ -33,122 +33,178 @@ static struct class ir_input_class =3D {
 };
=20
 /**
- * show_protocol() - shows the current IR protocol
+ * show_protocols() - shows the current IR protocol(s)
  * @d:		the device descriptor
  * @mattr:	the device attribute struct (unused)
  * @buf:	a pointer to the output buffer
  *
- * This routine is a callback routine for input read the IR protocol t=
ype.
- * it is trigged by reading /sys/class/rc/rc?/current_protocol.
- * It returns the protocol name, as understood by the driver.
+ * This routine is a callback routine for input read the IR protocol t=
ype(s).
+ * it is trigged by reading /sys/class/rc/rc?/protocols.
+ * It returns the protocol names of supported protocols.
+ * Enabled protocols are printed in brackets.
  */
-static ssize_t show_protocol(struct device *d,
-			     struct device_attribute *mattr, char *buf)
+static ssize_t show_protocols(struct device *d,
+			      struct device_attribute *mattr, char *buf)
 {
-	char *s;
 	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	u64 ir_type =3D ir_dev->rc_tab.ir_type;
-
-	IR_dprintk(1, "Current protocol is %lld\n", (long long)ir_type);
-
-	/* FIXME: doesn't support multiple protocols at the same time */
-	if (ir_type =3D=3D IR_TYPE_UNKNOWN)
-		s =3D "Unknown";
-	else if (ir_type =3D=3D IR_TYPE_RC5)
-		s =3D "rc-5";
-	else if (ir_type =3D=3D IR_TYPE_NEC)
-		s =3D "nec";
-	else if (ir_type =3D=3D IR_TYPE_RC6)
-		s =3D "rc6";
-	else if (ir_type =3D=3D IR_TYPE_JVC)
-		s =3D "jvc";
-	else if (ir_type =3D=3D IR_TYPE_SONY)
-		s =3D "sony";
-	else
-		s =3D "other";
+	u64 allowed, enabled;
+	char *tmp =3D buf;
+
+	if (ir_dev->props->driver_type =3D=3D RC_DRIVER_SCANCODE) {
+		enabled =3D ir_dev->rc_tab.ir_type;
+		allowed =3D ir_dev->props->allowed_protos;
+	} else {
+		enabled =3D ir_dev->raw->enabled_protocols;
+		allowed =3D ir_raw_get_allowed_protocols();
+	}
=20
-	return sprintf(buf, "%s\n", s);
+	IR_dprintk(1, "allowed - 0x%llx, enabled - 0x%llx\n",
+		   (long long)allowed,
+		   (long long)enabled);
+
+	if (allowed & enabled & IR_TYPE_UNKNOWN)
+		tmp +=3D sprintf(tmp, "[unknown] ");
+	else if (allowed & IR_TYPE_UNKNOWN)
+		tmp +=3D sprintf(tmp, "unknown ");
+
+	if (allowed & enabled & IR_TYPE_RC5)
+		tmp +=3D sprintf(tmp, "[rc5] ");
+	else if (allowed & IR_TYPE_RC5)
+		tmp +=3D sprintf(tmp, "rc5 ");
+
+	if (allowed & enabled & IR_TYPE_NEC)
+		tmp +=3D sprintf(tmp, "[nec] ");
+	else if (allowed & IR_TYPE_NEC)
+		tmp +=3D sprintf(tmp, "nec ");
+
+	if (allowed & enabled & IR_TYPE_RC6)
+		tmp +=3D sprintf(tmp, "[rc6] ");
+	else if (allowed & IR_TYPE_RC6)
+		tmp +=3D sprintf(tmp, "rc6 ");
+
+	if (allowed & enabled & IR_TYPE_JVC)
+		tmp +=3D sprintf(tmp, "[jvc] ");
+	else if (allowed & IR_TYPE_JVC)
+		tmp +=3D sprintf(tmp, "jvc ");
+
+	if (allowed & enabled & IR_TYPE_SONY)
+		tmp +=3D sprintf(tmp, "[sony] ");
+	else if (allowed & IR_TYPE_SONY)
+		tmp +=3D sprintf(tmp, "sony ");
+
+	if (tmp !=3D buf)
+		tmp--;
+	*tmp =3D '\n';
+	return tmp + 1 - buf;
 }
=20
 /**
- * store_protocol() - shows the current IR protocol
+ * store_protocols() - changes the current IR protocol(s)
  * @d:		the device descriptor
  * @mattr:	the device attribute struct (unused)
  * @buf:	a pointer to the input buffer
  * @len:	length of the input buffer
  *
  * This routine is a callback routine for changing the IR protocol typ=
e.
- * it is trigged by reading /sys/class/rc/rc?/current_protocol.
- * It changes the IR the protocol name, if the IR type is recognized
- * by the driver.
- * If an unknown protocol name is used, returns -EINVAL.
+ * It is trigged by writing to /sys/class/rc/rc?/protocols.
+ * Writing "+proto" will add a protocol to the list of enabled protoco=
ls.
+ * Writing "-proto" will remove a protocol from the list of enabled pr=
otocols.
+ * Writing "proto" will enable only "proto".
+ * Returns -EINVAL if an invalid protocol combination or unknown proto=
col name
+ * is used, otherwise @len.
  */
-static ssize_t store_protocol(struct device *d,
-			      struct device_attribute *mattr,
-			      const char *data,
-			      size_t len)
+static ssize_t store_protocols(struct device *d,
+			       struct device_attribute *mattr,
+			       const char *data,
+			       size_t len)
 {
 	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
-	u64 ir_type =3D 0;
-	int rc =3D -EINVAL;
+	bool enable, disable;
+	const char *tmp;
+	u64 type;
+	u64 mask;
+	int rc;
 	unsigned long flags;
-	char *buf;
-
-	while ((buf =3D strsep((char **) &data, " \n")) !=3D NULL) {
-		if (!strcasecmp(buf, "rc-5") || !strcasecmp(buf, "rc5"))
-			ir_type |=3D IR_TYPE_RC5;
-		if (!strcasecmp(buf, "nec"))
-			ir_type |=3D IR_TYPE_NEC;
-		if (!strcasecmp(buf, "jvc"))
-			ir_type |=3D IR_TYPE_JVC;
-		if (!strcasecmp(buf, "sony"))
-			ir_type |=3D IR_TYPE_SONY;
+
+	tmp =3D skip_spaces(data);
+
+	if (*tmp =3D=3D '+') {
+		enable =3D true;
+		disable =3D false;
+		tmp++;
+	} else if (*tmp =3D=3D '-') {
+		enable =3D false;
+		disable =3D true;
+		tmp++;
+	} else {
+		enable =3D false;
+		disable =3D false;
 	}
=20
-	if (!ir_type) {
+	if (!strncasecmp(tmp, "unknown", 7)) {
+		tmp +=3D 7;
+		mask =3D IR_TYPE_UNKNOWN;
+	} else if (!strncasecmp(tmp, "rc5", 3)) {
+		tmp +=3D 3;
+		mask =3D IR_TYPE_RC5;
+	} else if (!strncasecmp(tmp, "nec", 3)) {
+		tmp +=3D 3;
+		mask =3D IR_TYPE_NEC;
+	} else if (!strncasecmp(tmp, "rc6", 3)) {
+		tmp +=3D 3;
+		mask =3D IR_TYPE_RC6;
+	} else if (!strncasecmp(tmp, "jvc", 3)) {
+		tmp +=3D 3;
+		mask =3D IR_TYPE_JVC;
+	} else if (!strncasecmp(tmp, "sony", 4)) {
+		tmp +=3D 4;
+		mask =3D IR_TYPE_SONY;
+	} else {
 		IR_dprintk(1, "Unknown protocol\n");
 		return -EINVAL;
 	}
=20
-	if (ir_dev->props && ir_dev->props->change_protocol)
-		rc =3D ir_dev->props->change_protocol(ir_dev->props->priv,
-						    ir_type);
-
-	if (rc < 0) {
-		IR_dprintk(1, "Error setting protocol to %lld\n",
-			   (long long)ir_type);
+	tmp =3D skip_spaces(tmp);
+	if (*tmp !=3D '\0') {
+		IR_dprintk(1, "Invalid trailing characters\n");
 		return -EINVAL;
 	}
=20
-	spin_lock_irqsave(&ir_dev->rc_tab.lock, flags);
-	ir_dev->rc_tab.ir_type =3D ir_type;
-	spin_unlock_irqrestore(&ir_dev->rc_tab.lock, flags);
+	if (ir_dev->props->driver_type =3D=3D RC_DRIVER_SCANCODE)
+		type =3D ir_dev->rc_tab.ir_type;
+	else
+		type =3D ir_dev->raw->enabled_protocols;
=20
-	IR_dprintk(1, "Current protocol(s) is(are) %lld\n",
-		   (long long)ir_type);
+	if (enable)
+		type |=3D mask;
+	else if (disable)
+		type &=3D ~mask;
+	else
+		type =3D mask;
=20
-	return len;
-}
+	if (ir_dev->props && ir_dev->props->change_protocol) {
+		rc =3D ir_dev->props->change_protocol(ir_dev->props->priv,
+						    type);
+		if (rc < 0) {
+			IR_dprintk(1, "Error setting protocols to 0x%llx\n",
+				   (long long)type);
+			return -EINVAL;
+		}
+	}
=20
-static ssize_t show_supported_protocols(struct device *d,
-			     struct device_attribute *mattr, char *buf)
-{
-	char *orgbuf =3D buf;
-	struct ir_input_dev *ir_dev =3D dev_get_drvdata(d);
+	if (ir_dev->props->driver_type =3D=3D RC_DRIVER_SCANCODE) {
+		spin_lock_irqsave(&ir_dev->rc_tab.lock, flags);
+		ir_dev->rc_tab.ir_type =3D type;
+		spin_unlock_irqrestore(&ir_dev->rc_tab.lock, flags);
+	} else {
+		ir_dev->raw->enabled_protocols =3D type;
+	}
=20
-	/* FIXME: doesn't support multiple protocols at the same time */
-	if (ir_dev->props->allowed_protos =3D=3D IR_TYPE_UNKNOWN)
-		buf +=3D sprintf(buf, "unknown ");
-	if (ir_dev->props->allowed_protos & IR_TYPE_RC5)
-		buf +=3D sprintf(buf, "rc-5 ");
-	if (ir_dev->props->allowed_protos & IR_TYPE_NEC)
-		buf +=3D sprintf(buf, "nec ");
-	if (buf =3D=3D orgbuf)
-		buf +=3D sprintf(buf, "other ");
=20
-	buf +=3D sprintf(buf - 1, "\n");
+	IR_dprintk(1, "Current protocol(s): 0x%llx\n",
+		   (long long)type);
=20
-	return buf - orgbuf;
+	return len;
 }
=20
 #define ADD_HOTPLUG_VAR(fmt, val...)					\
@@ -158,7 +214,7 @@ static ssize_t show_supported_protocols(struct devi=
ce *d,
 			return err;					\
 	} while (0)
=20
-static int ir_dev_uevent(struct device *device, struct kobj_uevent_env=
 *env)
+static int rc_dev_uevent(struct device *device, struct kobj_uevent_env=
 *env)
 {
 	struct ir_input_dev *ir_dev =3D dev_get_drvdata(device);
=20
@@ -173,34 +229,26 @@ static int ir_dev_uevent(struct device *device, s=
truct kobj_uevent_env *env)
 /*
  * Static device attribute struct with the sysfs attributes for IR's
  */
-static DEVICE_ATTR(protocol, S_IRUGO | S_IWUSR,
-		   show_protocol, store_protocol);
+static DEVICE_ATTR(protocols, S_IRUGO | S_IWUSR,
+		   show_protocols, store_protocols);
=20
-static DEVICE_ATTR(supported_protocols, S_IRUGO | S_IWUSR,
-		   show_supported_protocols, NULL);
-
-static struct attribute *ir_hw_dev_attrs[] =3D {
-	&dev_attr_protocol.attr,
-	&dev_attr_supported_protocols.attr,
+static struct attribute *rc_dev_attrs[] =3D {
+	&dev_attr_protocols.attr,
 	NULL,
 };
=20
-static struct attribute_group ir_hw_dev_attr_grp =3D {
-	.attrs	=3D ir_hw_dev_attrs,
+static struct attribute_group rc_dev_attr_grp =3D {
+	.attrs	=3D rc_dev_attrs,
 };
=20
-static const struct attribute_group *ir_hw_dev_attr_groups[] =3D {
-	&ir_hw_dev_attr_grp,
+static const struct attribute_group *rc_dev_attr_groups[] =3D {
+	&rc_dev_attr_grp,
 	NULL
 };
=20
 static struct device_type rc_dev_type =3D {
-	.groups		=3D ir_hw_dev_attr_groups,
-	.uevent		=3D ir_dev_uevent,
-};
-
-static struct device_type ir_raw_dev_type =3D {
-	.uevent		=3D ir_dev_uevent,
+	.groups		=3D rc_dev_attr_groups,
+	.uevent		=3D rc_dev_uevent,
 };
=20
 /**
@@ -220,11 +268,7 @@ int ir_register_class(struct input_dev *input_dev)
 	if (unlikely(devno < 0))
 		return devno;
=20
-	if (ir_dev->props->driver_type =3D=3D RC_DRIVER_SCANCODE)
-		ir_dev->dev.type =3D &rc_dev_type;
-	else
-		ir_dev->dev.type =3D &ir_raw_dev_type;
-
+	ir_dev->dev.type =3D &rc_dev_type;
 	ir_dev->dev.class =3D &ir_input_class;
 	ir_dev->dev.parent =3D input_dev->dev.parent;
 	dev_set_name(&ir_dev->dev, "rc%d", devno);
