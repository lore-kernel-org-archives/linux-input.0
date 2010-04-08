From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC2] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Wed, 7 Apr 2010 20:18:22 -0400
Message-ID: <n2n9e4733911004071718r4523fbefx4b2a21bf5f9c3b78@mail.gmail.com>
References: <20100407201835.GA8438@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100407201835.GA8438@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 7, 2010 at 4:18 PM, David H=E4rdeman <david@hardeman.nu> wr=
ote:
> drivers/media/IR/ir-raw-event.c is currently written with the assumpt=
ion
> that all "raw" hardware will generate events only on state change (i.=
e.
> when a pulse or space starts).
>
> However, some hardware (like mceusb, probably the most popular IR rec=
eiver
> out there) only generates duration data (and that data is buffered so=
 using
> any kind of timing on the data is futile).
>
> Furthermore, using signed int's to represent pulse/space durations in=
 ms
> is a well-known approach to anyone with experience in writing ir deco=
ders.
>
> This patch (which has been tested this time) is still a RFC on my pro=
posed
> interface changes.
>
> Changes since last version:
>
> o RC5x and NECx support no longer added in patch (separate patches to=
 follow)
>
> o The use of a kfifo has been left given feedback from Jon, Andy, Mau=
ro
>
> o The RX decoding is now handled via a workqueue (I can break that up=
 into a
> =A0separate patch later, but I think it helps the discussion to have =
it in for
> =A0now), with inspiration from Andy's code.
>
> o Separate reset operations are no longer added to decoders, a durati=
on of
> =A0zero is instead used to signal a reset (which allows the reset req=
uest to
> =A0be inserted into the kfifo).
>
> o Not sent using quilt...Mauro, does it still trip up your MUA?
>
> Not changed:
>
> o int's are still used to represent pulse/space durations in ms. Maur=
o and I
> =A0seem to disagree on this one but I'm right :)
>
> Index: ir/drivers/media/IR/ir-raw-event.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ir.orig/drivers/media/IR/ir-raw-event.c =A0 =A0 2010-04-06 12:16:=
27.000000000 +0200
> +++ ir/drivers/media/IR/ir-raw-event.c =A02010-04-07 21:32:13.9618504=
81 +0200
> @@ -15,13 +15,14 @@
> =A0#include <media/ir-core.h>
> =A0#include <linux/workqueue.h>
> =A0#include <linux/spinlock.h>
> +#include <linux/sched.h>
>
> =A0/* Define the max number of bit transitions per IR keycode */
> =A0#define MAX_IR_EVENT_SIZE =A0 =A0 =A0256
>
> =A0/* Used to handle IR raw handler extensions */
> =A0static LIST_HEAD(ir_raw_handler_list);
> -static spinlock_t ir_raw_handler_lock;
> +static DEFINE_SPINLOCK(ir_raw_handler_lock);
>
> =A0/**
> =A0* RUN_DECODER() =A0 =A0 =A0 - runs an operation on all IR decoders
> @@ -53,19 +54,30 @@
> =A0/* Used to load the decoders */
> =A0static struct work_struct wq_load;
>
> +static void ir_raw_event_work(struct work_struct *work)
> +{
> + =A0 =A0 =A0 int d;
> + =A0 =A0 =A0 struct ir_raw_event_ctrl *raw =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct ir_raw_event_=
ctrl, rx_work);
> +
> + =A0 =A0 =A0 while (kfifo_out(&raw->kfifo, &d, sizeof(d)) =3D=3D siz=
eof(d))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 RUN_DECODER(decode, raw->input_dev, d);
> +}
> +
> =A0int ir_raw_event_register(struct input_dev *input_dev)
> =A0{
> =A0 =A0 =A0 =A0struct ir_input_dev *ir =3D input_get_drvdata(input_de=
v);
> - =A0 =A0 =A0 int rc, size;
> + =A0 =A0 =A0 int rc;
>
> =A0 =A0 =A0 =A0ir->raw =3D kzalloc(sizeof(*ir->raw), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!ir->raw)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> - =A0 =A0 =A0 size =3D sizeof(struct ir_raw_event) * MAX_IR_EVENT_SIZ=
E * 2;
> - =A0 =A0 =A0 size =3D roundup_pow_of_two(size);
> + =A0 =A0 =A0 ir->raw->input_dev =3D input_dev;
> + =A0 =A0 =A0 INIT_WORK(&ir->raw->rx_work, ir_raw_event_work);
>
> - =A0 =A0 =A0 rc =3D kfifo_alloc(&ir->raw->kfifo, size, GFP_KERNEL);
> + =A0 =A0 =A0 rc =3D kfifo_alloc(&ir->raw->kfifo, sizeof(int) * MAX_I=
R_EVENT_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
> =A0 =A0 =A0 =A0if (rc < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(ir->raw);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ir->raw =3D NULL;
> @@ -91,6 +103,7 @@
> =A0 =A0 =A0 =A0if (!ir->raw)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> + =A0 =A0 =A0 cancel_work_sync(&ir->raw->rx_work);
> =A0 =A0 =A0 =A0RUN_DECODER(raw_unregister, input_dev);
>
> =A0 =A0 =A0 =A0kfifo_free(&ir->raw->kfifo);
> @@ -99,74 +112,85 @@
> =A0}
> =A0EXPORT_SYMBOL_GPL(ir_raw_event_unregister);
>
> -int ir_raw_event_store(struct input_dev *input_dev, enum raw_event_t=
ype type)
> +/**
> + * ir_raw_event_store() - pass a pulse/space duration to the raw ir =
decoders
> + * @input_dev: the struct input_dev device descriptor
> + * @duration: =A0duration of the pulse or space
> + *
> + * This routine passes a pulse/space duration to the raw ir decoding=
 state
> + * machines. Pulses are signalled as positive values and spaces as n=
egative
> + * values. A zero value will reset the decoding state machines.

Mention that this routine is safe to call from interrupt context

> + */
> +int ir_raw_event_store(struct input_dev *input_dev, int duration)
> =A0{
> - =A0 =A0 =A0 struct ir_input_dev =A0 =A0 *ir =3D input_get_drvdata(i=
nput_dev);
> - =A0 =A0 =A0 struct timespec =A0 =A0 =A0 =A0 ts;
> - =A0 =A0 =A0 struct ir_raw_event =A0 =A0 event;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc;
> + =A0 =A0 =A0 struct ir_input_dev *ir =3D input_get_drvdata(input_dev=
);
>
> =A0 =A0 =A0 =A0if (!ir->raw)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 event.type =3D type;
> - =A0 =A0 =A0 event.delta.tv_sec =3D 0;
> - =A0 =A0 =A0 event.delta.tv_nsec =3D 0;
> + =A0 =A0 =A0 if (kfifo_in(&ir->raw->kfifo, &duration, sizeof(duratio=
n)) !=3D sizeof(duration))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>
> - =A0 =A0 =A0 ktime_get_ts(&ts);
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(ir_raw_event_store);
>
> - =A0 =A0 =A0 if (timespec_equal(&ir->raw->last_event, &event.delta))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 event.type |=3D IR_START_EVENT;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 event.delta =3D timespec_sub(ts, ir->ra=
w->last_event);
> +/**
> + * ir_raw_event_store_edge() - notify raw ir decoders of the start o=
f a pulse/space
> + * @input_dev: the struct input_dev device descriptor
> + * @type: =A0 =A0 =A0the type of the event that has occurred
> + *
> + * This routine is used to notify the raw ir decoders on the beginni=
ng of an
> + * ir pulse or space (or the start/end of ir reception). This is use=
d by
> + * hardware which does not provide durations directly but only inter=
rupts
> + * (or similar events) on state change.

Mention that this routine is safe to call from interrupt context

> + */
> +int ir_raw_event_store_edge(struct input_dev *input_dev, enum raw_ev=
ent_type type)
> +{
> + =A0 =A0 =A0 struct ir_input_dev =A0 =A0 *ir =3D input_get_drvdata(i=
nput_dev);
> + =A0 =A0 =A0 ktime_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 now;
> + =A0 =A0 =A0 s64 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delta; /* u=
s */
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D 0;
>
> - =A0 =A0 =A0 memcpy(&ir->raw->last_event, &ts, sizeof(ts));
> + =A0 =A0 =A0 if (!ir->raw)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> - =A0 =A0 =A0 if (event.delta.tv_sec) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 event.type |=3D IR_START_EVENT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 event.delta.tv_sec =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 event.delta.tv_nsec =3D 0;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 now =3D ktime_get();
> + =A0 =A0 =A0 delta =3D ktime_us_delta(now, ir->raw->last_event);
>
> - =A0 =A0 =A0 kfifo_in(&ir->raw->kfifo, &event, sizeof(event));
> + =A0 =A0 =A0 /* Are we called for the first time? */
> + =A0 =A0 =A0 if (!ir->raw->last_type)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 type |=3D IR_START_EVENT;
> +
> + =A0 =A0 =A0 if (type & IR_START_EVENT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_raw_event_reset(input_dev);

--- make sure this is ok to call from interrupt context

> + =A0 =A0 =A0 else if (ir->raw->last_type & IR_SPACE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ir_raw_event_store(input_dev, (i=
nt)-delta);
> + =A0 =A0 =A0 else if (ir->raw->last_type & IR_PULSE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ir_raw_event_store(input_dev, (i=
nt)delta);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> + =A0 =A0 =A0 ir->raw->last_event =3D now;
> + =A0 =A0 =A0 ir->raw->last_type =3D type;
> =A0 =A0 =A0 =A0return rc;
> =A0}
> -EXPORT_SYMBOL_GPL(ir_raw_event_store);
> +EXPORT_SYMBOL_GPL(ir_raw_event_store_edge);
>
> -int ir_raw_event_handle(struct input_dev *input_dev)
> +/**
> + * ir_raw_event_handle() - schedules the decoding of stored ir data
> + * @input_dev: the struct input_dev device descriptor
> + *
> + * This routine will signal the workqueue to start decoding stored i=
r data.
> + */
> +void ir_raw_event_handle(struct input_dev *input_dev)
> =A0{
> - =A0 =A0 =A0 struct ir_input_dev =A0 =A0 =A0 =A0 =A0 =A0 *ir =3D inp=
ut_get_drvdata(input_dev);
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 rc;
> - =A0 =A0 =A0 struct ir_raw_event =A0 =A0 =A0 =A0 =A0 =A0 ev;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 len, i;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Store the events into a temporary buffer. This all=
ows calling more than
> - =A0 =A0 =A0 =A0* one decoder to deal with the received data
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 len =3D kfifo_len(&ir->raw->kfifo) / sizeof(ev);
> - =A0 =A0 =A0 if (!len)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 for (i =3D 0; i < len; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D kfifo_out(&ir->raw->kfifo, &ev, =
sizeof(ev));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc !=3D sizeof(ev)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "overflow=
 error: received %d instead of %zd\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
rc, sizeof(ev));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(2, "event type %d, time befo=
re event: %07luus\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ev.type, (ev.delta.tv_n=
sec + 500) / 1000);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D RUN_DECODER(decode, input_dev, &=
ev);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 struct ir_input_dev *ir =3D input_get_drvdata(input_dev=
);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Call all ir decoders. This allows decoding the sam=
e event with
> - =A0 =A0 =A0 =A0* more than one protocol handler.
> - =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!ir->raw)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> - =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 schedule_work(&ir->raw->rx_work);
> =A0}
> =A0EXPORT_SYMBOL_GPL(ir_raw_event_handle);
>
> @@ -205,8 +229,6 @@
>
> =A0void ir_raw_init(void)
> =A0{
> - =A0 =A0 =A0 spin_lock_init(&ir_raw_handler_lock);
> -
> =A0#ifdef MODULE
> =A0 =A0 =A0 =A0INIT_WORK(&wq_load, init_decoders);
> =A0 =A0 =A0 =A0schedule_work(&wq_load);
> Index: ir/include/media/ir-core.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ir.orig/include/media/ir-core.h =A0 =A0 2010-04-06 12:16:27.00000=
0000 +0200
> +++ ir/include/media/ir-core.h =A02010-04-07 18:17:53.524850074 +0200
> @@ -57,14 +57,12 @@
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0(*close)(void *priv);
> =A0};
>
> -struct ir_raw_event {
> - =A0 =A0 =A0 struct timespec =A0 =A0 =A0 =A0 delta; =A0/* Time spent=
 before event */
> - =A0 =A0 =A0 enum raw_event_type =A0 =A0 type; =A0 /* event type */
> -};
> -
> =A0struct ir_raw_event_ctrl {
> - =A0 =A0 =A0 struct kfifo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfi=
fo; =A0 =A0 =A0 =A0 =A0/* fifo for the pulse/space events */
> - =A0 =A0 =A0 struct timespec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_ev=
ent; =A0 =A0 /* when last event occurred */
> + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_work; =
=A0 =A0 =A0 =A0/* for the rx decoding workqueue */
> + =A0 =A0 =A0 struct kfifo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfi=
fo; =A0 =A0 =A0 =A0 =A0/* fifo for the pulse/space durations */
> + =A0 =A0 =A0 ktime_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 last_event; =A0 =A0 /* when last event occurred */
> + =A0 =A0 =A0 enum raw_event_type =A0 =A0 =A0 =A0 =A0 =A0 last_type; =
=A0 =A0 =A0/* last event type */
> + =A0 =A0 =A0 struct input_dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*input_=
dev; =A0 =A0 /* pointer to the parent input_dev */
> =A0};
>
> =A0struct ir_input_dev {
> @@ -89,8 +87,7 @@
> =A0struct ir_raw_handler {
> =A0 =A0 =A0 =A0struct list_head list;
>
> - =A0 =A0 =A0 int (*decode)(struct input_dev *input_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ir_raw_event *ev);
> + =A0 =A0 =A0 int (*decode)(struct input_dev *input_dev, int duration=
);
> =A0 =A0 =A0 =A0int (*raw_register)(struct input_dev *input_dev);
> =A0 =A0 =A0 =A0int (*raw_unregister)(struct input_dev *input_dev);
> =A0};
> @@ -146,8 +143,13 @@
> =A0/* Routines from ir-raw-event.c */
> =A0int ir_raw_event_register(struct input_dev *input_dev);
> =A0void ir_raw_event_unregister(struct input_dev *input_dev);
> -int ir_raw_event_store(struct input_dev *input_dev, enum raw_event_t=
ype type);
> -int ir_raw_event_handle(struct input_dev *input_dev);
> +void ir_raw_event_handle(struct input_dev *input_dev);
> +int ir_raw_event_store(struct input_dev *input_dev, int duration);
> +int ir_raw_event_store_edge(struct input_dev *input_dev, enum raw_ev=
ent_type type);
> +static inline void ir_raw_event_reset(struct input_dev *dev) {
> + =A0 =A0 =A0 ir_raw_event_store(input_dev, 0);
> + =A0 =A0 =A0 ir_raw_event_handle(input_dev);
> +}
> =A0int ir_raw_handler_register(struct ir_raw_handler *ir_raw_handler)=
;
> =A0void ir_raw_handler_unregister(struct ir_raw_handler *ir_raw_handl=
er);
> =A0void ir_raw_init(void);
> Index: ir/drivers/media/IR/ir-nec-decoder.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ir.orig/drivers/media/IR/ir-nec-decoder.c =A0 2010-04-06 12:16:27=
=2E000000000 +0200
> +++ ir/drivers/media/IR/ir-nec-decoder.c =A0 =A0 =A0 =A02010-04-07 18=
:32:10.892853025 +0200
> @@ -13,23 +13,23 @@
> =A0*/
>
> =A0#include <media/ir-core.h>
> +#include <linux/bitrev.h>
>
> =A0#define NEC_NBITS =A0 =A0 =A0 =A0 =A0 =A0 =A032
> -#define NEC_UNIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 559979 /* ns */
> -#define NEC_HEADER_MARK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(16 * NEC_UNI=
T)
> -#define NEC_HEADER_SPACE =A0 =A0 =A0 (8 * NEC_UNIT)
> -#define NEC_REPEAT_SPACE =A0 =A0 =A0 (4 * NEC_UNIT)
> -#define NEC_MARK =A0 =A0 =A0 =A0 =A0 =A0 =A0 (NEC_UNIT)
> -#define NEC_0_SPACE =A0 =A0 =A0 =A0 =A0 =A0(NEC_UNIT)
> -#define NEC_1_SPACE =A0 =A0 =A0 =A0 =A0 =A0(3 * NEC_UNIT)
> +#define NEC_UNIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 562 =A0 =A0 /* us */
> +#define NEC_HEADER_MARK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
> +#define NEC_HEADER_SPACE =A0 =A0 =A0 -8
> +#define NEC_REPEAT_SPACE =A0 =A0 =A0 -4
> +#define NEC_MARK =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define NEC_0_SPACE =A0 =A0 =A0 =A0 =A0 =A0-1
> +#define NEC_1_SPACE =A0 =A0 =A0 =A0 =A0 =A0-3
>
> =A0/* Used to register nec_decoder clients */
> =A0static LIST_HEAD(decoder_list);
> -static spinlock_t decoder_lock;
> +static DEFINE_SPINLOCK(decoder_lock);
>
> =A0enum nec_state {
> =A0 =A0 =A0 =A0STATE_INACTIVE,
> - =A0 =A0 =A0 STATE_HEADER_MARK,
> =A0 =A0 =A0 =A0STATE_HEADER_SPACE,
> =A0 =A0 =A0 =A0STATE_MARK,
> =A0 =A0 =A0 =A0STATE_SPACE,
> @@ -37,13 +37,6 @@
> =A0 =A0 =A0 =A0STATE_TRAILER_SPACE,
> =A0};
>
> -struct nec_code {
> - =A0 =A0 =A0 u8 =A0 =A0 =A0address;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0not_address;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0command;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0not_command;
> -};
> -
> =A0struct decoder_data {
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0list;
> =A0 =A0 =A0 =A0struct ir_input_dev =A0 =A0 *ir_dev;
> @@ -51,7 +44,7 @@
>
> =A0 =A0 =A0 =A0/* State machine control */
> =A0 =A0 =A0 =A0enum nec_state =A0 =A0 =A0 =A0 =A0state;
> - =A0 =A0 =A0 struct nec_code =A0 =A0 =A0 =A0 nec_code;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nec_bits;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count;
> =A0};
>
> @@ -62,7 +55,6 @@
> =A0*
> =A0* Returns the struct decoder_data that corresponds to a device
> =A0*/
> -
> =A0static struct decoder_data *get_decoder_data(struct =A0ir_input_de=
v *ir_dev)
> =A0{
> =A0 =A0 =A0 =A0struct decoder_data *data =3D NULL;
> @@ -123,20 +115,20 @@
> =A0 =A0 =A0 =A0.attrs =A0=3D decoder_attributes,
> =A0};
>
> -
> =A0/**
> =A0* ir_nec_decode() - Decode one NEC pulse or space
> =A0* @input_dev: the struct input_dev descriptor of the device
> - * @ev: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0event array with type/duratio=
n of pulse/space
> + * @duration: =A0duration in us of pulse/space
> =A0*
> =A0* This function returns -EINVAL if the pulse violates the state ma=
chine
> =A0*/
> -static int ir_nec_decode(struct input_dev *input_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ir_raw_event =
*ev)
> +static int ir_nec_decode(struct input_dev *input_dev, int duration)
> =A0{
> =A0 =A0 =A0 =A0struct decoder_data *data;
> =A0 =A0 =A0 =A0struct ir_input_dev *ir_dev =3D input_get_drvdata(inpu=
t_dev);
> - =A0 =A0 =A0 int bit, last_bit;
> + =A0 =A0 =A0 int d;
> + =A0 =A0 =A0 u32 scancode;
> + =A0 =A0 =A0 u8 address, not_address, command, not_command;
>
> =A0 =A0 =A0 =A0data =3D get_decoder_data(ir_dev);
> =A0 =A0 =A0 =A0if (!data)
> @@ -145,150 +137,106 @@
> =A0 =A0 =A0 =A0if (!data->enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> - =A0 =A0 =A0 /* Except for the initial event, what matters is the pr=
evious bit */
> - =A0 =A0 =A0 bit =3D (ev->type & IR_PULSE) ? 1 : 0;
> -
> - =A0 =A0 =A0 last_bit =3D !bit;
> -
> - =A0 =A0 =A0 /* Discards spurious space last_bits when inactive */
> -
> - =A0 =A0 =A0 /* Very long delays are considered as start events */
> - =A0 =A0 =A0 if (ev->delta.tv_nsec > NEC_HEADER_MARK + NEC_HEADER_SP=
ACE - NEC_UNIT / 2)
> + =A0 =A0 =A0 if (duration =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state =3D STATE_INACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 if (ev->type & IR_START_EVENT)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
> + =A0 =A0 =A0 d =3D DIV_ROUND_CLOSEST(abs(duration), NEC_UNIT);
> + =A0 =A0 =A0 if (duration < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 d =3D -d;

d =3D abs(duration)
d =3D DIV_ROUND_CLOSEST(d, NEC_UNIT);


> +
> + =A0 =A0 =A0 IR_dprintk(2, "NEC decode started at state %d (%i units=
, %ius)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state, d, duration);
>
> =A0 =A0 =A0 =A0switch (data->state) {
> - =A0 =A0 =A0 case STATE_INACTIVE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bit) =A0 =A0 =A0 =A0 =A0 =A0 =A0 /=
* PULSE marks the start event */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_HEADER_MARK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset (&data->nec_code, 0, sizeof(data=
->nec_code));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 case STATE_HEADER_MARK:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!last_bit)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ev->delta.tv_nsec < NEC_HEADER_MARK=
 - 6 * NEC_UNIT)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_HEADER_SPACE;
> + =A0 =A0 =A0 case STATE_INACTIVE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d =3D=3D NEC_HEADER_MARK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_H=
EADER_SPACE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> +
> =A0 =A0 =A0 =A0case STATE_HEADER_SPACE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (last_bit)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ev->delta.tv_nsec >=3D NEC_HEADER_S=
PACE - NEC_UNIT / 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d =3D=3D NEC_HEADER_SPACE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state =3D STATE_=
MARK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ev->delta.tv_nsec >=3D NEC_REPEAT_S=
PACE - NEC_UNIT / 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (d =3D=3D NEC_REPEAT_SPACE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ir_repeat(input_dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IR_dprintk(1, "Repeat =
last key\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state =3D STATE_=
TRAILER_MARK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0case STATE_MARK:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!last_bit)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ev->delta.tv_nsec > NEC_MARK + NEC=
_UNIT / 2) ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ev->delta.tv_nsec < NEC_MARK -=
 NEC_UNIT / 2))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_SPACE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d =3D=3D NEC_MARK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_S=
PACE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0case STATE_SPACE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (last_bit)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d !=3D NEC_0_SPACE && d !=3D NEC_1_=
SPACE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ev->delta.tv_nsec >=3D NEC_0_SPACE=
 - NEC_UNIT / 2) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ev->delta.tv_nsec < NEC_0_SPAC=
E + NEC_UNIT / 2))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if ((ev->delta.tv_nsec >=3D NEC_1_=
SPACE - NEC_UNIT / 2) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ev->delta.tv_nsec <=
 NEC_1_SPACE + NEC_UNIT / 2))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "Decode f=
ailed at %d-th bit (%s) @%luus\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->c=
ount,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_bi=
t ? "pulse" : "space",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ev->de=
lta.tv_nsec + 500) / 1000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->nec_bits <<=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d =3D=3D NEC_1_SPACE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->nec_bits |=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count++;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->count !=3D NEC_NBITS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_M=
ARK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ok, we've got a valid bit. proccess =
it */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bit) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int shift =3D data->cou=
nt;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* NEC transmit bytes=
 on this temporal order:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* address | not addr=
