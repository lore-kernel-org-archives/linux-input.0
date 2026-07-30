Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF81368D40
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384874; cv=none; b=ZfhYA8zBC/FPvsWRG/ODstJGzLX60TX/xNtd3nldvijRoOUh3sfGU0YVUH3ow2TRP+k8KxnaDDwdebXw/E5SWFrbZq9O8DAODO8N+qegVie2T9XutZro1/Dd4VYDaj6scDbIuJBYd2D9WoE2Us8k01F4Fx6X7h7fSu4ehncqNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384874; c=relaxed/simple;
	bh=NiY+LWn3m83BQyVxD4VcMQgTDgaUX1edy8Z6k8V0ssc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3T4NNIIRg68ysShUg8WBT5yxEF2aAI776Dd5d6FaZ7Qg4Ufroaf0yQ6x97VSbYdg2dT3E63sDKuQ0Cl3ZJnzr4YQoumNH8xOCJIcOd6sTnLzhWth9/peRfVKuI9FKKzR+GoQETbXiOGViTGKRhmppa9v685VJS4QWPiIfw8G0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=vd7B9OVl; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="vd7B9OVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384867; bh=NiY+LWn3m83BQyVxD4VcMQgTDgaUX1edy8Z6k8V0ssc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vd7B9OVlrQbO8r5vleqPOGEuznARGd8JNn2anNIAv9SeDNBVGnABqKy54+xSnbUNW
	 pV9JQqUGJtryIyZ6FTJpcXbsUrrIFXQF0zGd1T9RRynT3dTK1eIQRWwXPn23uqOhd9
	 RQ0yNkiOkhDcgTOezf7dD3JN0rAy/1UnYVQoFPjaiEhvxkF/3L1/BPW4+5CyjtJDTU
	 mzPkrEmPTZftXrfXkfU6DQiu6eMQhn9QAEFRfHPsBVnOSx+csAtbqJgQCTvv4piG78
	 2ULzrr9pPqtiB5g4MeowYZccSWTM3rQs9pb7ilMI9W9WghhBnc1Lzyn8cpPctT9w3S
	 Iev31cHnww03g==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id B6757132031;
	Wed, 29 Jul 2026 21:14:26 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 03/11] HID: steam: Rename some constants that got renamed upstream
Date: Wed, 29 Jul 2026 21:12:26 -0700
Message-ID: <20260730041251.1659029-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730041251.1659029-1-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
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
index 75d6be0be0a2..983d18d1de4f 100644
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

