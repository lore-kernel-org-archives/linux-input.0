From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Tue, 29 Sep 2015 20:54:38 +0200
Message-ID: <CA+icZUWxmmR8CiyXEjicNnzfr-35pJzgAiWxOzw8eGobkhRKjg@mail.gmail.com>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33425 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935176AbbI2Syj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 14:54:39 -0400
Received: by vkgd64 with SMTP id d64so11027409vkg.0
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2015 11:54:38 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Tue, Sep 29, 2015 at 11:27 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Tue, 29 Sep 2015, Sedat Dilek wrote:
>
>> Did you look at the step-by-step moving of trace_hardirqs_off() and
>> the corresponding dmesg-logs?
>> What helps is a trace_hardirqs_off() before spin_unlock_irq() in the
>> if-statement.
>> So, yes "IRQs are enabled" but tracing does not like it.
>
> I so far fail to make any sense out of this behavior.
>
>> > Therefore ...
>> >
>> > [ ... snip ... ]
>> >> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
>> >> index 36712e9f56c2..188f59348ec5 100644
>> >> --- a/drivers/hid/usbhid/hid-core.c
>> >> +++ b/drivers/hid/usbhid/hid-core.c
>> >> @@ -729,16 +729,16 @@ void usbhid_close(struct hid_device *hid)
>> >>        * data acquistion due to a resumption we no longer
>> >>        * care about
>> >>        */
>> >> -     spin_lock_irq(&usbhid->lock);
>> >> +     spin_lock_bh(&usbhid->lock);
>> >>       if (!--hid->open) {
>> >> -             spin_unlock_irq(&usbhid->lock);
>> >> +             spin_unlock_bh(&usbhid->lock);
>> >>               hid_cancel_delayed_stuff(usbhid);
>> >
>> > I still don't understand how this should be improving anything. I believe
>> > spin_unlock_irq() should just re-enable interrupts, because we've been
>> > called with them enabled as well.
>>
>> Is spin_lock_bh() not an appropriate replacement?
>
> No, it's not. Plus, before we gain understanding why exactly is the
> warning being issued, I am not making any random changes to the code.
>
>> > Now if you are able to see how usbhid_close() can be called with IRQs
>> > off, that would be a completely different story. But if that's not the
>> > case, the warning is bogus, and gcc-compiled kernels are right about not
>> > issuing it.
>>
>> Again, I am new to tracing.
>> Steven encouraged me to look at the lockdep hints in dmesg - not ftrace [1].
>>
>> "Actually, if you are looking for where interrupts were disabled last
>> before triggering the "sleeping function called from invalid context",
>> lockdep, not ftrace, would be your better bet.
>>
>> Enable lockdep with CONFIG_PROVE_LOCKING. It will give you better
>> information about where the last irq was disabled."
>>
>> Here, I have CONFIG_PROVE_LOCKING=y.
>>
>> I am doing a new kernel-build with the might_sleep() on top of
>> hid_cancel_delayed_stuff() which showed some lockdep/irqsoff hints in
>> dmesg-log.
>
> Yes. That dmesg doesn't still make any sense. It tells us that IRQs got
> enabled during spin_unlock_irq() (I believe it's the very one in
> usbhid_close(), but we'll see), and then it bugs because it thinks they
> are enabled.
>
> Actually, could you please run with the attached patch (you need lockdep
> enabled for it to build) and send me your dmesg? Ideally both from
> gcc-compiled kernel and llvm-compiled kernel as well.
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 36712e9..aaae42e 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -38,6 +38,8 @@
>  #include <linux/hidraw.h>
>  #include "usbhid.h"
>
> +#include <linux/lockdep.h>
> +
>  /*
>   * Version Information
>   */
> @@ -725,6 +727,9 @@ void usbhid_close(struct hid_device *hid)
>
>         mutex_lock(&hid_open_mut);
>
> +       if(WARN_ON(irqs_disabled()))
> +               print_irqtrace_events(current);
> +
>         /* protecting hid->open to make sure we don't restart
>          * data acquistion due to a resumption we no longer
>          * care about
>
> --
>

This breaks my build when CONFIG_USB_HID=m...

  find .tmp_versions -name '*.mod' | xargs -r grep -h '\.ko$' | sort
-u | sed 's/\.ko$/.o/' | scripts/mod/modpost -m -a -o ./Module.symvers
   -S   -s -T -
ERROR: "print_irqtrace_events" [drivers/hid/usbhid/usbhid.ko] undefined!
make[3]: *** [__modpost] Error 1
make[2]: *** [modules] Error 2
make[1]: *** [bindeb-pkg] Error 2
make: *** [bindeb-pkg] Error 2

- Sedat -
