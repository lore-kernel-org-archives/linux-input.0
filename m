From: Gowri Ries - Stantum <G.Ries@stantum.com>
Subject: RE: Sitronix ST9RM01 multitouch panel
Date: Wed, 29 Sep 2010 09:31:46 +0200
Message-ID: <39DA9B419B56B14AB97E543A876B0ECF195F57B665@stantum-exch.stantum.local>
References: <20100928093949.26553.55566.stgit@localhost.localdomain>
 <E8E47989-5040-4B4C-9955-5B48A5CA2073@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from reverse.completel.net ([92.103.162.83]:11486 "EHLO
	mail.stantum.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750995Ab0I2HhO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 03:37:14 -0400
In-Reply-To: <E8E47989-5040-4B4C-9955-5B48A5CA2073@enac.fr>
Content-Language: fr-FR
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Alan Cox <alan@linux.intel.com>, "rudy_huang@sitronix.com.tw" <rudy_huang@sitronix.com.tw>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

Hi Everyone,=20

Sitronix uses Stantum design, but I do not believe there is any need fo=
r another driver for this.
VID and PID have to be added to the existing Stantum driver (hid-stantu=
m) - there should not be another driver needed.=20
I believe sitronix probably wrote the driver as they thought the existi=
ng driver does not work with their device.=20
In my opinion it should be removed and the original should be updated t=
o include the sitronix vid and pid=20

I have added rudy_huang to this mail : Rudy please let me know if you w=
ant to update the driver or if you want us to do it.

Regards
Gowri

-----Message d'origine-----
De=A0: St=E9phane Chatty [mailto:chatty@enac.fr]=20
Envoy=E9=A0: mardi 28 septembre 2010 19:51
=C0=A0: Alan Cox
Cc=A0: linux-input; Jiri Kosina; Gowri Ries - Stantum; Henrik Rydberg
Objet=A0: Re: Sitronix ST9RM01 multitouch panel


Le 28 sept. 10 =E0 11:40, Alan Cox a =E9crit :

> From: Rudy Huang <rudy_huang@sitronix.com.tw>
>
> USB HID support for the Sitronix ST9RM01 multi-touch panel as an inpu=
t
> device.
>

The Sitronix ST9RM01 appears to be based on Stantum's design and =20
firmware (see http://www.stantum.com/en/supply-chain/icdesigners/=20
Sitronix). Actually, the submitted driver still contains an error =20
message from the original hid-stantum.c :-) Are there differences =20
that force the creation of a new driver?

Cheers,

St.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
