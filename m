Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC946AA76
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190526; cv=none; b=CVifnL/grjNp1GpLhBRpJLa1mWiJPlJ/o3UEGmuHX1eujihYE2hOxnVPuvp97hPlAav9h6G8tQc5oNAD7ZWbWHwyVZ15LNpIF9x6m7PkvjKZUrQIIscvm7ksulf27VJfdzW0B7XjL3v6pAuRVoJjUmPM1y8y9ibVzm5u3i2AseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190526; c=relaxed/simple;
	bh=WzorpVk9chapWpwOob8GI582boBmat7YJhHyMjbooXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpMEe+LGHB4H6/MR2U+ASVXnYZowX3tqDl7VpV4XXhDVFlK6Px8pz5i8zPgdU9bpQy5ff4RDusuKQCclK9fwQzZg/4OiTj+TAeR05xwKIZmSLFlBgntUayT6Cf/ugoQtjz7l2lpyjHEyUW23U/U+PbIsd6vGlfIsqHuJ8k+GKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqgtXGqt; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqgtXGqt"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30b6dad2382so1142949eec.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792190524; x=1792795324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxQ3juOVRNgpkeTcscN809epa+8Mjh4WA2LpDZqjj3A=;
        b=VqgtXGqtH/e92bl1UBv7Jmagt6vwQ4CWpFA8nPR5hnebRj1t/ZwPA2ez2pgfdvntOP
         Z5HqoiY/ijUTvvqjdQ67VaRtb0ILb/oEL0YtD+f/VDNbG/XdOBoalguOj/KLzoNhB+QA
         8nJPgSFgYVAABMk/vqeoKCGoZZz3suvddQpGSv4ERA6hyVYP2TA0/kpdN3HTeenZ6k0k
         XCn99w5zP7Wdv5t2hQuy5dQgmqAGiR++6xll/Ao6NhS/WjufgILY9hy9DlgGOvDGM6q/
         Ap0uYqdU2m0n0fnSzTSZUraJeraavf+j5ykAI9P2JWN5CY5XE1wRpY+GsoxpR6Gv56cT
         smZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792190524; x=1792795324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxQ3juOVRNgpkeTcscN809epa+8Mjh4WA2LpDZqjj3A=;
        b=nJtjo56kQ9T74M01hmVps156bD30CP13WCBaGo5hTR8dP3j31Hn+u964qCDD0VQsMj
         y4p6jvifQqGZMzvsrmnWuoDt5CW+DbYTZf0JGS97vfM4Jo2m1W6FpzTbeEaQHORFzKik
         k2lkvDFZlDFXi6lFHHEzhZatntpDkriBOPfGNI75ZQSh4brGL2fgrPli7fUjO1KxNWhh
         U2VGHWaV/7GK92z7bXi16RkP3IFjFyoMup6UxOqQr1ZD6wvHtulOIVaX7Ex2ohs7Ud3D
         cVUwsH81Ee3C9+jb+jlqNolxfOZJJkdKcFkDmbgktdlcqYAJOIrAVubDc8d9eaptSNy+
         P2lw==
X-Forwarded-Encrypted: i=1; AKwUvBwutLyM91K+X7mxKs9CUOsRsjgFhVb4XuB4ChBIStnt46+72sc7s/vZbMpzHPEtHDceO7LeF1MdFQhG2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIs/oJ2+9Y4ZipDMmXKaweJnrMGotcyAIt8q9wgiXw4i3Jxn93f
	O4au1pOeUDg8AInvsTec2sril/LGYO65JHR7MOtQKXouRdHvyHynid/c
X-Gm-Gg: AYBFou00ito+QDC9GOE1g3HUIOyyzEW4n88NyaoAeSB4JAlQACiTghcFA9FJz1x1Ohk
	pxKieVnwvNm5QvPnAsfIvAjYb6CWeI22sT2otTbByIV0Z7wIGs6ahE8pKiFnQl3bwbPGZ5apuIS
	TXII/cJq5aBgcT98v4EY7p/Ymylzw/fhZn1+LNLAlnDYrLWtwSfjZxlh9m0k+OtTzT8dkN8wmhR
	38TZv9BYZZsY6RuMFtAF2X0Us1chu9btkGmA1nX/QbdJP1DBFI+28F+DMMrQCt3dZlqWuZOpTp9
	QvlIgFBHyoMRkliUkbbEczLgHHypoNGrQI347dPiu8+8Q8niDXME56AwpD0VvXjXIQMUIEz3Ssc
	UsiXn6P2L5oR5jFvtsaMhfaGg69LaT1nI7KaYMyWc4fu3V5Hskh4Tzh8gnZCwc1i0ecB+A68gbf
	SbHSs6zaSAJxARbQG6rB5VV+LZIc6xqqefYNSua2kDZa3h7dZZDg2cNBn7RKHP4Z/xIVOLfNEut
	v9PMwAfl5pWT3tE15jZyqOxbgHjqldfuxscvYJ1bYy6XxzARSIjen0O1CVdD/0=
X-Received: by 2002:a05:701b:450f:10b0:185:33ab:4d55 with SMTP id a92af1059eb24-18533ab4e84mr1428104c88.29.1792190524384;
        Fri, 16 Oct 2026 15:42:04 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:34f0:f27d:9a5d:56e0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm8252348c88.21.2026.10.16.15.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:42:02 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 16 Oct 2026 15:41:48 -0700
