From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/3] HID: usbhid: defer LED setting to a workqueue
Date: Tue, 20 Dec 2011 18:12:37 +0800
Message-ID: <CAGS+omCLU6FAxmT3+TgYf0b8YvgfbH9CL9M6WpZ0yNS01O5Hrw@mail.gmail.com>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org>
 <201112141222.41006.oneukum@suse.de> <CAGS+omB8kmALYg+m__WpiGzcpTdFEzHz1x3gFFkyqofpnANvNQ@mail.gmail.com>
 <201112151001.52761.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201112151001.52761.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 15, 2011 at 5:01 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
>
> Am Donnerstag, 15. Dezember 2011, 07:43:09 schrieb Daniel Kurtz:
>
> Hi,
>
> > I'm sorry, I'm not seeing how using a workqueue to set the LEDs
> > changes anything with respect to how the driver deals with USB rese=
t.
>
> You are unfortunately right. This means that the driver currently is =
already
> buggy.
>
> > With or without a workqueue, LED control urbs are being queued and/=
or
> > submitted asynchronously to reset. =A0AFAICT, the only thing that
> > changes here is exactly when __usbhid_submit_report() is called. =A0=
In
> > the original case, this happens directly in the input event handler=
=2E
> > In the workqueue case, it happens in a system worker thread some sh=
ort
> > time after the input handler finishes.
>
> The current driver kills the ctrl URB in cease_io() which is not enou=
gh
> to prevent new IO.
>
> > Could you please be more specific about what this patch breaks and
> > perhaps give some guidance on how to fix it?
>
> It breaks nothing. It just continues a bug and I assumed it was not p=
resent.
> Basically the work queue must do nothing after pre_reset() and post_r=
eset()
> ought to rerun the work in case some request came down during that ti=
me.

So, is this an Ack for this patchset?
Can we fix any existing races in later patches?

Regards,
-Daniel

> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
