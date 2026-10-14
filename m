Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3C41F5D7
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954822; cv=none; b=TEUNR73IsMrJmbFmR0AEULRWtITgHbFujj5v0gwD7kQAKqTp7H5yFqnhXK2gg9x93qmsSrwX1fc4YwrHO4kKvF6iJ+J3MyV2fGsfxUDIEpOK1hW804UCmotCZxvUKdmgqU7hvRXdQpkc4ho7qCvB8plhLx5ZfYNC9xMWW2TPT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954822; c=relaxed/simple;
	bh=rpdjqRPo/nMEF5LGfSaxzBsb4+u1UPgA0QiSwAqrJHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGXVU75d7B+o3drL/bJmv5NnxzZG2cUH+DmhC2NTm7GZ/DCUosIbbZbOMY5zvuzWjY/SyT8buBEQyVAZ/UlFtASGtIigp8OaeS6MMTnsC1sEz5iuED0tz/yHsgXPyTbW5ZcMbUGsyFQXBFZrqXrkVizY+GerVjiMjvXS3SEGADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp8zSGpN; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp8zSGpN"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so835452eec.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791954820; x=1792559620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6B8ArzIo9Bbqhd/pBaN1TCTzyJMvGcjD8xg/cTLGFCA=;
        b=fp8zSGpN09mZdm4jVPz448xjU8ePB9n3RMlv45zFAAhWjtXph3gXDnVqp4P33syAtg
         0r8rQMK5mLVPKo5ki+gFjHld7tZMV+dOHfobCYG2PeNBRhMW7kbLWcPYPCOTgi1DmdNy
         8MNnKm9Y+p9AHJeMxGNPWx4nLgN0DL4WOmJ4VORcbaoBOCnC+O3jIsSP2Kl8kjks2bR3
         czkYpr4WjjalGoiVkzIy4rVJERCbJ7BnUNoWnD98kH9s5JoFQgmp6oNvSv+D5/MspryD
         iVXyvdgcosyPPtelTTx4zTzAPHIbK0s2OqqDBdrBNw6q5jcTOpiz0VKnqnbyHSxAVN34
         CQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791954820; x=1792559620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6B8ArzIo9Bbqhd/pBaN1TCTzyJMvGcjD8xg/cTLGFCA=;
        b=e5a03o+yuT/SUwWsvo750cNtJpUnGSEC5hFyq98Nsp1nK+pB1HnaeoGLWECuHfY+NW
         mZyI+ZCUaC2T2GEYJ/AVMWT6yuIN7k4duSKsWWUpkv25tLboss5hO61wq71l77R91T8T
         fQJx7jcskdXHfl05Dt/3VN9T7MgOOZOsUoifd3twRzRppk5JRcoSDtoI9w1xd4YnQBbl
         9M86JrwF09OOzkNW5r1uD4xCObHjM+Nt5/AGobsvikUY1blAN7PUVEoHLFHwcdO6RSx9
         13P9iI4TRCufFw+RGWkySumExmuNbgWVW+X/Vczy7l06RckJiMtg/qpBOg3v989Iq9Hb
         YIrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhADiCTwjbk75h2udbOI1YuREJHfy7nhrKzcI/RnyhDwBauOtyz1b5eR8tynVvUn+Ce70LY9JBLsHIvw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKq/mcHPD6RSSKqAXOCi+hFtTsFy5usdXx3Kud+VcMgv349Z+tb
	bXZz0yjWuDQDl1q/CUVO5sXWIPrAIUu9u783Ee7rucADRo8FYe0YGcCO
X-Gm-Gg: AYBFou0mC8qwe+mN01k3d0XklS6SJxBmwZM1x9WGGUScojsd9EQTyqzSubwSl9bDRv9
	GeDhPvDChI2hf8V7z2f2CHY3cMr2CIqoM1LMtB0PzuwnR/1lkpFY4S1GqUXUh8eb3/3zX777EMS
	IAGtkmj0jq955VaVpzb6Fi4j/hqjQXxL+LaMOPEfu32mleZv4b6db017zaq8wZwKn5KNOM1bk5x
	3SJBussUaAKyKwKDQxm/5Z3IgcJ2Nly5pwkl/q049tX6Yzzq59Nvs8aRqbpOnJwTj65JqOYWySp
	U5gsGGxCzv3eqXhpH1w/RiAW7ubauZtK37tkrFHdoEP40tnIcbxO28RbFxAJ54ODEUv81u0csIg
	WbswAQTalsrg2RkUokz3/+OdOJdlXQPo+9a4y8h6xg5b7m6EPBlK78Rk1kGl6IvmGsb7VrqMCYk
	Eopv04l2oUvCGQ6yobZlGXOKxmNSUncOiM2JAq2W2c8wZ/uMiCPjwHGW1k8TLFO6jjbzgq4eWwr
	no/oXp03fqS6pkLiOGGjLQNuSFIozZYRSyePMIqIEt6n7wzjZZMwVFm2SEKxbkhx776cD7GeA==
X-Received: by 2002:a05:7300:8803:b0:353:7b46:4819 with SMTP id 5a478bee46e88-3537e032905mr24065867eec.8.1791954819617;
        Tue, 13 Oct 2026 22:13:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm51629125eec.21.2026.10.13.22.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:13:38 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Rishi Gupta <gupt21@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Andrej Shadura <andrew@shadura.me>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] HID: hidraw: Make hidraw.h private to HID subsystem
