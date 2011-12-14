From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/3] HID: usbhid: hid-core: submit queued urbs before suspend
Date: Wed, 14 Dec 2011 10:14:33 +0100
Message-ID: <201112141014.33696.oneukum@suse.de>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org> <201112140855.40050.oneukum@suse.de> <CAGS+omDMipRTVOGV9fG0ciWpuwMRBL-eTY8uDwaiSOW==CkQ-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omDMipRTVOGV9fG0ciWpuwMRBL-eTY8uDwaiSOW==CkQ-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Mittwoch, 14. Dezember 2011, 09:00:18 schrieb Daniel Kurtz:
> On Wed, Dec 14, 2011 at 3:55 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
> > Am Donnerstag, 17. November 2011, 12:23:49 schrieb Daniel Kurtz:
> >> Unfortunately, this usually happens while the first LED request is
> >> actually still being processed.  Thus when the completion handler tries
> >> to submit the second LED request it fails, since REPORTED_IDLE is
> >> already set!  This REPORTED_IDLE check failure causes the completion
> >> handler to complete, however without clearing the CTRL_RUNNING flag.
> >> This, in turn, means that the suspend() handler's wait_io() condition
> >> is never satisfied, and instead it times out after 10 seconds, aborting
> >> the original system suspend.
> >>
> >> This patch changes the behavior to the following:
> >>   (1) allow completion handler to finish submitting all queued URBs, even if
> >>       REPORTED_IDLE is set.  This guarantees that all URBs queued before the
> >>       hid-core suspend() call will be submitted before the system is
> >>       suspended.
> >
> > Hi,
> >
> > why is this desirable? You'd want to requests to be executed at resumption.
> > A system suspend will alter the LED state anyway.
> 
> This is how a system suspend 'alters' the LED state.  The input layer
> sends those LED off commands down through HID as it is trying to
> suspend.  We want to make sure the usbhid layer actually finishes
> forwarding those requests on to the device before the system is
> suspended.

You know the HID layer will send those commands. You don't know which
other commands may already be queued. So I don't know whether you really want
to execute them all while the system is asuspending.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
