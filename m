Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B333242AA;
	Fri, 20 Feb 2026 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581840; cv=none; b=WhOCM0QeY2x/31zqJ5ZgAWijpY7F4BIUuEv4F+E0xV4xqXLMmwq/+WqQdIIBZ/t6k34H0pt2RTvpf9qYBN1FEPJyGe/nR/5yLn6QXnKpRo0tefE7wLufGvC6hWSugUAqztMFnEhAOdy/7U9A7o2eO9OaqbO0UDPhCDxiu7AIgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581840; c=relaxed/simple;
	bh=EpsesNMCa9nFH8JHaVA5GClws47ka4WXLb/3sZjIvIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oilkZMyMjwYhgNM7KVosQIy8WXMkYNXaT/QlEgNeek8CAGmYtfmcltuqpRN4KXL6kT1vJq0iqb52toHqVAb7PAmzDx6UfsRWWSXy46nMaDnUNlIQQIQk95mf4TixsLIhnXslkwfK3preYawogCC8nXI7cr6mwJMQ4R0k7xv5XSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=SvlAQuMj; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="SvlAQuMj"
Received: from tguttzeit-tuxedo.fritz.box (ip5f5bfe92.dynamic.kabel-deutschland.de [95.91.254.146])
	(Authenticated sender: t.guttzeit@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 103092FC004A;
	Fri, 20 Feb 2026 11:03:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1771581829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KWRWtkwNUcyCkwW3JMhoWxTHzO01lUYD2PP7BUWwCGg=;
	b=SvlAQuMjEG5+++UqL6dZGSAdez8OsZo4qgLFnYVArSAmLGKcySY8NT+cvIwJ7oBI2OTMMT
	drDj1eRfUU+IWiXQYlMSa1Q3/76bM9VEO2AkHySHjnipQlghejLFyfgc9kqxBWhdOJnMOD
	KmIthD+LVv4bMobQugHjpDCSYFLy0hs=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=t.guttzeit@tuxedocomputers.com smtp.mailfrom=tgu@tuxedocomputers.com
From: Tim Guttzeit <tgu@tuxedocomputers.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: wse@tuxedocomputers.com,
	Tim Guttzeit <tgu@tuxedocomputers.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: generic: fix build when LEDS_CLASS_MULTICOLOR is disabled
Date: Fri, 20 Feb 2026 11:03:17 +0100
Message-ID: <20260220100325.133327-1-tgu@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building HID generic with LampArray support enabled caused link
failures when LEDS_CLASS_MULTICOLOR was disabled, due to unresolved
led_classdev_multicolor_* and led_mc_* symbols.

hid-lamparray.o was built whenever HID_GENERIC was enabled,
regardless of LED multicolor support.

Introduce CONFIG_HID_LAMPARRAY with dependencies on HID_GENERIC &&
LEDS_CLASS && LEDS_CLASS_MULTICOLOR and build hid-lamparray.o only
when enabled. Provide stub helpers so hid-generic.c builds cleanly
when the option is disabled.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202602200233.9Bwav9tZ-lkp@intel.com/
Link: https://lore.kernel.org/oe-kbuild-all/202602200241.6ypuWvE5-lkp@intel.com/
Link: https://lore.kernel.org/oe-kbuild-all/202602192025.xrvVo680-lkp@intel.com/
Link: https://lore.kernel.org/oe-kbuild-all/202602192131.Q9y8Kqvt-lkp@intel.com/

Changes in v2:
  - Add CONFIG_HID_LAMPARRAY with proper dependencies
  - Build hid-lamparray.o only when enabled
  - Add stub helpers when disabled
  - Fix build failures reported by kernel test robot

Signed-off-by: Tim Guttzeit <tgu@tuxedocomputers.com>
---
 drivers/hid/Kconfig         | 10 ++++++++++
 drivers/hid/Makefile        |  3 ++-
 drivers/hid/hid-generic.c   |  4 ++--
 drivers/hid/hid-lamparray.h | 25 ++++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 920a64b66b25..91547dfa5661 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -92,6 +92,16 @@ config HID_GENERIC
 
 	If unsure, say Y.
 
+config HID_LAMPARRAY
+	bool "HID LampArray helper"
+	depends on HID_GENERIC && LEDS_CLASS && LEDS_CLASS_MULTICOLOR
+	default y
+	help
+	Helper for HID devices exposing a Lighting/LampArray collection.
+	Treats LampArray devices as a single-zone device and exposes a sysfs
+	interface for changing color and intensity values. Also exposes a
+	sysfs flag to be disabled e.g. by a userspace driver.
+
 config HID_HAPTIC
 	bool "Haptic touchpad support"
 	default n
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index e6903be9c4df..5a14b4b0970d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -12,7 +12,8 @@ obj-$(CONFIG_HID)		+= hid.o
 obj-$(CONFIG_UHID)		+= uhid.o
 
 obj-$(CONFIG_HID_GENERIC)	+= hid-generic.o
-obj-$(CONFIG_HID_GENERIC)	+= hid-lamparray.o
+
+obj-$(CONFIG_HID_LAMPARRAY) += hid-lamparray.o
 
 hid-$(CONFIG_HIDRAW)		+= hidraw.o
 
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index 650c2121b403..57b81c86982c 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -77,7 +77,7 @@ static int hid_generic_probe(struct hid_device *hdev,
 	 * Optional: attach LampArray support if present.
 	 * Never fail probe on LampArray errors; keep device functional.
 	 */
-	if (lamparray_is_supported_device(hdev)) {
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && lamparray_is_supported_device(hdev)) {
 		const struct lamparray_init_state init = {
 			.r = 0xff,
 			.g = 0xff,
@@ -108,7 +108,7 @@ static void hid_generic_remove(struct hid_device *hdev)
 {
 	struct lamparray *la = hid_get_drvdata(hdev);
 
-	if (la)
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
 		lamparray_unregister(la);
 
 	hid_hw_stop(hdev);
diff --git a/drivers/hid/hid-lamparray.h b/drivers/hid/hid-lamparray.h
index b786ca00c404..ac3edd366a5b 100644
--- a/drivers/hid/hid-lamparray.h
+++ b/drivers/hid/hid-lamparray.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/leds.h>
 #include <linux/err.h>
+#include <linux/errno.h>
 
 struct hid_device;
 struct lamparray;
@@ -21,6 +22,8 @@ struct lamparray_init_state {
 	enum led_brightness brightness;
 };
 
+#if IS_ENABLED(CONFIG_HID_LAMPARRAY)
+
 /**
  * lamparray_is_supported_device() - check whether a HID device supports LampArray
  * @hdev: HID device to inspect
@@ -65,4 +68,24 @@ struct lamparray *lamparray_register(struct hid_device *hdev,
  */
 void lamparray_unregister(struct lamparray *la);
 
-#endif
+#else /* !CONFIG_HID_LAMPARRAY */
+
+static inline bool lamparray_is_supported_device(struct hid_device *hdev)
+{
+	return false;
+}
+
+static inline struct lamparray *
+lamparray_register(struct hid_device *hdev,
+		   const struct lamparray_init_state *led_init_state)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void lamparray_unregister(struct lamparray *la)
+{
+}
+
+#endif /* CONFIG_HID_LAMPARRAY */
+
+#endif /* _HID_LAMPARRAY_H */
-- 
2.43.0

