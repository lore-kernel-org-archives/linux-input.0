From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: [PATCH] Add EV_IR bit
Date: Thu, 13 Aug 2009 00:33:27 +0200
Message-ID: <20090812223327.GA6827@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:44047 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZHLWd3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2009 18:33:29 -0400
Received: from basil.haag.hardeman.nu (host-88-217-225-61.customer.m-online.net [88.217.225.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTPSA id E90ACE51
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2009 00:33:29 +0200 (CEST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This patch adds an EV_IR bit to allow input drivers to let userspace=20
know that the hardware is an infrared remote control transceiver.

No dev->irbit is defined yet but I plan to add that later (which would=20
be used to indicate whether the hardware supports RX, TX, etc).

If the patch is accepted I'll send followup patches adding the=20
appropriate input_set_capability call to the relevant drivers.

Signed-off-by: David H=E4rdeman <david@hardeman.nu>


Index: linux-2.6/drivers/input/input.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/input/input.c	2009-08-12 19:45:10.000000000 =
+0200
+++ linux-2.6/drivers/input/input.c	2009-08-12 19:54:56.000000000 +0200
@@ -1375,6 +1375,10 @@
  		/* do nothing */
  		break;
 =20
+	case EV_IR:
+		/* do nothing */
+		break;
+
  	default:
  		printk(KERN_ERR
  			"input_set_capability: unknown type %u (code %u)\n",
Index: linux-2.6/include/linux/input.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/input.h	2009-08-12 19:56:03.000000000 =
+0200
+++ linux-2.6/include/linux/input.h	2009-08-12 19:57:53.000000000 +0200
@@ -98,6 +98,7 @@
  #define EV_FF			0x15
  #define EV_PWR			0x16
  #define EV_FF_STATUS		0x17
+#define EV_IR			0x18
  #define EV_MAX			0x1f
  #define EV_CNT			(EV_MAX+1)
 =20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