ess | command | not command
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (shift < 8) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->n=
ec_code.address |=3D 1 << shift;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (shift < 16) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->n=
ec_code.not_address |=3D 1 << (shift - 8);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (shift < 24) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->n=
ec_code.command |=3D 1 << (shift - 16);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->n=
ec_code.not_command |=3D 1 << (shift - 24);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 address =A0 =A0 =3D bitrev8((data->nec_=
bits >> 24) & 0xff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 not_address =3D bitrev8((data->nec_bits=
 >> 16) & 0xff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 command =A0 =A0 =3D bitrev8((data->nec_=
bits >> =A08) & 0xff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 not_command =3D bitrev8((data->nec_bits=
 >> =A00) & 0xff);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((command ^ not_command) !=3D 0xff) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "NEC chec=
ksum error: received 0x%08x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
data->nec_bits);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (++data->count =3D=3D NEC_NBITS) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 scancode;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fixme: may need to=
 accept Extended NEC protocol?
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((data->nec_code.com=
mand ^ data->nec_code.not_command) !=3D 0xff)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ch=
ecksum_err;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((data->nec_code.add=
ress ^ data->nec_code.not_address) !=3D 0xff) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Exte=
nded NEC */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancod=
e =3D data->nec_code.address << 16 |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0data->nec_code.not_address << 8 |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0data->nec_code.command;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dpri=
ntk(1, "NEC scancode 0x%06x\n", scancode);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* norm=
al NEC */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancod=
e =3D data->nec_code.address << 8 |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0data->nec_code.command;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dpri=
ntk(1, "NEC scancode 0x%04x\n", scancode);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_keydown(input_dev, s=
cancode, 0);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_T=
RAILER_MARK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_M=
ARK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((address ^ not_address) !=3D 0xff) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Extended NEC */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D address =A0=
 =A0 << 16 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
not_address << =A08 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
command;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "NEC (Ext=
) scancode 0x%06x\n", scancode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* normal NEC */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D address <<=
 8 | command;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "NEC scan=
code 0x%04x\n", scancode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_keydown(input_dev, scancode, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAILER_MARK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> +
> =A0 =A0 =A0 =A0case STATE_TRAILER_MARK:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!last_bit)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAILER_SPACE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_T=
RAILER_SPACE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0case STATE_TRAILER_SPACE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (last_bit)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_I=
NACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> -err:
> - =A0 =A0 =A0 IR_dprintk(1, "NEC decoded failed at state %d (%s) @ %l=
uus\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bit ? "pulse" : "space",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ev->delta.tv_nsec + 500) / 1000=
);
> -err2:
> - =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
> - =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
>
> -checksum_err:
> + =A0 =A0 =A0 IR_dprintk(1, "NEC decode failed at state %d (%i units,=
 %ius)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state, d, duration);
