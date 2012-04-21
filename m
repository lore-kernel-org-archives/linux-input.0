From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sat, 21 Apr 2012 09:06:19 +0800
Message-ID: <CACVXFVPVd1sCYzCZytuTGaaWfhybXeRf=s+hmjUOBaq_fuTuxg@mail.gmail.com>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com>
	<201204200957.34154.oneukum@suse.de>
	<CACVXFVP42WL2aVDGSn0BF0NJbg824VsU=Fs30XKEif6siOrQvw@mail.gmail.com>
	<3064999.MGqgi6qjvF@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34480 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab2DUBGX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Apr 2012 21:06:23 -0400
In-Reply-To: <3064999.MGqgi6qjvF@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oneukum@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sat, Apr 21, 2012 at 5:59 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Friday, April 20, 2012 06:17:51 PM Ming Lei wrote:

> Why don't you do something like this:
>
> =A0 =A0 =A0 =A0urb_to_unlink =3D usbhid->urbout;
> =A0 =A0 =A0 =A0usbhid->urbout =3D NULL;

This may trigger oops in hid_submit_out called by hid_irq_out.

Even though you can check if usbhid->urbout is NULL inside
hid_submit_out, and just not submit it if it is NULL, then the solution
become similar with Oliver's idea, and the problem is that when the
usbhid->urbout will be resubmitted, which looks may involve much
more changes than the per cpu flag patch.

The difficulty is in the race between unlink with complete handler(irq)=
,
both may run concurrently on different CPUs.

>
> =A0 =A0 =A0 =A0spin_unlock(&usbhid->lock);
> =A0 =A0 =A0 =A0usb_unlink_urb(urb_to_unlink);
> =A0 =A0 =A0 =A0spin_lock(&usbhid->lock);
>
> and of course comment it properly.
>
> Thanks.
>
> --
> Dmitry



Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
