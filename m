From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Mon, 28 Sep 2015 13:33:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53781 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932297AbbI1LdW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 07:33:22 -0400
In-Reply-To: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Mon, 28 Sep 2015, Sedat Dilek wrote:

> When compiling Linux v4.2+ and v4.3-rc2+ with a llvmlinux patchset
> and CLANG v3.7 I see a BUG line like this:
> 
> [   24.705463] BUG: sleeping function called from invalid context at kernel/workqueue.c:2680
> [   24.705576] in_atomic(): 0, irqs_disabled(): 1, pid: 1447, name: acpid
> 
> After some vital help from workqueue and hid folks it turned out to be
> a problem in the hid area.
> 
> Jiri encouraged me to look into del_timer-sync()/cancel_work_sync().
> So, I disassembled kernel/time/timer.o.
> This looked good.
> 
> Both functions are called in hid_cancel_delayed_stuff().

Yeah, but we're enabling IRQs before calling hid_cancel_delayed_stuff() 
(or, to be more precise, we're restoring original flags, and I don't see 
usbhid_close() being called with IRQs off).

Therefore ...

[ ... snip ... ]
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 36712e9f56c2..188f59348ec5 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -729,16 +729,16 @@ void usbhid_close(struct hid_device *hid)
>  	 * data acquistion due to a resumption we no longer
>  	 * care about
>  	 */
> -	spin_lock_irq(&usbhid->lock);
> +	spin_lock_bh(&usbhid->lock);
>  	if (!--hid->open) {
> -		spin_unlock_irq(&usbhid->lock);
> +		spin_unlock_bh(&usbhid->lock);
>  		hid_cancel_delayed_stuff(usbhid);

I still don't understand how this should be improving anything. I believe 
spin_unlock_irq() should just re-enable interrupts, because we've been 
called with them enabled as well.

Now if you are able to see how usbhid_close() can be called with IRQs 
off, that would be a completely different story. But if that's not the 
case, the warning is bogus, and gcc-compiled kernels are right about not 
issuing it.

But without that, I so far fail to see how this is a correct thing to do.

Thanks,

-- 
Jiri Kosina
SUSE Labs

