From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get buffer size
Date: Mon, 11 Jan 2016 23:43:00 +0530
Message-ID: <CADYu30_eRD=h4S60EbT_Ou1uGWeEfs-8vkNoPQmiE_Yng6RSRw@mail.gmail.com>
References: <CADYu309gh6QOgGXsaxJO06Xif50mK73u6VaxjwRQYWyeeL5EMg@mail.gmail.com>
	<20160108203340.2b728a41@lxorguk.ukuu.org.uk>
	<CADYu309viVxQJVo-HR=17s-gGhXm03t4p_qL5i1=YUwKqh3pbA@mail.gmail.com>
	<CAKdAkRQ6SPt2oBJPv6h-gPVsEGZWRcBfp7J-TZpzWnO-nEOXKw@mail.gmail.com>
	<CADYu309cx-mb0skOTOkT67bjg83Vx6A-_rJ2QWRkbyLL9yHKxQ@mail.gmail.com>
	<20160108222720.GB39042@dtor-ws>
	<CADYu30-Nykka4gwWCUSDt1_pKUZkYDuGY5X_giFLOYxDSDr3wA@mail.gmail.com>
	<CADYu30-Y8oBtupLx+e6N5WJkc_ck5AdotZc69mDpeFMjU=A6zw@mail.gmail.com>
	<20160109185155.GB19004@dtor-ws>
	<CADYu30_nnL7snv2b5Nn8vYcYd90pD2cp9BaJseg9Y=DDAjTU_g@mail.gmail.com>
	<20160110224354.GA28145@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34475 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758982AbcAKSNB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2016 13:13:01 -0500
In-Reply-To: <20160110224354.GA28145@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, s.samuel@samsung.com, r.mahale@samsung.com

