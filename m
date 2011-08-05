From: Michael Thayer <michael.thayer@oracle.com>
Subject: Getting notification of PS/2 mouse packages
Date: Fri, 05 Aug 2011 13:35:55 +0200
Message-ID: <1312544155.2426.49.camel@michael-latitude-e6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:48174 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab1HELgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Aug 2011 07:36:08 -0400
Received: from rtcsinet21.oracle.com (rtcsinet21.oracle.com [66.248.204.29])
	by rcsinet15.oracle.com (Switch-3.4.4/Switch-3.4.4) with ESMTP id p75Ba4Pp004179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-input@vger.kernel.org>; Fri, 5 Aug 2011 11:36:06 GMT
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
	by rtcsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id p75Ba3tZ013844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Fri, 5 Aug 2011 11:36:04 GMT
Received: from abhmt111.oracle.com (abhmt111.oracle.com [141.146.116.63])
	by acsmt357.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id p75BZvhi018172
	for <linux-input@vger.kernel.org>; Fri, 5 Aug 2011 06:35:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I am looking at writing a driver (it is to be open source, but not for
mainstream kernel inclusion) for a virtual machine-specific input
device.  Unfortunately one of the versions of the device I have to
support signals that it has new data available by sending a fake packag=
e
to the PS/2 mouse, so I need to be able to get notification of that
somehow.  Looking at the kernel source, I see that the i8042 driver
requests IRQ 12 as IRQF_SHARED, and that the kernel always notifies all
registered interrupt handlers of an interrupt, even if one of them
returns IRQ_HANDLED.  So it looks like I can just request my own shared
handler for IRQ 12 and always return IRQ_NONE, but still update my data=
=2E
However I am not sure whether this is something I can count on to keep
working in future kernel releases.  Does anyone on this list know more
about this, or can someone suggest a cleaner way to get the
notifications I need?

Thanks.

Regards,

Michael
--=20
ORACLE Deutschland B.V. & Co. KG   Michael Thayer
Werkstrasse 24                     VirtualBox engineering
71384 Weinstadt, Germany           mailto:michael.thayer@oracle.com

Hauptverwaltung: Riesstr. 25, D-80992 M=C3=BCnchen
Registergericht: Amtsgericht M=C3=BCnchen, HRA 95603

Komplement=C3=A4rin: ORACLE Deutschland Verwaltung B.V.
Hertogswetering 163/167, 3543 AS Utrecht, Niederlande
Handelsregister der Handelskammer Midden-Niederlande, Nr. 30143697
Gesch=C3=A4ftsf=C3=BChrer: J=C3=BCrgen Kunz, Marcel van de Molen, Alexa=
nder van der Ven

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
