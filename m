From: Karsten Merker <merker@debian.org>
Subject: [PATCH RFC 0/2] Input: Goodix - add axis swapping and inversion support
Date: Thu,  1 Oct 2015 00:29:53 +0200
Message-ID: <1443652195-7104-1-git-send-email-merker@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52227 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbbI3Waj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 18:30:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>

Hello,

the goodix touchscreen driver has gained device-tree support in kernel
4.1, but doesn't currently support the touchscreen-swapped-x-y,
touchscreen-inverted-x and touchscreen-inverted-y properties.

On systems which combine a portrait-mode display with a landscape-mode
touchscreen, such as e.g. the MSI Primo 81 tablet, support for these
features is necessary to have the touchscreen and the display use the
same coordinate system.

With support for axis inversion, the "rotated_screen" flag in the
driver can also be removed, as "rotated_screen" is just a special case
of x/y axis inversion.

This patchset sits on top of the "[PATCH v6 0/9] Goodix touchscreen
enhancements" series by Irina Tirdea:
http://www.spinics.net/lists/linux-input/msg40992.html

I have successfully tested the axis swapping on an (arm-based) MSI
Primo 81 tablet, but I lack appropriate hardware to do a real-world
test of the "rotated_screen" code path, so I would apprechiate very
much if somebody with appropriate hardware could give it a try.

This is my first go at modifying an input driver; any kind of
feedback and hints is welcome.

Regards,
Karsten

Karsten Merker (2):
  Input: goodix - add dt axis swapping and axis inversion support
  Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"

 drivers/input/touchscreen/goodix.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

-- 
2.1.4