On Mon, Jan 11, 2016 at 4:13 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Sun, Jan 10, 2016 at 04:33:08AM +0530, Aniroop Mathur wrote:
>> On Sun, Jan 10, 2016 at 12:21 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Sat, Jan 09, 2016 at 09:51:59PM +0530, Aniroop Mathur wrote:
>> >> On Sat, Jan 9, 2016 at 4:13 AM, Aniroop Mathur <aniroop.mathur@gmail.com> wrote:
>> >> > On Sat, Jan 9, 2016 at 3:57 AM, Dmitry Torokhov
>> >> > <dmitry.torokhov@gmail.com> wrote:
>> >> >> On Sat, Jan 09, 2016 at 03:46:41AM +0530, Aniroop Mathur wrote:
>> >> >>> On Sat, Jan 9, 2016 at 2:32 AM, Dmitry Torokhov
>> >> >>> <dmitry.torokhov@gmail.com> wrote:
>> >> >>> > On Fri, Jan 8, 2016 at 12:51 PM, Aniroop Mathur
>> >> >>> > <aniroop.mathur@gmail.com> wrote:
>> >> >>> >> On Sat, Jan 9, 2016 at 2:03 AM, One Thousand Gnomes
>> >> >>> >> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >> >>> >>> On Sat, 9 Jan 2016 01:50:42 +0530
>> >> >>> >>> Aniroop Mathur <aniroop.mathur@gmail.com> wrote:
>> >> >>> >>>
>> >> >>> >>>> On Sat, Jan 9, 2016 at 1:43 AM, One Thousand Gnomes
>> >> >>> >>>> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >> >>> >>>> >> During system boot up, user space buf size is fixed, it cannot be
>> >> >>> >>>> >> resized later and we cannot choose by hit&trial.
>> >> >>> >>>> >> struct input_event* mBuffer = new input_event[mBuf];
>> >> >>> >>>> >
>> >> >>> >>>> > Who says that won't change ? Imagine a future case where plugging in a
>> >> >>> >>>> > device changes the buffer size ?
>> >> >>> >>>> >
>> >> >>> >>>>
>> >> >>> >>>> Ofcourse buffer size can be changed but it will also change the value of bufsize
>> >> >>> >>>> variable and accordingly user space client should also change its buf size.
>> >> >>> >>>
>> >> >>> >>> If its hot plugged why shouldn't that value change dynamically after
>> >> >>> >>> you've asked ?
>> >> >>> >>>
>> >> >>> >>
>> >> >>> >> Please put up your query clearly. what value ? what asked ?
>> >> >>> >
>> >> >>> > There is nothing that would stop us (kernel) to decide to resize the
>> >> >>> > buffer after you issued your new EVIOCGBUFSIZE. For example one can
>> >> >>> > decide to implement a feature that will double the size of evdev's
>> >> >>> > client buffer if there happened too many overruns i a given time
>> >> >>> > period.
>> >> >>> >
>> >> >>>
>> >> >>> If one decided to double the size of evdev buffer then it would be done
>> >> >>> by the same client facing buffer overrun and for this case client would
>> >> >>> not need to request for evdev buf size again as it has only set it. And
>> >> >>> still evdev buf size variable value be changed as well with the request
>> >> >>> to change buf size so client can read it again, if wishes.
>> >> >>
>> >> >> I was talking about changing the size of the buffer on kernel side.
>> >> >>
>> >> >>>
>> >> >>> > In any case the userpsace consumers already have to inspect input
>> >> >>> > device in question (number of axes and what they are; number of
>> >> >>> > keys/buttons, number of slots, etc) so that they can handle devices
>> >> >>> > properly and it should have enough information to intelligently size
>> >> >>> > of the receiving buffers. There is no need for a new kernel ioctl.
>> >> >>> >
>> >> >>>
>> >> >>> yes, consumers have to inspect input device but they cannot know
>> >> >>> the size of evdev buffer initially set as it is calculated in evdev.c file
>> >> >>> Consumer does not know that there is a limit of 8 packets.
>> >> >>> #define EVDEV_BUF_PACKETS       8
>> >> >>> unsigned int n_events =
>> >> >>>     max(dev->hint_events_per_packet * EVDEV_BUF_PACKETS, EVDEV_MIN_BUFFER_SIZE);
>> >> >>> return roundup_pow_of_two(n_events);
>> >> >>> This value varies for every device as every device has different value
>> >> >>> of hint_events_per_packet.
>> >> >>>
>> >> >>> Even after increasing kernel buffer size, buffer overrun can occur
>> >> >>> if reading is delayed and userspace buf is very small say only 1/2.
>> >> >>> In this case, buffer overrun will still occur and it will only be delayed.
>> >> >>> This was happening in my use case for gyroscope sensor device for
>> >> >>> which I initially forcefully increased the evdev buf size but problem was
>> >> >>> still not solved and buffer overrun was only delayed. The cause of the
>> >> >>> problem was that gyroscope client was using very small buf size for
>> >> >>> reading and after increasing the user space buf size, problem was solved.
>> >> >>> If client chooses maximum possible buffer size then it will be able to
>> >> >>> consume maximum events when reading is delayed and hence there will
>> >> >>> be least chance of buffer overrun. Evdev buf size should only be increased
>> >> >>> when buffer overrun occurs even with max user-space buf size.
>> >> >>> But the max user space buf size cannot be known until client request for it
>> >> >>> using this ioctl. So, I added it.
>> >> >>>
>> >> >>> So, are you convinced now that this ioctl is required ?
>> >> >>
>> >> >> No because I'd rather you managed size of your own buffer and increased
>> >> >> it as needed if you see drops. Let's say kernel decides to have buffer
>> >> >> of 100 events, do you have to mirror this size? What if device only
>> >> >> generates 1 event per minute?
>> >> >>
>> >> >
>> >> > We do not want any drop in the first place by keeping max buf size for
>> >> > reading for devices which need it only. On changing buf size on run time
>> >> > would not do any help because many events have already been dropped.
>> >> > And then after rebooting the system, user space buf size will again change
>> >> > to old value and so again events will be dropped and again buf size need to
>> >> > be changed.
>> >> > Yes, there is a need to mirror it, especially for device which support batching.
>> >> > If device generates only 1 event per minute, then client can choose minimum
>> >> > user space buf size, say 1. It is not compulsory to choose max buf size always
>> >> > for every device.
>> >> >
>> >>
>> >> Any update on above in order to conclude this change ?
>> >
>> > I am still unconvinced that it is needed.
>> >
>> >>
>> >> As consumer need to manage the user-space buf size as per requirement,
>> >> it needs to know the max limit upto which it can be increased so that consumer
>> >> should not request to read for more data than the max limit.
>> >
>> > What is exactly the requirement? Minimizing amount of reads? Why? If
>> > device is basically "streaming" events to userspace and you believe that
>> > it is essential for you want to consume entire client buffer at once
>> > that means that you are basically losing the race and with the slightest
>> > hickup you'll experience drop. If you are keeping up with the
>> > device/kernel you reads should be typically smaller than what kernel
>> > buffer can potentially hold.
>> >
>>
>> There is only one requirement:
>> How would the clients come to know the maximum number of events they
>> can read at once ?
>>
>> Usually, reading as small as 1 packet is enough, keeping reading+writing
>> remains in sync and no problem/drops occur, However, sometimes, it is
>> possible that reading and writing are not in sync like in case of batching
>> where multiple data is written to chip without any delay or in case of
>> high cpu load. So sometimes for a short time, writing can be fast but
>> reading can be slow. To balance out gap between reading and writing in
>> order to make them in sync again for that short time, we need to read
>> multiple packets at once and in worst case maximum possible packets.
>> For example:
>> If gyro chip is generating data at 5ms interval and reading is delayed
>> by extra 5 ms for 80 ms with reading size of 1 packet & kernel but size of
>> 8 packets, then drop will occur after 80 ms as client would only be able to
>> read 8 packets but 16 packets are reported. Surely, reading can again be
>> in sync after 80 ms but for that 80 ms when not in sync, client will loose data
>> which could have been saved just by using reading size of 2 packets in this
>> case. Similarly, reading can be delayed by 10/20/30 ms for a short time and
>> reading size of 4/6/max_packet can solve the problem.
>

