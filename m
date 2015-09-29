From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Tue, 29 Sep 2015 21:32:15 +0200
Message-ID: <CA+icZUWKBb5vSm5b_7n7xVC1SJXFVEdavCqGZR68L4bGZA1Teg@mail.gmail.com>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
	<CA+icZUWxmmR8CiyXEjicNnzfr-35pJzgAiWxOzw8eGobkhRKjg@mail.gmail.com>
	<20150929150809.192d34bf@gandalf.local.home>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36366 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbbI2TcQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 15:32:16 -0400
Received: by vkfp126 with SMTP id p126so11631773vkf.3
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2015 12:32:15 -0700 (PDT)
In-Reply-To: <20150929150809.192d34bf@gandalf.local.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Tue, Sep 29, 2015 at 9:08 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 29 Sep 2015 20:54:38 +0200
> Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
>> This breaks my build when CONFIG_USB_HID=m...
>>
>>   find .tmp_versions -name '*.mod' | xargs -r grep -h '\.ko$' | sort
>> -u | sed 's/\.ko$/.o/' | scripts/mod/modpost -m -a -o ./Module.symvers
>>    -S   -s -T -
>> ERROR: "print_irqtrace_events" [drivers/hid/usbhid/usbhid.ko] undefined!
>> make[3]: *** [__modpost] Error 1
>> make[2]: *** [modules] Error 2
>> make[1]: *** [bindeb-pkg] Error 2
>> make: *** [bindeb-pkg] Error 2
>
> Add the below patch too:
>
> -- Steve
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 8acfbf773e06..8b29b3dd518f 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2410,6 +2410,7 @@ void print_irqtrace_events(struct task_struct *curr)
>         printk("softirqs last disabled at (%u): ", curr->softirq_disable_event);
>         print_ip_sym(curr->softirq_disable_ip);
>  }
> +EXPORT_SYMBOL(print_irqtrace_events);
>
>  static int HARDIRQ_verbose(struct lock_class *class)
>  {
>

Thanks, that fixed it.

- Sedat -
