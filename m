Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F936342177
	for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510434; cv=none; b=IbwtWLspFD/XTB3wwd4O2/Y79kDYrJ8KPxIUZLuLymrAmKB4bsep9QtUYypQ3i/7JX/h8kO31MQ5r0tz8Uzqpy1PttdsaCOWWINvFokB4NZRb6wYG2cZZK6lAoPcsVAfcwjt3mK/NpMXd9rD5Wz13cjIePOzvDrNU7vAjzZ37K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510434; c=relaxed/simple;
	bh=Hrnazuahv2v9rpFCsMEJC0zgdKheqCVmhgytvsJwNK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHiV5qdC6mKQlU1xF3aFD6tKUsd47JpIgt4rX7Xg6X6UN2tLzOWDtOjMKEXt0Gu4gazJ8akuyBH5Iqougcjaxh1G9Z8sR6hLTtdny2aGQjBkUAeOY/k2xQsWkNytJLA5IpjreaLFWO1lSqVgUfypwOwtKL2M5HZE7X4pgVVAdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiiPqSwh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiiPqSwh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823075fed75so3068866b3a.1
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 02:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769510432; x=1770115232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMAB5C1zkD/DVWLKDv3RV0IL8z1Pp7D3kuyKzpTCHnM=;
        b=RiiPqSwhBk8BCVPYmf67hAC1uW9PC0gf9QVZTFC1vDiR3wWmPO9viO8DTcyBpPAPhj
         VYn/A38jy938i/gVBKI/Zic+IYBfpVlwFairMDqo/FZ7k0H4F7XTgk/8DSCx+i76SCnA
         Dluybrx0fd14Lo0Se7zeVvzPK6fEosG17+cq09C6nQqKQ76Bfntj0X34yTDc4CbWciXC
         rUGgh3fuybL9WaoHin4OVnOzuVM6VHZ652+W8H0JMqGlc1gh9Srb08juEAFn4Cfiairk
         Mj9mSLe69nV1DxPtqLvSO5W6iAq7rOrsib8kT6i7hWAuNCF8dpZQ8EOFK9UIlQlFTGDF
         f18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510432; x=1770115232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMAB5C1zkD/DVWLKDv3RV0IL8z1Pp7D3kuyKzpTCHnM=;
        b=SZer7j5SAm/i6c4lPgbSJDlmZeOUu+a2nmP/NaqXlOYPOAmCNemgHx3NGYb3cr3Yzr
         cw2L37mJ9wVx6glmZsEb6d9wAP7HP1HZGEiY9/rb+LHtg99buSC6FbDL04rGmzH8zVfs
         TCFkUZQ8t1VpqzOtiSgfsDgAr+uqfS8UCW0nTMKHYMbhedERPKMh6nKn14w5qYqQ9U62
         6wuXO01KM8LwnW0hfUiVYNv7eUuzEHleDv2dnc09+dtrTXk4I7Ff0M5IS+cuPBzXqlN3
         JFdy4WkBgF/k/eAL6zvsKT2E9wwj6csQKpyMEz4nzFn9FL6G5b6U1o0+3j5fMIVRAScM
         scGw==
X-Gm-Message-State: AOJu0YzYqNdYnBTVP9McrEqXDpd6GrSRtLic2iXRqC142tn7p5DdCxb+
	e57LDBDf6g8QgI85blm6zNlgWyy6Yl5P8GeLi0Bs03bywZWXtGUEotDe
X-Gm-Gg: AZuq6aL/0K6VUAYhbrUcgokOXlmCmTsSYLoy0uNawjh7oniKb/cQVP7hLaeanu5+G++
	A++a5zsgSELpqG9UdYcajIOts/+G5W2yHhfjtFAq/l2vgfjPUUu/NnE6pabq8lV8bPASHvmN1kq
	SdSoPxp3FaPTIrBhj/uDds5Ze92JEsqOWwVT4jpQLJ1U8KPF9iKcPQSswjilphQwdp3pqfLPuFO
	tkZQwrwZZq0+GBiE9ejO/aji9K3s6ESppEuTJXZHHJ0ySI1KCINRK1wZloV0+el+MXrpj7EYLhx
	8XNZiLp/irClJ27a1iK5h2U45Gc7C54oJa4ekVGqTlHi9O1Um0/JvAK11/KQmJQhJuv0iGz6DHg
	JGbR69Ccsk0S7C/EW3XiKNIepjHMaL64J8hpTx8IbCG2LS0ZcMF2D/oOPKI3+2dI+kiz80qvlbg
	WJssUdf/xu4ZsdOl7M1PuzbK9xQtDMCOOHuTygxQ==
