From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC3] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Fri, 9 Apr 2010 08:31:21 -0400
Message-ID: <s2o9e4733911004090531we8ff39b4r570e32fdafa04204@mail.gmail.com>
References: <20100408113910.GA17104@hardeman.nu>
	 <1270812351.3764.66.camel@palomino.walls.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1270812351.3764.66.camel@palomino.walls.org>
Sender: linux-media-owner@vger.kernel.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>, mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 9, 2010 at 7:25 AM, Andy Walls <awalls@md.metrocast.net> wr=
ote:
> On Thu, 2010-04-08 at 13:39 +0200, David H=E4rdeman wrote:
>> drivers/media/IR/ir-raw-event.c is currently written with the assump=
tion
>> that all "raw" hardware will generate events only on state change (i=
=2Ee.
>> when a pulse or space starts).
>>
>> However, some hardware (like mceusb, probably the most popular IR re=
ceiver
>> out there) only generates duration data (and that data is buffered s=
o using
>> any kind of timing on the data is futile).
>>
>> Furthermore, using signed int's to represent pulse/space durations i=
n ms
>> is a well-known approach to anyone with experience in writing ir dec=
oders.
>>
>> This patch (which has been tested this time) is still a RFC on my pr=
oposed
>> interface changes.
>>
>> Changes since last version:
>>
>> o s64's are used to represent pulse/space durations in ns.
>>
>> o Lots of #defines are used in the decoders
>>
>> o Refreshed to apply cleanly on top of Mauro's current git tree
>>
>> o Jon's comments wrt. interrupt-context safe functions have been add=
ed
>>
>> Index: ir/drivers/media/IR/ir-raw-event.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ir.orig/drivers/media/IR/ir-raw-event.c =A0 2010-04-08 12:30:28.=
036098192 +0200
>> +++ ir/drivers/media/IR/ir-raw-event.c =A0 =A0 =A0 =A02010-04-08 12:=
45:19.780145403 +0200
>> @@ -15,9 +15,10 @@
>> =A0#include <media/ir-core.h>
>> =A0#include <linux/workqueue.h>
>> =A0#include <linux/spinlock.h>
>> +#include <linux/sched.h>
>>
>> -/* Define the max number of bit transitions per IR keycode */
>> -#define MAX_IR_EVENT_SIZE =A0 =A0256
>> +/* Define the max number of pulse/space transitions to buffer */
>> +#define MAX_IR_EVENT_SIZE =A0 =A0 =A0512
>>
>> =A0/* Used to handle IR raw handler extensions */
>> =A0static LIST_HEAD(ir_raw_handler_list);
>> @@ -53,19 +54,30 @@
>> =A0/* Used to load the decoders */
>> =A0static struct work_struct wq_load;
>>
>> +static void ir_raw_event_work(struct work_struct *work)
>> +{
>> + =A0 =A0 s64 d;
>> + =A0 =A0 struct ir_raw_event_ctrl *raw =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct ir_raw_event_ctr=
l, rx_work);
>> +
>> + =A0 =A0 while (kfifo_out(&raw->kfifo, &d, sizeof(d)) =3D=3D sizeof=
(d))
>> + =A0 =A0 =A0 =A0 =A0 =A0 RUN_DECODER(decode, raw->input_dev, d);
>> +}
>> +
>> =A0int ir_raw_event_register(struct input_dev *input_dev)
>> =A0{
>> =A0 =A0 =A0 struct ir_input_dev *ir =3D input_get_drvdata(input_dev)=
;
>> - =A0 =A0 int rc, size;
>> + =A0 =A0 int rc;
>>
>> =A0 =A0 =A0 ir->raw =3D kzalloc(sizeof(*ir->raw), GFP_KERNEL);
>> =A0 =A0 =A0 if (!ir->raw)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>
>> - =A0 =A0 size =3D sizeof(struct ir_raw_event) * MAX_IR_EVENT_SIZE *=
 2;
>> - =A0 =A0 size =3D roundup_pow_of_two(size);
>> + =A0 =A0 ir->raw->input_dev =3D input_dev;
>> + =A0 =A0 INIT_WORK(&ir->raw->rx_work, ir_raw_event_work);
>>
>> - =A0 =A0 rc =3D kfifo_alloc(&ir->raw->kfifo, size, GFP_KERNEL);
>> + =A0 =A0 rc =3D kfifo_alloc(&ir->raw->kfifo, sizeof(s64) * MAX_IR_E=
VENT_SIZE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>> =A0 =A0 =A0 if (rc < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(ir->raw);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir->raw =3D NULL;
>> @@ -90,6 +102,7 @@
>> =A0 =A0 =A0 if (!ir->raw)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 cancel_work_sync(&ir->raw->rx_work);
>> =A0 =A0 =A0 RUN_DECODER(raw_unregister, input_dev);
>>
>> =A0 =A0 =A0 kfifo_free(&ir->raw->kfifo);
>> @@ -97,74 +110,90 @@
>> =A0 =A0 =A0 ir->raw =3D NULL;
>> =A0}
>>
>> -int ir_raw_event_store(struct input_dev *input_dev, enum raw_event_=
type type)
>> +/**
>> + * ir_raw_event_store() - pass a pulse/space duration to the raw ir=
 decoders
>> + * @input_dev: =A0 =A0 =A0 the struct input_dev device descriptor
>> + * @duration: =A0 =A0 =A0 =A0duration of the pulse or space in ns
>> + *
>> + * This routine (which may be called from an interrupt context) sto=
res a
>> + * pulse/space duration for the raw ir decoding state machines. Pul=
ses are
>> + * signalled as positive values and spaces as negative values. A ze=
ro value
>> + * will reset the decoding state machines.
>> + */
>> +int ir_raw_event_store(struct input_dev *input_dev, s64 duration)
>> =A0{
>> - =A0 =A0 struct ir_input_dev =A0 =A0 *ir =3D input_get_drvdata(inpu=
t_dev);
>> - =A0 =A0 struct timespec =A0 =A0 =A0 =A0 ts;
>> - =A0 =A0 struct ir_raw_event =A0 =A0 event;
>> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc;
>> + =A0 =A0 struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
>>
>> =A0 =A0 =A0 if (!ir->raw)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> - =A0 =A0 event.type =3D type;
>> - =A0 =A0 event.delta.tv_sec =3D 0;
>> - =A0 =A0 event.delta.tv_nsec =3D 0;
>> + =A0 =A0 if (kfifo_in(&ir->raw->kfifo, &duration, sizeof(duration))=
 !=3D sizeof(duration))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>
>> - =A0 =A0 ktime_get_ts(&ts);
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(ir_raw_event_store);
>>
>> - =A0 =A0 if (timespec_equal(&ir->raw->last_event, &event.delta))
>> - =A0 =A0 =A0 =A0 =A0 =A0 event.type |=3D IR_START_EVENT;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 event.delta =3D timespec_sub(ts, ir->raw->=
last_event);
>> +/**
>> + * ir_raw_event_store_edge() - notify raw ir decoders of the start =
of a pulse/space
>> + * @input_dev: =A0 =A0 =A0 the struct input_dev device descriptor
>> + * @type: =A0 =A0the type of the event that has occurred
>> + *
>> + * This routine (which may be called from an interrupt context) is =
used to
>> + * store the beginning of an ir pulse or space (or the start/end of=
 ir
>> + * reception) for the raw ir decoding state machines. This is used =
by
>> + * hardware which does not provide durations directly but only inte=
rrupts
>> + * (or similar events) on state change.
>> + */
>> +int ir_raw_event_store_edge(struct input_dev *input_dev, enum raw_e=
vent_type type)
>> +{
>> + =A0 =A0 struct ir_input_dev =A0 =A0 *ir =3D input_get_drvdata(inpu=
t_dev);
>> + =A0 =A0 ktime_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 now;
>> + =A0 =A0 s64 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delta; /* ns *=
/
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D 0;
>> +
>> + =A0 =A0 if (!ir->raw)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> - =A0 =A0 memcpy(&ir->raw->last_event, &ts, sizeof(ts));
>> + =A0 =A0 now =3D ktime_get();
>> + =A0 =A0 delta =3D ktime_to_ns(ktime_sub(now, ir->raw->last_event))=
;
>>
>> - =A0 =A0 if (event.delta.tv_sec) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 event.type |=3D IR_START_EVENT;
>> - =A0 =A0 =A0 =A0 =A0 =A0 event.delta.tv_sec =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 event.delta.tv_nsec =3D 0;
>> - =A0 =A0 }
>> + =A0 =A0 /* Check for a long duration since last event or if we're
>> + =A0 =A0 =A0* being called for the first time, note that delta can'=
t
>> + =A0 =A0 =A0* possibly be negative.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (delta > NSEC_PER_SEC || !ir->raw->last_type)
>> + =A0 =A0 =A0 =A0 =A0 =A0 type |=3D IR_START_EVENT;
>>
>> - =A0 =A0 kfifo_in(&ir->raw->kfifo, &event, sizeof(event));
>> + =A0 =A0 if (type & IR_START_EVENT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ir_raw_event_reset(input_dev);
>> + =A0 =A0 else if (ir->raw->last_type & IR_SPACE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ir_raw_event_store(input_dev, -delt=
a);
>> + =A0 =A0 else if (ir->raw->last_type & IR_PULSE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ir_raw_event_store(input_dev, delta=
);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> + =A0 =A0 ir->raw->last_event =3D now;
>> + =A0 =A0 ir->raw->last_type =3D type;
>> =A0 =A0 =A0 return rc;
>> =A0}
>> -EXPORT_SYMBOL_GPL(ir_raw_event_store);
>> +EXPORT_SYMBOL_GPL(ir_raw_event_store_edge);
>>
>> -int ir_raw_event_handle(struct input_dev *input_dev)
>> +/**
>> + * ir_raw_event_handle() - schedules the decoding of stored ir data
>> + * @input_dev: =A0 =A0 =A0 the struct input_dev device descriptor
>> + *
>> + * This routine will signal the workqueue to start decoding stored =
ir data.
>> + */
>> +void ir_raw_event_handle(struct input_dev *input_dev)
>> =A0{
>> - =A0 =A0 struct ir_input_dev =A0 =A0 =A0 =A0 =A0 =A0 *ir =3D input_=
get_drvdata(input_dev);
>> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 rc;
>> - =A0 =A0 struct ir_raw_event =A0 =A0 =A0 =A0 =A0 =A0 ev;
>> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 len, i;
>> -
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* Store the events into a temporary buffer. This allows=
 calling more than
>> - =A0 =A0 =A0* one decoder to deal with the received data
>> - =A0 =A0 =A0*/
>> - =A0 =A0 len =3D kfifo_len(&ir->raw->kfifo) / sizeof(ev);
>> - =A0 =A0 if (!len)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> -
>> - =A0 =A0 for (i =3D 0; i < len; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D kfifo_out(&ir->raw->kfifo, &ev, siz=
eof(ev));
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (rc !=3D sizeof(ev)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "overflow er=
ror: received %d instead of %zd\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc,=
 sizeof(ev));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(2, "event type %d, time before =
event: %07luus\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ev.type, (ev.delta.tv_nsec=
 + 500) / 1000);
>> - =A0 =A0 =A0 =A0 =A0 =A0 rc =3D RUN_DECODER(decode, input_dev, &ev)=
;
>> - =A0 =A0 }
>> + =A0 =A0 struct ir_input_dev *ir =3D input_get_drvdata(input_dev);
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* Call all ir decoders. This allows decoding the same e=
vent with
>> - =A0 =A0 =A0* more than one protocol handler.
>> - =A0 =A0 =A0*/
>> + =A0 =A0 if (!ir->raw)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 return rc;
>> + =A0 =A0 schedule_work(&ir->raw->rx_work);
>> =A0}
>> =A0EXPORT_SYMBOL_GPL(ir_raw_event_handle);
>>
>> Index: ir/include/media/ir-core.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ir.orig/include/media/ir-core.h =A0 2010-04-08 12:30:28.00000000=
0 +0200
>> +++ ir/include/media/ir-core.h =A0 =A0 =A0 =A02010-04-08 13:25:43.76=
1137406 +0200
>> @@ -65,14 +65,12 @@
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*close)(voi=
d *priv);
>> =A0};
>>
>> -struct ir_raw_event {
>> - =A0 =A0 struct timespec =A0 =A0 =A0 =A0 delta; =A0/* Time spent be=
fore event */
>> - =A0 =A0 enum raw_event_type =A0 =A0 type; =A0 /* event type */
>> -};
>> -
>> =A0struct ir_raw_event_ctrl {
>> - =A0 =A0 struct kfifo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfifo;=
 =A0 =A0 =A0 =A0 =A0/* fifo for the pulse/space events */
>> - =A0 =A0 struct timespec =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_event=
; =A0 =A0 /* when last event occurred */
>> + =A0 =A0 struct work_struct =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_work; =A0=
 =A0 =A0 =A0/* for the rx decoding workqueue */
>> + =A0 =A0 struct kfifo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfifo;=
 =A0 =A0 =A0 =A0 =A0/* fifo for the pulse/space durations */
>> + =A0 =A0 ktime_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 la=
st_event; =A0 =A0 /* when last event occurred */
>> + =A0 =A0 enum raw_event_type =A0 =A0 =A0 =A0 =A0 =A0 last_type; =A0=
 =A0 =A0/* last event type */
>> + =A0 =A0 struct input_dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*input_dev=
; =A0 =A0 /* pointer to the parent input_dev */
>> =A0};
>>
>> =A0struct ir_input_dev {
>> @@ -97,8 +95,7 @@
>> =A0struct ir_raw_handler {
>> =A0 =A0 =A0 struct list_head list;
>>
>> - =A0 =A0 int (*decode)(struct input_dev *input_dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ir_raw_event *ev);
>> + =A0 =A0 int (*decode)(struct input_dev *input_dev, s64 duration);
>> =A0 =A0 =A0 int (*raw_register)(struct input_dev *input_dev);
>> =A0 =A0 =A0 int (*raw_unregister)(struct input_dev *input_dev);
>> =A0};
>> @@ -154,8 +151,13 @@
>> =A0/* Routines from ir-raw-event.c */
>> =A0int ir_raw_event_register(struct input_dev *input_dev);
>> =A0void ir_raw_event_unregister(struct input_dev *input_dev);
>> -int ir_raw_event_store(struct input_dev *input_dev, enum raw_event_=
type type);
>> -int ir_raw_event_handle(struct input_dev *input_dev);
>> +void ir_raw_event_handle(struct input_dev *input_dev);
>> +int ir_raw_event_store(struct input_dev *input_dev, s64 duration);
>> +int ir_raw_event_store_edge(struct input_dev *input_dev, enum raw_e=
vent_type type);
>> +static inline void ir_raw_event_reset(struct input_dev *input_dev) =
{
>> + =A0 =A0 ir_raw_event_store(input_dev, 0);
>> + =A0 =A0 ir_raw_event_handle(input_dev);
>> +}
>> =A0int ir_raw_handler_register(struct ir_raw_handler *ir_raw_handler=
);
>> =A0void ir_raw_handler_unregister(struct ir_raw_handler *ir_raw_hand=
ler);
>> =A0void ir_raw_init(void);
>> @@ -174,4 +176,26 @@
>> =A0#define load_rc5_decode() =A0 =A00
>> =A0#endif
>>
>> +/* macros for ir decoders */
>> +#define PULSE(units) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ((units))
>> +#define SPACE(units) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (-(units))
>
> Encoding pulse vs space with a negative sign, even if now hidden with
> macros, is still just using a sign instead of a boolean. =A0Memory in
> modern computers (and now microcontrollers) is cheap and only getting
> cheaper. =A0Don't give up readability, flexibility, or mainatainabili=
ty,
> for the sake of saving memory.

I agree with this. I did it with signed ints in my first version, then
ripped it out and switched to duration + boolean. The duration/boolean
pair was much easier to understand. This is a matter of style, both
schemes work.

>
>
>
>> +#define IS_RESET(duration) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((du=
ration) =3D=3D 0)
>> +#define IS_PULSE(duration) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((du=
ration) > 0)
>> +#define IS_SPACE(duration) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((du=
ration) < 0)
>> +#define DURATION(duration) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (abs=
((duration)))
>> +#define IS_TRANSITION(x ,y) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((x)=
 * (y) < 0)
