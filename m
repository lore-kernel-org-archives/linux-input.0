From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Mon, 12 Mar 2012 16:57:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203121650500.18356@pobox.suse.cz>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>  <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz> <20120308105737.GA11201@polaris.bitmath.org>
 <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43430 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab2CLP5v (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 11:57:51 -0400
In-Reply-To: <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Henrik Rydberg <rydberg@euromail.se>, "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org

On Thu, 8 Mar 2012, St=E9phane Chatty wrote:

> > What if we were to change the definition of a HID device on the
> > modalias level?
> >=20
> > In practise, a HID device can be either an usb device, a hid device=
,
>=20
> Just to be sure: do you mean "bluetooth device"? or is there such a=20
> thing as a hid device per se? I'm asking because I've always been=20
> surprised at seeing usbhid/ in hid/, which kind of breaks the potenti=
al=20
> symmetry between USB and Bluetooth wrt hid.

Please don't get confused by the directory layout ... this has mostly=20
non-technical reasons -- Marcel wanted to keep bluetooth/hidp under his=
=20
wings, and I didn't have reasons to object strongly.

I am adding Marcel and Gustavo to CC just in case they have changed the=
ir=20
mind, but it's definitely a side-topic in this discussion.
Marcel, Gustavo -- if you are interested in the whole discussion regard=
ing=20
potential extension of HID core infrastructure to better suit multitouc=
h,=20
please see the whole thread at http://marc.info/?t=3D133105322800006&r=3D=
1&w=3D4

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
