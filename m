From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [v8]Input: evdev: fix bug of dropping valid packet after
 syn_dropped event
Date: Sat, 23 Jan 2016 10:39:40 -0800
Message-ID: <20160123183940.GA3410@dtor-ws>
References: <1453397839-942-1-git-send-email-a.mathur@samsung.com>
 <20160121191725.GA39970@dtor-ws>
 <CADYu30_xbT5sA1J04-JRxcC_Ky9N_iNoqknQXX-CUooBdF1gbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33410 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbcAWSjo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jan 2016 13:39:44 -0500
Content-Disposition: inline
In-Reply-To: <CADYu30_xbT5sA1J04-JRxcC_Ky9N_iNoqknQXX-CUooBdF1gbw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jan 23, 2016 at 11:29:29PM +0530, Aniroop Mathur wrote:
> Hi Mr. Torokhov,
> 
> On Fri, Jan 22, 2016 at 12:47 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Anoroop,
> >
> > On Thu, Jan 21, 2016 at 11:07:19PM +0530, Aniroop Mathur wrote:
> >> If last event dropped in the old queue was EVi_SYN/SYN_REPORT, then lets
> >> generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
> >> so that clients would not ignore next valid full packet events.
> >>
> >> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> >> ---
> >>  drivers/input/evdev.c | 46 ++++++++++++++++++++++++++++++++++------------
> >>  1 file changed, 34 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> >> index e9ae3d5..821b68a 100644
> >> --- a/drivers/input/evdev.c
> >> +++ b/drivers/input/evdev.c
> >> @@ -156,7 +156,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
> >>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
> >>  {
> >>       struct input_event ev;
> >> +     struct input_event *last_ev;
> >>       ktime_t time;
> >> +     unsigned int mask = client->bufsize - 1;
> >> +
> >> +     /* capture last event stored in the buffer */
> >> +     last_ev = &client->buffer[(client->head - 1) & mask];
> >
> > I have still the same comment. How do you know that event at last_ev
> > position is in fact valid and unconsumed yet event. Also, you need to
> > figure out not only if queue contains last SYN event, but also to handle
> > the case where the queue is empty and client has consumed either full or
> > partial packet at the time you are queueing the drop.
> >
> 
> Could you please explain what you mean exactly so that I could answer it
> properly?
> 
> From what I understood, it seems to me that there is no problem related to
> validity, unconsumption, empty queue, full/partial packet.
> I would like to explain for clock change request case so that you can know
> my understanding for your question.
> 
> Clock change request case:
> 
> 1.1 About last event being valid and unconsumed:
> We flush buffer and queue syn_dropped only when buffer is not empty. So there
> will be always be atleast one event in buffer that is not consumed and is
> ofcourse valid.
> 
> 1.2 About queue is empty
> If not empty, we do not flush or add syn_dropped at all.

Clock type change is not the only time we queue SYN_DROP, the other time
is when we fail to handle EVIOCG[type] (during which we remove some
events from the queue). Queue may be empty when these ioctls are issued.

> 
> 1.3 About consumption of full or partial packet
> If client has consumed full packet, then buffer will look like,
> ... X Y S(consumed) ... X Y S
> As we always store packets keeping buffer lock and not single events, so there
> will always be syn_report in the end.

We try to pass full packets to clients, but there is no guarantee. We
only estimate number of events in device's packet, not guarantee that it
is correct size.

> If syn_dropped is queued here, then queing syn_report is fine.
> If client has consumed partial packet,  then buffer will look like,
> ... X(consumed) Y S ... S
> If syn_dropped is queued here, then it is fine to queue syn_report because
> now new X Y will be reported by driver, and so client will consume new X and Y
> and that old X will be replaced with new X and this new packet will be sent by
> client to application. Obviously, client never sends partial events to
> application and send data packet by packet.
> So I do not see any trouble here related to partial or full packet.
> 
> > Also please enumerate what changes you done between version n and n+1 so
> > I do not have to compare them line by line trying to figure it out
> > myself.
> >
> 
> Difference from v5:
> Made a mistake about head index in v5.
> Corrected in v8.
> 
> evdev_set_clk_type:
> - client->packet_head = client->head = client->tail;
> + client->packet_head = client->tail = client->head;

Why does this matter?

Thanks.

-- 
Dmitry
