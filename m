Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589443749F5
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467233; cv=none; b=lNlDuuuDI/lvoPuhwSGXHP3TdSYRMEHAgvgwO+egB+l10ZZgwSFalVvwxQo9kJt7hxLGhoQCCHVsrJleAp4wCHISnWBSzCI77WQv+L1zaS3VfMOhlTtjczTeQj4JQi9764N2u36Ky5E+3PAHpOafnM40+znZ2XQ5RZ7uAd5ks+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467233; c=relaxed/simple;
	bh=8NYKUEEjoO5/3uOxfYK7qIuagvVchxTGd4SKyKRDQ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqt3YIV7uwajEsRInofPOwRVqqDEOVsJqN9QnFcv964szUym8DjaAKhDhZ+YraG6DAsUWvVzn0UCbuH1e3OqDxOblBnHFW7We1LTqRl0U9nADRNLwa9oz5AD2tn+iRXweU0VNNFtDI9/OVq6Bpb4XQIca0bKA1Z1MEkq+vxUfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=ZDR1uPY8; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="ZDR1uPY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783467231; bh=8NYKUEEjoO5/3uOxfYK7qIuagvVchxTGd4SKyKRDQ5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDR1uPY8KPhDqJ63+Y286QlTx6XkzhSuB8H6bHb3Iu9vWIxQgA7avTtFe+03j2YBa
	 ccDChgTVhqhsxK2EIZyhoxy2iD+p89hGtafZdN2vMyv+peIkt6SCVYU6CMRjFQcXT+
	 LPkKsB14j/bJgaTeIMzhpkRqzabctbjfRekbZqAJpzv3scXyT8TwnkW5STAuI9y/Yl
	 /EPNGyw1qOC/sOmwil6k4hvH37CsoClYipUj5clQ/Di4eCFlxWL/kRZ7SEd0DecJ0E
	 wMc2GuQFfhTmLrpJkUhxUaZPaoFHuDeHK/RIzRnoELePPpoat1fpnmF3rOjW6sl4PR
	 SUcI3TMa7h91A==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 92A36A0D2;
	Tue, 07 Jul 2026 16:33:51 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2 03/10] HID: steam: Rename some constants that got renamed upstream
Date: Tue,  7 Jul 2026 16:32:23 -0700
Message-ID: <20260707233241.2644971-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707233241.2644971-1-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
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

