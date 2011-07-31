From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: PATCH [6/6] HID: lg4ff - Document sysfs interface for range setting
Date: Sun, 31 Jul 2011 03:18:34 +0200
Message-ID: <7818673.UX420zEQaF@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42883 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab1GaBSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 21:18:37 -0400
Received: by fxh19 with SMTP id 19so3417012fxh.19
        for <linux-input@vger.kernel.org>; Sat, 30 Jul 2011 18:18:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, simon@mungewell.org

Adds documentation of the sysfs interface used to set the wheel range

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