X-Received: by 2002:a05:6a00:c91:b0:7a2:7058:ab89 with SMTP id d2e1a72fcca58-8236a14a9d4mr1288694b3a.7.1769510432512;
        Tue, 27 Jan 2026 02:40:32 -0800 (PST)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:38fe:3edc:7f99:7e99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82339095c85sm7218907b3a.67.2026.01.27.02.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:40:31 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: mpearson-lenovo@squebb.ca,
	dmitry.torokhov@gmail.com,
	hmh@hmh.eng.br,
	hansg@kernel.org,
	corbet@lwn.net,
	derekjohn.clark@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v6 1/3] input: trackpoint - Enable doubletap by default on capable devices
Date: Tue, 27 Jan 2026 19:39:05 +0900
Message-ID: <20260127103907.20269-2-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127103907.20269-1-vishnuocv@gmail.com>
References: <20260127103907.20269-1-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable doubletap functionality by default on TrackPoint devices that
support it. The feature is detected using firmware ID pattern matching
(PNP: LEN03xxx) with a deny list of incompatible devices.

This provides immediate doubletap functionality without requiring
userspace configuration. The hardware is enabled during device
detection, while event filtering continues to be handled by the
thinkpad_acpi driver as before.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v5:
- Renamed function to trackpoint_is_dt_capable()
- Simplified string comparison without sscanf()
- Removed wrapper function as suggested
- Fixed missing period in comment

Changes in v4:
- Simplified approach: removed all sysfs attributes and user interface
- Enable doubletap by default during device detection
- Removed global variables and complex attribute infrastructure
- Uses minimal firmware ID detection with deny list
- Follows KISS principle as suggested by reviewers

Changes in v3:
- No changes

Changes in v2:
- Improve commit messages
- Sysfs attributes moved to trackpoint.c
- Removed unnecessary comments
- Removed unnecessary debug messages
- Using strstarts() instead of strcmp()
- is_trackpoint_dt_capable() modified
- Removed _BIT suffix and used BIT() define
- Reverse the trackpoint_doubletap_status() logic to return error first
- Removed export functions as a result of the design change
- Changed trackpoint_dev->psmouse to parent_psmouse
- The path of trackpoint.h is not changed
---
 drivers/input/mouse/trackpoint.c | 47 ++++++++++++++++++++++++++++++++
 drivers/input/mouse/trackpoint.h |  5 ++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 5f6643b69a2c..8319b5bb6ce5 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -393,6 +393,45 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
 	return 0;
 }
 
+/* List of known incapable device PNP IDs */
+static const char * const dt_incompatible_devices[] = {
+	"LEN0304",
+	"LEN0306",
+	"LEN0317",
+	"LEN031A",
+	"LEN031B",
+	"LEN031C",
+	"LEN031D",
+};
+
+/*
+ * Checks if it's a doubletap capable device.
+ * The PNP ID format is "PNP: LEN030d PNP0f13".
+ */
+static bool trackpoint_is_dt_capable(const char *pnp_id)
+{
+	size_t i;
+
+	if (!pnp_id)
+		return false;
+
+	/* Must start with "PNP: LEN03" */
+	if (!strstarts(pnp_id, "PNP: LEN03"))
+		return false;
+
+	/* Ensure enough length before comparing */
+	if (strlen(pnp_id) < 12)
+		return false;
+
+	/* Check deny-list */
+	for (i = 0; i < ARRAY_SIZE(dt_incompatible_devices); i++) {
+		if (!strncmp(pnp_id + 5,
+			     dt_incompatible_devices[i], 7))
+			return false;
+	}
+	return true;
+}
+
 int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -470,6 +509,14 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 		     psmouse->vendor, firmware_id,
 		     (button_info & 0xf0) >> 4, button_info & 0x0f);
 
+	/* Enable doubletap by default on capable devices */
+	if (trackpoint_is_dt_capable(ps2dev->serio->firmware_id)) {
+		if (trackpoint_write(ps2dev, TP_DOUBLETAP, TP_DOUBLETAP_ENABLE))
+			psmouse_warn(psmouse, "Failed to enable doubletap: %d\n", error);
+		else
+			psmouse_info(psmouse, "Doubletap enabled by default!\n");
+	}
+
 	return 0;
 }
 
diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
index eb5412904fe0..3e03cdb39449 100644
--- a/drivers/input/mouse/trackpoint.h
+++ b/drivers/input/mouse/trackpoint.h
@@ -69,6 +69,8 @@
 					/* (how hard it is to drag */
 					/* with Z-axis pressed) */
 
+#define TP_DOUBLETAP		0x58	/* TrackPoint doubletap register */
+
 #define TP_MINDRAG		0x59	/* Minimum amount of force needed */
 					/* to trigger dragging */
 
@@ -110,6 +112,9 @@
 					   external device will be forced to 1 */
 #define TP_MASK_EXT_TAG			0x04
 
+/* Doubletap register values */
+#define TP_DOUBLETAP_ENABLE	0xFF	/* Enable value */
+#define TP_DOUBLETAP_DISABLE	0xFE	/* Disable value */
 
 /* Power on Self Test Results */
 #define TP_POR_SUCCESS		0x3B
-- 
2.51.0