>> +#define DECREASE_DURATION(duration, amount) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0\
>> + =A0 =A0 do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_SPACE(duration)) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 duration +=3D (amount); =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (IS_PULSE(duration)) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 duration -=3D (amount); =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 } while(0)
>> +
>> +#define TO_UNITS(duration, unit_len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 ((int)((duration) > 0 ? =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 DIV_ROUND_CLOSEST(abs((duration)), (unit_l=
en)) :\
>> + =A0 =A0 =A0 =A0 =A0 =A0 - DIV_ROUND_CLOSEST(abs((duration)), (unit=
_len))))
>> +#define TO_US(duration) =A0 =A0 =A0 =A0 =A0 =A0 =A0((int)TO_UNITS(d=
uration, 1000))
>> +
>> =A0#endif /* _IR_CORE */
>> Index: ir/drivers/media/IR/ir-nec-decoder.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ir.orig/drivers/media/IR/ir-nec-decoder.c 2010-04-08 12:30:28.00=
0000000 +0200
>> +++ ir/drivers/media/IR/ir-nec-decoder.c =A0 =A0 =A02010-04-08 12:35=
:02.276484204 +0200
>> @@ -13,15 +13,16 @@
>> =A0 */
>>
>> =A0#include <media/ir-core.h>
>> +#include <linux/bitrev.h>
>>
>> =A0#define NEC_NBITS =A0 =A0 =A0 =A0 =A0 =A032
>> -#define NEC_UNIT =A0 =A0 =A0 =A0 =A0 =A0 559979 /* ns */
>> -#define NEC_HEADER_MARK =A0 =A0 =A0 =A0 =A0 =A0 =A0(16 * NEC_UNIT)
>> -#define NEC_HEADER_SPACE =A0 =A0 (8 * NEC_UNIT)
>> -#define NEC_REPEAT_SPACE =A0 =A0 (4 * NEC_UNIT)
>> -#define NEC_MARK =A0 =A0 =A0 =A0 =A0 =A0 (NEC_UNIT)
>> -#define NEC_0_SPACE =A0 =A0 =A0 =A0 =A0(NEC_UNIT)
>> -#define NEC_1_SPACE =A0 =A0 =A0 =A0 =A0(3 * NEC_UNIT)
>> +#define NEC_UNIT =A0 =A0 =A0 =A0 =A0 =A0 562500 =A0/* ns */
>
> Have you got a spec on the NEC protocol that justifies 562.5 usec?
>
> >From the best I can tell from the sources I have read and some deduc=
tive
> reasoning, 560 usec is the actual number. =A0Here's one:
>
> =A0 =A0 =A0 =A0http://www.audiodevelopers.com/temp/Remote_Controls.pp=
t
>
> Note:
> =A0 =A0 =A0 =A0560 usec * 38 kHz ~=3D 4192/197

