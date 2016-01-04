From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Re: [PATCH] Input: evdev - drop partial events after emptying the buffer
Date: Mon, 4 Jan 2016 09:52:22 +0100
Message-ID: <CAN+gG=FXTg2OJm+SitJRHhzhB2P-4Z1fjqRDmeSom2gjbQD3UA@mail.gmail.com>
References: <1641442630.571691451893817108.JavaMail.weblogic@ep2mlwas04c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38165 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbcADIwY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 03:52:24 -0500
In-Reply-To: <1641442630.571691451893817108.JavaMail.weblogic@ep2mlwas04c>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "aniroop.mathur@gmail.com" <aniroop.mathur@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

On Mon, Jan 4, 2016 at 8:50 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> On Jan 4, 2016 5:08 AM, "Peter Hutterer" <peter.hutterer@who-t.net> wrote:
>>
>> On Sat, Jan 02, 2016 at 08:39:21PM -0800, Dmitry Torokhov wrote:
>> > On Thu, Dec 31, 2015 at 03:36:47AM +0530, Aniroop Mathur wrote:
>> > > This patch introduces concept to drop partial events in evdev handler
>> > > itself after emptying the buffer which are dropped by all evdev
>> > > clients in userspace after SYN_DROPPED occurs.
>> > > This in turn saves space of partial events in evdev handler buffer
>> > > and reduces evdev client reading requests.
>> >
>> > Let's add a few people who write consumer code to see if this is
>> > something that they consider useful.
>>
>> yeah, it's useful though we already have the code in libevdev to work around
>> this. Still, it reduces the number of events discarde by the client, so it'll be a net
>> plus. but, afaict, there's a bug in this implementation.
>> The doc states: "Client should ignore all events up to and including next
>> SYN_REPORT event". If you drop partial events, you need to have an empty
>> SYN_REPORT after the SYN_DROPPED before you start with full events again.
>> This patch skips that, so after the SYN_DROPPED you have a valid full event
>> that will be ignored by any client currently capable of handling
>> SYN_DROPPED.
>> Example: let's assume a device sending ABS_X/ABS_Y fast enough to cause a
>> SYN_DROPPED, you may have this queue:
>>     ABS_X
>>     ABS_Y
>>     SYN_REPORT
>>     ...
>>     SYN_DROPPED
>>     ABS_Y      <---- partial event
>>     SYN_REPORT <---- client discards up to here, sync state
>>     ABS_X
>>     ABS_Y
>>     SYN_REPORT <---- first full event after sync
>>
>> With this patch this sequence becomes:
>>     ABS_X
>>     ABS_Y
>>     SYN_REPORT
>>     ...
>>     SYN_DROPPED
>>         [kernel discards ABS_Y + SYN_REPORT as partial event]
>>     ABS_X
>>     ABS_Y
>>     SYN_REPORT <--- client discards up to here, sync state
>>                <--- there is no event after sync
>>
>> That's a change in kernel behaviour and will make all current clients
>> potentially buggy, you'll really need the empty SYN_REPORT here.
>>
>
> Thank you for your input, Mr. Peter.
> Actually, there is a need to update the documentation as well after this patch
> so that clients no more ignore the events after SYN_DROPPED occurs and
> should read the events normally. I skipped updating the documentation in
> this patch as I thought of getting a consent first.
> * SYN_DROPPED:
>   - Used to indicate buffer overrun in the evdev client's event queue.
>     Client should ignore all events up to and including next SYN_REPORT
>     event and query the device (using EVIOCG* ioctls) to obtain its
>     current state
>     + From kernel version <4.4.x> onwards, clients do no need to ignore
>     + events anymore and should read normally as there will be no
>     + partial events after SYN_DROPPED occurs.

Hi Aniroop,

this just won't do. As Peter said, there are current implementation of
SYN_DROPPED around, which ignore the events until the next SYN_REPORT.
If you change the protocol by updating the doc, you will just break
existing userspace which has not included a check on the kernel
version (and honestly, checking the kernel version from the userspace
point of view is just a nightmare when distributions start backporting
changes here and there).

The kernel rule is "do not break userspace", so we can not accept this.
Peter suggested you just add an empty SYN_REPORT after SYN_DROPPED
which would solve the whole problem: clients already handling
SYN_DROPPED will receive the next valid event, and those who don't (or
which will be updated) will not have to do anything more.

The only cons I can think of is that multitouch protocol A will be a
pain to handle with this empty SYN_REPORT if you do not handle the
SYN_DROPPED as per the doc.
But on the other hand, if you have a MT protocol A device, you are
screwed anyway because you need mtdev and so let's use libevdev at
this point.

>
> As far as I've worked on client codes, this client code change is easy and

Nope, checking the kernel version is not "easy" as this is not reliable.

> even if some clients miss to update the code then it seems not much of
> a problem because 8 packets are already dropped so an additional packet
> would not cause any trouble in case of buffer overrun.

Nope again. In case of a SYN_DROPPED, the client syncs its internal
state by using ioctls. So if you drop one valid event, you are not in
sync again and the SYN_DROPPED is moot.

Cheers,
Benjamin

