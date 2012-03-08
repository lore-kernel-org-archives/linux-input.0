From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Thu, 8 Mar 2012 12:48:24 +0100
Message-ID: <E18D154F-E02F-4DF9-8749-7F9EF92792CB@enac.fr>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>  <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>  <20120308105737.GA11201@polaris.bitmath.org>  <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr> <20120308113009.GA11416@polaris.bitmath.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 88-230.252-81.static-ip.oleane.fr ([81.252.230.88]:33360 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab2CHLs0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Mar 2012 06:48:26 -0500
In-Reply-To: <20120308113009.GA11416@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Le 8 mars 2012 =E0 12:30, Henrik Rydberg a =E9crit :
>=20
> The device-driver matching is done in the kernel, but driver (aka
> module) loading is done from userland. The crux is to be able to tell
> userland what driver to load for a certain device. In this case, it
> means giving more information to userland via the device/modalias
> construct. Or at least, that is the question. :-)
>=20

Oook, I understand. The current solution used by distros is to load the=
 hid module statically, but then we don't want to do it for every new k=
ind of device-specific module, right? Is this your point?=20

I had the feeling that the current hid code was somehow trying to be un=
iversal, thus making the point moot, and figured that we would need to =
reintegrate hid-multitouch into hid-core at some point. You're suggesti=
ng another, more distributed option, in which new categories of HID dev=
ices appear from time to time and are handled in new modules, right? So=
unds interesting to me, I'd like to hear what the original designers of=
 the hid module think of it.

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
