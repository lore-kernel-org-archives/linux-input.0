From: Christian Ehrlicher <Ch.Ehrlicher@gmx.de>
Subject: Problem with Logitech SpaceNavigator
Date: Wed, 19 Feb 2014 20:38:37 +0100
Message-ID: <5305083D.6090503@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080200080409000906070306"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:53450 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbaBSTik (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 14:38:40 -0500
Received: from [192.168.178.20] ([91.58.245.42]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0Mcmmn-1WXbP52vxZ-00HxYJ for
 <linux-input@vger.kernel.org>; Wed, 19 Feb 2014 20:38:38 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------080200080409000906070306
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've a problem with some SpaceNavigator devices with a newer firmware 
(4.31). The problem is that the fixup for the EV_REL/EV_ABS 
(LG_RDESC_REL_ABS) is not applied for the new firmware because the 
report_descriptor is different (see attachments). It looks like the 
checked and modified bytes are no longer at offset 32/33 and 49/50 but 
at 36/37 and 53/54.
Is my assumption correct and is it possible to get this into hid-lg.c ?

Thx,
Christian Ehrlicher

--------------080200080409000906070306
Content-Type: text/plain; charset=windows-1252;
 name="sn_401_report_descriptor.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sn_401_report_descriptor.txt"

00000000  05 01 09 08 a1 01 a1 00  85 01 16 0c fe 26 f4 01  |.............&..|
00000010  36 00 80 46 ff 7f 09 30  09 31 09 32 75 10 95 03  |6..F...0.1.2u...|
00000020  81 02 c0 a1 00 85 02 09  33 09 34 09 35 75 10 95  |........3.4.5u..|
00000030  03 81 02 c0 a1 02 85 03  05 01 05 09 19 01 29 02  |..............).|
00000040  15 00 25 01 35 00 45 01  75 01 95 02 81 02 95 06  |..%.5.E.u.......|
00000050  81 03 c0 a1 02 85 04 05  08 09 4b 15 00 25 01 95  |..........K..%..|
00000060  01 75 01 91 02 95 01 75  07 91 03 c0 06 00 ff 09  |.u.....u........|
00000070  01 a1 02 15 80 25 7f 75  08 09 3a a1 02 85 05 09  |.....%.u..:.....|
00000080  20 95 01 b1 02 c0 a1 02  85 06 09 21 95 01 b1 02  | ..........!....|
00000090  c0 a1 02 85 07 09 22 95  01 b1 02 c0 a1 02 85 08  |......".........|
000000a0  09 23 95 07 b1 02 c0 a1  02 85 09 09 24 95 07 b1  |.#..........$...|
000000b0  02 c0 a1 02 85 0a 09 25  95 07 b1 02 c0 a1 02 85  |.......%........|
000000c0  0b 09 26 95 01 b1 02 c0  c0 c0                    |..&.......|


--------------080200080409000906070306
Content-Type: text/plain; charset=windows-1252;
 name="sn_431_report_descriptor.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sn_431_report_descriptor.txt"

00000000  05 01 09 08 a1 01 a1 00  85 01 16 a2 fe 26 5e 01  |.............&^.|
00000010  36 88 fa 46 78 05 55 0c  65 11 09 30 09 31 09 32  |6..Fx.U.e..0.1.2|
00000020  75 10 95 03 81 06 c0 a1  00 85 02 09 33 09 34 09  |u...........3.4.|
00000030  35 75 10 95 03 81 06 c0  a1 02 85 03 05 01 05 09  |5u..............|
00000040  19 01 29 02 15 00 25 01  35 00 45 01 75 01 95 02  |..)...%.5.E.u...|
00000050  81 02 95 0e 81 03 c0 a1  02 85 04 05 08 09 4b 15  |..............K.|
00000060  00 25 01 95 01 75 01 91  02 95 01 75 07 91 03 c0  |.%...u.....u....|
00000070  06 00 ff 09 01 a1 02 15  80 25 7f 75 08 09 3a a1  |.........%.u..:.|
00000080  02 85 05 09 20 95 01 b1  02 c0 a1 02 85 06 09 21  |.... ..........!|
00000090  95 01 b1 02 c0 a1 02 85  07 09 22 95 01 b1 02 c0  |..........".....|
000000a0  a1 02 85 08 09 23 95 07  b1 02 c0 a1 02 85 09 09  |.....#..........|
000000b0  24 95 07 b1 02 c0 a1 02  85 0a 09 25 95 07 b1 02  |$..........%....|
000000c0  c0 a1 02 85 0b 09 26 95  01 b1 02 c0 a1 02 85 13  |......&.........|
000000d0  09 2e 95 01 b1 02 c0 c0  c0                       |.........|


--------------080200080409000906070306--
