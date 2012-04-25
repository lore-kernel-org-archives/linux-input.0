From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 21:18:19 +0800
Message-ID: <CACVXFVPgAGA+D=dyS33eUBTH2xrXz_9+Fu5qB+bqB+6zg0WWNw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1204241100210.1511-100000@iolanthe.rowland.org>
	<201204251006.16272.oneukum@suse.de>
	<CACVXFVM6KMeMcXy549x9XqhqvCzq73pXvhLki363=KjQu2Nfsg@mail.gmail.com>
	<201204251252.55901.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50937 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab2DYNSX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 09:18:23 -0400
In-Reply-To: <201204251252.55901.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Wed, Apr 25, 2012 at 6:52 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Mittwoch, 25. April 2012, 11:14:19 schrieb Ming Lei:
>> You need to add check of "usbhid->outtail !=3D usbhid->outhead" abov=
e.
>
> Done. Could you test?

Basically my USB keyboard can work well as before with the patch, but t=
he
timeout is not covered since it can't be triggered in my box.

>
> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
> From 9ff6b78dc59c98b9844dc9922549fd338828a889 Mon Sep 17 00:00:00 200=
1
> From: Oliver Neukum <oliver@neukum.org>
> Date: Wed, 25 Apr 2012 12:50:37 +0200
> Subject: [PATCH] usbhid: prevent deadlock during timeout
>
> On some HCDs usb_unlink_urb() can directly call the
> completion handler. That limits the spinlocks that can
> be taken in the handler to locks not held while calling
> usb_unlink_urb
> To prevent a race with resubmission, this patch exposes
> usbcore's infrastructure for blocking submission, uses it
> and so drops the lock without causing a race in usbhid.
>
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

Reported-by: Ming Lei <ming.lei@canonical.com>

> ---
> =A0drivers/hid/usbhid/hid-core.c | =A0 61 +++++++++++++++++++++++++++=
++++++++++----
> =A0drivers/usb/core/urb.c =A0 =A0 =A0 =A0| =A0 30 +++++++++++++++++++=
+
> =A0include/linux/usb.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A03 files changed, 87 insertions(+), 6 deletions(-)
>


Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
