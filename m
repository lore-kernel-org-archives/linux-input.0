From: Maulik Mankad <mankad.maulik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFT]patch to remove kernel thread for runtime pm from usbhid
Date: Tue, 12 Oct 2010 17:04:33 +0530
Message-ID: <AANLkTi=AWMWPH7N035n0Tk+8PcWgu10LzGbLQfpSefO1@mail.gmail.com>
References: <201010121000.50465.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201010121000.50465.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 12, 2010 at 1:30 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
> Hi,
>
> this patch saves a kernel thread. It works with my mouse. Please test=
=2E
>
> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
>
> From 89cb25b186e336c04f74165f08bca6c934ebdfad Mon Sep 17 00:00:00 200=
1
> From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
> Date: Tue, 12 Oct 2010 09:28:11 +0200
> Subject: [PATCH] Input: usbhid: convert runtime pm to async API
>
> This patch removes the dedicated work queue and thus the kernel threa=
d
> used to wake up USB HID devices. It is replaced with the use of
> the async API which didn't exist when runtime pm was introduced to
> usbhid.
>
> Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> ---

Tested on OMAP4 SDP with USB Keyboard and USB Mouse using 'evtest' prog=
ram.

Works fine.

Regards,
Maulik
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