In the PPT you reference there are three numbers...
http://www.sbprojects.com/knowledge/ir/nec.htm

560us
1.12ms
2.25ms

I think those are rounding errors.

562.5 * 2 =3D 1.125ms * 2 =3D 2.25ms

Most IR protocols are related in a power of two pattern for their
timings to make them easy to decode.

The protocol doesn't appear to be based on an even number of 38Khz cycl=
es.
These are easy things to change as we get better data on the protocols.

>
> and that the three numbers that yield ~560 usec don't evenly divide e=
ach
> other:
>
> =A0 =A0 =A0 =A0$ factor 4192 197 38000
> =A0 =A0 =A0 =A04192: 2 2 2 2 2 131
> =A0 =A0 =A0 =A0197: 197
> =A0 =A0 =A0 =A038000: 2 2 2 2 5 5 5 19
>
> which strikes me as being done on purpose (maybe only by me?).
>
> Also note that:
>
> =A0 =A0 =A0 =A04192 / 38 kHz =3D 110.32 usec
>
> and public sources list 110 usec as the NEC repeat period.
>
>
>> +#define NEC_HEADER_PULSE =A0 =A0 PULSE(16)
>> +#define NEC_HEADER_SPACE =A0 =A0 SPACE(8)
>> +#define NEC_REPEAT_SPACE =A0 =A0 SPACE(4)
>> +#define NEC_BIT_PULSE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PULSE(1)
>> +#define NEC_BIT_0_SPACE =A0 =A0 =A0 =A0 =A0 =A0 =A0SPACE(1)
>> +#define NEC_BIT_1_SPACE =A0 =A0 =A0 =A0 =A0 =A0 =A0SPACE(3)
>
> This is slightly better than your previous patch, but the original
> #defines were still clearer. =A0A maintainer coming through has to sp=
end
> time and energy on asking "16 what?" for example.
>
>
> While I'm on the subject of maintainability:
> It would be better to convert #defines into "const int"s within a
> function scope, if these defines are only used in one function and fi=
le
> scope is unneeded.
>
>
>
>> =A0/* Used to register nec_decoder clients */
>> =A0static LIST_HEAD(decoder_list);
>> @@ -29,21 +30,13 @@
>>
>> =A0enum nec_state {
>> =A0 =A0 =A0 STATE_INACTIVE,
>> - =A0 =A0 STATE_HEADER_MARK,
>> =A0 =A0 =A0 STATE_HEADER_SPACE,
>> - =A0 =A0 STATE_MARK,
>> - =A0 =A0 STATE_SPACE,
>> - =A0 =A0 STATE_TRAILER_MARK,
>> + =A0 =A0 STATE_BIT_PULSE,
>> + =A0 =A0 STATE_BIT_SPACE,
>> + =A0 =A0 STATE_TRAILER_PULSE,
>> =A0 =A0 =A0 STATE_TRAILER_SPACE,
>> =A0};
>>
>> -struct nec_code {
>> - =A0 =A0 u8 =A0 =A0 =A0address;
>> - =A0 =A0 u8 =A0 =A0 =A0not_address;
>> - =A0 =A0 u8 =A0 =A0 =A0command;
>> - =A0 =A0 u8 =A0 =A0 =A0not_command;
>> -};
>> -
>> =A0struct decoder_data {
>> =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0list;
>> =A0 =A0 =A0 struct ir_input_dev =A0 =A0 *ir_dev;
>> @@ -51,7 +44,7 @@
>>
>> =A0 =A0 =A0 /* State machine control */
>> =A0 =A0 =A0 enum nec_state =A0 =A0 =A0 =A0 =A0state;
>> - =A0 =A0 struct nec_code =A0 =A0 =A0 =A0 nec_code;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nec_bits;
>> =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count;
>> =A0};
>>
>> @@ -62,7 +55,6 @@
>> =A0 *
>> =A0 * Returns the struct decoder_data that corresponds to a device
>> =A0 */
>> -
>> =A0static struct decoder_data *get_decoder_data(struct =A0ir_input_d=
ev *ir_dev)
>> =A0{
>> =A0 =A0 =A0 struct decoder_data *data =3D NULL;
>> @@ -123,20 +115,20 @@
>> =A0 =A0 =A0 .attrs =A0=3D decoder_attributes,
>> =A0};
>>
>> -
>> =A0/**
>> =A0 * ir_nec_decode() - Decode one NEC pulse or space
>> =A0 * @input_dev: =A0 =A0 =A0 the struct input_dev descriptor of the=
 device
>> - * @ev: =A0 =A0 =A0 =A0 =A0 =A0 =A0event array with type/duration o=
f pulse/space
>> + * @duration: =A0 =A0 =A0 =A0duration in ns of pulse/space
>> =A0 *
>> =A0 * This function returns -EINVAL if the pulse violates the state =
machine
>> =A0 */
>> -static int ir_nec_decode(struct input_dev *input_dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ir_raw_event *ev=
)
>> +static int ir_nec_decode(struct input_dev *input_dev, s64 duration)
>> =A0{
>> =A0 =A0 =A0 struct decoder_data *data;
>> =A0 =A0 =A0 struct ir_input_dev *ir_dev =3D input_get_drvdata(input_=
dev);
>> - =A0 =A0 int bit, last_bit;
>> + =A0 =A0 int u;
>> + =A0 =A0 u32 scancode;
>> + =A0 =A0 u8 address, not_address, command, not_command;
>>
>> =A0 =A0 =A0 data =3D get_decoder_data(ir_dev);
>> =A0 =A0 =A0 if (!data)
>> @@ -145,150 +137,107 @@
>> =A0 =A0 =A0 if (!data->enabled)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> - =A0 =A0 /* Except for the initial event, what matters is the previ=
ous bit */
>> - =A0 =A0 bit =3D (ev->type & IR_PULSE) ? 1 : 0;
>> -
>> - =A0 =A0 last_bit =3D !bit;
>> -
>> - =A0 =A0 /* Discards spurious space last_bits when inactive */
>> -
>> - =A0 =A0 /* Very long delays are considered as start events */
>> - =A0 =A0 if (ev->delta.tv_nsec > NEC_HEADER_MARK + NEC_HEADER_SPACE=
 - NEC_UNIT / 2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(example compile-time constant)
>> + =A0 =A0 if (IS_RESET(duration)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>>
>> - =A0 =A0 if (ev->type & IR_START_EVENT)
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
>> + =A0 =A0 u =3D TO_UNITS(duration, NEC_UNIT);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Why are 2 run-time divisons and 2 run-time abs() invocations for ever=
y
> measurment preferrable to comparisons to compile-time constants?
>
> Your TO_UNITS(), IS_SPACE(), etc. macros help with the readability an=
d
> maintainability over your previously proposed change, but you're stil=
l
> having the CPU do extra work over what was done before.
>
> Regards,
> Andy
>
>> + =A0 =A0 if (DURATION(u) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 IR_dprintk(2, "NEC decode started at state %d (%i units, %=
ius)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state, u, TO_US(duration));
>>
>> =A0 =A0 =A0 switch (data->state) {
>> - =A0 =A0 case STATE_INACTIVE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!bit) =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* P=
ULSE marks the start event */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->count =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_HEADER_MARK;
>> - =A0 =A0 =A0 =A0 =A0 =A0 memset (&data->nec_code, 0, sizeof(data->n=
ec_code));
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 case STATE_HEADER_MARK:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!last_bit)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ev->delta.tv_nsec < NEC_HEADER_MARK - =
6 * NEC_UNIT)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_HEADER_SPACE;
>> + =A0 =A0 case STATE_INACTIVE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (u =3D=3D NEC_HEADER_PULSE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_HEAD=
ER_SPACE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> =A0 =A0 =A0 case STATE_HEADER_SPACE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (last_bit)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ev->delta.tv_nsec >=3D NEC_HEADER_SPAC=
E - NEC_UNIT / 2) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_MARK=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (u =3D=3D NEC_HEADER_SPACE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_BIT_=
PULSE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ev->delta.tv_nsec >=3D NEC_REPEAT_SPAC=
E - NEC_UNIT / 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (u =3D=3D NEC_REPEAT_SPACE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_repeat(input_dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "Repeat la=
st key\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAI=
LER_MARK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAI=
LER_PULSE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 case STATE_MARK:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!last_bit)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((ev->delta.tv_nsec > NEC_MARK + NEC_UN=
IT / 2) ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ev->delta.tv_nsec < NEC_MARK - NE=
C_UNIT / 2))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_SPACE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 case STATE_SPACE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (last_bit)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((ev->delta.tv_nsec >=3D NEC_0_SPACE - =
NEC_UNIT / 2) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ev->delta.tv_nsec < NEC_0_SPACE +=
 NEC_UNIT / 2))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 else if ((ev->delta.tv_nsec >=3D NEC_1_SPA=
CE - NEC_UNIT / 2) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ev->delta.tv_nsec < NE=
C_1_SPACE + NEC_UNIT / 2))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "Decode fail=
ed at %d-th bit (%s) @%luus\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->coun=
t,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_bit ?=
 "pulse" : "space",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ev->delta=
