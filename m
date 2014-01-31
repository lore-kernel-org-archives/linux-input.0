From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 5/6] HID: Add the HIDIOCGRAWCLIENTADDR ioctl to the hidraw documentation
Date: Fri, 31 Jan 2014 12:32:52 -0500
Message-ID: <1391189573-2591-6-git-send-email-frank.praznik@oh.rr.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:52176 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbaAaRdE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 12:33:04 -0500
In-Reply-To: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add the HIDIOCGRAWCLIENTADDR ioctl to the hidraw documentation.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 Documentation/hid/hidraw.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/hid/hidraw.txt b/Documentation/hid/hidraw.txt
index 029e6cb..737fd1f 100644
--- a/Documentation/hid/hidraw.txt
+++ b/Documentation/hid/hidraw.txt
@@ -93,6 +93,11 @@ For USB devices, the string contains the physical path to the device (the
 USB controller, hubs, ports, etc).  For Bluetooth devices, the string
 contains the hardware (MAC) address of the device.
 
+HIDIOCGRAWCLIENTADDR(len): Get Client Address
+This ioctl returns a string representing the client address of the device.
+For Bluetooth devices, the string contains the hardware (MAC) address of the
+device.  For USB devices, the returned string is always 00:00:00:00:00:00.
+
 HIDIOCSFEATURE(len): Send a Feature Report
 This ioctl will send a feature report to the device.  Per the HID
 specification, feature reports are always sent using the control endpoint.
-- 
1.8.5.3

