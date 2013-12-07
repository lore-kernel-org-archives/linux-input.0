From: simon@mungewell.org
Subject: Re: Sony DualShock4 - basic functions work, but looking to improve
 support
Date: Sat, 7 Dec 2013 15:43:14 -0500
Message-ID: <10aade622f5593ec49af0256e3c60d83.squirrel@mungewell.org>
References: <61a33717137a02a1d0eac5a2d1cb257e.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20131207154314_10542"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:46938 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab3LGUnP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Dec 2013 15:43:15 -0500
In-Reply-To: <61a33717137a02a1d0eac5a2d1cb257e.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Linux Input <linux-input@vger.kernel.org>, Antonio Ospite <ospite@studenti.unina.it>

------=_20131207154314_10542
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> Anyone here want to collaborate?

I've decoded the majority of the HID stream including the multi-touch.

Also some good teardown info/pictures here:
http://mygaming.co.za/news/ps4/60397-cost-of-building-a-ps4.html

fccid = AK8CUHZCT1
ic = 409B-CUHZCT1

Simon.
------=_20131207154314_10542
Content-Type: text/plain; name="hidraw.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="hidraw.txt"

01 7e 7c 80 7f 08 00 04 00 00 6f 35 0d 06 00 03 00 01 00 69 04 ff 1e 9d f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 08 00 00 53 38 0d 01 00 f9 ff 02 00 8d 04 e5 1e b5 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 0c 00 00 40 3b 0d 00 00 04 00 04 00 7d 04 eb 1e a9 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 10 00 00 81 76 0d f7 ff 00 00 00 00 5d 04 f7 1e b2 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 14 00 00 67 79 0d f1 ff 00 00 f2 ff dd 04 bb 1f 55 f9 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 18 00 00 56 7c 0d 16 00 fc ff ff ff 75 04 db 1f 9d f9 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 1c 00 00 3f 7f 0d 3a 00 f3 ff 12 00 c5 03 9f 1f b9 f9 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 20 00 00 2b 82 0d 4f 00 fa ff 10 00 e7 03 75 1f c8 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 24 00 00 27 85 0d 5d 00 fe ff 12 00 f9 03 43 1f a1 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 28 00 00 04 88 0d 61 00 f9 ff 18 00 55 04 c7 1e c5 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 2c 00 00 f1 8a 0d 53 00 fc ff 1a 00 b1 04 57 1e 75 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 30 00 00 de 8d 0d 49 00 fd ff 14 00 b1 04 53 1e 19 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 34 00 00 cc 90 0d 35 00 fd ff 0d 00 b9 04 1b 1e d5 f7 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 38 00 00 bf 93 0d 10 00 fb ff 09 00 99 04 23 1e e5 f7 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 3c 00 00 a5 96 0d fc ff 01 00 fe ff 6a 04 35 1e eb f7 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 40 00 00 94 99 0d dc ff 06 00 f9 ff 71 04 57 1e 31 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 44 00 00 81 9c 0d d1 ff ff ff f8 ff 55 04 83 1e 7d f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00
01 7e 7c 80 7f 08 00 48 00 00 69 9f 0d ce ff 05 00 f6 ff 4d 04 fb 1e c9 f8 00 00 00 00 00 1b 00 00 01 79 96 8e 85 01 8b 20 21 24 00 80 00 00 00 80 00 00 00 00 80 00 00 00 80 00 00 00 00 80 00

|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || ||
|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ touch pad (see below)
|| || || || || || || || || || || || || || || || || || || || || || || || || ++ ++ ++ ++ ++ ++ ++ ++ fixed?
|| || || || || || || || || || || || || || || || || || || ++ ++ ++ ++ ++ ++ Accelerometers X, Y, Z (lsb, msb)
|| || || || || || || || || || || || || ++ ++ ++ ++ ++ ++ Gyros pitch, roll, yaw (lsb, msb)
|| || || || || || || || || || || || ++ fixed or slowly changing?
|| || || || || || || || || || ++ ++ always changing = time stamp ?
|| || || || || || || || || ++ R-Trigger
|| || || || || || || || ++ L-Trigger
|| || || || || || || ++ Count by 0x04?
|| || || || || ++ ++ Button bit field
|| || || || ++ R-Thumb Y
|| || || ++ R-Thumb X
|| || ++ L-Thumb Y
|| ++ L-Thumb X
++ alway 01


Multitouch section, allows for 2 simulataneous fingers
--
01 9f bc a9 d4 1c bd 0e f7 0d 00 80 00 00 00 80 00 00 00

|| || || || || || || || || || ++ ++ ++ ++ ++ ++ ++ ++ ++  only present while swiping, last position format as below

|| || || || || || || || +| ++ 2nd Y location
|| || || || || || || ++ |+ 2nd X location
|| || || || || || ++ 2nd event number

|| || || || +| ++ current Y location (lsb + msb, top = 0)
|| || || ++ |+ current X location (lsb + msb, left = 0)? note nibble order!!
|| || ++ event number, remains constant during press, counts up each time press starts, high bit set on release (ie 43->c3)
|| ++ presure/size? changes with both 1st of 2nd finger
++ type of data packets (1=static or 2=motion)
------=_20131207154314_10542--


