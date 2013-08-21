From: GRENON =?iso-8859-1?b?TG/vYw==?= <difool@rs2i.net>
Subject: Rotary encoder platform device driver code examples
Date: Wed, 21 Aug 2013 22:50:16 +0200
Message-ID: <52152808.1000608@rs2i.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp24.services.sfr.fr ([93.17.128.82]:1933 "EHLO
	smtp24.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab3HUVAP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Aug 2013 17:00:15 -0400
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2417.sfr.fr (SMTP Server) with ESMTP id B992170000D4
	for <linux-input@vger.kernel.org>; Wed, 21 Aug 2013 22:50:16 +0200 (CEST)
Received: from [192.168.1.100] (AAmiens-154-1-6-33.w83-192.abo.wanadoo.fr [83.192.82.33])
	by msfrf2417.sfr.fr (SMTP Server) with ESMTP id 9A95870000D0
	for <linux-input@vger.kernel.org>; Wed, 21 Aug 2013 22:50:16 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi guys,

I want to interface a magnetic scale position sensor with a BeagleBone=20
Black (an ARM development platform).
While I was reading this following article :=20
http://bwgz57.wordpress.com/2012/04/11/beaglebone-with-a-rotary-encoder=
/=20
I discovered that linux has built-in support for rotary encoders=20
connected via GPIO.

The magnetic scale position sensor can be considered like a rotary=20
encoder so I would use the rotary_encoder platform device driver.

I've read the code example at the end of this document :=20
https://www.kernel.org/doc/Documentation/input/rotary-encoder.txt
But I don't know how to access to the "pos" value of the rotary encoder=
=2E

Do you have some code example of use of this driver ? Or anything that=20
can be helpful for me.

Thanks,
Regards,

Lo=EFc
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
