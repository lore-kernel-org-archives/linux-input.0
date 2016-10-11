From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hidraw: fix list->buffer race condition
Date: Mon, 10 Oct 2016 20:12:37 -0700
Message-ID: <CAKdAkRQsuGBux5VvPsKjt8yfk1xWELA7xq2ZYFWirRRXGDbhsg@mail.gmail.com>
References: <1475628266-4767-1-git-send-email-gary.king@oculus.com>
 <alpine.LNX.2.00.1610071038340.31629@cbobk.fhfr.pm> <alpine.OSX.1.10.1610071027351.23556@cromulentg-mba.local>
 <alpine.LNX.2.00.1610101019040.31629@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34230 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbcJKDNa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Oct 2016 23:13:30 -0400
Received: by mail-oi0-f65.google.com with SMTP id p136so400431oic.1
        for <linux-input@vger.kernel.org>; Mon, 10 Oct 2016 20:12:38 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1610101019040.31629@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Gary King <gary.king@oculus.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Oct 10, 2016 at 1:36 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 7 Oct 2016, Gary King wrote:
>
>> > > diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
>> > > index f0e2757..dc3465f 100644
>> > > --- a/drivers/hid/hidraw.c
>> > > +++ b/drivers/hid/hidraw.c
>> > > @@ -53,6 +53,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
>> > >   mutex_lock(&list->read_mutex);
>> > >
>> > >   while (ret == 0) {
>> > > +         smp_rmb();
>> >
>> > Which _wmb() does this one pair with?
>>
>> The _rmb() operations don't really pair with the _wmb()
>
> That unfortunately immediately implies that its usage is incorrect though.
>
> [ ... snip ... ]
>> > I think this is just papering the real problem (missing list_lock) over in
>> > an odd way; could you please look into whether locking list_lock properly
>> > would resolve the crashes you're able to trigger on your ARM system?
>>
>> list_lock does not appear to be a good solution for this, since it is
>> currently an IRQ-safe spinlock on the device. Using it would cause
>> _read() to have unnecessary lock contention if the device is opened
>> and read simultaneously from multiple fds, and every loop iteration would
>> need to acquire the spinlock / disable interrupts at least once.
>
> We could make the spinlock per struct file *, which'd remove the
> contention bottleneck when the same device is accessed from through
> multiple fds, but still maintain the correctness (as the list itself is a
> per-fd thing anyway).
>
> Probably introducing new spinlock would make more sense, as list_lock is
> currently being used mostly to protect accessing of the dev->list linked
> list.

Yes, I'd protect dev->list with RCU, introducde per-file spinlock,
took it when both putting data into teh queue and taking values out.

One could try to optimize and rely on kfifo to avoid taking lock on
writer side, but we are not dealing with 40Gb network interface here
so I would not get too fancy.

Thanks.

-- 
Dmitry
