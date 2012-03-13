From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hig-lg, hif-lg4ff: Allow for custom device properties
 to be stored as private driver data
Date: Tue, 13 Mar 2012 09:28:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203130925350.18356@pobox.suse.cz>
References: <2576330.lyEl61c5nA@qosmio-x300>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41376 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359Ab2CMI26 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 04:28:58 -0400
In-Reply-To: <2576330.lyEl61c5nA@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org, simon@mungewell.org

On Mon, 12 Mar 2012, Michal Mal=FD wrote:

> this is sort of a response to Simon Wood's recent G27 LED's patch but=
=20
> since the patch touches a completely different part of the Logitech=20
> driver I submitted it separately.

Michal,

thanks for the patch.

> The main goal of this patch is to allow for some custom device specif=
ic=20
> properties like the rotation range to be stored as private driver dat=
a.=20
> Up until now the hid-lg treated the pointer to driver_data as unsigne=
d=20
> long as stored some device quirks there. Because of the scope of the=20
> changes, Simon's implementation of the G27 LEDs code is unfortunately=
=20
> incompatible with this patch because it uses the linked list I'm tryi=
ng=20
> to get rid of.

I hope Simon will be refreshing his patch to use LEDS_CLASS anyway.

> The patch also introduces some spinlocking to hid-lg and hid-lg4ff to=
=20
> (hopefully) prevent any nasty race conditions you were concerned abou=
t.

=46rom a cursory look the locking looks good (why do you need to disabl=
e=20
IRQs while taking the lock? It doesn't seem to be taken in IRQ context=20
anywhere, right?).
But it's somewhat difficult to review, as it's inter-mixed with other=20
changes. Could you please split your patch in two independent patches, =
one=20
adding proper locking, and second one implementing the drv_data change?=
=20
Those changes don't have anything in common in principle, so it makes=20
sense to have them separated.

Thanks.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
