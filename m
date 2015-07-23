From: Hanno Zulla <abos@hanno.de>
Subject: Re: How to add support for Motorola RZ100?
Date: Thu, 23 Jul 2015 13:24:45 +0200
Message-ID: <55B0CEFD.6040602@hanno.de>
References: <55B0C883.20001@hanno.de> <1437649596.2863.7.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoot.epublica.de ([78.46.103.157]:42067 "EHLO zoot.epublica.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbbGWLY4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 07:24:56 -0400
In-Reply-To: <1437649596.2863.7.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

Hi,

> You could start with making the hid-recorder output available...

Ok.

For reference:

<https://motorola-global-portal.custhelp.com/ci/fattach/get/593562/1361474625/redirect/1/session/L2F2LzEvdGltZS8xNDM3NjUwMjg3L3NpZC9reU9zZTRzbQ==/filename/SmartControler_Eng_SP_Fr_68016304001C.pdf>

<http://ecx.images-amazon.com/images/I/61EzkJ7jmpL._SL1200_.jpg>


There are four buttons on the front.


"Burger Menu button"

pressed    E: 1020.868306 4 01 00 00 e3
released   E: 1021.065924 4 01 00 00 00

"Home button"

pressed    E: 967.576417 4 01 00 00 4a
released   E: 967.907627 4 01 00 00 00

"Back button"

pressed    E: 1115.066579 4 01 00 00 29
released   E: 1115.292091 4 01 00 00 00

"Search button"

pressed    E: 1140.136426 4 01 00 00 65
released   E: 1140.306423 4 01 00 00 00


Next, there's a volume slider and a mute button on the left side.

"Volume up"

pressed    E: 1246.894763 4 03 00 80 00
released   E: 1247.816149 4 03 00 00 00

"Volume down"

pressed    E: 1270.319676 4 03 00 00 01
released   E: 1270.518170 4 03 00 00 00

"Mute"

no output, probably not handled by HID subdevice. Part of the headset
subdevice? How do I capture those events?


Finally, the big black trackpad on the top, above the four buttons.

When I move my fingers on that trackpad, hid-recorder will output lots
of raw HID data. How do I group these so that it's useful?

Thanks,

Hanno
