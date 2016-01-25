From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] [v8]Input: evdev: fix bug of dropping valid packet after
 syn_dropped event
Date: Mon, 25 Jan 2016 23:31:54 +0530
Message-ID: <CADYu308LG55DfxP2t1XUzG9QzWe3rdMoyLGoREA5DzT8socQdw@mail.gmail.com>
References: <1453397839-942-1-git-send-email-a.mathur@samsung.com>
	<20160121191725.GA39970@dtor-ws>
	<CADYu30_xbT5sA1J04-JRxcC_Ky9N_iNoqknQXX-CUooBdF1gbw@mail.gmail.com>
	<20160123183940.GA3410@dtor-ws>
	<CADYu3099RDSnHWy-fs1kw2Ga_LZhL_0veF3JSgw_-bLRw5u1NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35570 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbcAYSB4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2016 13:01:56 -0500
In-Reply-To: <CADYu3099RDSnHWy-fs1kw2Ga_LZhL_0veF3JSgw_-bLRw5u1NA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Jan 24, 2016 at 1:35 AM, Aniroop Mathur
<aniroop.mathur@gmail.com> wrote:
> On Sun, Jan 24, 2016 at 12:09 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Sat, Jan 23, 2016 at 11:29:29PM +0530, Aniroop Mathur wrote:
>>> Hi Mr. Torokhov,
>>>
>>> On Fri, Jan 22, 2016 at 12:47 AM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > Hi Anoroop,
>>> >
>>> > On Thu, Jan 21, 2016 at 11:07:19PM +0530, Aniroop Mathur wrote:
>>> >> If last event dropped in the old queue was EVi_SYN/SYN_REPORT, then lets
>>> >> generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
>>> >> so that clients would not ignore next valid full packet events.
>>> >>
>>> >> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>>> >> ---
>>> >>  drivers/input/evdev.c | 46 ++++++++++++++++++++++++++++++++++------------
>>> >>  1 file changed, 34 insertions(+), 12 deletions(-)
>>> >>
>>> >> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>>> >> index e9ae3d5..821b68a 100644
>>> >> --- a/drivers/input/evdev.c
>>> >> +++ b/drivers/input/evdev.c
>>> >> @@ -156,7 +156,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>> >>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>> >>  {
>>> >>       struct input_event ev;
>>> >> +     struct input_event *last_ev;
>>> >>       ktime_t time;
>>> >> +     unsigned int mask = client->bufsize - 1;
>>> >> +
>>> >> +     /* capture last event stored in the buffer */
>>> >> +     last_ev = &client->buffer[(client->head - 1) & mask];
>>> >
>>> > I have still the same comment. How do you know that event at last_ev
>>> > position is in fact valid and unconsumed yet event. Also, you need to
>>> > figure out not only if queue contains last SYN event, but also to handle
>>> > the case where the queue is empty and client has consumed either full or
>>> > partial packet at the time you are queueing the drop.
>>> >
>>>
>>> Could you please explain what you mean exactly so that I could answer it
>>> properly?
>>>
>>> From what I understood, it seems to me that there is no problem related to
>>> validity, unconsumption, empty queue, full/partial packet.
>>> I would like to explain for clock change request case so that you can know
>>> my understanding for your question.
>>>
>>> Clock change request case:
>>>
>>> 1.1 About last event being valid and unconsumed:
>>> We flush buffer and queue syn_dropped only when buffer is not empty. So there
>>> will be always be atleast one event in buffer that is not consumed and is
>>> ofcourse valid.
>>>
>>> 1.2 About queue is empty
>>> If not empty, we do not flush or add syn_dropped at all.
>>
>> Clock type change is not the only time we queue SYN_DROP, the other time
>> is when we fail to handle EVIOCG[type] (during which we remove some
>> events from the queue). Queue may be empty when these ioctls are issued.
>>
>
> yeah, ideally it should be changed to:
> ret = bits_to_user(mem, maxbit, maxlen, p, compat);
> if (ret < 0)
>     + if (client->head != client->tail)
>     - evdev_queue_syn_dropped(client);
>     +     evdev_queue_syn_dropped(client);
>
> Firstly, there is a need to follow protocol of SYN_REPORT as mentioned in
> next section.
>

and yes, there is need to make many more changes to have correct
last_event for this case. But it seems really complex.

> Unless syn_report does not denote end of a packet,
> it is okay without this change too because last event stored would be
> syn_report and after flushing, syn_report will still be at the end and
> with empty queue too if syn_dropped is queued then we have added syn_report
> to not ignore upcoming valid packet.
>
>>>
>>> 1.3 About consumption of full or partial packet
>>> If client has consumed full packet, then buffer will look like,
>>> ... X Y S(consumed) ... X Y S
>>> As we always store packets keeping buffer lock and not single events, so there
>>> will always be syn_report in the end.
>>
>> We try to pass full packets to clients, but there is no guarantee. We
>> only estimate number of events in device's packet, not guarantee that it
>> is correct size.
>>
>
> As per documentation, SYN_REPORT should be used to separate packets.
> * SYN_REPORT:
>   - Used to synchronize and separate events into packets of input data changes
>     occurring at the same moment in time. For example, motion of a mouse may set
>     the REL_X and REL_Y values for one motion, then emit a SYN_REPORT. The next
>     motion will emit more REL_X and REL_Y values and send another SYN_REPORT.
>
> So I think, there is a need of below change:
> file: input.c
> function: input_handle_event:
> } else if (dev->num_vals >= dev->max_vals - 2) {
> - dev->vals[dev->num_vals++] = input_value_sync;
> input_pass_values(dev, dev->vals, dev->num_vals);
>
> We have sufficient space in buffer to store more than 1 packet even when
> actual packet size is more than max_vals so there seems no need to add
> syn_report event here by self. So whenever driver sends syn_report, then only
> it will be considered as end of a packet and on exceding max_vals, we can
> simply pass to handlers to store those partial events in buffer. And anyways
> unless the packet is really completed then only client will send it to
> application.
>
> Without following this protocol, we would not be able to find the end of a
> packet because if max_vals comes out to 3 but actual packet size is 15, then
> in the buffer, there will be many syn_reports within a single packet. So with
> both current code and with patch code, there will be trouble in handling
> syn_dropped because after one syn_report comes, client will stop ignoring the
> events.
>

How about above change and do you want me send separate patch for it?

>>> If syn_dropped is queued here, then queing syn_report is fine.
>>> If client has consumed partial packet,  then buffer will look like,
>>> ... X(consumed) Y S ... S
>>> If syn_dropped is queued here, then it is fine to queue syn_report because
>>> now new X Y will be reported by driver, and so client will consume new X and Y
>>> and that old X will be replaced with new X and this new packet will be sent by
>>> client to application. Obviously, client never sends partial events to
>>> application and send data packet by packet.
>>> So I do not see any trouble here related to partial or full packet.
>>>
>>> > Also please enumerate what changes you done between version n and n+1 so
>>> > I do not have to compare them line by line trying to figure it out
>>> > myself.
>>> >
>>>
>>> Difference from v5:
>>> Made a mistake about head index in v5.
>>> Corrected in v8.
>>>
>>> evdev_set_clk_type:
>>> - client->packet_head = client->head = client->tail;
>>> + client->packet_head = client->tail = client->head;
>>
>> Why does this matter?
>>
>
> We must not change the head index. So we need to make packet_head and tail
> index same as head index and not same as tail index. After this setting,
> we call evdev_queue_syn_dropped where we capture last event as the event
> present at (head - 1) index;
>
> Thanks,
> Aniroop Mathur
>
>> Thanks.
>>
>> --
>> Dmitry