> =A0 =A0 =A0 =A0data->state =3D STATE_INACTIVE;
> - =A0 =A0 =A0 IR_dprintk(1, "NEC checksum error: received 0x%02x%02x%=
02x%02x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->nec_code.address,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->nec_code.not_address,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->nec_code.command,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->nec_code.not_command);
> =A0 =A0 =A0 =A0return -EINVAL;
> =A0}
>
> Index: ir/drivers/media/IR/ir-rc5-decoder.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ir.orig/drivers/media/IR/ir-rc5-decoder.c =A0 2010-04-06 12:16:51=
=2E784849187 +0200
> +++ ir/drivers/media/IR/ir-rc5-decoder.c =A0 =A0 =A0 =A02010-04-07 21=
:34:14.816870395 +0200
> @@ -15,31 +15,22 @@
> =A0/*
> =A0* This code only handles 14 bits RC-5 protocols. There are other v=
ariants
> =A0* that use a different number of bits. This is currently unsupport=
ed
> - * It considers a carrier of 36 kHz, with a total of 14 bits, where
> - * the first two bits are start bits, and a third one is a filing bi=
t
> =A0*/
>
> =A0#include <media/ir-core.h>
>
> -static unsigned int ir_rc5_remote_gap =3D 888888;
> -
> -#define RC5_NBITS =A0 =A0 =A0 =A0 =A0 =A0 =A014
> -#define RC5_BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ir_r=
c5_remote_gap * 2)
> -#define RC5_DURATION =A0 =A0 =A0 =A0 =A0 (ir_rc5_remote_gap * RC5_NB=
ITS)
> +#define RC5_UNIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 889 /* us */
> +#define =A0 =A0 =A0 =A0RC5_BITS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>
> =A0/* Used to register rc5_decoder clients */
> =A0static LIST_HEAD(decoder_list);
> -static spinlock_t decoder_lock;
> +static DEFINE_SPINLOCK(decoder_lock);
>
> =A0enum rc5_state {
> =A0 =A0 =A0 =A0STATE_INACTIVE,
> - =A0 =A0 =A0 STATE_MARKSPACE,
> - =A0 =A0 =A0 STATE_TRAILER,
> -};
> -
> -struct rc5_code {
> - =A0 =A0 =A0 u8 =A0 =A0 =A0address;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0command;
> + =A0 =A0 =A0 STATE_BIT_START,
> + =A0 =A0 =A0 STATE_BIT_END,
> + =A0 =A0 =A0 STATE_FINISHED,
> =A0};
>
> =A0struct decoder_data {
> @@ -49,8 +40,9 @@
>
> =A0 =A0 =A0 =A0/* State machine control */
> =A0 =A0 =A0 =A0enum rc5_state =A0 =A0 =A0 =A0 =A0state;
> - =A0 =A0 =A0 struct rc5_code =A0 =A0 =A0 =A0 rc5_code;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0code, elapsed, =
last_bit, last_code;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc5_bits;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_delta;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count;
> =A0};
>
>
> @@ -122,18 +114,19 @@
> =A0};
>
> =A0/**
> - * handle_event() - Decode one RC-5 pulse or space
> + * ir_rc5_decode() - Decode one RC-5 pulse or space
> =A0* @input_dev: the struct input_dev descriptor of the device
> - * @ev: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0event array with type/duratio=
n of pulse/space
> + * @duration: =A0duration of pulse/space
> =A0*
> =A0* This function returns -EINVAL if the pulse violates the state ma=
chine
> =A0*/
> -static int ir_rc5_decode(struct input_dev *input_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ir_raw_event *ev=
)
> +static int ir_rc5_decode(struct input_dev *input_dev, int duration)
> =A0{
> =A0 =A0 =A0 =A0struct decoder_data *data;
> =A0 =A0 =A0 =A0struct ir_input_dev *ir_dev =3D input_get_drvdata(inpu=
t_dev);
> - =A0 =A0 =A0 int is_pulse, scancode, delta, toggle;
> + =A0 =A0 =A0 u8 command, system, toggle;
> + =A0 =A0 =A0 u32 scancode;
> + =A0 =A0 =A0 int d;
>
> =A0 =A0 =A0 =A0data =3D get_decoder_data(ir_dev);
> =A0 =A0 =A0 =A0if (!data)
> @@ -142,79 +135,86 @@
> =A0 =A0 =A0 =A0if (!data->enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> - =A0 =A0 =A0 delta =3D DIV_ROUND_CLOSEST(ev->delta.tv_nsec, ir_rc5_r=
emote_gap);
> + =A0 =A0 =A0 if (duration =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 /* The duration time refers to the last bit time */
> - =A0 =A0 =A0 is_pulse =3D (ev->type & IR_PULSE) ? 1 : 0;
> + =A0 =A0 =A0 d =3D DIV_ROUND_CLOSEST(abs(duration), RC5_UNIT);
> + =A0 =A0 =A0 if (duration < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 d =3D -d;

d =3D abs(duration)
d =3D DIV_ROUND_CLOSEST(d, RC5_UNIT);

> +
> +again:
> + =A0 =A0 =A0 IR_dprintk(2, "RC5 decode started at state %i (%i units=
, %ius)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state, d, duration);
>
> - =A0 =A0 =A0 /* Very long delays are considered as start events */
> - =A0 =A0 =A0 if (delta > RC5_DURATION || (ev->type & IR_START_EVENT)=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
> + =A0 =A0 =A0 if (d =3D=3D 0 && data->state !=3D STATE_FINISHED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> =A0 =A0 =A0 =A0switch (data->state) {
> +
> =A0 =A0 =A0 =A0case STATE_INACTIVE:
> - =A0 =A0 =A0 IR_dprintk(2, "currently inative. Start bit (%s) @%uus\=
n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_pulse ? "pulse" : "space",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned)(ev->delta.tv_nsec + 5=
00) / 1000);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Discards the initial start space */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!is_pulse)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->code =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->last_bit =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->elapsed =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(&data->rc5_code, 0, sizeof(data-=
>rc5_code));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_MARKSPACE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 case STATE_MARKSPACE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (delta !=3D 1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->last_bit =3D data=
->last_bit ? 0 : 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((d =3D=3D 1) || (d =3D=3D 2)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_B=
IT_START;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->elapsed +=3D delta;
> + =A0 =A0 =A0 case STATE_BIT_START:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (abs(d) =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->rc5_bits <<=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->r=
c5_bits |=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->last_delta =3D d;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the last bit is=
 zero, a space will "merge"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with the silence a=
fter the command.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((data->count =3D=3D=
 data->wanted_bits) && (d =3D=3D 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->s=
tate =3D STATE_FINISHED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->s=
tate =3D STATE_BIT_END;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((data->elapsed % 2) =3D=3D 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->code <<=3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->code |=3D data->last_bit;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Fill the 2 unused bits at the comman=
d with 0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->elapsed / 2 =3D=3D 6)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->code <<=3D 2;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->elapsed >=3D (RC5_NBITS - 1) =
* 2) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D data->code=
;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for the start =
bits */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((scancode & 0xc000)=
 !=3D 0xc000) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dpri=
ntk(1, "Code 0x%04x doesn't have two start bits. It is not RC-5\n", sca=
ncode);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 toggle =3D (scancode & =
0x2000) ? 1 : 0;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scancode =3D=3D dat=
a->last_code) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dpri=
ntk(1, "RC-5 repeat\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_repe=
at(input_dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->l=
ast_code =3D scancode;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancod=
e &=3D 0x1fff;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dpri=
ntk(1, "RC-5 scancode 0x%04x\n", scancode);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_keyd=
own(input_dev, scancode, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_T=
RAILER;
> + =A0 =A0 =A0 case STATE_BIT_END:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* delta and last_delta signedness must=
 differ */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d * data->last_delta < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->count =3D=3D =
RC5_BITS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->s=
tate =3D STATE_FINISHED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->s=
tate =3D STATE_BIT_START;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (d < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 case STATE_TRAILER:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case STATE_FINISHED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 command =A0=3D (data->rc5_bits & 0x0003=
=46) >> 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 system =A0 =3D (data->rc5_bits & 0x007C=
0) >> 6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 toggle =A0 =3D (data->rc5_bits & 0x0080=
0) ? 1 : 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 command +=3D (data->rc5_bits & 0x01000)=
 ? 0 : 0x40;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D system << 8 | command;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "RC5 scancode 0x%04x (tog=
gle: %u)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scancode, toggle=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_keydown(input_dev, scancode, toggle)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state =3D STATE_INACTIVE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> -err:
> - =A0 =A0 =A0 IR_dprintk(1, "RC-5 decoded failed at %s @ %luus\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_pulse ? "pulse" : "space",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ev->delta.tv_nsec + 500) / 1000=
);
> + =A0 =A0 =A0 IR_dprintk(1, "RC5 decode failed at state %i (%i units,=
 %ius)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state, d, duration);
> =A0 =A0 =A0 =A0data->state =3D STATE_INACTIVE;
> =A0 =A0 =A0 =A0return -EINVAL;
> =A0}
> Index: ir/drivers/media/video/saa7134/saa7134-input.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ir.orig/drivers/media/video/saa7134/saa7134-input.c 2010-04-06 12=
:30:16.428854774 +0200
> +++ ir/drivers/media/video/saa7134/saa7134-input.c =A0 =A0 =A02010-04=
-07 18:05:27.756852639 +0200
> @@ -1021,7 +1021,7 @@
> =A0 =A0 =A0 =A0saa_clearb(SAA7134_GPIO_GPMODE3, SAA7134_GPIO_GPRESCAN=
);
> =A0 =A0 =A0 =A0saa_setb(SAA7134_GPIO_GPMODE3, SAA7134_GPIO_GPRESCAN);
> =A0 =A0 =A0 =A0space =3D saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2) & ir-=
>mask_keydown;
> - =A0 =A0 =A0 ir_raw_event_store(dev->remote->dev, space ? IR_SPACE :=
 IR_PULSE);
> + =A0 =A0 =A0 ir_raw_event_store_edge(dev->remote->dev, space ? IR_SP=
ACE : IR_PULSE);
>
>
> =A0 =A0 =A0 =A0/*
>
> --
> David H=E4rdeman
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
