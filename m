From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [v4 6/6] HID: lg4ff - Document sysfs interface for range setting
Date: Thu, 04 Aug 2011 16:27:18 +0200
Message-ID: <1888132.MMzf1G0PX3@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48581 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab1HDO1W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2011 10:27:22 -0400
Received: by fxh19 with SMTP id 19so1801628fxh.19
        for <linux-input@vger.kernel.org>; Thu, 04 Aug 2011 07:27:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, simon@mungewell.org

(Hopefully) fixed wordwrapping

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff =
b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
new file mode 100644
index 0000000..167d903
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
@@ -0,0 +1,7 @@
+What:		/sys/module/hid_logitech/drivers/hid:logitech/<dev>/range.
+Date:		July 2011
+KernelVersion:	3.2
+Contact:	Michal Mal=FD <madcatxster@gmail.com>
+Description:	Display minimum, maximum and current range of the steerin=
g
+		wheel. Writing a value within min and max boundaries sets the
+		range of the wheel.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