Date: Tue, 13 Oct 2026 22:13:25 -0700
Message-ID: <20261014051326.3784498-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
References: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all external consumers converted to use the hidraw instance helper,
hidraw.h no longer needs to be exposed in include/linux.

Move the header into drivers/hid, keep private buffer and list
structures internal to hidraw.c, and drop unneeded symbol exports
since hidraw and hid-core are built into the same module.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c                  |  2 +-
 drivers/hid/hid-cp2112.c                |  2 +-
 drivers/hid/hid-led.c                   |  2 +-
 drivers/hid/hid-u2fzero.c               |  2 +-
 drivers/hid/hidraw.c                    | 33 ++++++++++++++++++++++---
 {include/linux => drivers/hid}/hidraw.h | 29 +---------------------
 6 files changed, 34 insertions(+), 36 deletions(-)
 rename {include/linux => drivers/hid}/hidraw.h (63%)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c430f2d0d779..a5d03504c061 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -31,10 +31,10 @@
 #include <linux/hid.h>
 #include <linux/hiddev.h>
 #include <linux/hid-debug.h>
-#include <linux/hidraw.h>
 
 #include "hid-core.h"
 #include "hid-ids.h"
+#include "hidraw.h"
 
 /*
  * Version Information
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 148946b04bff..0f65ce44e677 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -20,7 +20,6 @@
 #include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -28,6 +27,7 @@
 #include <linux/string_choices.h>
 #include <linux/usb/ch9.h>
 #include "hid-ids.h"
+#include "hidraw.h"
 
 /**
  * enum cp2112_child_acpi_cell_addrs - Child ACPI addresses for CP2112 sub-functions
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index 63fd723d9e69..f5a798c7979e 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -8,12 +8,12 @@
  */
 
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 
 #include "hid-ids.h"
+#include "hidraw.h"
 
 enum hidled_report_type {
 	RAW_REQUEST,
diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index 83e223c12cd6..4b9271b4e45e 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/hw_random.h>
 #include <linux/leds.h>
 #include <linux/module.h>
@@ -21,6 +20,7 @@
 
 #include "usbhid/usbhid.h"
 #include "hid-ids.h"
+#include "hidraw.h"
 
 #define DRIVER_SHORT		"u2fzero"
 
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 949e7546339f..9d0df711ed5d 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -27,8 +27,36 @@
 #include <linux/mutex.h>
 #include <linux/sched/signal.h>
 #include <linux/string.h>
+#include <uapi/linux/hidraw.h>
+
+#include "hidraw.h"
+
+struct hidraw {
+	unsigned int minor;
+	int exist;
+	int open;
+	wait_queue_head_t wait;
+	struct hid_device *hid;
+	struct device *dev;
+	spinlock_t list_lock;
+	struct list_head list;
+};
+
+struct hidraw_report {
+	__u8 *value;
+	int len;
+};
 
-#include <linux/hidraw.h>
+struct hidraw_list {
+	struct hidraw_report buffer[HIDRAW_BUFFER_SIZE];
+	int head;
+	int tail;
+	struct fasync_struct *fasync;
+	struct hidraw *hidraw;
+	struct list_head node;
+	struct mutex read_mutex;
+	bool revoked;
+};
 
 static int hidraw_major;
 static struct cdev hidraw_cdev;
@@ -594,7 +622,6 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 	wake_up_interruptible(&dev->wait);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hidraw_report_event);
 
 int hidraw_connect(struct hid_device *hid)
 {
@@ -651,7 +678,6 @@ int hidraw_connect(struct hid_device *hid)
 	return result;
 
 }
-EXPORT_SYMBOL_GPL(hidraw_connect);
 
 void hidraw_disconnect(struct hid_device *hid)
 {
@@ -663,7 +689,6 @@ void hidraw_disconnect(struct hid_device *hid)
 
 	up_write(&minors_rwsem);
 }
-EXPORT_SYMBOL_GPL(hidraw_disconnect);
 
 /**
  * hidraw_instance - get hidraw instance minor number for a HID device
diff --git a/include/linux/hidraw.h b/drivers/hid/hidraw.h
similarity index 63%
rename from include/linux/hidraw.h
rename to drivers/hid/hidraw.h
index 3021454ba513..a822007ce5f8 100644
--- a/include/linux/hidraw.h
+++ b/drivers/hid/hidraw.h
@@ -6,35 +6,8 @@
 #define _HIDRAW_H
 
 #include <linux/errno.h>
-#include <uapi/linux/hidraw.h>
 
-
-struct hidraw {
-	unsigned int minor;
-	int exist;
-	int open;
-	wait_queue_head_t wait;
-	struct hid_device *hid;
-	struct device *dev;
-	spinlock_t list_lock;
-	struct list_head list;
-};
-
-struct hidraw_report {
-	__u8 *value;
-	int len;
-};
-
-struct hidraw_list {
-	struct hidraw_report buffer[HIDRAW_BUFFER_SIZE];
-	int head;
-	int tail;
-	struct fasync_struct *fasync;
-	struct hidraw *hidraw;
-	struct list_head node;
-	struct mutex read_mutex;
-	bool revoked;
-};
+struct hid_device;
 
 #ifdef CONFIG_HIDRAW
 int hidraw_init(void);
-- 
2.56.0.385.gd3acb90ef8-goog