=2Etv_nsec + 500) / 1000);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case STATE_BIT_PULSE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (u =3D=3D NEC_BIT_PULSE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_BIT_=
SPACE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case STATE_BIT_SPACE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (u !=3D NEC_BIT_0_SPACE && u !=3D NEC_B=
IT_1_SPACE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->nec_bits <<=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (u =3D=3D NEC_BIT_1_SPACE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->nec_bits |=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->count++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (data->count !=3D NEC_NBITS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_BIT_=
PULSE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Ok, we've got a valid bit. proccess it =
*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (bit) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int shift =3D data->count;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* NEC transmit bytes on=
 this temporal order:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* address | not address=
 | command | not command
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (shift < 8) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->nec_=
code.address |=3D 1 << shift;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (shift < 16) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->nec_=
code.not_address |=3D 1 << (shift - 8);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (shift < 24) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->nec_=
code.command |=3D 1 << (shift - 16);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->nec_=
code.not_command |=3D 1 << (shift - 24);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 address =A0 =A0 =3D bitrev8((data->nec_bit=
s >> 24) & 0xff);
>> + =A0 =A0 =A0 =A0 =A0 =A0 not_address =3D bitrev8((data->nec_bits >>=
 16) & 0xff);
>> + =A0 =A0 =A0 =A0 =A0 =A0 command =A0 =A0 =3D bitrev8((data->nec_bit=
s >> =A08) & 0xff);
>> + =A0 =A0 =A0 =A0 =A0 =A0 not_command =3D bitrev8((data->nec_bits >>=
 =A00) & 0xff);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((command ^ not_command) !=3D 0xff) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "NEC checksu=
m error: received 0x%08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dat=
a->nec_bits);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (++data->count =3D=3D NEC_NBITS) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 scancode;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fixme: may need to ac=
cept Extended NEC protocol?
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((data->nec_code.comman=
d ^ data->nec_code.not_command) !=3D 0xff)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto check=
sum_err;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((data->nec_code.addres=
s ^ data->nec_code.not_address) !=3D 0xff) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Extende=
d NEC */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D=
 data->nec_code.address << 16 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0data->nec_code.not_address << 8 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0data->nec_code.command;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk=
(1, "NEC scancode 0x%06x\n", scancode);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* normal =
NEC */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D=
 data->nec_code.address << 8 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0data->nec_code.command;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk=
(1, "NEC scancode 0x%04x\n", scancode);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_keydown(input_dev, scan=
code, 0);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAI=
LER_MARK;
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_MARK=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 case STATE_TRAILER_MARK:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!last_bit)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAILER_SPACE;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((address ^ not_address) !=3D 0xff) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Extended NEC */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D address =A0 =A0=
 << 16 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0not=
_address << =A08 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0com=
mand;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "NEC (Ext) s=
cancode 0x%06x\n", scancode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* normal NEC */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D address << 8 =
| command;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "NEC scancod=
e 0x%04x\n", scancode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ir_keydown(input_dev, scancode, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAILER_PULSE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 case STATE_TRAILER_PULSE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (u > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAI=
LER_SPACE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> =A0 =A0 =A0 case STATE_TRAILER_SPACE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (last_bit)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (u < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INAC=
TIVE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> -err:
>> - =A0 =A0 IR_dprintk(1, "NEC decoded failed at state %d (%s) @ %luus=
\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bit ? "pulse" : "space",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ev->delta.tv_nsec + 500) / 1000);
>> -err2:
>> - =A0 =A0 data->state =3D STATE_INACTIVE;
>> - =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>>
>> -checksum_err:
>> +out:
>> + =A0 =A0 IR_dprintk(1, "NEC decode failed at state %d (%i units, %i=
us)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state, u, TO_US(duration));
>> =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
>> - =A0 =A0 IR_dprintk(1, "NEC checksum error: received 0x%02x%02x%02x=
%02x\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->nec_code.address,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->nec_code.not_address,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->nec_code.command,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->nec_code.not_command);
>> =A0 =A0 =A0 return -EINVAL;
>> =A0}
>>
>> Index: ir/drivers/media/IR/ir-rc5-decoder.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ir.orig/drivers/media/IR/ir-rc5-decoder.c 2010-04-08 12:30:28.00=
0000000 +0200
>> +++ ir/drivers/media/IR/ir-rc5-decoder.c =A0 =A0 =A02010-04-08 12:48=
:28.361137494 +0200
>> @@ -21,11 +21,8 @@
>>
>> =A0#include <media/ir-core.h>
>>
>> -static unsigned int ir_rc5_remote_gap =3D 888888;
>> -
>> =A0#define RC5_NBITS =A0 =A0 =A0 =A0 =A0 =A014
>> -#define RC5_BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ir_rc5_=
remote_gap * 2)
>> -#define RC5_DURATION =A0 =A0 =A0 =A0 (ir_rc5_remote_gap * RC5_NBITS=
)
>> +#define RC5_UNIT =A0 =A0 =A0 =A0 =A0 =A0 888888 /* ns */
>>
>> =A0/* Used to register rc5_decoder clients */
>> =A0static LIST_HEAD(decoder_list);
>> @@ -33,13 +30,9 @@
>>
>> =A0enum rc5_state {
>> =A0 =A0 =A0 STATE_INACTIVE,
>> - =A0 =A0 STATE_MARKSPACE,
>> - =A0 =A0 STATE_TRAILER,
>> -};
>> -
>> -struct rc5_code {
>> - =A0 =A0 u8 =A0 =A0 =A0address;
>> - =A0 =A0 u8 =A0 =A0 =A0command;
>> + =A0 =A0 STATE_BIT_START,
>> + =A0 =A0 STATE_BIT_END,
>> + =A0 =A0 STATE_FINISHED,
>> =A0};
>>
>> =A0struct decoder_data {
>> @@ -49,8 +42,9 @@
>>
>> =A0 =A0 =A0 /* State machine control */
>> =A0 =A0 =A0 enum rc5_state =A0 =A0 =A0 =A0 =A0state;
>> - =A0 =A0 struct rc5_code =A0 =A0 =A0 =A0 rc5_code;
>> - =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0code, elapsed, las=
t_bit, last_code;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc5_bits;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_unit;
>> + =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count;
>> =A0};
>>
>>
>> @@ -122,18 +116,19 @@
>> =A0};
>>
>> =A0/**
>> - * handle_event() - Decode one RC-5 pulse or space
>> + * ir_rc5_decode() - Decode one RC-5 pulse or space
>> =A0 * @input_dev: =A0 =A0 =A0 the struct input_dev descriptor of the=
 device
>> - * @ev: =A0 =A0 =A0 =A0 =A0 =A0 =A0event array with type/duration o=
f pulse/space
>> + * @duration: =A0 =A0 =A0 =A0duration of pulse/space in ns
>> =A0 *
>> =A0 * This function returns -EINVAL if the pulse violates the state =
machine
>> =A0 */
>> -static int ir_rc5_decode(struct input_dev *input_dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ir_raw_event *ev)
>> +static int ir_rc5_decode(struct input_dev *input_dev, s64 duration)
>> =A0{
>> =A0 =A0 =A0 struct decoder_data *data;
>> =A0 =A0 =A0 struct ir_input_dev *ir_dev =3D input_get_drvdata(input_=
dev);
>> - =A0 =A0 int is_pulse, scancode, delta, toggle;
>> + =A0 =A0 u8 command, system, toggle;
>> + =A0 =A0 u32 scancode;
>> + =A0 =A0 int u;
>>
>> =A0 =A0 =A0 data =3D get_decoder_data(ir_dev);
>> =A0 =A0 =A0 if (!data)
>> @@ -142,79 +137,84 @@
>> =A0 =A0 =A0 if (!data->enabled)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> - =A0 =A0 delta =3D DIV_ROUND_CLOSEST(ev->delta.tv_nsec, ir_rc5_remo=
te_gap);
>> -
>> - =A0 =A0 /* The duration time refers to the last bit time */
>> - =A0 =A0 is_pulse =3D (ev->type & IR_PULSE) ? 1 : 0;
>> -
>> - =A0 =A0 /* Very long delays are considered as start events */
>> - =A0 =A0 if (delta > RC5_DURATION || (ev->type & IR_START_EVENT))
>> + =A0 =A0 if (IS_RESET(duration)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
>> -
>> - =A0 =A0 switch (data->state) {
>> - =A0 =A0 case STATE_INACTIVE:
>> - =A0 =A0 IR_dprintk(2, "currently inative. Start bit (%s) @%uus\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_pulse ? "pulse" : "space",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned)(ev->delta.tv_nsec + 500)=
 / 1000);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Discards the initial start space */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!is_pulse)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->code =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->last_bit =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->elapsed =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 memset(&data->rc5_code, 0, sizeof(data->rc=
5_code));
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_MARKSPACE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 case STATE_MARKSPACE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (delta !=3D 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->last_bit =3D data->l=
ast_bit ? 0 : 1;
>> + =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->elapsed +=3D delta;
>> + =A0 =A0 u =3D TO_UNITS(duration, RC5_UNIT);
>> + =A0 =A0 if (DURATION(u) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> +again:
>> + =A0 =A0 IR_dprintk(2, "RC5 decode started at state %i (%i units, %=
ius)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state, u, TO_US(duration));
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((data->elapsed % 2) =3D=3D 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 if (DURATION(u) =3D=3D 0 && data->state !=3D STATE_FINISHE=
D)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 switch (data->state) {
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->code <<=3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->code |=3D data->last_bit;
>> + =A0 =A0 case STATE_INACTIVE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_PULSE(u)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_BIT_=
START;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DECREASE_DURATION(u, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Fill the 2 unused bits at the command w=
ith 0 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (data->elapsed / 2 =3D=3D 6)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->code <<=3D 2;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (data->elapsed >=3D (RC5_NBITS - 1) * 2=
) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D data->code;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for the start bit=
s */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((scancode & 0xc000) !=3D=
 0xc000) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk=
(1, "Code 0x%04x doesn't have two start bits. It is not RC-5\n", scanco=
de);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 case STATE_BIT_START:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (DURATION(u) =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->rc5_bits <<=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_SPACE(u))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->rc5_=
bits |=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->last_unit =3D u;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the last bit is ze=
ro, a space will merge
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with the silence afte=
r the command.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_PULSE(u) && data->c=
ount =3D=3D RC5_NBITS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->stat=
e =3D STATE_FINISHED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 toggle =3D (scancode & 0x2=
000) ? 1 : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_BIT_=
END;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scancode =3D=3D data->=
last_code) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk=
(1, "RC-5 repeat\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_repeat(=
input_dev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->last=
_code =3D scancode;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancode &=
=3D 0x1fff;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk=
(1, "RC-5 scancode 0x%04x\n", scancode);
>> + =A0 =A0 case STATE_BIT_END:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_TRANSITION(u, data->last_unit)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->count =3D=3D RC5=
_NBITS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->stat=
e =3D STATE_FINISHED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->stat=
e =3D STATE_BIT_START;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir_keydown=
(input_dev, scancode, 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_TRAI=
LER;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DECREASE_DURATION(u, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 case STATE_TRAILER:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case STATE_FINISHED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 command =A0=3D (data->rc5_bits & 0x0003F) =
>> 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 system =A0 =3D (data->rc5_bits & 0x007C0) =
>> 6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 toggle =A0 =3D (data->rc5_bits & 0x00800) =
? 1 : 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 command +=3D (data->rc5_bits & 0x01000) ? =
0 : 0x40;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scancode =3D system << 8 | command;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 IR_dprintk(1, "RC5 scancode 0x%04x (toggle=
: %u)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scancode, toggle);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ir_keydown(input_dev, scancode, toggle);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 }
>>
>> -err:
>> - =A0 =A0 IR_dprintk(1, "RC-5 decoded failed at %s @ %luus\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_pulse ? "pulse" : "space",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ev->delta.tv_nsec + 500) / 1000);
>> +out:
>> + =A0 =A0 IR_dprintk(1, "RC5 decode failed at state %i (%i units, %i=
us)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->state, u, TO_US(duration));
>> =A0 =A0 =A0 data->state =3D STATE_INACTIVE;
>> =A0 =A0 =A0 return -EINVAL;
>> =A0}
>> Index: ir/drivers/media/video/saa7134/saa7134-input.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ir.orig/drivers/media/video/saa7134/saa7134-input.c =A0 =A0 =A0 =
2010-04-08 12:30:28.000000000 +0200
>> +++ ir/drivers/media/video/saa7134/saa7134-input.c =A0 =A02010-04-08=
 12:31:07.697096148 +0200
>> @@ -1018,7 +1018,7 @@
>> =A0 =A0 =A0 saa_clearb(SAA7134_GPIO_GPMODE3, SAA7134_GPIO_GPRESCAN);
>> =A0 =A0 =A0 saa_setb(SAA7134_GPIO_GPMODE3, SAA7134_GPIO_GPRESCAN);
>> =A0 =A0 =A0 space =3D saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2) & ir->m=
ask_keydown;
>> - =A0 =A0 ir_raw_event_store(dev->remote->dev, space ? IR_SPACE : IR=
_PULSE);
>> + =A0 =A0 ir_raw_event_store_edge(dev->remote->dev, space ? IR_SPACE=
 : IR_PULSE);
>>
>>
>> =A0 =A0 =A0 /*
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
