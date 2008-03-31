From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]race between open and disconnect in usbhid
Date: Mon, 31 Mar 2008 15:47:55 +0200
Message-ID: <200803311547.56448.oliver@neukum.org>
References: <200803311535.10067.oliver@neukum.org> <Pine.LNX.4.64.0803311522110.5541@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:35622 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYCaN3K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2008 09:29:10 -0400
In-Reply-To: <Pine.LNX.4.64.0803311522110.5541@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Montag, 31. M=E4rz 2008 15:23:50 schrieb Jiri Kosina:
> On Mon, 31 Mar 2008, Oliver Neukum wrote:
>=20
> > There is a window:
> > task A					task B
> > spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
> > usb_set_intfdata(intf, NULL);
> > spin_unlock_irq(&usbhid->inlock);
> > usb_kill_urb(usbhid->urbin);
> > usb_kill_urb(usbhid->urbout);
> > usb_kill_urb(usbhid->urbctrl);
> >=20
> > del_timer_sync(&usbhid->io_retry);
> > cancel_work_sync(&usbhid->reset_work);
> >=20
> > 						if (!hid->open++) {
> > 							res =3D usb_autopm_get_interface(usbhid->intf);
> > 							if (res < 0) {
> > 								hid->open--;
> > 								return -EIO;
> > 							}
> > 						}
> > 						if (hid_start_in(hid))
> >=20
> > if (hid->claimed & HID_CLAIMED_INPUT)
> > 	hidinput_disconnect(hid);
> > in which an open() to an already disconnected device will submit an=
 URB=20
> > to an undead device. In case disconnect() was called by an ioctl,=20
> > this'll oops. Fix by introducing a reliable flag an checking it in=20
> > hid_start_in().
>=20
> Hi Oliver,
>=20
> thanks for checking this, good catch.
>=20
> > +	char disconnected:1;						/* indicates undead device - no use */
>=20
> Wouldn't introduction of new flag (HID_DISCONNECTED) to=20
> usbhid_device->iofl be cleaner?

A matter of taste. I don't use atomic ops if I don't have to, but if yo=
u
like it better the other way I can redo it.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
