From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 0/4] HID: magicmouse: improve scrolling
Date: Wed,  2 Jun 2010 10:28:24 -0400
Message-ID: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51369 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab0FBO2c (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 10:28:32 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OJovm-0003G0-TL
	for <linux-input@vger.kernel.org>; Wed, 02 Jun 2010 15:28:30 +0100
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1OJovm-0005F6-Ka
	for linux-input@vger.kernel.org; Wed, 02 Jun 2010 15:28:30 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I love my Magic Mouse, and Michael Poole did a great job creating a new
driver for it in Linux. However, the scrolling behavior in Linux has
been a pet peeve of mine. I am proposing a few patches to change the
behavior in the following ways:

* Scroll on entire surface of mouse instead of an artificial "middle"
  area.
* Fix up a scroll state math issue (trivial).
* Add a param for enabling scroll acceleration, but disable it by
  default. It's unique to magicmouse I believe, and isn't intuitive.
* Add a param for scroll speed (i.e. distance a touch needs to travel on
  the surface to produce a WHEEL event). Clean up acceleration code as
  well because it is tightly integrated with the speed logic.

After these four patches, setting scroll_speed to 48, and setting
ConstantDeceleration to 2 in xorg.conf, I have found my mouse to be much
better.

Thanks,

-- Chase

 drivers/hid/hid-magicmouse.c |   49 +++++++++++++++++++++++++++++------------
 1 files changed, 34 insertions(+), 15 deletions(-)