Is the requirement clear by above example? (Here, packet means events+syn)

As above example shows that sometimes, we need to read full kernel buffer
and for that we need to know the kernel buffer size.
For example:
if kernel space buf size is 100 bytes,
then user space buf size for "reading" should be between 1 to 100 bytes,
otherwise, user-space buf may choose 200 bytes for "reading", which is
"ideally" wrong.

> Speaking for the xorg drivers and libevdev, we always try to read as many
> packets as are available or fit into our event queue. The kernel buffer is
> just that - a buffer. If you need all events unconditionally, you better
> pull them out of the buffer into your own queue asap, then you have control
> over it.
>

But as you know and as I mentioned above, writing can be fast and reading can
be delayed sometimes for some short period of time, so we would not be able to
pull them out asap.

> I can't think of a use-case where reading one event/packet is a good idea.
> Which brings me to the next point: you talk about "packet", so I'm not sure
> if you talk about one struct input_event, or one frame (i.e. events +
> SYN_REPORT). The kernel flushes on SYN_REPORT, so you'll always have more
> than one event waiting anyway, better to read in more in one go.
> In the latter: you can't know how many events are in the frame, the kernel
> may suppress some values or you get other values that aren't usually in the
> same frame (e.g. button presses on top of finger data).
> And if you *do* know the exact number of events per frame, your software is
> probably specific enough for the device that you can hardcode or closely
> estimate the buffer size rather than requiring an ioctl.
>

I meant, packet as events+syn_report.
Hardcoding and doing estimation is generally considered a bad idea everywhere.
There are so many types of input devices and every device has different
capabilities and different kernel buf size. There are so many different systems
and each system can have many input devices so hardcoding or estimating
maximum possible buf size seems not a good idea. Instead just using
ioctl call to
get the max buf size value seems much easier.

> so again, you should be reading multiple events per run. for example,
> libevdev reads up to 64 events at a time.
>

I absolutely agree. :)
However, how have you decided exact 64 events here?
Its most likely because evdev.c define minimum buf size as 64 and that is the
final buf size set by evdev handler using compute_buf_size api.
All my asking here is to get this value using this new ioctl call which will
give correct buf size value easily and we do not have to hardcode or estimate
for every input device in the world.

>> > I'll add Peter as he was complaining about dropouts too at some point.
>
> The problem we still have is that it's hard to synchronise correctly after
> a SYN_DROPPED. Key events get discarded from the queue and iirc EV_ABS too,
> but if you have a multitouch device, the slot states aren't necessarily
> correct. David had a patch for that at some point, but I don't think it made
> ever made it to the final submission.
> Having said that, clearly not highest priority :)
>
>> >> Also, evdev read should be changed to
>> >> - if (count != 0 && count < input_event_size())
>> >> + if ((count != 0 && count < input_event_size()) || (count > client->bufsize))
>> >>              return -EINVAL;
>> >
>> > Why on earth??? No, we do not need this.
>> >
>>
>> okay.
>> My concern was to notify the client that it is requesting for number
>> of events which
>> will never ever be possible to deliver at once so it should request
>> for proper number
>> of events for reading and free the unnecessary memory allocated at user-space.
>> It might not be a good idea to return -EINVAL here but at least print
>> a warning log
>> about it so that clients can take action upon it.
>
> What are you optimising for? sizeof(struct input_event) is 24 bytes, I
> reckon a larger-than-needed event queue is the least of your memory worries.
>

I meant,
count > client->bufsize * input_event_size();
I am not worried about more memory as there is plenty in userspace. I am worried
about "unnecessary" allocated memory at user space for reading events as it
is "ideally" wrong and not a standard.
For example:
If kernel buf size is: 64*24  = 1536 bytes
And if user space buf is: 100*24 = 2400 bytes.
So 2400 - 1536 i.e. 864 bytes are wasted because they will never be filled
with any event by kernel. So 864 bytes will always be empty in user-space buf.
So I wanted to notify userspace that maximum valid size for reading events
could not be more than 1536 bytes for the above case.
Using this extra space for some other purpose except reading is a different
question or concern.

Thanks.

BR,
Aniroop Mathur

> Cheers,
>    Peter
