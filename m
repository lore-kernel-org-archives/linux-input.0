From: Arjan Opmeer <arjan@opmeer.net>
Subject: FW: elantech modification to use with new asus touchpads
Date: Thu, 10 Jul 2014 22:17:13 +0200
Message-ID: <20140710201713.GA4536@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:53176 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752127AbaGJURO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 16:17:14 -0400
Received: from ado by ado.lan with local (Exim 4.82)
	(envelope-from <ado@adopmeer.homeip.net>)
	id 1X5KmH-0001EA-9q
	for linux-input@vger.kernel.org; Thu, 10 Jul 2014 22:17:14 +0200
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Please have a look at this:

----- Forwarded message from Marius Monton <marius.monton@gmail.com> --=
---

Date: Thu, 10 Jul 2014 19:43:27 +0200
Delivery-date: Thu, 10 Jul 2014 19:43:41 +0200
=46rom: Marius Monton <marius.monton@gmail.com>
To: arjan@opmeer.net
Subject: elantech modification to use with new asus touchpads

Hello Arjan

I've sending this email because you are in the list of developer for th=
e
elantech.c kernel module.

I have a asus s301L laptop with a unrecognized touchpad by elantech.

After debugging the output of the module, I realized that the touchpad
returns a invalid signature (to the elantech_is_signature_valid functio=
n).
 Elantech version query result 0x46, 0x1f, 0x14.


I've managed to remove this signature from the list and voil=E0! it is
working

If you need some more information or some job for me to do, don't hesit=
ate
to contact me.

Best regards, and thank you for your work

--=20
M=E0rius

----- End forwarded message -----
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
