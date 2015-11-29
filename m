From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: Re: [PATCH v2] hid: usbhid: hid-core: fix recursive deadlock
Date: Sun, 29 Nov 2015 12:29:15 +0200
Message-ID: <20151129122915.66ead7c2@adipc>
References: <1447874755-8673-1-git-send-email-adi@adirat.com>
	<1448050742-10777-1-git-send-email-adi@adirat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33989 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbK2K3O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2015 05:29:14 -0500
Received: by wmvv187 with SMTP id v187so119048158wmv.1
        for <linux-input@vger.kernel.org>; Sun, 29 Nov 2015 02:29:13 -0800 (PST)
In-Reply-To: <1448050742-10777-1-git-send-email-adi@adirat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, joshc@ni.com

On Fri, 20 Nov 2015 22:19:02 +0200
Ioan-Adrian Ratiu <adi@adirat.com> wrote:

> The critical section protected by usbhid->lock in hid_ctrl() is too
> big and because of this it causes a recursive deadlock. "Too big" means
> the case statement and the call to hid_input_report() do not need to be
> protected by the spinlock (no URB operations are done inside them).
> 
> The deadlock happens because in certain rare cases drivers try to grab
> the lock while handling the ctrl irq which grabs the lock before them
> as described above. For example newer wacom tablets like 056a:033c try
> to reschedule proximity reads from wacom_intuos_schedule_prox_event()
> calling hid_hw_request() -> usbhid_request() -> usbhid_submit_report()
> which tries to grab the usbhid lock already held by hid_ctrl().
> 
> There are two ways to get out of this deadlock:
>     1. Make the drivers work "around" the ctrl critical region, in the
>     wacom case for ex. by delaying the scheduling of the proximity read
>     request itself to a workqueue.
>     2. Shrink the critical region so the usbhid lock protects only the
>     instructions which modify usbhid state, calling hid_input_report()
>     with the spinlock unlocked, allowing the device driver to grab the
>     lock first, finish and then grab the lock afterwards in hid_ctrl().
> 
> This patch implements the 2nd solution.
> 
> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 36712e9..5dd426f 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -477,8 +477,6 @@ static void hid_ctrl(struct urb *urb)
>  	struct usbhid_device *usbhid = hid->driver_data;
>  	int unplug = 0, status = urb->status;
>  
> -	spin_lock(&usbhid->lock);
> -
>  	switch (status) {
>  	case 0:			/* success */
>  		if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
> @@ -498,6 +496,8 @@ static void hid_ctrl(struct urb *urb)
>  		hid_warn(urb->dev, "ctrl urb status %d received\n", status);
>  	}
>  
> +	spin_lock(&usbhid->lock);
> +
>  	if (unplug) {
>  		usbhid->ctrltail = usbhid->ctrlhead;
>  	} else {

Hello again

Can this please be merged in the 4.4? There are quite a few people who have
their tablets deadlock and don't know how to patch their kernels so are stuck
waiting for a new release.

The severity of this issue is much bigger than I initially thought. Since I've
posted on the wacom mailing list that I have a fix for this deadlock I've
recived lots of email from people complaining of the same problem on a wide
range of tablets.

Some of those people know how to patch a kernel, some found this patch on the
mailing list and tested it and confirmed that it works on the wacom mailing
list (you can verify the deadlock + fix on that mailing list).

Thank you,
Adrian
