From: Oliver Neukum <oliver@neukum.org>
Subject: Re: cleanup of hiddev
Date: Tue, 4 Nov 2008 23:59:41 +0100
Message-ID: <200811042359.42661.oliver@neukum.org>
References: <200811031731.38055.oliver@neukum.org> <200811042351.28526.oliver@neukum.org> <4910D33E.7050006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:50127 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbYKDW7a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 17:59:30 -0500
In-Reply-To: <4910D33E.7050006@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Am Dienstag, 4. November 2008 23:57:02 schrieb Jiri Slaby:
> On 11/04/2008 11:51 PM, Oliver Neukum wrote:
> > If you call usb_register_dev() before you set
> > hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE]
> > this check in hiddev_open() may fail:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (i >=3D HIDDEV_MINORS || i <=
 0 || !hiddev_table[i])
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0return -ENODEV;
>=20
> I think, that's the point. You should also get ENODEV if you don't ca=
ll
> usb_register_dev(), create a node for non-existent minor manually and=
 try to
> open it. It behaves the same as if there was a lock you suggested...

But by calling usb_register_dev() we also cause the kernel to emit a
hotplug event that tells udev that the device exists.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
