From: Hanno Zulla <abos@hanno.de>
Subject: Re: How to add support for Motorola RZ100?
Date: Thu, 23 Jul 2015 13:31:08 +0200
Message-ID: <55B0D07C.5000207@hanno.de>
References: <55B0C883.20001@hanno.de> <1437649596.2863.7.camel@hadess.net> <55B0CEFD.6040602@hanno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoot.epublica.de ([78.46.103.157]:42207 "EHLO zoot.epublica.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbbGWLbL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 07:31:11 -0400
In-Reply-To: <55B0CEFD.6040602@hanno.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

Hi,

oops, I forgot the initial output of hid-recorder:

D: 0
R: 331 05 01 09 02 a1 01 85 02 05 09 19 01 29 03 15 00 25 01 75 01 95 03
81 02 75 05 95 01 81 03 05 01 09 01 a1 00 09 30 09 31 15 81 25 7f 75 08
95 02 81 06 09 38 15 81 25 7f 75 08 95 01 81 06 05 0c 0a 38 02 15 80 25
7f 75 08 95 01 81 06 c0 c0 05 01 09 06 a1 01 85 01 05 07 75 08 95 02 81
03 19 00 29 ff 15 00 26 ff 00 75 08 95 01 81 00 c0 05 0c 09 01 a1 01 85
03 15 00 25 01 75 01 95 12 0a 94 01 0a 92 01 0a 83 01 0a 23 02 0a 8a 01
0a 82 01 0a 21 02 0a 24 02 0a 25 02 0a 26 02 0a b6 01 09 b6 09 b5 09 8c
09 cd 09 e9 09 ea 09 e2 81 02 75 06 95 01 81 03 c0 05 0d 09 05 a1 01 85
33 05 0d 09 35 15 00 25 01 75 01 95 01 81 06 05 09 19 01 29 03 15 00 25
01 75 01 95 03 81 02 75 04 95 01 81 03 05 0d 09 22 a1 02 09 51 15 00 25
0f 75 04 95 01 81 02 09 33 15 00 25 01 75 01 95 01 81 02 09 f0 15 00 25
01 75 01 95 01 81 06 75 02 95 01 81 03 05 01 09 01 a1 00 05 01 09 30 15
00 26 e4 02 65 11 55 0e 35 00 46 c2 01 75 0c 95 01 81 02 09 31 15 00 26
81 02 65 11 55 0e 35 00 46 5e 01 75 0c 95 01 81 02 c0 c0 c0 00
N: Motorola RZ100
P: 00:10:60:a6:0c:12
I: 5 22b8 093d

> Finally, the big black trackpad on the top, above the four buttons.
> 
> When I move my fingers on that trackpad, hid-recorder will output lots
> of raw HID data. How do I group these so that it's useful?

Figured out this much so far (hopefully not on the wrong track, though):

One finger tap on touchpad:

E: 1731.624925 6 02 01 00 00 00 00
E: 1731.626147 6 02 00 00 00 00 00

Two finger tap on touchpad:

E: 1740.959910 6 02 02 00 00 00 00
E: 1740.962016 6 02 00 00 00 00 00


I'm not sure if the gestures on page 5 ("Basics") of the manual at

<https://motorola-global-portal.custhelp.com/ci/fattach/get/593562/1361474625/redirect/1/session/L2F2LzEvdGltZS8xNDM3NjUwMjg3L3NpZC9reU9zZTRzbQ==/filename/SmartControler_Eng_SP_Fr_68016304001C.pdf>

are interpreted by the controller or by the device.
