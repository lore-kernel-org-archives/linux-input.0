From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: [RFC3] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 8 Apr 2010 13:39:10 +0200
Message-ID: <20100408113910.GA17104@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: mchehab@infradead.org
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

drivers/media/IR/ir-raw-event.c is currently written with the assumptio=
n=20
that all "raw" hardware will generate events only on state change (i.e.=
 =20
when a pulse or space starts).

However, some hardware (like mceusb, probably the most popular IR recei=
ver
out there) only generates duration data (and that data is buffered so u=
sing
any kind of timing on the data is futile).

=46urthermore, using signed int's to represent pulse/space durations in=
 ms
is a well-known approach to anyone with experience in writing ir decode=
rs.

This patch (which has been tested this time) is still a RFC on my propo=
sed
interface changes.

Changes since last version:

o s64's are used to represent pulse/space durations in ns.

o Lots of #defines are used in the decoders

o Refreshed to apply cleanly on top of Mauro's current git tree

o Jon's comments wrt. interrupt-context safe functions have been added

Index: ir/drivers/media/IR/ir-raw-event.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ir.orig/drivers/media/IR/ir-raw-event.c	2010-04-08 12:30:28.0360981=
92 +0200
+++ ir/drivers/media/IR/ir-raw-event.c	2010-04-08 12:45:19.780145403 +0=
200
@@ -15,9 +15,10 @@
 #include <media/ir-core.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
=20
-/* Define the max number of bit transitions per IR keycode */
-#define MAX_IR_EVENT_SIZE	256
+/* Define the max number of pulse/space transitions to buffer */
+#define MAX_IR_EVENT_SIZE      512
=20
 /* Used to handle IR raw handler extensions */
 static LIST_HEAD(ir_raw_handler_list);
@@ -53,19 +54,30 @@
 /* Used to load the decoders */
 static struct work_struct wq_load;
