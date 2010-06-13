From: David =?utf-8?b?SMOkcmRlbWFu?= <david@hardeman.nu>
Subject: [PATCH 2/2] ir-core: move decoding state to ir_raw_event_ctrl
Date: Sun, 13 Jun 2010 22:29:36 +0200
Message-ID: <20100613202936.6044.99651.stgit@localhost.localdomain>
References: <20100613202718.6044.29599.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:46119 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab0FMU3k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jun 2010 16:29:40 -0400
In-Reply-To: <20100613202718.6044.29599.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jarod@wilsonet.com
Cc: jarod@redhat.com, linux-media@vger.kernel.org, mchehab@redhat.com, linux-input@vger.kernel.org

This patch moves the state from each raw decoder into the
ir_raw_event_ctrl struct.

This allows the removal of code like this:

        spin_lock(&decoder_lock);
        list_for_each_entry(data, &decoder_list, list) {
                if (data->ir_dev =3D=3D ir_dev)
                        break;
        }
        spin_unlock(&decoder_lock);
        return data;

which is currently run for each decoder on each event in order
to get the client-specific decoding state data.

In addition, ir decoding modules and ir driver module load
order is now independent. Centralizing the data also allows
for a nice code reduction of about 30% per raw decoder as
client lists and client registration callbacks are no longer
necessary (but still kept around for the benefit of the lirc
decoder).

Out-of-tree modules can still use a similar trick to what
the raw decoders did before this patch until they are merged.

Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
---
 drivers/media/IR/ir-core-priv.h    |   38 +++++++++++++
 drivers/media/IR/ir-jvc-decoder.c  |   90 ++--------------------------=
---
 drivers/media/IR/ir-nec-decoder.c  |   89 +++-------------------------=
---
 drivers/media/IR/ir-raw-event.c    |   74 +++++++++++++-------------
 drivers/media/IR/ir-rc5-decoder.c  |  103 +++++-----------------------=
--------
 drivers/media/IR/ir-rc6-decoder.c  |   92 ++--------------------------=
----
 drivers/media/IR/ir-sony-decoder.c |   93 +++-------------------------=
-----
 7 files changed, 118 insertions(+), 461 deletions(-)

diff --git a/drivers/media/IR/ir-core-priv.h b/drivers/media/IR/ir-core=
-priv.h
index 3072e55..9994af4 100644
--- a/drivers/media/IR/ir-core-priv.h
+++ b/drivers/media/IR/ir-core-priv.h
@@ -23,17 +23,55 @@ struct ir_raw_handler {
=20
 	u64 protocols; /* which are handled by this handler */
 	int (*decode)(struct input_dev *input_dev, struct ir_raw_event event)=
;
+
+	/* These two should only be used by the lirc decoder */
 	int (*raw_register)(struct input_dev *input_dev);
 	int (*raw_unregister)(struct input_dev *input_dev);
 };
=20
 struct ir_raw_event_ctrl {
+	struct list_head		list;		/* to keep track of raw clients */
 	struct work_struct		rx_work;	/* for the rx decoding workqueue */
 	struct kfifo			kfifo;		/* fifo for the pulse/space durations */
 	ktime_t				last_event;	/* when last event occurred */
 	enum raw_event_type		last_type;	/* last event type */
 	struct input_dev		*input_dev;	/* pointer to the parent input_dev */
 	u64				enabled_protocols; /* enabled raw protocol decoders */
+
+	/* raw decoder state follows */
+	struct ir_raw_event prev_ev;
+	struct nec_dec {
+		int state;
+		unsigned count;
+		u32 bits;
+	} nec;
+	struct rc5_dec {
+		int state;
+		u32 bits;
+		unsigned count;
+		unsigned wanted_bits;
+	} rc5;
+	struct rc6_dec {
+		int state;
+		u8 header;
+		u32 body;
+		bool toggle;
+		unsigned count;
+		unsigned wanted_bits;
+	} rc6;
+	struct sony_dec {
+		int state;
+		u32 bits;
+		unsigned count;
+	} sony;
+	struct jvc_dec {
+		int state;
+		u16 bits;
+		u16 old_bits;
+		unsigned count;
+		bool first;
+		bool toggle;
+	} jvc;
 };
=20
 /* macros for IR decoders */
diff --git a/drivers/media/IR/ir-jvc-decoder.c b/drivers/media/IR/ir-jv=
c-decoder.c
index 1055de4..8894d8b 100644
--- a/drivers/media/IR/ir-jvc-decoder.c
+++ b/drivers/media/IR/ir-jvc-decoder.c
@@ -25,10 +25,6 @@
 #define JVC_TRAILER_PULSE	(1  * JVC_UNIT)
 #define	JVC_TRAILER_SPACE	(35 * JVC_UNIT)
