Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB214385D97
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030984; cv=none; b=Y2wTQM8dqXfRYX1ICUl74PWivo0OV8tV5hBxSsRroOqItVmjrs5I9axqMfYJiirpi13tIJY88DTL2XYbgfp9XEcNapID5WLewySzN5MGq1lLfSjAsgc/dsSKyI5aPfuhb6Af8nkJ9veIQaDgcHIUBQSoNcwEDUUHA6QegbzgmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030984; c=relaxed/simple;
	bh=8NYKUEEjoO5/3uOxfYK7qIuagvVchxTGd4SKyKRDQ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmO1yNau48PfYWqcqnIfKaF+mCLvJST8ElNmGHsxVtRKT0WAxQ4c9sq81QCCck+lqpVKRiqo2aoCazQGvpwTxL55uRp0v78nj7eyLsxAIRp4yeMlWHtgGrnZGot/7IwN7EcefWQbCHV+zhKhke1/1by71WO/cai02CJ/cGkk3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=ewz/tlpv; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="ewz/tlpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783030982; bh=8NYKUEEjoO5/3uOxfYK7qIuagvVchxTGd4SKyKRDQ5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewz/tlpvZnUlCoo3xDwrcPsUu3zHL7rHl2IXxn3FmwzuBJ7OGuIEOr9h4uDV5yMBy
	 0oVRcCVm5u9lfuRH4d0UDZ9Wo4RsEvMHXiDKax1/cIGcsoW/ALe5q5fMGP0NAVgeJU
	 ffumJGXgwxLLyVowMhWv+FzpZjytnAM7BzNJemt0OfuCzXdwXu0Q973mf9OSQ5NKeX
	 RbzMHsa02ApAUVMHeuSAgN31QjD/DviNGoPXzW9S6YpsGArADtV74EFLCvl3azQCVa
	 mQ/6OWWJfcj4b77TJMIF67x0W1dA/uwY9WGaPYSgOvGNEg+TO8r9pRid7DC1QLcqmI
	 LiJNSWEXthTgg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 07E66A0CF;
	Thu, 02 Jul 2026 15:23:01 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 03/10] HID: steam: Rename some constants that got renamed upstream
Date: Thu,  2 Jul 2026 15:21:36 -0700
Message-ID: <20260702222145.1863104-3-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702222145.1863104-1-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
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