=20
+static void ir_raw_event_work(struct work_struct *work)
+{
+	s64 d;
+	struct ir_raw_event_ctrl *raw =3D
+		container_of(work, struct ir_raw_event_ctrl, rx_work);
+
+	while (kfifo_out(&raw->kfifo, &d, sizeof(d)) =3D=3D sizeof(d))
+		RUN_DECODER(decode, raw->input_dev, d);
+}
+
 int ir_raw_event_register(struct input_dev *input_dev)
 {
 	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
-	int rc, size;
+	int rc;
=20
 	ir->raw =3D kzalloc(sizeof(*ir->raw), GFP_KERNEL);
 	if (!ir->raw)
 		return -ENOMEM;
=20
-	size =3D sizeof(struct ir_raw_event) * MAX_IR_EVENT_SIZE * 2;
-	size =3D roundup_pow_of_two(size);
+	ir->raw->input_dev =3D input_dev;
+	INIT_WORK(&ir->raw->rx_work, ir_raw_event_work);
=20
-	rc =3D kfifo_alloc(&ir->raw->kfifo, size, GFP_KERNEL);
+	rc =3D kfifo_alloc(&ir->raw->kfifo, sizeof(s64) * MAX_IR_EVENT_SIZE,
+			 GFP_KERNEL);
 	if (rc < 0) {
 		kfree(ir->raw);
 		ir->raw =3D NULL;
@@ -90,6 +102,7 @@
 	if (!ir->raw)
 		return;
=20
+	cancel_work_sync(&ir->raw->rx_work);
 	RUN_DECODER(raw_unregister, input_dev);
=20
 	kfifo_free(&ir->raw->kfifo);
@@ -97,74 +110,90 @@
 	ir->raw =3D NULL;
 }
=20
-int ir_raw_event_store(struct input_dev *input_dev, enum raw_event_typ=
e type)
+/**
+ * ir_raw_event_store() - pass a pulse/space duration to the raw ir de=
coders
+ * @input_dev:	the struct input_dev device descriptor
+ * @duration:	duration of the pulse or space in ns
+ *
+ * This routine (which may be called from an interrupt context) stores=
 a
+ * pulse/space duration for the raw ir decoding state machines. Pulses=
 are
+ * signalled as positive values and spaces as negative values. A zero =
value
+ * will reset the decoding state machines.
+ */
+int ir_raw_event_store(struct input_dev *input_dev, s64 duration)
 {
-	struct ir_input_dev	*ir =3D input_get_drvdata(input_dev);
-	struct timespec		ts;
-	struct ir_raw_event	event;
-	int			rc;
+	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
=20
 	if (!ir->raw)
 		return -EINVAL;
=20
-	event.type =3D type;
-	event.delta.tv_sec =3D 0;
-	event.delta.tv_nsec =3D 0;
+	if (kfifo_in(&ir->raw->kfifo, &duration, sizeof(duration)) !=3D sizeo=
f(duration))
+		return -ENOMEM;
=20
-	ktime_get_ts(&ts);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ir_raw_event_store);
=20
-	if (timespec_equal(&ir->raw->last_event, &event.delta))
-		event.type |=3D IR_START_EVENT;
-	else
-		event.delta =3D timespec_sub(ts, ir->raw->last_event);
+/**
+ * ir_raw_event_store_edge() - notify raw ir decoders of the start of =
a pulse/space
+ * @input_dev:	the struct input_dev device descriptor
+ * @type:	the type of the event that has occurred
+ *
+ * This routine (which may be called from an interrupt context) is use=
d to
+ * store the beginning of an ir pulse or space (or the start/end of ir
+ * reception) for the raw ir decoding state machines. This is used by
+ * hardware which does not provide durations directly but only interru=
pts
+ * (or similar events) on state change.
+ */
+int ir_raw_event_store_edge(struct input_dev *input_dev, enum raw_even=
t_type type)
+{
+	struct ir_input_dev	*ir =3D input_get_drvdata(input_dev);
+	ktime_t			now;
+	s64			delta; /* ns */
+	int			rc =3D 0;
+
+	if (!ir->raw)
+		return -EINVAL;
=20
-	memcpy(&ir->raw->last_event, &ts, sizeof(ts));
+	now =3D ktime_get();
+	delta =3D ktime_to_ns(ktime_sub(now, ir->raw->last_event));
=20
-	if (event.delta.tv_sec) {
-		event.type |=3D IR_START_EVENT;
-		event.delta.tv_sec =3D 0;
-		event.delta.tv_nsec =3D 0;
-	}
+	/* Check for a long duration since last event or if we're
+	 * being called for the first time, note that delta can't
+	 * possibly be negative.
+	 */
+	if (delta > NSEC_PER_SEC || !ir->raw->last_type)
+		type |=3D IR_START_EVENT;
=20
-	kfifo_in(&ir->raw->kfifo, &event, sizeof(event));
+	if (type & IR_START_EVENT)
+		ir_raw_event_reset(input_dev);
+	else if (ir->raw->last_type & IR_SPACE)
+		rc =3D ir_raw_event_store(input_dev, -delta);
+	else if (ir->raw->last_type & IR_PULSE)
+		rc =3D ir_raw_event_store(input_dev, delta);
+	else
+		return 0;
=20
+	ir->raw->last_event =3D now;
+	ir->raw->last_type =3D type;
 	return rc;
 }
-EXPORT_SYMBOL_GPL(ir_raw_event_store);
+EXPORT_SYMBOL_GPL(ir_raw_event_store_edge);
=20
-int ir_raw_event_handle(struct input_dev *input_dev)
+/**
+ * ir_raw_event_handle() - schedules the decoding of stored ir data
+ * @input_dev:	the struct input_dev device descriptor
+ *
+ * This routine will signal the workqueue to start decoding stored ir =
data.
+ */
+void ir_raw_event_handle(struct input_dev *input_dev)
 {
-	struct ir_input_dev		*ir =3D input_get_drvdata(input_dev);
-	int				rc;
-	struct ir_raw_event		ev;
-	int 				len, i;
-
-	/*
-	 * Store the events into a temporary buffer. This allows calling more=
 than
-	 * one decoder to deal with the received data
-	 */
-	len =3D kfifo_len(&ir->raw->kfifo) / sizeof(ev);
-	if (!len)
-		return 0;
-
-	for (i =3D 0; i < len; i++) {
-		rc =3D kfifo_out(&ir->raw->kfifo, &ev, sizeof(ev));
-		if (rc !=3D sizeof(ev)) {
-			IR_dprintk(1, "overflow error: received %d instead of %zd\n",
-				   rc, sizeof(ev));
-			return -EINVAL;
-		}
-		IR_dprintk(2, "event type %d, time before event: %07luus\n",
-			ev.type, (ev.delta.tv_nsec + 500) / 1000);
-		rc =3D RUN_DECODER(decode, input_dev, &ev);
-	}
+	struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
=20
-	/*
-	 * Call all ir decoders. This allows decoding the same event with
-	 * more than one protocol handler.
-	 */
+	if (!ir->raw)
+		return;
=20
-	return rc;
+	schedule_work(&ir->raw->rx_work);
 }
 EXPORT_SYMBOL_GPL(ir_raw_event_handle);
=20
Index: ir/include/media/ir-core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ir.orig/include/media/ir-core.h	2010-04-08 12:30:28.000000000 +0200
+++ ir/include/media/ir-core.h	2010-04-08 13:25:43.761137406 +0200
@@ -65,14 +65,12 @@
 	void			(*close)(void *priv);
 };
