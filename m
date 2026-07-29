Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3031A7E2
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290352; cv=none; b=YVPog3L8WGWz/LgoUP0lZz2pmDi2bE1Dsj6LG3gwBW+/EUAOICka+7SAza4cWUy0D41emHux9saieDqUHCA2sSf6m46HFCLgRIBpD3B/AqYHT40OO5mOUhMn3MnnJMJlZ+j4CmHnQvFbLolRWdQgLELTRewsyGDK1ePDH0e//I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290352; c=relaxed/simple;
	bh=NiY+LWn3m83BQyVxD4VcMQgTDgaUX1edy8Z6k8V0ssc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3asWxAw0nOJNF7PcrcP5X5W1OazV3YEPrmrTNBC/AtWpL2qIVneuEam835v+c7lRQ4vmKo2m0RhM24MsrYISI1iZxhQ45eBitvJmIB1752JQCAhJzAySqV9sFflF8NuVzJToxtO8NH1MLsMP15r2l+KlLasOfZYfZBm+lunRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=hOlHuH/6; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="hOlHuH/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290045; bh=NiY+LWn3m83BQyVxD4VcMQgTDgaUX1edy8Z6k8V0ssc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOlHuH/6O7JmF1uXS7S/qYo41CwhFeiBB2FbMzG50exzncfyNyu035SmzDaVuHNWK
	 vXNjpq32ZxBtlyMec6Mi0zZe4zZNRcfoSoQNkApDNiI6vyBjQhEP7NjFTipVrtH/ps
	 H5fGvoQFQevLAHJ3Vs1LahNbdYPiRYtKeGn8/QTb7FSGQs1yAMg2zB2Tv3MrOdXI8B
	 cottQ/pr58qbmPDW1v/GPgEGvxzqFeLnUnrsNYf7KwP/TZJaecKDSJEVkxbgOi+tEu
	 /V48cFV6dK4tyFvHORaUDAuj0ZvXhIzYR6qSAAU+RqnOi5JmogkAeEGp3Qa5xwBw5s
	 fI11+Vme2QX0Q==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id C6601A099;
	Tue, 28 Jul 2026 18:54:04 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 03/11] HID: steam: Rename some constants that got renamed upstream
Date: Tue, 28 Jul 2026 18:52:25 -0700
Message-ID: <20260729015243.1170573-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729015243.1170573-1-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
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

