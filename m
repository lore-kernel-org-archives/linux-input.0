From: "Alain Hervo" <alain.hervo@prescom.fr>
Subject: C-Media CM119A GPIO  not reachables with Cm109 driver
Date: Wed, 11 Apr 2012 09:44:53 +0200
Message-ID: <E43D2A9C21DA4D7D97DBF878376FD3A0@AHXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpout1.mel.teaser.net ([213.162.54.51]:33207 "EHLO
	smtpout1.mel.teaser.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab2DKHop (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Apr 2012 03:44:45 -0400
Received: from AHXP (LAubervilliers-151-13-1-251.w217-128.abo.wanadoo.fr [217.128.0.251])
	by smtpout1.mel.teaser.net (Postfix) with SMTP id B992111F6A8
	for <linux-input@vger.kernel.org>; Wed, 11 Apr 2012 09:44:43 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Good morning.
I use the interesting  Alfred E.Heggestad 's driver for driving C-Media=
=20
cm109 usb audio component.=20
http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-02/msg03332.html
This driver is useful for accessing GPIO  event.

Now C-Media  CM109 component is replaced by CM119A.
CM119A 's documentation don't  provide difference between CM119A and CM=
109=20
components, except the binterval time : 2ms for CM119A , 32ms for CM109=
=2E .

But,  when cm109_usb_probe() is processed,  usb_endpoint_is_int_in(endp=
oint)=20
fails with CM119A component.  : component seems not have accessible=20
interrupt endpoint.

Please, do you know this problem ?
Thank you.
Best regards.
Alain.

--=20
Alain HERVO

PRESCOM
Rue de Broglie
22300 LANNION - FRANCE
Tel. : 33 (0)2 96 05 76 08
=46ax : 33 (0)2 96 48 04 21
http://www.prescom.fr

"Les informations contenues dans ce courriel sont donn=E9es =E0 titre p=
urement=20
informatif et ne peuvent =EAtre consid=E9r=E9es comme contractuelles en=
tre les=20
r=E9cipiendaires et la soci=E9t=E9 Prescom."=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
