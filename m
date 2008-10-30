From: Oliver Neukum <oliver@neukum.org>
Subject: proposal on runtime power management in hid
Date: Thu, 30 Oct 2008 17:03:59 +0100
Message-ID: <200810301704.01005.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:45774 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbYJ3QEB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2008 12:04:01 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri Slaby <jslaby@suse.cz>, linux-pm@vger.kernel.org

Hi,

I am looking at runtime power management for usb hid devices.
There's a problem with hidraw. As we have no idea, what goes
on between a device and users of hidraw, it seems to me that
such a device should not be subject to runtime power management
without the user's explicit agreement.
But that would be only a kludge. Therefore this is my first draft of
an API to cleanly allow this.

It is based on telling drivers what capabilties a device must provide
to the system, allowing the driver to use the most aggressive runtime
power management compatible with the requirement.
Comments?

	Regards
		Oliver

diff --git a/include/linux/hid.h b/include/linux/hid.h
index ea80380..9b886c5 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -602,6 +602,12 @@ struct hid_driver {
  * @parse: this method is called only once to parse the device data,
  *	   shouldn't allocate anything to not leak memory
  */
+
+#define HID_POWER_LEVEL_NONE		0
+#define HID_POWER_LEVEL_WAKEUP		1
+#define HID_POWER_LEVEL_OPERATING	2
+#define HID_POWER_LEVEL_ON		3
+
 struct hid_ll_driver {
 	int (*start)(struct hid_device *hdev);
 	void (*stop)(struct hid_device *hdev);
@@ -613,6 +619,7 @@ struct hid_ll_driver {
 			unsigned int code, int value);
 
 	int (*parse)(struct hid_device *hdev);
+	int (*pctrl)(struct hid_device *hdev, int level);
 };
 
 /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