=20
-struct ir_raw_event {
-	struct timespec		delta;	/* Time spent before event */
-	enum raw_event_type	type;	/* event type */
-};
-
 struct ir_raw_event_ctrl {
-	struct kfifo			kfifo;		/* fifo for the pulse/space events */
-	struct timespec			last_event;	/* when last event occurred */
+	struct work_struct		rx_work;	/* for the rx decoding workqueue */
+	struct kfifo			kfifo;		/* fifo for the pulse/space durations */
+	ktime_t				last_event;	/* when last event occurred */
+	enum raw_event_type		last_type;	/* last event type */
+	struct input_dev		*input_dev;	/* pointer to the parent input_dev */
 };
=20
 struct ir_input_dev {
@@ -97,8 +95,7 @@
 struct ir_raw_handler {
 	struct list_head list;
=20
-	int (*decode)(struct input_dev *input_dev,
-		      struct ir_raw_event *ev);
+	int (*decode)(struct input_dev *input_dev, s64 duration);
 	int (*raw_register)(struct input_dev *input_dev);
 	int (*raw_unregister)(struct input_dev *input_dev);
 };
@@ -154,8 +151,13 @@
 /* Routines from ir-raw-event.c */
 int ir_raw_event_register(struct input_dev *input_dev);
 void ir_raw_event_unregister(struct input_dev *input_dev);
-int ir_raw_event_store(struct input_dev *input_dev, enum raw_event_typ=
e type);
-int ir_raw_event_handle(struct input_dev *input_dev);
+void ir_raw_event_handle(struct input_dev *input_dev);
+int ir_raw_event_store(struct input_dev *input_dev, s64 duration);
+int ir_raw_event_store_edge(struct input_dev *input_dev, enum raw_even=
t_type type);
+static inline void ir_raw_event_reset(struct input_dev *input_dev) {
+	ir_raw_event_store(input_dev, 0);
+	ir_raw_event_handle(input_dev);
+}
 int ir_raw_handler_register(struct ir_raw_handler *ir_raw_handler);
 void ir_raw_handler_unregister(struct ir_raw_handler *ir_raw_handler);
 void ir_raw_init(void);
@@ -174,4 +176,26 @@
 #define load_rc5_decode()	0
 #endif
=20
+/* macros for ir decoders */
+#define PULSE(units)				((units))
+#define SPACE(units)				(-(units))
+#define IS_RESET(duration)			((duration) =3D=3D 0)
+#define IS_PULSE(duration)			((duration) > 0)
+#define IS_SPACE(duration)			((duration) < 0)
+#define DURATION(duration)			(abs((duration)))
+#define IS_TRANSITION(x ,y)			((x) * (y) < 0)
+#define DECREASE_DURATION(duration, amount)			\
+	do {							\
+		if (IS_SPACE(duration))				\
+			duration +=3D (amount);			\
+		else if (IS_PULSE(duration))			\
+			duration -=3D (amount);			\
+	} while(0)
+
+#define TO_UNITS(duration, unit_len)				\
+	((int)((duration) > 0 ?					\
+		DIV_ROUND_CLOSEST(abs((duration)), (unit_len)) :\
+		- DIV_ROUND_CLOSEST(abs((duration)), (unit_len))))
+#define TO_US(duration)		((int)TO_UNITS(duration, 1000))
+
 #endif /* _IR_CORE */
Index: ir/drivers/media/IR/ir-nec-decoder.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ir.orig/drivers/media/IR/ir-nec-decoder.c	2010-04-08 12:30:28.00000=
0000 +0200
+++ ir/drivers/media/IR/ir-nec-decoder.c	2010-04-08 12:35:02.276484204 =
+0200
@@ -13,15 +13,16 @@
  */
=20
 #include <media/ir-core.h>
+#include <linux/bitrev.h>
=20
 #define NEC_NBITS		32
-#define NEC_UNIT		559979 /* ns */
-#define NEC_HEADER_MARK		(16 * NEC_UNIT)
-#define NEC_HEADER_SPACE	(8 * NEC_UNIT)
-#define NEC_REPEAT_SPACE	(4 * NEC_UNIT)
-#define NEC_MARK		(NEC_UNIT)
-#define NEC_0_SPACE		(NEC_UNIT)
-#define NEC_1_SPACE		(3 * NEC_UNIT)
+#define NEC_UNIT		562500  /* ns */
+#define NEC_HEADER_PULSE	PULSE(16)
+#define NEC_HEADER_SPACE	SPACE(8)
+#define NEC_REPEAT_SPACE	SPACE(4)
+#define NEC_BIT_PULSE		PULSE(1)
+#define NEC_BIT_0_SPACE		SPACE(1)
+#define NEC_BIT_1_SPACE		SPACE(3)
=20
 /* Used to register nec_decoder clients */
 static LIST_HEAD(decoder_list);
@@ -29,21 +30,13 @@
=20
 enum nec_state {
 	STATE_INACTIVE,
-	STATE_HEADER_MARK,
 	STATE_HEADER_SPACE,
-	STATE_MARK,
-	STATE_SPACE,
-	STATE_TRAILER_MARK,
+	STATE_BIT_PULSE,
+	STATE_BIT_SPACE,
+	STATE_TRAILER_PULSE,
 	STATE_TRAILER_SPACE,
 };
=20
-struct nec_code {
-	u8	address;
-	u8	not_address;
-	u8	command;
-	u8	not_command;
-};
-
 struct decoder_data {
 	struct list_head	list;
 	struct ir_input_dev	*ir_dev;
@@ -51,7 +44,7 @@
=20
 	/* State machine control */
 	enum nec_state		state;
-	struct nec_code		nec_code;
+	u32			nec_bits;
 	unsigned		count;
 };
=20
@@ -62,7 +55,6 @@
  *
  * Returns the struct decoder_data that corresponds to a device
  */
-
 static struct decoder_data *get_decoder_data(struct  ir_input_dev *ir_=
dev)
 {
 	struct decoder_data *data =3D NULL;
@@ -123,20 +115,20 @@
 	.attrs	=3D decoder_attributes,
 };
=20
-
 /**
  * ir_nec_decode() - Decode one NEC pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
- * @ev:		event array with type/duration of pulse/space
+ * @duration:	duration in ns of pulse/space
  *
  * This function returns -EINVAL if the pulse violates the state machi=
ne
  */
-static int ir_nec_decode(struct input_dev *input_dev,
-			 struct ir_raw_event *ev)
+static int ir_nec_decode(struct input_dev *input_dev, s64 duration)
 {
 	struct decoder_data *data;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	int bit, last_bit;
+	int u;
+	u32 scancode;
+	u8 address, not_address, command, not_command;
=20
 	data =3D get_decoder_data(ir_dev);
 	if (!data)
@@ -145,150 +137,107 @@
 	if (!data->enabled)
 		return 0;
=20
-	/* Except for the initial event, what matters is the previous bit */
-	bit =3D (ev->type & IR_PULSE) ? 1 : 0;
-
-	last_bit =3D !bit;
-
-	/* Discards spurious space last_bits when inactive */
-
-	/* Very long delays are considered as start events */
-	if (ev->delta.tv_nsec > NEC_HEADER_MARK + NEC_HEADER_SPACE - NEC_UNIT=
 / 2)
+	if (IS_RESET(duration)) {
 		data->state =3D STATE_INACTIVE;
+		return 0;
+	}
=20
-	if (ev->type & IR_START_EVENT)
-		data->state =3D STATE_INACTIVE;
+	u =3D TO_UNITS(duration, NEC_UNIT);
+	if (DURATION(u) =3D=3D 0)
+		goto out;
+
+	IR_dprintk(2, "NEC decode started at state %d (%i units, %ius)\n",
+		   data->state, u, TO_US(duration));
=20
 	switch (data->state) {
-	case STATE_INACTIVE:
-		if (!bit)		/* PULSE marks the start event */
-			return 0;
=20
-		data->count =3D 0;
-		data->state =3D STATE_HEADER_MARK;
-		memset (&data->nec_code, 0, sizeof(data->nec_code));
-		return 0;
-	case STATE_HEADER_MARK:
-		if (!last_bit)
-			goto err;
-		if (ev->delta.tv_nsec < NEC_HEADER_MARK - 6 * NEC_UNIT)
-			goto err;
-		data->state =3D STATE_HEADER_SPACE;
+	case STATE_INACTIVE:
+		if (u =3D=3D NEC_HEADER_PULSE) {
+			data->count =3D 0;
+			data->state =3D STATE_HEADER_SPACE;
+		}
 		return 0;
+
 	case STATE_HEADER_SPACE:
-		if (last_bit)
-			goto err;
-		if (ev->delta.tv_nsec >=3D NEC_HEADER_SPACE - NEC_UNIT / 2) {
-			data->state =3D STATE_MARK;
+		if (u =3D=3D NEC_HEADER_SPACE) {
+			data->state =3D STATE_BIT_PULSE;
 			return 0;
-		}
-
-		if (ev->delta.tv_nsec >=3D NEC_REPEAT_SPACE - NEC_UNIT / 2) {
+		} else if (u =3D=3D NEC_REPEAT_SPACE) {
 			ir_repeat(input_dev);
 			IR_dprintk(1, "Repeat last key\n");
-			data->state =3D STATE_TRAILER_MARK;
+			data->state =3D STATE_TRAILER_PULSE;
 			return 0;
 		}
-		goto err;
-	case STATE_MARK:
-		if (!last_bit)
-			goto err;
-		if ((ev->delta.tv_nsec > NEC_MARK + NEC_UNIT / 2) ||
-		    (ev->delta.tv_nsec < NEC_MARK - NEC_UNIT / 2))
-			goto err;
-		data->state =3D STATE_SPACE;
-		return 0;
-	case STATE_SPACE:
-		if (last_bit)
-			goto err;
-
-		if ((ev->delta.tv_nsec >=3D NEC_0_SPACE - NEC_UNIT / 2) &&
-		    (ev->delta.tv_nsec < NEC_0_SPACE + NEC_UNIT / 2))
-			bit =3D 0;
-		else if ((ev->delta.tv_nsec >=3D NEC_1_SPACE - NEC_UNIT / 2) &&
-		         (ev->delta.tv_nsec < NEC_1_SPACE + NEC_UNIT / 2))
-			bit =3D 1;
-		else {
-			IR_dprintk(1, "Decode failed at %d-th bit (%s) @%luus\n",
-				data->count,
-				last_bit ? "pulse" : "space",
-				(ev->delta.tv_nsec + 500) / 1000);
+		break;
+
+	case STATE_BIT_PULSE:
+		if (u =3D=3D NEC_BIT_PULSE) {
+			data->state =3D STATE_BIT_SPACE;
+			return 0;
+		}
+		break;
+
+	case STATE_BIT_SPACE:
+		if (u !=3D NEC_BIT_0_SPACE && u !=3D NEC_BIT_1_SPACE)
+			break;
=20
-			goto err2;
+		data->nec_bits <<=3D 1;
+		if (u =3D=3D NEC_BIT_1_SPACE)
+			data->nec_bits |=3D 1;
+		data->count++;
+
+		if (data->count !=3D NEC_NBITS) {
+			data->state =3D STATE_BIT_PULSE;
+			return 0;
 		}
=20
-		/* Ok, we've got a valid bit. proccess it */
-		if (bit) {
-			int shift =3D data->count;
-
-			/*
-			 * NEC transmit bytes on this temporal order:
-			 * address | not address | command | not command
-			 */
-			if (shift < 8) {
-				data->nec_code.address |=3D 1 << shift;
-			} else if (shift < 16) {
-				data->nec_code.not_address |=3D 1 << (shift - 8);
-			} else if (shift < 24) {
-				data->nec_code.command |=3D 1 << (shift - 16);
-			} else {
-				data->nec_code.not_command |=3D 1 << (shift - 24);
-			}
+		address     =3D bitrev8((data->nec_bits >> 24) & 0xff);
+		not_address =3D bitrev8((data->nec_bits >> 16) & 0xff);
+		command	    =3D bitrev8((data->nec_bits >>  8) & 0xff);
+		not_command =3D bitrev8((data->nec_bits >>  0) & 0xff);
+
+		if ((command ^ not_command) !=3D 0xff) {
+			IR_dprintk(1, "NEC checksum error: received 0x%08x\n",
+				   data->nec_bits);
+			break;
 		}
-		if (++data->count =3D=3D NEC_NBITS) {
-			u32 scancode;
-			/*
-			 * Fixme: may need to accept Extended NEC protocol?
-			 */
-			if ((data->nec_code.command ^ data->nec_code.not_command) !=3D 0xff=
)
-				goto checksum_err;
-
-			if ((data->nec_code.address ^ data->nec_code.not_address) !=3D 0xff=
) {
-				/* Extended NEC */
-				scancode =3D data->nec_code.address << 16 |
-					   data->nec_code.not_address << 8 |
-					   data->nec_code.command;
-				IR_dprintk(1, "NEC scancode 0x%06x\n", scancode);
-			} else {
-				/* normal NEC */
-				scancode =3D data->nec_code.address << 8 |
-					   data->nec_code.command;
-				IR_dprintk(1, "NEC scancode 0x%04x\n", scancode);
-			}
-			ir_keydown(input_dev, scancode, 0);
-
-			data->state =3D STATE_TRAILER_MARK;
-		} else
-			data->state =3D STATE_MARK;
-		return 0;
-	case STATE_TRAILER_MARK:
-		if (!last_bit)
-			goto err;
-		data->state =3D STATE_TRAILER_SPACE;
+
+		if ((address ^ not_address) !=3D 0xff) {
+			/* Extended NEC */
+			scancode =3D address     << 16 |
+				   not_address <<  8 |
+				   command;
+			IR_dprintk(1, "NEC (Ext) scancode 0x%06x\n", scancode);
+		} else {
+			/* normal NEC */
+			scancode =3D address << 8 | command;
+			IR_dprintk(1, "NEC scancode 0x%04x\n", scancode);
+		}
+
+		ir_keydown(input_dev, scancode, 0);
+		data->state =3D STATE_TRAILER_PULSE;
 		return 0;
+
+	case STATE_TRAILER_PULSE:
+		if (u > 0) {
+			data->state =3D STATE_TRAILER_SPACE;
+			return 0;
+		}
+		break;
+
 	case STATE_TRAILER_SPACE:
-		if (last_bit)
-			goto err;
-		data->state =3D STATE_INACTIVE;
-		return 0;
-	}
+		if (u < 0) {
+			data->state =3D STATE_INACTIVE;
+			return 0;
+		}
=20
-err:
-	IR_dprintk(1, "NEC decoded failed at state %d (%s) @ %luus\n",
-		   data->state,
-		   bit ? "pulse" : "space",
-		   (ev->delta.tv_nsec + 500) / 1000);
-err2:
-	data->state =3D STATE_INACTIVE;
-	return -EINVAL;
+		break;
+	}
=20
-checksum_err:
+out:
+	IR_dprintk(1, "NEC decode failed at state %d (%i units, %ius)\n",
+		   data->state, u, TO_US(duration));
 	data->state =3D STATE_INACTIVE;
-	IR_dprintk(1, "NEC checksum error: received 0x%02x%02x%02x%02x\n",
-		   data->nec_code.address,
-		   data->nec_code.not_address,
-		   data->nec_code.command,
-		   data->nec_code.not_command);
 	return -EINVAL;
 }
=20
Index: ir/drivers/media/IR/ir-rc5-decoder.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ir.orig/drivers/media/IR/ir-rc5-decoder.c	2010-04-08 12:30:28.00000=
0000 +0200
+++ ir/drivers/media/IR/ir-rc5-decoder.c	2010-04-08 12:48:28.361137494 =
+0200
@@ -21,11 +21,8 @@
=20
 #include <media/ir-core.h>
=20
-static unsigned int ir_rc5_remote_gap =3D 888888;
-
 #define RC5_NBITS		14
-#define RC5_BIT			(ir_rc5_remote_gap * 2)
-#define RC5_DURATION		(ir_rc5_remote_gap * RC5_NBITS)
+#define RC5_UNIT		888888 /* ns */
=20
 /* Used to register rc5_decoder clients */
 static LIST_HEAD(decoder_list);
@@ -33,13 +30,9 @@
=20
 enum rc5_state {
 	STATE_INACTIVE,
-	STATE_MARKSPACE,
-	STATE_TRAILER,
-};
-
-struct rc5_code {
-	u8	address;
-	u8	command;
+	STATE_BIT_START,
+	STATE_BIT_END,
+	STATE_FINISHED,
 };
=20
 struct decoder_data {
@@ -49,8 +42,9 @@
=20
 	/* State machine control */
 	enum rc5_state		state;
-	struct rc5_code		rc5_code;
-	unsigned		code, elapsed, last_bit, last_code;
+	u32			rc5_bits;
+	int			last_unit;
+	unsigned		count;
 };
=20
=20
@@ -122,18 +116,19 @@
 };
=20
 /**
- * handle_event() - Decode one RC-5 pulse or space
+ * ir_rc5_decode() - Decode one RC-5 pulse or space
  * @input_dev:	the struct input_dev descriptor of the device
- * @ev:		event array with type/duration of pulse/space
+ * @duration:	duration of pulse/space in ns
  *
  * This function returns -EINVAL if the pulse violates the state machi=
ne
  */
-static int ir_rc5_decode(struct input_dev *input_dev,
-			struct ir_raw_event *ev)
+static int ir_rc5_decode(struct input_dev *input_dev, s64 duration)
 {
 	struct decoder_data *data;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	int is_pulse, scancode, delta, toggle;
+	u8 command, system, toggle;
+	u32 scancode;
+	int u;
=20
 	data =3D get_decoder_data(ir_dev);
 	if (!data)
@@ -142,79 +137,84 @@
 	if (!data->enabled)
 		return 0;
=20
-	delta =3D DIV_ROUND_CLOSEST(ev->delta.tv_nsec, ir_rc5_remote_gap);
-
-	/* The duration time refers to the last bit time */
-	is_pulse =3D (ev->type & IR_PULSE) ? 1 : 0;
-
-	/* Very long delays are considered as start events */
-	if (delta > RC5_DURATION || (ev->type & IR_START_EVENT))
+	if (IS_RESET(duration)) {
 		data->state =3D STATE_INACTIVE;
-
-	switch (data->state) {
-	case STATE_INACTIVE:
-	IR_dprintk(2, "currently inative. Start bit (%s) @%uus\n",
-		   is_pulse ? "pulse" : "space",
-		   (unsigned)(ev->delta.tv_nsec + 500) / 1000);
-
-		/* Discards the initial start space */
-		if (!is_pulse)
-			goto err;
-		data->code =3D 1;
-		data->last_bit =3D 1;
-		data->elapsed =3D 0;
-		memset(&data->rc5_code, 0, sizeof(data->rc5_code));
-		data->state =3D STATE_MARKSPACE;
 		return 0;
-	case STATE_MARKSPACE:
-		if (delta !=3D 1)
-			data->last_bit =3D data->last_bit ? 0 : 1;
+	}
=20
-		data->elapsed +=3D delta;
+	u =3D TO_UNITS(duration, RC5_UNIT);
+	if (DURATION(u) =3D=3D 0)
+		goto out;
+
+again:
+	IR_dprintk(2, "RC5 decode started at state %i (%i units, %ius)\n",
+		   data->state, u, TO_US(duration));
=20
-		if ((data->elapsed % 2) =3D=3D 1)
-			return 0;
+	if (DURATION(u) =3D=3D 0 && data->state !=3D STATE_FINISHED)
+		return 0;
+
+	switch (data->state) {
=20
-		data->code <<=3D 1;
-		data->code |=3D data->last_bit;
+	case STATE_INACTIVE:
+		if (IS_PULSE(u)) {
+			data->state =3D STATE_BIT_START;
+			data->count =3D 1;
+			DECREASE_DURATION(u, 1);
+			goto again;
+		}
+		break;
=20
-		/* Fill the 2 unused bits at the command with 0 */
-		if (data->elapsed / 2 =3D=3D 6)
-			data->code <<=3D 2;
-
-		if (data->elapsed >=3D (RC5_NBITS - 1) * 2) {
-			scancode =3D data->code;
-
-			/* Check for the start bits */
-			if ((scancode & 0xc000) !=3D 0xc000) {
-				IR_dprintk(1, "Code 0x%04x doesn't have two start bits. It is not =
RC-5\n", scancode);
-				goto err;
+	case STATE_BIT_START:
+		if (DURATION(u) =3D=3D 1) {
+			data->rc5_bits <<=3D 1;
+			if (IS_SPACE(u))
+				data->rc5_bits |=3D 1;
+			data->count++;
+			data->last_unit =3D u;
+
+			/*
+			 * If the last bit is zero, a space will merge
+			 * with the silence after the command.
+			 */
+			if (IS_PULSE(u) && data->count =3D=3D RC5_NBITS) {
+				data->state =3D STATE_FINISHED;
+				goto again;
 			}
=20
-			toggle =3D (scancode & 0x2000) ? 1 : 0;
+			data->state =3D STATE_BIT_END;
+			return 0;
+		}
+		break;
=20
-			if (scancode =3D=3D data->last_code) {
-				IR_dprintk(1, "RC-5 repeat\n");
-				ir_repeat(input_dev);
-			} else {
-				data->last_code =3D scancode;
-				scancode &=3D 0x1fff;
-				IR_dprintk(1, "RC-5 scancode 0x%04x\n", scancode);
+	case STATE_BIT_END:
+		if (IS_TRANSITION(u, data->last_unit)) {
+			if (data->count =3D=3D RC5_NBITS)
+				data->state =3D STATE_FINISHED;
+			else
+				data->state =3D STATE_BIT_START;
=20
-				ir_keydown(input_dev, scancode, 0);
-			}
-			data->state =3D STATE_TRAILER;
+			DECREASE_DURATION(u, 1);
+			goto again;
 		}
-		return 0;
-	case STATE_TRAILER:
+		break;
+
+	case STATE_FINISHED:
+		command  =3D (data->rc5_bits & 0x0003F) >> 0;
+		system   =3D (data->rc5_bits & 0x007C0) >> 6;
+		toggle   =3D (data->rc5_bits & 0x00800) ? 1 : 0;
+		command +=3D (data->rc5_bits & 0x01000) ? 0 : 0x40;
+		scancode =3D system << 8 | command;
+
+		IR_dprintk(1, "RC5 scancode 0x%04x (toggle: %u)\n",
+			   scancode, toggle);
+		ir_keydown(input_dev, scancode, toggle);
 		data->state =3D STATE_INACTIVE;
 		return 0;
 	}
=20
-err:
-	IR_dprintk(1, "RC-5 decoded failed at %s @ %luus\n",
-		   is_pulse ? "pulse" : "space",
-		   (ev->delta.tv_nsec + 500) / 1000);
+out:
+	IR_dprintk(1, "RC5 decode failed at state %i (%i units, %ius)\n",
+		   data->state, u, TO_US(duration));
 	data->state =3D STATE_INACTIVE;
 	return -EINVAL;
 }
Index: ir/drivers/media/video/saa7134/saa7134-input.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ir.orig/drivers/media/video/saa7134/saa7134-input.c	2010-04-08 12:3=
0:28.000000000 +0200
+++ ir/drivers/media/video/saa7134/saa7134-input.c	2010-04-08 12:31:07.=
697096148 +0200
@@ -1018,7 +1018,7 @@
 	saa_clearb(SAA7134_GPIO_GPMODE3, SAA7134_GPIO_GPRESCAN);
 	saa_setb(SAA7134_GPIO_GPMODE3, SAA7134_GPIO_GPRESCAN);
 	space =3D saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2) & ir->mask_keydown;
-	ir_raw_event_store(dev->remote->dev, space ? IR_SPACE : IR_PULSE);
+	ir_raw_event_store_edge(dev->remote->dev, space ? IR_SPACE : IR_PULSE=
);
=20
=20
 	/*

--=20
David H=E4rdeman
