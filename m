Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230251DCB24
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648929; cv=none; b=RpIwbtKJwa2KXDh4GdBNciKb71hXdG+NKXJuX+RjHP59c82R6ErxsBxIiyM0868eMFB1xzmsWpx1ivkVnkLmNS2/5FBRBJxy58UlISZF6h215FZqb/knnNKd6nUVbii+BTARNRYcmdGImvvEuGBqe/SuH8E87eL0uXUF9AQpshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648929; c=relaxed/simple;
	bh=8NYKUEEjoO5/3uOxfYK7qIuagvVchxTGd4SKyKRDQ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZqekPDZXFIRiDEBzx5P+DMaqrY9PemmHccOvFeJHVjP4gtmpPAH3cxlej5Bf6E6Dg08maBnUfPPHE+M//WtnEQqre8ep5GfG7ofMUZ/YHh5/5SG2AF2vStU4w9ljxf4iIqHsYLWrcrVN+wQuJS2+mCtxBjtZn2COvSG9zcfQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=NUxDlych; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="NUxDlych"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783648917; bh=8NYKUEEjoO5/3uOxfYK7qIuagvVchxTGd4SKyKRDQ5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUxDlychdYScDM2K2L7DOevZ8OISH5dbSz62bgiER19oLOWCzVWcbLwkrePwBQrXi
	 qP14I8Of4E4jMAWOCFIJlybNVrvUOQ400Y5Ms7Xxw6/QbJbdS+iou3B2/LTmvip3By
	 4IOnivfv/G+4eOYyaYboHy7Gm8OvY/HjikHxaIQK8O6UCtD0c4E7t33wJyJ29bnhdT
	 Qk6jwJQzVlKiM5tGic+8Rl0B0QU6Ad7aFoFuHIVXWr+E5oqcyK9lFIvQuuzTmaXB5a
	 pKO7DZ91J+rhrBveKT2IAdHBlal6h9QDJbhA4/sd/Hou0zbkzNv72cRGPt3oovNtGX
	 pwfPRQ1r1AJoQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id D1D0613202C;
	Thu, 09 Jul 2026 19:01:56 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v3 03/10] HID: steam: Rename some constants that got renamed upstream
Date: Thu,  9 Jul 2026 19:00:38 -0700
Message-ID: <20260710020048.2337655-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710020048.2337655-1-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SETTING_MOUSE_POINTER_ENABLED was renamed to SETTING_LIZARD_MODE upstream.
SETTING_GYRO_MODE was renamed to SETTING_IMU_MODE in an older commit, but
the associated enum was overlooked.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 1b0367c98eac..add9f4f27fff 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -151,7 +151,7 @@ enum {
 	SETTING_USB_DEBUG_MODE,
 	SETTING_LEFT_TRACKPAD_MODE,
 	SETTING_RIGHT_TRACKPAD_MODE,
-	SETTING_MOUSE_POINTER_ENABLED,
+	SETTING_LIZARD_MODE,
 
 	/* 10 */
 	SETTING_DPAD_DEADZONE,
@@ -261,14 +261,14 @@ enum {
 	ATTRIB_STR_UNIT_SERIAL,
 };
 
-/* Values for GYRO_MODE (bitmask) */
+/* Values for IMU_MODE (bitmask) */
 enum {
-	SETTING_GYRO_MODE_OFF			= 0,
-	SETTING_GYRO_MODE_STEERING		= BIT(0),
-	SETTING_GYRO_MODE_TILT			= BIT(1),
-	SETTING_GYRO_MODE_SEND_ORIENTATION	= BIT(2),
-	SETTING_GYRO_MODE_SEND_RAW_ACCEL	= BIT(3),
-	SETTING_GYRO_MODE_SEND_RAW_GYRO		= BIT(4),
+	SETTING_IMU_MODE_OFF			= 0,
+	SETTING_IMU_MODE_STEERING		= BIT(0),
+	SETTING_IMU_MODE_TILT			= BIT(1),
+	SETTING_IMU_MODE_SEND_ORIENTATION	= BIT(2),
+	SETTING_IMU_MODE_SEND_RAW_ACCEL		= BIT(3),
+	SETTING_IMU_MODE_SEND_RAW_GYRO		= BIT(4),
 };
 
 /* Trackpad modes */
-- 
2.54.0

