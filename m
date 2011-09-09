From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] HID: Add full support for Logitech Unifying receivers
Date: Fri, 9 Sep 2011 11:28:06 -0700
Message-ID: <20110909182805.GH32383@core.coreip.homeip.net>
References: <1314259880-7854-1-git-send-email-benjamin.tissoires@gmail.com>
 <CAN+gG=HZsREeuc0h53juGg3L6kseuEUeiBWe8ZCaNLaVpth1Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45711 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759649Ab1IIS2N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2011 14:28:13 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=HZsREeuc0h53juGg3L6kseuEUeiBWe8ZCaNLaVpth1Qw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, rtitmuss@logitech.com, ogay@logitech.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Thu, Sep 01, 2011 at 02:43:32PM +0200, Benjamin Tissoires wrote:
> > +
> > + =A0 =A0 =A0 usbhid_submit_report(dj_rcv_hiddev, &report, USB_DIR_=
OUT);
>=20
> This is not working when the receiver is paired to a keyboard. When
> the session launches, Gnome try to send leds commands to the keyboard
> and this results in an oops.
>=20
> Using a  pointer to the struct hid_report solves the crash.
>=20
> However, Dmitry, you told us about a DMA stack problem. Can you give
> us a better way to handle that?
>=20

Actually it is OK, usbhid_submit_report internally allocates DMA_safe
memory for raw report and copies the data for you.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