>
> Regards,
> Aniroop Mathur
>
>> > >
>> > > Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>> > > ---
>> > >  drivers/input/evdev.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
>> > >  1 file changed, 45 insertions(+), 4 deletions(-)
>> > >
>> > > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> > > index e9ae3d5..e7b612e 100644
>> > > --- a/drivers/input/evdev.c
>> > > +++ b/drivers/input/evdev.c
>> > > @@ -58,6 +58,7 @@ struct evdev_client {
>> > >     struct list_head node;
>> > >     unsigned int clk_type;
>> > >     bool revoked;
>> > > +   bool drop_pevent; /* specifies whether partial events need to be dropped */
>> > >     unsigned long *evmasks[EV_CNT]; > >     unsigned int bufsize;
>> > >     struct input_event buffer[];
>> > > @@ -192,6 +193,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>> > >  {
>> > >     unsigned long flags;
>> > >     unsigned int clk_type;
>> > > +   struct input_event *ev;
>> > >
>> > >     switch (clkid) {
>> > >
>> > > @@ -218,6 +220,17 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>> > >             spin_lock_irqsave(&client->buffer_lock, flags);
>> > >
>> > >             if (client->head != client->tail) {
>> > > +
>> > > +                   /*
>> > > +                    * Set drop_pevent to true if last event packet is
>> > > +                    * not stored completely in buffer.
>> > > +                    */
>> > > +                   client->head--;
>> > > +                   client->head &= client->bufsize - 1;
>> > > +                   ev = &client->buffer[client->head];
>> > > +                   if (!(ev->type == EV_SYN && ev->code == SYN_REPORT))
>> > > +                           client->drop_pevent = true;
>> > > +
>> > >                     client->packet_head = client->head = client->tail;
>> > >                     __evdev_queue_syn_dropped(client);
>> > >             }
>> > > @@ -228,31 +241,51 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>> > >     return 0;
>> > >  }
>> > >
>> > > -static void __pass_event(struct evdev_client *client,
>> > > +static bool __pass_event(struct evdev_client *client,
>> > >                      const struct input_event *event)
>> > >  {
>> > > +   struct input_event *prev_ev;
>> > > +
>> > >     client->buffer[client->head++] = *event;
>> > >     client->head &= client->bufsize - 1;
>> > >
>> > >     if (unlikely(client->head == client->tail)) {
>> > >             /*
>> > > -            * This effectively "drops" all unconsumed events, leaving
>> > > -            * EV_SYN/SYN_DROPPED plus the newest event in the queue.
>> > > +            * This effectively "drops" all unconsumed events, storing
>> > > +            * EV_SYN/SYN_DROPPED and the newest event in the queue but
>> > > +            * only if it is not part of partial packet.
>> > > +            * Set drop_pevent to true if last event packet is not stored
>> > > +            * completely in buffer and set to false if SYN_REPORT occurs.
>> > >              */
>> > > +
>> > >             client->tail = (client->head - 2) & (client->bufsize - 1);
>> > >
>> > > +           prev_ev = &client->buffer[client->tail];
>> > > +           if (!(prev_ev->type == EV_SYN && prev_ev->code == SYN_REPORT)) {
>>
>> IMO a (prev_ev->type != EV_SYN || prev_ev->code != SYN_REPORT) would be
>> easier to read than this (!(a && b)).
>>
>> Cheers,
>>    Peter
>>
>> > > +                   client->drop_pevent = true;
>> > > +                   client->head--;
>> > > +                   client->head &= client->bufsize - 1;
>> > > +           }
>> > > +
>> > >             client->buffer[client->tail].time = event->time;
>> > >             client->buffer[client->tail].type = EV_SYN;
>> > >             client->buffer[client->tail].code = SYN_DROPPED;
>> > >             client->buffer[client->tail].value = 0;
>> > >
>> > >             client->packet_head = client->tail;
>> > > +
>> > > +           if (event->type == EV_SYN && event->code == SYN_REPORT) {
>> > > +                   client->drop_pevent = false;
>> > > +                   return true;
>> > > +           }
>> > >     }
>> > >
>> > >     if (event->type == EV_SYN && event->code == SYN_REPORT) {
>> > >             client->packet_head = client->head;
>> > >             kill_fasync(&client->fasync, SIGIO, POLL_IN);
>> > >     }
>> > > +
>> > > +   return false;
>> > >  }
>> > >
>> > >  static void evdev_pass_values(struct evdev_client *client,
>> > > @@ -284,10 +317,18 @@ static void evdev_pass_values(struct evdev_client *client,
>> > >                     wakeup = true;
>> > >             }
>> > >
>> > > +           /* drop partial events until SYN_REPORT occurs */
>> > > +           if (client->drop_pevent) {
>> > > +                   if (v->type == EV_SYN && v->code == SYN_REPORT)
>> > > +                           client->drop_pevent = false;
>> > > +                   continue;
>> > > +           }
>> > > +
>> > >             event.type = v->type;
>> > >             event.code = v->code;
>> > >             event.value = v->value;
>> > > -           __pass_event(client, &event);
>> > > +           if (__pass_event(client, &event))
>> > > +                   wakeup = false;
>> > >     }
>> > >
>> > >     spin_unlock(&client->buffer_lock);
>> > > --
>> > > 2.6.2
>> > >
>> >
>> > --
>> > Dmitry
>