=20
-/* Used to register jvc_decoder clients */
-static LIST_HEAD(decoder_list);
-DEFINE_SPINLOCK(decoder_lock);
-
 enum jvc_state {
 	STATE_INACTIVE,
 	STATE_HEADER_SPACE,
@@ -38,39 +34,6 @@ enum jvc_state {
 	STATE_TRAILER_SPACE,
 };
=20
-struct decoder_data {
-	struct list_head	list;
-	struct ir_input_dev	*ir_dev;
-
-	/* State machine control */
-	enum jvc_state		state;
-	u16			jvc_bits;
-	u16			jvc_old_bits;
-	unsigned		count;
-	bool			first;
-	bool			toggle;
-};
-
-
-/**
- * get_decoder_data()	- gets decoder data
- * @input_dev:	input device
- *
- * Returns the struct decoder_data that corresponds to a device
- */
-static struct decoder_data *get_decoder_data(struct  ir_input_dev *ir_=
dev)
-{
-	struct decoder_data *data =3D NULL;
-
-	spin_lock(&decoder_lock);
-	list_for_each_entry(data, &decoder_list, list) {
-		if (data->ir_dev =3D=3D ir_dev)
-			break;
-	}
-	spin_unlock(&decoder_lock);
-	return data;
-}
-
 /**
  * ir_jvc_decode() - Decode one JVC pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
@@ -80,12 +43,8 @@ static struct decoder_data *get_decoder_data(struct =
 ir_input_dev *ir_dev)
  */
 static int ir_jvc_decode(struct input_dev *input_dev, struct ir_raw_ev=
ent ev)
 {
-	struct decoder_data *data;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return -EINVAL;
+	struct jvc_dec *data =3D &ir_dev->raw->jvc;
=20
 	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_JVC))
 		return 0;
@@ -140,9 +99,9 @@ static int ir_jvc_decode(struct input_dev *input_dev=
, struct ir_raw_event ev)
 		if (ev.pulse)
 			break;
=20
-		data->jvc_bits <<=3D 1;
+		data->bits <<=3D 1;
 		if (eq_margin(ev.duration, JVC_BIT_1_SPACE, JVC_UNIT / 2)) {
-			data->jvc_bits |=3D 1;
+			data->bits |=3D 1;
 			decrease_duration(&ev, JVC_BIT_1_SPACE);
 		} else if (eq_margin(ev.duration, JVC_BIT_0_SPACE, JVC_UNIT / 2))
 			decrease_duration(&ev, JVC_BIT_0_SPACE);
@@ -175,13 +134,13 @@ static int ir_jvc_decode(struct input_dev *input_=
dev, struct ir_raw_event ev)
=20
 		if (data->first) {
 			u32 scancode;
-			scancode =3D (bitrev8((data->jvc_bits >> 8) & 0xff) << 8) |
-				   (bitrev8((data->jvc_bits >> 0) & 0xff) << 0);
+			scancode =3D (bitrev8((data->bits >> 8) & 0xff) << 8) |
+				   (bitrev8((data->bits >> 0) & 0xff) << 0);
 			IR_dprintk(1, "JVC scancode 0x%04x\n", scancode);
 			ir_keydown(input_dev, scancode, data->toggle);
 			data->first =3D false;
-			data->jvc_old_bits =3D data->jvc_bits;
-		} else if (data->jvc_bits =3D=3D data->jvc_old_bits) {
+			data->old_bits =3D data->bits;
+		} else if (data->bits =3D=3D data->old_bits) {
 			IR_dprintk(1, "JVC repeat\n");
 			ir_repeat(input_dev);
 		} else {
@@ -201,44 +160,9 @@ out:
 	return -EINVAL;
 }
