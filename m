From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get buffer
 size
Date: Mon, 11 Jan 2016 15:46:02 -0800
Message-ID: <20160111234602.GD39766@dtor-ws>
References: <CADYu309viVxQJVo-HR=17s-gGhXm03t4p_qL5i1=YUwKqh3pbA@mail.gmail.com>
 <CAKdAkRQ6SPt2oBJPv6h-gPVsEGZWRcBfp7J-TZpzWnO-nEOXKw@mail.gmail.com>
 <CADYu309cx-mb0skOTOkT67bjg83Vx6A-_rJ2QWRkbyLL9yHKxQ@mail.gmail.com>
 <20160108222720.GB39042@dtor-ws>
 <CADYu30-Nykka4gwWCUSDt1_pKUZkYDuGY5X_giFLOYxDSDr3wA@mail.gmail.com>
 <CADYu30-Y8oBtupLx+e6N5WJkc_ck5AdotZc69mDpeFMjU=A6zw@mail.gmail.com>
 <20160109185155.GB19004@dtor-ws>
 <CADYu30_nnL7snv2b5Nn8vYcYd90pD2cp9BaJseg9Y=DDAjTU_g@mail.gmail.com>
 <20160110224354.GA28145@jelly.redhat.com>
 <CADYu30_eRD=h4S60EbT_Ou1uGWeEfs-8vkNoPQmiE_Yng6RSRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33488 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761936AbcAKXqJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2016 18:46:09 -0500
Content-Disposition: inline
In-Reply-To: <CADYu30_eRD=h4S60EbT_Ou1uGWeEfs-8vkNoPQmiE_Yng6RSRw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, s.samuel@samsung.com, r.mahale@samsung.com

