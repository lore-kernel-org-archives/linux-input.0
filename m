From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC 4/5] hid: Add idtags to modalias
Date: Tue, 3 Apr 2012 12:57:31 +0200
Message-ID: <20120403105731.GB14201@polaris.bitmath.org>
References: <1333436730-13008-1-git-send-email-rydberg@euromail.se>
 <1333436730-13008-5-git-send-email-rydberg@euromail.se>
 <CAN+gG=F0v1NnBd5G_Z77m3Qf8FuSs5Nj2-W97k=GhFdWmZDiKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:49188 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab2DCK4A (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 06:56:00 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=F0v1NnBd5G_Z77m3Qf8FuSs5Nj2-W97k=GhFdWmZDiKg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > + =A0 =A0 =A0 /* Generic MT device */
> > + =A0 =A0 =A0 { .driver_data =3D MT_CLS_DEFAULT,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_MT_DEVICE(HID_ANY_ID,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_ANY_ID) },
>=20
> This breaks the mechanism used to detect serial protocol.
> A better solution would be to keep .driver_data =3D 0 -> this would t=
ell
> us that the device is unknown and that we can override the given
> settings.

Good point, will do.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