Subject: [PATCH v2 1/5] HID: core: Move internal declarations and drop
 unused exports
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-test-hidraw-base-v2-1-153f67a20cad@gmail.com>
References: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
In-Reply-To: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Michael Zaidman <michael.zaidman@gmail.com>, Rishi Gupta <gupt21@gmail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Andrej Shadura <andrew@shadura.me>, 
 Johannes Roith <johannes@gnu-linux.rocks>, linux-input@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Several declarations in the public HID header and exported symbols are
used solely within the core HID module (linked together from hid-core,
hid-input, and hid-quirks into hid.o).

Move internal request, input hook, resolution multiplier, and device
matching declarations into a private header shared across core HID
sources, and drop the unused GPL symbol exports.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c   |  3 +--
 drivers/hid/hid-core.h   | 20 ++++++++++++++++++++
 drivers/hid/hid-input.c  |  4 +---
 drivers/hid/hid-quirks.c |  1 +
 include/linux/hid.h      |  8 --------
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ec7c2860c93e..e2944dbdc9e6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -33,6 +33,7 @@
 #include <linux/hid-debug.h>
 #include <linux/hidraw.h>
 
+#include "hid-core.h"
 #include "hid-ids.h"
 
 /*
@@ -1249,7 +1250,6 @@ void hid_setup_resolution_multiplier(struct hid_device *hid)
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(hid_setup_resolution_multiplier);
 
 static int hid_parse_collections(struct hid_device *device)
 {
@@ -2038,7 +2038,6 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(__hid_request);
 
 int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
 			 size_t bufsize, u32 size, int interrupt)
diff --git a/drivers/hid/hid-core.h b/drivers/hid/hid-core.h
new file mode 100644
index 000000000000..653bf0f32f94
--- /dev/null
+++ b/drivers/hid/hid-core.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __HID_CORE_H
+#define __HID_CORE_H
+
+#include <linux/hid.h>
+
+int __hid_request(struct hid_device *hid, struct hid_report *report,
+		  enum hid_class_request reqtype);
+
+int hidinput_connect(struct hid_device *hid, unsigned int connect_mask);
+void hidinput_disconnect(struct hid_device *hid);
+void hidinput_hid_event(struct hid_device *hid, struct hid_field *field,
+			struct hid_usage *usage, __s32 value);
+void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
+
+void hid_setup_resolution_multiplier(struct hid_device *hid);
+bool hid_match_one_id(const struct hid_device *hdev,
+		      const struct hid_device_id *id);
+
+#endif /* __HID_CORE_H */
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index edd6bbf8342b..d7213f1c417c 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -20,6 +20,7 @@
 #include <linux/hid.h>
 #include <linux/hid-debug.h>
 
+#include "hid-core.h"
 #include "hid-ids.h"
 
 #define unk	KEY_UNKNOWN
@@ -1805,7 +1806,6 @@ void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
 	list_for_each_entry(hidinput, &hid->inputs, list)
 		input_sync(hidinput->input);
 }
-EXPORT_SYMBOL_GPL(hidinput_report_event);
 
 static int hidinput_find_field(struct hid_device *hid, unsigned int type,
 			       unsigned int code, struct hid_field **field)
@@ -2447,7 +2447,6 @@ int hidinput_connect(struct hid_device *hid, unsigned int connect_mask)
 
 	return -1;
 }
-EXPORT_SYMBOL_GPL(hidinput_connect);
 
 void hidinput_disconnect(struct hid_device *hid)
 {
@@ -2469,7 +2468,6 @@ void hidinput_disconnect(struct hid_device *hid)
 	 * synchronously and are safe. */
 	cancel_work_sync(&hid->led_work);
 }
-EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
 void hidinput_reset_resume(struct hid_device *hid)
 {
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 96a36c5ba04f..e885ce3f3a14 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/input/elan-i2c-ids.h>
 
+#include "hid-core.h"
 #include "hid-ids.h"
 
 /*
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c..4b58e9b4ae43 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1021,10 +1021,6 @@ extern void hid_unregister_driver(struct hid_driver *);
 	module_driver(__hid_driver, hid_register_driver, \
 		      hid_unregister_driver)
 
-extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct hid_usage *, __s32);
-extern void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
-extern int hidinput_connect(struct hid_device *hid, unsigned int connect_mask);
-extern void hidinput_disconnect(struct hid_device *);
 void hidinput_reset_resume(struct hid_device *hid);
 
 struct hid_field *hid_find_field(struct hid_device *hdev, unsigned int report_type,
@@ -1038,7 +1034,6 @@ struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
 __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
 void hid_output_report(struct hid_report *report, __u8 *data);
-int __hid_request(struct hid_device *hid, struct hid_report *rep, enum hid_class_request reqtype);
 u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
 struct hid_device *hid_allocate_device(void);
 struct hid_report *hid_register_report(struct hid_device *device,
@@ -1050,13 +1045,10 @@ struct hid_report *hid_validate_values(struct hid_device *hid,
 				       unsigned int field_index,
 				       unsigned int report_counts);
 
-void hid_setup_resolution_multiplier(struct hid_device *hid);
 int hid_open_report(struct hid_device *device);
 int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
 void hid_disconnect(struct hid_device *hid);
-bool hid_match_one_id(const struct hid_device *hdev,
-		      const struct hid_device_id *id);
 const struct hid_device_id *hid_match_id(const struct hid_device *hdev,
 					 const struct hid_device_id *id);
 const struct hid_device_id *hid_match_device(struct hid_device *hdev,

-- 
2.56.0.176.g3575e65682-goog