On Mon, Jan 11, 2016 at 11:43:00PM +0530, Aniroop Mathur wrote:
> On Mon, Jan 11, 2016 at 4:13 AM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > On Sun, Jan 10, 2016 at 04:33:08AM +0530, Aniroop Mathur wrote:
> >> On Sun, Jan 10, 2016 at 12:21 AM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Sat, Jan 09, 2016 at 09:51:59PM +0530, Aniroop Mathur wrote:
> >> >> On Sat, Jan 9, 2016 at 4:13 AM, Aniroop Mathur <aniroop.mathur@gmail.com> wrote:
> >> >> > On Sat, Jan 9, 2016 at 3:57 AM, Dmitry Torokhov
> >> >> > <dmitry.torokhov@gmail.com> wrote:
> >> >> >> On Sat, Jan 09, 2016 at 03:46:41AM +0530, Aniroop Mathur wrote:
> >> >> >>> On Sat, Jan 9, 2016 at 2:32 AM, Dmitry Torokhov
> >> >> >>> <dmitry.torokhov@gmail.com> wrote:
> >> >> >>> > On Fri, Jan 8, 2016 at 12:51 PM, Aniroop Mathur
> >> >> >>> > <aniroop.mathur@gmail.com> wrote:
> >> >> >>> >> On Sat, Jan 9, 2016 at 2:03 AM, One Thousand Gnomes
> >> >> >>> >> <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> >> >>> >>> On Sat, 9 Jan 2016 01:50:42 +0530
> >> >> >>> >>> Aniroop Mathur <aniroop.mathur@gmail.com> wrote:
> >> >> >>> >>>
> >> >> >>> >>>> On Sat, Jan 9, 2016 at 1:43 AM, One Thousand Gnomes
> >> >> >>> >>>> <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> >> >>> >>>> >> During system boot up, user space buf size is fixed, it cannot be
> >> >> >>> >>>> >> resized later and we cannot choose by hit&trial.
> >> >> >>> >>>> >> struct input_event* mBuffer = new input_event[mBuf];
> >> >> >>> >>>> >
> >> >> >>> >>>> > Who says that won't change ? Imagine a future case where plugging in a
> >> >> >>> >>>> > device changes the buffer size ?
> >> >> >>> >>>> >
> >> >> >>> >>>>
> >> >> >>> >>>> Ofcourse buffer size can be changed but it will also change the value of bufsize
> >> >> >>> >>>> variable and accordingly user space client should also change its buf size.
> >> >> >>> >>>
> >> >> >>> >>> If its hot plugged why shouldn't that value change dynamically after
> >> >> >>> >>> you've asked ?
> >> >> >>> >>>
> >> >> >>> >>
> >> >> >>> >> Please put up your query clearly. what value ? what asked ?
> >> >> >>> >
> >> >> >>> > There is nothing that would stop us (kernel) to decide to resize the
> >> >> >>> > buffer after you issued your new EVIOCGBUFSIZE. For example one can
> >> >> >>> > decide to implement a feature that will double the size of evdev's
> >> >> >>> > client buffer if there happened too many overruns i a given time
> >> >> >>> > period.
> >> >> >>> >
> >> >> >>>
> >> >> >>> If one decided to double the size of evdev buffer then it would be done
> >> >> >>> by the same client facing buffer overrun and for this case client would
> >> >> >>> not need to request for evdev buf size again as it has only set it. And
> >> >> >>> still evdev buf size variable value be changed as well with the request
> >> >> >>> to change buf size so client can read it again, if wishes.
> >> >> >>
> >> >> >> I was talking about changing the size of the buffer on kernel side.
> >> >> >>
> >> >> >>>
> >> >> >>> > In any case the userpsace consumers already have to inspect input
> >> >> >>> > device in question (number of axes and what they are; number of
> >> >> >>> > keys/buttons, number of slots, etc) so that they can handle devices
> >> >> >>> > properly and it should have enough information to intelligently size
> >> >> >>> > of the receiving buffers. There is no need for a new kernel ioctl.
> >> >> >>> >
> >> >> >>>
> >> >> >>> yes, consumers have to inspect input device but they cannot know
> >> >> >>> the size of evdev buffer initially set as it is calculated in evdev.c file
> >> >> >>> Consumer does not know that there is a limit of 8 packets.
> >> >> >>> #define EVDEV_BUF_PACKETS       8
> >> >> >>> unsigned int n_events =
> >> >> >>>     max(dev->hint_events_per_packet * EVDEV_BUF_PACKETS, EVDEV_MIN_BUFFER_SIZE);
> >> >> >>> return roundup_pow_of_two(n_events);
> >> >> >>> This value varies for every device as every device has different value
> >> >> >>> of hint_events_per_packet.
> >> >> >>>
> >> >> >>> Even after increasing kernel buffer size, buffer overrun can occur
> >> >> >>> if reading is delayed and userspace buf is very small say only 1/2.
> >> >> >>> In this case, buffer overrun will still occur and it will only be delayed.
> >> >> >>> This was happening in my use case for gyroscope sensor device for
> >> >> >>> which I initially forcefully increased the evdev buf size but problem was
> >> >> >>> still not solved and buffer overrun was only delayed. The cause of the
> >> >> >>> problem was that gyroscope client was using very small buf size for
> >> >> >>> reading and after increasing the user space buf size, problem was solved.
> >> >> >>> If client chooses maximum possible buffer size then it will be able to
> >> >> >>> consume maximum events when reading is delayed and hence there will
> >> >> >>> be least chance of buffer overrun. Evdev buf size should only be increased
> >> >> >>> when buffer overrun occurs even with max user-space buf size.
> >> >> >>> But the max user space buf size cannot be known until client request for it
> >> >> >>> using this ioctl. So, I added it.
> >> >> >>>
> >> >> >>> So, are you convinced now that this ioctl is required ?
> >> >> >>
> >> >> >> No because I'd rather you managed size of your own buffer and increased
> >> >> >> it as needed if you see drops. Let's say kernel decides to have buffer
> >> >> >> of 100 events, do you have to mirror this size? What if device only
> >> >> >> generates 1 event per minute?
> >> >> >>
> >> >> >
> >> >> > We do not want any drop in the first place by keeping max buf size for
> >> >> > reading for devices which need it only. On changing buf size on run time
> >> >> > would not do any help because many events have already been dropped.
> >> >> > And then after rebooting the system, user space buf size will again change
> >> >> > to old value and so again events will be dropped and again buf size need to
> >> >> > be changed.
> >> >> > Yes, there is a need to mirror it, especially for device which support batching.
> >> >> > If device generates only 1 event per minute, then client can choose minimum
> >> >> > user space buf size, say 1. It is not compulsory to choose max buf size always
> >> >> > for every device.
> >> >> >
> >> >>
> >> >> Any update on above in order to conclude this change ?
> >> >
> >> > I am still unconvinced that it is needed.
> >> >
> >> >>
> >> >> As consumer need to manage the user-space buf size as per requirement,
> >> >> it needs to know the max limit upto which it can be increased so that consumer
> >> >> should not request to read for more data than the max limit.
> >> >
> >> > What is exactly the requirement? Minimizing amount of reads? Why? If
> >> > device is basically "streaming" events to userspace and you believe that
> >> > it is essential for you want to consume entire client buffer at once
> >> > that means that you are basically losing the race and with the slightest
> >> > hickup you'll experience drop. If you are keeping up with the
> >> > device/kernel you reads should be typically smaller than what kernel
> >> > buffer can potentially hold.
> >> >
> >>
> >> There is only one requirement:
> >> How would the clients come to know the maximum number of events they
> >> can read at once ?
> >>
> >> Usually, reading as small as 1 packet is enough, keeping reading+writing
> >> remains in sync and no problem/drops occur, However, sometimes, it is
> >> possible that reading and writing are not in sync like in case of batching
> >> where multiple data is written to chip without any delay or in case of
> >> high cpu load. So sometimes for a short time, writing can be fast but
> >> reading can be slow. To balance out gap between reading and writing in
> >> order to make them in sync again for that short time, we need to read
> >> multiple packets at once and in worst case maximum possible packets.
> >> For example:
> >> If gyro chip is generating data at 5ms interval and reading is delayed
> >> by extra 5 ms for 80 ms with reading size of 1 packet & kernel but size of
> >> 8 packets, then drop will occur after 80 ms as client would only be able to
> >> read 8 packets but 16 packets are reported. Surely, reading can again be
> >> in sync after 80 ms but for that 80 ms when not in sync, client will loose data
> >> which could have been saved just by using reading size of 2 packets in this
> >> case. Similarly, reading can be delayed by 10/20/30 ms for a short time and
> >> reading size of 4/6/max_packet can solve the problem.
> >
> 
> Is the requirement clear by above example? (Here, packet means events+syn)
> 
> As above example shows that sometimes, we need to read full kernel buffer
> and for that we need to know the kernel buffer size.
> For example:
> if kernel space buf size is 100 bytes,
> then user space buf size for "reading" should be between 1 to 100 bytes,
> otherwise, user-space buf may choose 200 bytes for "reading", which is
> "ideally" wrong.

Aniroop,

It seems to me that you are optimizing for the wrong condition. You want
to know kernel's buffer size so that you can consume whole buffer in one
read(), but what you are missing is that if you let kernel to [almost]
fill entire event queue on the kernel side you are already losing. A
tiniest additional hiccup and you will see the drop.

You need to optimize your application/framework so that it keeps up with
the device, because if you do not, then no matter how big the buffers
are on either side you eventually full them up and will see the drop. So
the "normal" case for you should be where kernel queue is almost empty.
And if there is scheduling hiccup then you do have space in the buffer
as a safety net to carry you over, but consuming it in one go should not
be a priority. It should be perfectly fine to select your buffer size
(let's say 64 events, like libinput does) and consume input in smaller
chunks. I am sure you will not see any practical performance difference
between consuming up to 64 events and consuming your "ideal" buffer at
once.

Please consider the patch rejected.

Thanks.

-- 
Dmitry