=20
-static int ir_jvc_register(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	struct decoder_data *data;
-
-	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->ir_dev =3D ir_dev;
-	spin_lock(&decoder_lock);
-	list_add_tail(&data->list, &decoder_list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
-static int ir_jvc_unregister(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	static struct decoder_data *data;
-
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return 0;
-
-	spin_lock(&decoder_lock);
-	list_del(&data->list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
 static struct ir_raw_handler jvc_handler =3D {
 	.protocols	=3D IR_TYPE_JVC,
 	.decode		=3D ir_jvc_decode,
-	.raw_register	=3D ir_jvc_register,
-	.raw_unregister	=3D ir_jvc_unregister,
 };
=20
 static int __init ir_jvc_decode_init(void)
diff --git a/drivers/media/IR/ir-nec-decoder.c b/drivers/media/IR/ir-ne=
c-decoder.c
index 2cc2b92..52e0f37 100644
--- a/drivers/media/IR/ir-nec-decoder.c
+++ b/drivers/media/IR/ir-nec-decoder.c
@@ -27,10 +27,6 @@
 #define	NEC_TRAILER_PULSE	(1  * NEC_UNIT)
 #define	NEC_TRAILER_SPACE	(10 * NEC_UNIT) /* even longer in reality */
=20
-/* Used to register nec_decoder clients */
-static LIST_HEAD(decoder_list);
-static DEFINE_SPINLOCK(decoder_lock);
-
 enum nec_state {
 	STATE_INACTIVE,
 	STATE_HEADER_SPACE,
@@ -40,36 +36,6 @@ enum nec_state {
 	STATE_TRAILER_SPACE,
 };
=20
-struct decoder_data {
-	struct list_head	list;
-	struct ir_input_dev	*ir_dev;
-
-	/* State machine control */
-	enum nec_state		state;
-	u32			nec_bits;
-	unsigned		count;
-};
-
-
-/**
- * get_decoder_data()	- gets decoder data
- * @input_dev:	input device
- *
- * Returns the struct decoder_data that corresponds to a device
- */
-static struct decoder_data *get_decoder_data(struct  ir_input_dev *ir_=
dev)
-{
-	struct decoder_data *data =3D NULL;
-
-	spin_lock(&decoder_lock);
-	list_for_each_entry(data, &decoder_list, list) {
-		if (data->ir_dev =3D=3D ir_dev)
-			break;
-	}
-	spin_unlock(&decoder_lock);
-	return data;
-}
-
 /**
  * ir_nec_decode() - Decode one NEC pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
@@ -79,15 +45,11 @@ static struct decoder_data *get_decoder_data(struct=
  ir_input_dev *ir_dev)
  */
 static int ir_nec_decode(struct input_dev *input_dev, struct ir_raw_ev=
ent ev)
 {
-	struct decoder_data *data;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
+	struct nec_dec *data =3D &ir_dev->raw->nec;
 	u32 scancode;
 	u8 address, not_address, command, not_command;
=20
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return -EINVAL;
-
 	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_NEC))
 		return 0;
=20
@@ -143,9 +105,9 @@ static int ir_nec_decode(struct input_dev *input_de=
v, struct ir_raw_event ev)
 		if (ev.pulse)
 			break;
=20
-		data->nec_bits <<=3D 1;
+		data->bits <<=3D 1;
 		if (eq_margin(ev.duration, NEC_BIT_1_SPACE, NEC_UNIT / 2))
-			data->nec_bits |=3D 1;
+			data->bits |=3D 1;
 		else if (!eq_margin(ev.duration, NEC_BIT_0_SPACE, NEC_UNIT / 2))
 			break;
 		data->count++;
@@ -174,14 +136,14 @@ static int ir_nec_decode(struct input_dev *input_=
dev, struct ir_raw_event ev)
 		if (!geq_margin(ev.duration, NEC_TRAILER_SPACE, NEC_UNIT / 2))
 			break;
=20
-		address     =3D bitrev8((data->nec_bits >> 24) & 0xff);
-		not_address =3D bitrev8((data->nec_bits >> 16) & 0xff);
-		command	    =3D bitrev8((data->nec_bits >>  8) & 0xff);
-		not_command =3D bitrev8((data->nec_bits >>  0) & 0xff);
+		address     =3D bitrev8((data->bits >> 24) & 0xff);
+		not_address =3D bitrev8((data->bits >> 16) & 0xff);
+		command	    =3D bitrev8((data->bits >>  8) & 0xff);
+		not_command =3D bitrev8((data->bits >>  0) & 0xff);
=20
 		if ((command ^ not_command) !=3D 0xff) {
 			IR_dprintk(1, "NEC checksum error: received 0x%08x\n",
-				   data->nec_bits);
+				   data->bits);
 			break;
 		}
=20
@@ -208,44 +170,9 @@ static int ir_nec_decode(struct input_dev *input_d=
ev, struct ir_raw_event ev)
 	return -EINVAL;
 }
=20
-static int ir_nec_register(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	struct decoder_data *data;
-
-	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->ir_dev =3D ir_dev;
-	spin_lock(&decoder_lock);
-	list_add_tail(&data->list, &decoder_list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
-static int ir_nec_unregister(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	static struct decoder_data *data;
-
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return 0;
-
-	spin_lock(&decoder_lock);
-	list_del(&data->list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
 static struct ir_raw_handler nec_handler =3D {
 	.protocols	=3D IR_TYPE_NEC,
 	.decode		=3D ir_nec_decode,
-	.raw_register	=3D ir_nec_register,
-	.raw_unregister	=3D ir_nec_unregister,
 };
=20
 static int __init ir_nec_decode_init(void)
diff --git a/drivers/media/IR/ir-raw-event.c b/drivers/media/IR/ir-raw-=
event.c
index eeca8a8..5f98ab8 100644
--- a/drivers/media/IR/ir-raw-event.c
+++ b/drivers/media/IR/ir-raw-event.c
@@ -20,37 +20,14 @@
 /* Define the max number of pulse/space transitions to buffer */
 #define MAX_IR_EVENT_SIZE      512
=20
+/* Used to keep track of IR raw clients, protected by ir_raw_handler_l=
ock */
+static LIST_HEAD(ir_raw_client_list);
+
 /* Used to handle IR raw handler extensions */
 static DEFINE_SPINLOCK(ir_raw_handler_lock);
 static LIST_HEAD(ir_raw_handler_list);
 static u64 available_protocols;
=20
-/**
- * RUN_DECODER()	- runs an operation on all IR decoders
- * @ops:	IR raw handler operation to be called
- * @arg:	arguments to be passed to the callback
- *
- * Calls ir_raw_handler::ops for all registered IR handlers. It preven=
ts
- * new decode addition/removal while running, by locking ir_raw_handle=
r_lock
- * mutex. If an error occurs, it stops the ops. Otherwise, it returns =
a sum
- * of the return codes.
- */
-#define RUN_DECODER(ops, ...) ({					    \
-	struct ir_raw_handler		*_ir_raw_handler;		    \
-	int _sumrc =3D 0, _rc;						    \
-	spin_lock(&ir_raw_handler_lock);				    \
-	list_for_each_entry(_ir_raw_handler, &ir_raw_handler_list, list) {  \
-		if (_ir_raw_handler->ops) {				    \
-			_rc =3D _ir_raw_handler->ops(__VA_ARGS__);	    \
-			if (_rc < 0)					    \
-				break;					    \
-			_sumrc +=3D _rc;					    \
-		}							    \
-	}								    \
-	spin_unlock(&ir_raw_handler_lock);				    \
-	_sumrc;								    \
-})
-
 #ifdef MODULE
 /* Used to load the decoders */
 static struct work_struct wq_load;
@@ -59,11 +36,17 @@ static struct work_struct wq_load;
 static void ir_raw_event_work(struct work_struct *work)
 {
 	struct ir_raw_event ev;
+	struct ir_raw_handler *handler;
 	struct ir_raw_event_ctrl *raw =3D
 		container_of(work, struct ir_raw_event_ctrl, rx_work);
=20
-	while (kfifo_out(&raw->kfifo, &ev, sizeof(ev)) =3D=3D sizeof(ev))
-		RUN_DECODER(decode, raw->input_dev, ev);
+	while (kfifo_out(&raw->kfifo, &ev, sizeof(ev)) =3D=3D sizeof(ev)) {
+		spin_lock(&ir_raw_handler_lock);
+		list_for_each_entry(handler, &ir_raw_handler_list, list)
+			handler->decode(raw->input_dev, ev);
+		spin_unlock(&ir_raw_handler_lock);
+		raw->prev_ev =3D ev;
+	}
 }
=20
 /**
@@ -177,6 +160,7 @@ int ir_raw_event_register(struct input_dev *input_d=
ev)
 {
 	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
 	int rc;
+	struct ir_raw_handler *handler;
=20
 	ir->raw =3D kzalloc(sizeof(*ir->raw), GFP_KERNEL);
 	if (!ir->raw)
@@ -193,26 +177,32 @@ int ir_raw_event_register(struct input_dev *input=
_dev)
 		return rc;
 	}
=20
-	rc =3D RUN_DECODER(raw_register, input_dev);
-	if (rc < 0) {
-		kfifo_free(&ir->raw->kfifo);
-		kfree(ir->raw);
-		ir->raw =3D NULL;
-		return rc;
-	}
+	spin_lock(&ir_raw_handler_lock);
+	list_add_tail(&ir->raw->list, &ir_raw_client_list);
+	list_for_each_entry(handler, &ir_raw_handler_list, list)
+		if (handler->raw_register)
+			handler->raw_register(ir->raw->input_dev);
+	spin_unlock(&ir_raw_handler_lock);
=20
-	return rc;
+	return 0;
 }
=20
 void ir_raw_event_unregister(struct input_dev *input_dev)
 {
 	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
+	struct ir_raw_handler *handler;
=20
 	if (!ir->raw)
 		return;
=20
 	cancel_work_sync(&ir->raw->rx_work);
-	RUN_DECODER(raw_unregister, input_dev);
+
+	spin_lock(&ir_raw_handler_lock);
+	list_del(&ir->raw->list);
+	list_for_each_entry(handler, &ir_raw_handler_list, list)
+		if (handler->raw_unregister)
+			handler->raw_unregister(ir->raw->input_dev);
+	spin_unlock(&ir_raw_handler_lock);
=20
 	kfifo_free(&ir->raw->kfifo);
 	kfree(ir->raw);
@@ -225,8 +215,13 @@ void ir_raw_event_unregister(struct input_dev *inp=
ut_dev)
=20
 int ir_raw_handler_register(struct ir_raw_handler *ir_raw_handler)
 {
+	struct ir_raw_event_ctrl *raw;
+
 	spin_lock(&ir_raw_handler_lock);
 	list_add_tail(&ir_raw_handler->list, &ir_raw_handler_list);
+	if (ir_raw_handler->raw_register)
+		list_for_each_entry(raw, &ir_raw_client_list, list)
+			ir_raw_handler->raw_register(raw->input_dev);
 	available_protocols |=3D ir_raw_handler->protocols;
 	spin_unlock(&ir_raw_handler_lock);
=20
@@ -236,8 +231,13 @@ EXPORT_SYMBOL(ir_raw_handler_register);
=20
 void ir_raw_handler_unregister(struct ir_raw_handler *ir_raw_handler)
 {
+	struct ir_raw_event_ctrl *raw;
+
 	spin_lock(&ir_raw_handler_lock);
 	list_del(&ir_raw_handler->list);
+	if (ir_raw_handler->raw_unregister)
+		list_for_each_entry(raw, &ir_raw_client_list, list)
+			ir_raw_handler->raw_unregister(raw->input_dev);
 	available_protocols &=3D ~ir_raw_handler->protocols;
 	spin_unlock(&ir_raw_handler_lock);
 }
diff --git a/drivers/media/IR/ir-rc5-decoder.c b/drivers/media/IR/ir-rc=
5-decoder.c
index 1be8981..7af656d 100644
--- a/drivers/media/IR/ir-rc5-decoder.c
+++ b/drivers/media/IR/ir-rc5-decoder.c
@@ -30,10 +30,6 @@
 #define RC5_BIT_END		(1 * RC5_UNIT)
 #define RC5X_SPACE		(4 * RC5_UNIT)
=20
-/* Used to register rc5_decoder clients */
-static LIST_HEAD(decoder_list);
-static DEFINE_SPINLOCK(decoder_lock);
-
 enum rc5_state {
 	STATE_INACTIVE,
 	STATE_BIT_START,
@@ -42,39 +38,6 @@ enum rc5_state {
 	STATE_FINISHED,
 };
=20
-struct decoder_data {
-	struct list_head	list;
-	struct ir_input_dev	*ir_dev;
-
-	/* State machine control */
-	enum rc5_state		state;
-	u32			rc5_bits;
-	struct ir_raw_event	prev_ev;
-	unsigned		count;
-	unsigned		wanted_bits;
-};
-
-
-/**
- * get_decoder_data()	- gets decoder data
- * @input_dev:	input device
- *
- * Returns the struct decoder_data that corresponds to a device
- */
-
-static struct decoder_data *get_decoder_data(struct  ir_input_dev *ir_=
dev)
-{
-	struct decoder_data *data =3D NULL;
-
-	spin_lock(&decoder_lock);
-	list_for_each_entry(data, &decoder_list, list) {
-		if (data->ir_dev =3D=3D ir_dev)
-			break;
-	}
-	spin_unlock(&decoder_lock);
-	return data;
-}
-
 /**
  * ir_rc5_decode() - Decode one RC-5 pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
@@ -84,15 +47,11 @@ static struct decoder_data *get_decoder_data(struct=
  ir_input_dev *ir_dev)
  */
 static int ir_rc5_decode(struct input_dev *input_dev, struct ir_raw_ev=
ent ev)
 {
-	struct decoder_data *data;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
+	struct rc5_dec *data =3D &ir_dev->raw->rc5;
 	u8 toggle;
 	u32 scancode;
=20
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return -EINVAL;
-
 	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_RC5))
 		return 0;
=20
@@ -128,16 +87,15 @@ again:
 		if (!eq_margin(ev.duration, RC5_BIT_START, RC5_UNIT / 2))
 			break;
=20
-		data->rc5_bits <<=3D 1;
+		data->bits <<=3D 1;
 		if (!ev.pulse)
-			data->rc5_bits |=3D 1;
+			data->bits |=3D 1;
 		data->count++;
-		data->prev_ev =3D ev;
 		data->state =3D STATE_BIT_END;
 		return 0;
=20
 	case STATE_BIT_END:
-		if (!is_transition(&ev, &data->prev_ev))
+		if (!is_transition(&ev, &ir_dev->raw->prev_ev))
 			break;
=20
 		if (data->count =3D=3D data->wanted_bits)
@@ -169,11 +127,11 @@ again:
 		if (data->wanted_bits =3D=3D RC5X_NBITS) {
 			/* RC5X */
 			u8 xdata, command, system;
-			xdata    =3D (data->rc5_bits & 0x0003F) >> 0;
-			command  =3D (data->rc5_bits & 0x00FC0) >> 6;
-			system   =3D (data->rc5_bits & 0x1F000) >> 12;
-			toggle   =3D (data->rc5_bits & 0x20000) ? 1 : 0;
-			command +=3D (data->rc5_bits & 0x01000) ? 0 : 0x40;
+			xdata    =3D (data->bits & 0x0003F) >> 0;
+			command  =3D (data->bits & 0x00FC0) >> 6;
+			system   =3D (data->bits & 0x1F000) >> 12;
+			toggle   =3D (data->bits & 0x20000) ? 1 : 0;
+			command +=3D (data->bits & 0x01000) ? 0 : 0x40;
 			scancode =3D system << 16 | command << 8 | xdata;
=20
 			IR_dprintk(1, "RC5X scancode 0x%06x (toggle: %u)\n",
@@ -182,10 +140,10 @@ again:
 		} else {
 			/* RC5 */
 			u8 command, system;
-			command  =3D (data->rc5_bits & 0x0003F) >> 0;
-			system   =3D (data->rc5_bits & 0x007C0) >> 6;
-			toggle   =3D (data->rc5_bits & 0x00800) ? 1 : 0;
-			command +=3D (data->rc5_bits & 0x01000) ? 0 : 0x40;
+			command  =3D (data->bits & 0x0003F) >> 0;
+			system   =3D (data->bits & 0x007C0) >> 6;
+			toggle   =3D (data->bits & 0x00800) ? 1 : 0;
+			command +=3D (data->bits & 0x01000) ? 0 : 0x40;
 			scancode =3D system << 8 | command;
=20
 			IR_dprintk(1, "RC5 scancode 0x%04x (toggle: %u)\n",
@@ -204,44 +162,9 @@ out:
 	return -EINVAL;
 }
=20
-static int ir_rc5_register(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	struct decoder_data *data;
-
-	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->ir_dev =3D ir_dev;
-	spin_lock(&decoder_lock);
-	list_add_tail(&data->list, &decoder_list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
-static int ir_rc5_unregister(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	static struct decoder_data *data;
-
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return 0;
-
-	spin_lock(&decoder_lock);
-	list_del(&data->list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
 static struct ir_raw_handler rc5_handler =3D {
 	.protocols	=3D IR_TYPE_RC5,
 	.decode		=3D ir_rc5_decode,
-	.raw_register	=3D ir_rc5_register,
-	.raw_unregister	=3D ir_rc5_unregister,
 };
=20
 static int __init ir_rc5_decode_init(void)
diff --git a/drivers/media/IR/ir-rc6-decoder.c b/drivers/media/IR/ir-rc=
6-decoder.c
index 5e940a8..a562952 100644
--- a/drivers/media/IR/ir-rc6-decoder.c
+++ b/drivers/media/IR/ir-rc6-decoder.c
@@ -36,10 +36,6 @@
 #define RC6_STARTBIT_MASK	0x08	/* for the header bits */
 #define RC6_6A_MCE_TOGGLE_MASK	0x8000	/* for the body bits */
=20
-/* Used to register rc6_decoder clients */
-static LIST_HEAD(decoder_list);
-static DEFINE_SPINLOCK(decoder_lock);
-
 enum rc6_mode {
 	RC6_MODE_0,
 	RC6_MODE_6A,
@@ -58,41 +54,7 @@ enum rc6_state {
 	STATE_FINISHED,
 };
=20
-struct decoder_data {
-	struct list_head	list;
-	struct ir_input_dev	*ir_dev;
-
-	/* State machine control */
-	enum rc6_state		state;
-	u8			header;
-	u32			body;
-	struct ir_raw_event	prev_ev;
-	bool			toggle;
-	unsigned		count;
-	unsigned		wanted_bits;
-};
-
-
-/**
- * get_decoder_data()	- gets decoder data
- * @input_dev:	input device
- *
- * Returns the struct decoder_data that corresponds to a device
- */
-static struct decoder_data *get_decoder_data(struct  ir_input_dev *ir_=
dev)
-{
-	struct decoder_data *data =3D NULL;
-
-	spin_lock(&decoder_lock);
-	list_for_each_entry(data, &decoder_list, list) {
-		if (data->ir_dev =3D=3D ir_dev)
-			break;
-	}
-	spin_unlock(&decoder_lock);
-	return data;
-}
-
-static enum rc6_mode rc6_mode(struct decoder_data *data) {
+static enum rc6_mode rc6_mode(struct rc6_dec *data) {
 	switch (data->header & RC6_MODE_MASK) {
 	case 0:
 		return RC6_MODE_0;
@@ -114,15 +76,11 @@ static enum rc6_mode rc6_mode(struct decoder_data =
*data) {
  */
 static int ir_rc6_decode(struct input_dev *input_dev, struct ir_raw_ev=
ent ev)
 {
-	struct decoder_data *data;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
+	struct rc6_dec *data =3D &ir_dev->raw->rc6;
 	u32 scancode;
 	u8 toggle;
=20
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return -EINVAL;
-
 	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_RC6))
 		return 0;
=20
@@ -175,12 +133,11 @@ again:
 		if (ev.pulse)
 			data->header |=3D 1;
 		data->count++;
-		data->prev_ev =3D ev;
 		data->state =3D STATE_HEADER_BIT_END;
 		return 0;
=20
 	case STATE_HEADER_BIT_END:
-		if (!is_transition(&ev, &data->prev_ev))
+		if (!is_transition(&ev, &ir_dev->raw->prev_ev))
 			break;
=20
 		if (data->count =3D=3D RC6_HEADER_NBITS)
@@ -196,12 +153,11 @@ again:
 			break;
=20
 		data->toggle =3D ev.pulse;
-		data->prev_ev =3D ev;
 		data->state =3D STATE_TOGGLE_END;
 		return 0;
=20
 	case STATE_TOGGLE_END:
-		if (!is_transition(&ev, &data->prev_ev) ||
+		if (!is_transition(&ev, &ir_dev->raw->prev_ev) ||
 		    !geq_margin(ev.duration, RC6_TOGGLE_END, RC6_UNIT / 2))
 			break;
=20
@@ -211,7 +167,6 @@ again:
 		}
=20
 		data->state =3D STATE_BODY_BIT_START;
-		data->prev_ev =3D ev;
 		decrease_duration(&ev, RC6_TOGGLE_END);
 		data->count =3D 0;
=20
@@ -243,13 +198,11 @@ again:
 		if (ev.pulse)
 			data->body |=3D 1;
 		data->count++;
-		data->prev_ev =3D ev;
-
 		data->state =3D STATE_BODY_BIT_END;
 		return 0;
=20
 	case STATE_BODY_BIT_END:
-		if (!is_transition(&ev, &data->prev_ev))
+		if (!is_transition(&ev, &ir_dev->raw->prev_ev))
 			break;
=20
 		if (data->count =3D=3D data->wanted_bits)
@@ -300,44 +253,9 @@ out:
 	return -EINVAL;
 }
=20
-static int ir_rc6_register(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	struct decoder_data *data;
-
-	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->ir_dev =3D ir_dev;
-	spin_lock(&decoder_lock);
-	list_add_tail(&data->list, &decoder_list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
-static int ir_rc6_unregister(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	static struct decoder_data *data;
-
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return 0;
-
-	spin_lock(&decoder_lock);
-	list_del(&data->list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
 static struct ir_raw_handler rc6_handler =3D {
 	.protocols	=3D IR_TYPE_RC6,
 	.decode		=3D ir_rc6_decode,
-	.raw_register	=3D ir_rc6_register,
-	.raw_unregister	=3D ir_rc6_unregister,
 };
=20
 static int __init ir_rc6_decode_init(void)
diff --git a/drivers/media/IR/ir-sony-decoder.c b/drivers/media/IR/ir-s=
ony-decoder.c
index 8afd16a..b9074f0 100644
--- a/drivers/media/IR/ir-sony-decoder.c
+++ b/drivers/media/IR/ir-sony-decoder.c
@@ -23,10 +23,6 @@
 #define SONY_BIT_SPACE		(1 * SONY_UNIT)
 #define SONY_TRAILER_SPACE	(10 * SONY_UNIT) /* minimum */
=20
-/* Used to register sony_decoder clients */
-static LIST_HEAD(decoder_list);
-static DEFINE_SPINLOCK(decoder_lock);
-
 enum sony_state {
 	STATE_INACTIVE,
 	STATE_HEADER_SPACE,
@@ -35,36 +31,6 @@ enum sony_state {
 	STATE_FINISHED,
 };
=20
-struct decoder_data {
-	struct list_head	list;
-	struct ir_input_dev	*ir_dev;
-
-	/* State machine control */
-	enum sony_state		state;
-	u32			sony_bits;
-	unsigned		count;
-};
-
-
-/**
- * get_decoder_data()	- gets decoder data
- * @input_dev:	input device
- *
- * Returns the struct decoder_data that corresponds to a device
- */
-static struct decoder_data *get_decoder_data(struct  ir_input_dev *ir_=
dev)
-{
-	struct decoder_data *data =3D NULL;
-
-	spin_lock(&decoder_lock);
-	list_for_each_entry(data, &decoder_list, list) {
-		if (data->ir_dev =3D=3D ir_dev)
-			break;
-	}
-	spin_unlock(&decoder_lock);
-	return data;
-}
-
 /**
  * ir_sony_decode() - Decode one Sony pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
@@ -74,15 +40,11 @@ static struct decoder_data *get_decoder_data(struct=
  ir_input_dev *ir_dev)
  */
 static int ir_sony_decode(struct input_dev *input_dev, struct ir_raw_e=
vent ev)
 {
-	struct decoder_data *data;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
+	struct sony_dec *data =3D &ir_dev->raw->sony;
 	u32 scancode;
 	u8 device, subdevice, function;
=20
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return -EINVAL;
-
 	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_SONY))
 		return 0;
=20
@@ -124,9 +86,9 @@ static int ir_sony_decode(struct input_dev *input_de=
v, struct ir_raw_event ev)
 		if (!ev.pulse)
 			break;
=20
-		data->sony_bits <<=3D 1;
+		data->bits <<=3D 1;
 		if (eq_margin(ev.duration, SONY_BIT_1_PULSE, SONY_UNIT / 2))
-			data->sony_bits |=3D 1;
+			data->bits |=3D 1;
 		else if (!eq_margin(ev.duration, SONY_BIT_0_PULSE, SONY_UNIT / 2))
 			break;
=20
@@ -160,19 +122,19 @@ static int ir_sony_decode(struct input_dev *input=
_dev, struct ir_raw_event ev)
=20
 		switch (data->count) {
 		case 12:
-			device    =3D bitrev8((data->sony_bits <<  3) & 0xF8);
+			device    =3D bitrev8((data->bits <<  3) & 0xF8);
 			subdevice =3D 0;
-			function  =3D bitrev8((data->sony_bits >>  4) & 0xFE);
+			function  =3D bitrev8((data->bits >>  4) & 0xFE);
 			break;
 		case 15:
-			device    =3D bitrev8((data->sony_bits >>  0) & 0xFF);
+			device    =3D bitrev8((data->bits >>  0) & 0xFF);
 			subdevice =3D 0;
-			function  =3D bitrev8((data->sony_bits >>  7) & 0xFD);
+			function  =3D bitrev8((data->bits >>  7) & 0xFD);
 			break;
 		case 20:
-			device    =3D bitrev8((data->sony_bits >>  5) & 0xF8);
-			subdevice =3D bitrev8((data->sony_bits >>  0) & 0xFF);
-			function  =3D bitrev8((data->sony_bits >> 12) & 0xFE);
+			device    =3D bitrev8((data->bits >>  5) & 0xF8);
+			subdevice =3D bitrev8((data->bits >>  0) & 0xFF);
+			function  =3D bitrev8((data->bits >> 12) & 0xFE);
 			break;
 		default:
 			IR_dprintk(1, "Sony invalid bitcount %u\n", data->count);
@@ -193,44 +155,9 @@ out:
 	return -EINVAL;
 }
=20
-static int ir_sony_register(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	struct decoder_data *data;
-
-	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->ir_dev =3D ir_dev;
-	spin_lock(&decoder_lock);
-	list_add_tail(&data->list, &decoder_list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
-static int ir_sony_unregister(struct input_dev *input_dev)
-{
-	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	static struct decoder_data *data;
-
-	data =3D get_decoder_data(ir_dev);
-	if (!data)
-		return 0;
-
-	spin_lock(&decoder_lock);
-	list_del(&data->list);
-	spin_unlock(&decoder_lock);
-
-	return 0;
-}
-
 static struct ir_raw_handler sony_handler =3D {
 	.protocols	=3D IR_TYPE_SONY,
 	.decode		=3D ir_sony_decode,
-	.raw_register	=3D ir_sony_register,
-	.raw_unregister	=3D ir_sony_unregister,
 };
=20
 static int __init ir_sony_decode_init(void)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
