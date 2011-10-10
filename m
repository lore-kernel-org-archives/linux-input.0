From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH V2] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 16:34:38 +0200
Message-ID: <201110101634.39018.oneukum@suse.de>
References: <1318254086-22752-1-git-send-email-mjg@redhat.com> <201110101606.37878.oneukum@suse.de> <20111010141635.GA17889@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38393 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368Ab1JJOeX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 10:34:23 -0400
In-Reply-To: <20111010141635.GA17889@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, dtor@mail.ru

Am Montag, 10. Oktober 2011, 16:16:35 schrieb Matthew Garrett:
> On Mon, Oct 10, 2011 at 04:06:37PM +0200, Oliver Neukum wrote:
>=20
> > This is odd, because the hardware shouldn't generate remote wakeups=
 unless you
> > request them, like this (usbhid)
>=20
> I thought needs_remote_wakeup was a hint to the kernel that remote=20
> wakeup ability was required for the hardware to autosuspend? In theor=
y I

It fulfills that role, but it is not its sole function.

> guess it should be set, but in practice all the hardware supported by=
=20
> this driver generates them so it'd be a noop. No objection to adding =
it=20
> in the name of correctness (or if some future version is broken, I=20
> guess...), though.

It is used in usb_port_suspend in form of do_remote_wakeup which
is computed from it. And we send a real control message.

	Regards
		Oliver

int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
{
        struct usb_hub  *hub =3D hdev_to_hub(udev->parent);
        int             port1 =3D udev->portnum;
        int             status;

        // dev_dbg(hub->intfdev, "suspend port %d\n", port1);

        /* enable remote wakeup when appropriate; this lets the device
         * wake up the upstream hub (including maybe the root hub).
         *
         * NOTE:  OTG devices may issue remote wakeup (or SRP) even whe=
n
         * we don't explicitly enable it here.
         */
        if (udev->do_remote_wakeup) {
                status =3D usb_control_msg(udev, usb_sndctrlpipe(udev, =
0),
                                USB_REQ_SET_FEATURE, USB_RECIP_DEVICE,
                                USB_DEVICE_REMOTE_WAKEUP, 0,
                                NULL, 0,
                                USB_CTRL_SET_TIMEOUT);
                if (status) {
                        dev_dbg(&udev->dev, "won't remote wakeup, statu=
s %d\n",
                                        status);
                        /* bail if autosuspend is requested */
                        if (msg.event & PM_EVENT_AUTO)
                                return status;
                }
        }



> --=20
> Matthew Garrett | mjg59@srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
