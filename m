From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] hid: Remove "default m" from HID_LOGITECH_DJ
Date: Sun, 2 Sep 2012 21:43:52 -0700
Message-ID: <20120903044351.GA1590@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58585 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab2ICEn6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Sep 2012 00:43:58 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

HID_LOGITECH_DJ uses "default m", which enables it in default kernel
builds.  Since this module just enables extra, non-critical
functionality for one particular piece of hardware (specifically,
differentiating multiple wireless keyboards and mice as separate input
devices rather than treating them as one device), and the hardware works
just fine with the default USB HID support, drop the "default m".

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/hid/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index fbf4950..d004528 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -307,7 +307,6 @@ config HID_LOGITECH
 config HID_LOGITECH_DJ
 	tristate "Logitech Unifying receivers full support"
 	depends on HID_LOGITECH
-	default m
 	---help---
 	Say Y if you want support for Logitech Unifying receivers and devices.
 	Unifying receivers are capable of pairing up to 6 Logitech compliant
-- 
1.7.10.4

