From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Tue, 29 Sep 2015 10:40:09 +0200
Message-ID: <CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33235 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933630AbbI2IkK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 04:40:10 -0400
Received: by vkgd64 with SMTP id d64so82964vkg.0
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2015 01:40:09 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Mon, Sep 28, 2015 at 1:33 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Mon, 28 Sep 2015, Sedat Dilek wrote:
>
>> When compiling Linux v4.2+ and v4.3-rc2+ with a llvmlinux patchset
>> and CLANG v3.7 I see a BUG line like this:
>>
>> [   24.705463] BUG: sleeping function called from invalid context at kernel/workqueue.c:2680
>> [   24.705576] in_atomic(): 0, irqs_disabled(): 1, pid: 1447, name: acpid
>>
>> After some vital help from workqueue and hid folks it turned out to be
>> a problem in the hid area.
>>
>> Jiri encouraged me to look into del_timer-sync()/cancel_work_sync().
>> So, I disassembled kernel/time/timer.o.
>> This looked good.
>>
>> Both functions are called in hid_cancel_delayed_stuff().
>

Hi Jiri,

first of all thanky ou for your fast and informative reply.

I am not a LOCKING expert or compiler guru, so a lot of stuff is new
to me and I try to understand things by testing.

> Yeah, but we're enabling IRQs before calling hid_cancel_delayed_stuff()
> (or, to be more precise, we're restoring original flags, and I don't see
> usbhid_close() being called with IRQs off).
>

2nd this issue is really serious for me.
When doing a cut and paste in Firefox, my Xorg restarts and I am
confronted with my LightDM login-manager.
So... not really a working environment.

Did you look at the step-by-step moving of trace_hardirqs_off() and
the corresponding dmesg-logs?
What helps is a trace_hardirqs_off() before spin_unlock_irq() in the
if-statement.
So, yes "IRQs are enabled" but tracing does not like it.

> Therefore ...
>
> [ ... snip ... ]
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
>> index 36712e9f56c2..188f59348ec5 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -729,16 +729,16 @@ void usbhid_close(struct hid_device *hid)
>>        * data acquistion due to a resumption we no longer
>>        * care about
>>        */
>> -     spin_lock_irq(&usbhid->lock);
>> +     spin_lock_bh(&usbhid->lock);
>>       if (!--hid->open) {
>> -             spin_unlock_irq(&usbhid->lock);
>> +             spin_unlock_bh(&usbhid->lock);
>>               hid_cancel_delayed_stuff(usbhid);
>
> I still don't understand how this should be improving anything. I believe
> spin_unlock_irq() should just re-enable interrupts, because we've been
> called with them enabled as well.
>

Is spin_lock_bh() not an appropriate replacement?
Does it change code beaviour?
Is it important to re-enable IRQs here - before hid_cancel_delayed_stuff()?
Turning hardirqs off seems to make the bug-line go away.

> Now if you are able to see how usbhid_close() can be called with IRQs
> off, that would be a completely different story. But if that's not the
> case, the warning is bogus, and gcc-compiled kernels are right about not
> issuing it.
>

Again, I am new to tracing.
Steven encouraged me to look at the lockdep hints in dmesg - not ftrace [1].

"Actually, if you are looking for where interrupts were disabled last
before triggering the "sleeping function called from invalid context",
lockdep, not ftrace, would be your better bet.

Enable lockdep with CONFIG_PROVE_LOCKING. It will give you better
information about where the last irq was disabled."

Here, I have CONFIG_PROVE_LOCKING=y.

I am doing a new kernel-build with the might_sleep() on top of
hid_cancel_delayed_stuff() which showed some lockdep/irqsoff hints in
dmesg-log.

> But without that, I so far fail to see how this is a correct thing to do.

Again, I dunno why two compiler behave different here.
Unsure if it is a compiler or linux-kernel issue or whatever.

Still fighting...

- Sedat -

[1] http://marc.info/?l=linux-kernel&m=144337272915104&w=2
