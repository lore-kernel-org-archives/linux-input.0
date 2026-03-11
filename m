Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771DF3C1973
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239696; cv=none; b=oT2h1nXTYgK92D01VBuGR21VEUqEF+jb2WW47t8bZ7xaJ+EbbtgO9PiW2ZGR+V0I54jMTAWi9LtyRKH5Cv5sGxzinEejSwTseUYrll/onivbRYgqPlG1LUDvsKd775N91/rBOFAqSipRiSnJ9Ax60N3LN6r+REJ44PHlcJP2tK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239696; c=relaxed/simple;
	bh=27fpxFp7lB53jWFCOatArqKjpJFcS/bB5xSGstlmF3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCso0w6VSN/gEI7PdAbO05QMwv1MPFef+zDQS8FqzgirQBqDhHhPXNka28ECTT2L7OyHfW7PWiqYrczGhCDqnHkSP1fZBEjkJXJ52I+OpB1EdIjN0mQDhgcwP5SJcY9fs9laKfuT/KSDMCnMFTQczxmoAkIawkbjLU6TsEhtF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgIoq2/e; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgIoq2/e"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c73d361f0cdso174251a12.2
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773239693; x=1773844493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oJSVhuIHw/FWlPKxzaQUmvjCJEQN/D5Xsb6jINz2Mc=;
        b=AgIoq2/eTslMvi2XbnVMTbohboI0dd/s1ISFGbP0vFm64kvfBmycsOSpY2doa+acEI
         gKFBK1ackDkpdQYCpGhn43HGP9g8xrQi+qyUSSdi5DmgK0SuyiZbq1gxuj8O96fGfK/9
         1Ek6tjT3DptKD5ttBIVzKPNBNF5gwsyl5PH+DBBM336Zv+q7stm4z4CNa2TutO0hvD3v
         Oa9+kT4UBuEFpOEKNVDTB1td6E1N9TmDK3M13Dz+PxCIewI45U4/Cy17KX8bARQJIBbh
         RrGCse0xOs50GUGP97F9oLXgPjRW1peYnOBrGwlQmkIcPOVHwnZZXrf2jsXEDS1xYZrt
         I5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239693; x=1773844493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0oJSVhuIHw/FWlPKxzaQUmvjCJEQN/D5Xsb6jINz2Mc=;
        b=XiRiuhGAGDuqmMNg6/LI+7geB3yhlzO/P1WE7gHyVLFPMPM2MwtI1yxjsRwUe7jt9y
         VvTrXkiwDXjjRPKmWsqBd5WhkBqBlHYtupZWHfiZPJ72yStAK5RgbJ4vbrKmny0ew4z5
         pvrhgHuGbSX4WmQe+oFwE5NiCRtSHyBWrQd2IGhY65XTxcoNEab+ZmYTeG+6LTiB9a2K
         Y1tFnZ1Zp6XNJnvfpQity9XB8Y7D0kodvgd5qgWZW0s7i/zGreJjtdWDxD3xsmfXB/OA
         zZaknaSHjFlRKVHmIl9QxAC2qYx4T2fosAw/34HzptXHj3BtYhR2cNaoIpNJzINps4GK
         FAmg==
X-Gm-Message-State: AOJu0Yz5lYCT/VjBSBy/jbBrukjT2IoiJ0t7CurwVbj9xgkpznyEi4qZ
	ySZts4b0Z0nE5vTR+UC7fj9+tm3L27p6nnvBsY/ZdVe0TicM6zJ3hphc
X-Gm-Gg: ATEYQzxpTVlDD/aFgpJhzsWFTliIVo0mfiZwBlmet9vlV8v+uerq8q4Ui/gIlTlCf3S
	7dPEwzSTnRfHJsZlxlcSRNFVqqmOewQj0fzqC4sbWKut+t4YGmEa83QabBlFpzSUA6tzqZDtrpb
	hJ+epKrToDJd+BByTd39gXhy4DgAdia0ps7OKsU6C1U3/QZYM7Z8q8tsVS+dn2Z5ettrHEqQGPj
	/EFq5lYYazhHaP5sr9mLBDkxvhSBfcfxZzb1MQ9e3ieE/2l7zpCt0p2qb7RmrmwUqGcv56M0G2N
	O2qvrX/0rKeRv9kHab++L9/w9UEpQTi9hO0+gD3kJ5jl84d0XBiYWYOOHwmdUq1TVk4BY9cfSUb
	kFmohYW2YPWeaP69UW43t9yW4HvIeDh2K1z3d1LQ2vopyTYKqcA4zt4ku/n8QaZ3jpwfFkKhR2y
	7PbeB6sMZe3LIbD9uijqHBXuAuOS7wiUzTvnsTDkao6z+m7z+E
X-Received: by 2002:a17:903:288:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2aeae65e49amr29551425ad.0.1773239692701;
        Wed, 11 Mar 2026 07:34:52 -0700 (PDT)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:dd5:d7ff:1c94:3624])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34e070sm26399235ad.48.2026.03.11.07.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:34:51 -0700 (PDT)
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
Subject: [PATCH v8 1/3] input: trackpoint - Enable doubletap by default on capable devices
Date: Wed, 11 Mar 2026 23:31:42 +0900
Message-ID: <20260311143144.482145-2-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311143144.482145-1-vishnuocv@gmail.com>
References: <20260311143144.482145-1-vishnuocv@gmail.com>
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
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v8:
- Added missing includes (strings.h and array_size.h)
- Better formatting

Changes in v7:
- Removed unwanted comments
- Removed psmouse_info ()

Changes in v6:
- No Changes

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
 drivers/input/mouse/trackpoint.c | 46 ++++++++++++++++++++++++++++++++
 drivers/input/mouse/trackpoint.h |  5 ++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index b06c7ad721fe..3bd8fdf56cd3 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -5,6 +5,7 @@
  * Trademarks are the property of their respective owners.
  */
 
+#include <linux/array_size.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/serio.h>
@@ -12,6 +13,7 @@
 #include <linux/input.h>
 #include <linux/libps2.h>
 #include <linux/proc_fs.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include "psmouse.h"
 #include "trackpoint.h"
@@ -393,6 +395,44 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
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
+		if (!strncmp(pnp_id + 5, dt_incompatible_devices[i], 7))
+			return false;
+	}
+	return true;
+}
+
 int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -470,6 +510,12 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 		     psmouse->vendor, firmware_id,
 		     (button_info & 0xf0) >> 4, button_info & 0x0f);
 
+	if (trackpoint_is_dt_capable(ps2dev->serio->firmware_id)) {
+		error = trackpoint_write(ps2dev, TP_DOUBLETAP, TP_DOUBLETAP_ENABLE);
+		if (error)
+			psmouse_warn(psmouse, "Failed to enable doubletap: %d\n", error);
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

