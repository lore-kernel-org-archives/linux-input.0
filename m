Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334A2E7384
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787364807; cv=none; b=QQqCGHPN+ieIfM7xFAPniKz5kmMnouU1U3r9e578ijedthIwzvVfzk++sMHeG7yf97Oywse7FZw6vsEgPQIxL3EeAKrIDEhrIuPlNfStbgW8Y+S9WIX+Kn9Z9OsbMf5xAflR8isw0oWnBv3f/nvaJhJOJFNONMp2lzKCr1h9liU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787364807; c=relaxed/simple;
	bh=WkZMpc4CWuTucwIkcTPv4ta1znN9gM1Kt2vmjLU4iiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILIXyi8XyaQqW8HyAACWSWC0ldsDaPsi8zgdoo3H9S21Z6CTljSlq2Qwes/YpCZ4vWO312PqgwDbUcA7NxsBqWhg7Yyoqh0SRXTSks3f8z1I7jDFsxw66mtW3P8XiPrsM3ONUavpCXgQVhmt7vICGl+B3xhBmedJXmYy+SKffqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=qqTd+/RQ; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="qqTd+/RQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787364801; bh=WkZMpc4CWuTucwIkcTPv4ta1znN9gM1Kt2vmjLU4iiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqTd+/RQ3Eubqok9+UZeFkGJYjcMEnxRPTnR82LJ/VrVAz0B/IhPZ5mxYq9kXgvqL
	 lzFJ7C7Efq9tfDS6Q8rEkNVYlEsU0mSaYVCkD8CFA5QhWktYfXiV5AB6piScRBRWqp
	 xFbK5i1r9yr9gYteBrRQjtNQ8pNOdVneCsDCM0yEhn5EowinoUaN7ST/xwViZ0bu2E
	 bH6Ll48LzDeGAPHdN+4PNRrKGflQh0r5mfT8Bs3svMEat+9CcV7K/Zuvn17I/Qd4Uz
	 RnPtd16HrILmnTiRJACA6DzzqWeor0mKnD4JZ6TykDLaxdXjIe6Yraz3keFi9pEXbF
	 ApBBDT7IWP6ww==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 3E5CE13208B;
	Fri, 21 Aug 2026 19:13:21 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 10/12] Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
Date: Fri, 21 Aug 2026 19:11:34 -0700
Message-ID: <20260822021140.1149546-11-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822021140.1149546-1-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new absolute axes for racing game controllers

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-debug.c                | 16 +++++++++-------
 include/uapi/linux/input-event-codes.h |  3 +++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index f44e6e708404..7a1b56311e9b 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3511,13 +3511,15 @@ static const char *absolutes[ABS_CNT] = {
 	[ABS_RY] = "Ry",		[ABS_RZ] = "Rz",
 	[ABS_THROTTLE] = "Throttle",	[ABS_RUDDER] = "Rudder",
 	[ABS_WHEEL] = "Wheel",		[ABS_GAS] = "Gas",
-	[ABS_BRAKE] = "Brake",		[ABS_HAT0X] = "Hat0X",
-	[ABS_HAT0Y] = "Hat0Y",		[ABS_HAT1X] = "Hat1X",
-	[ABS_HAT1Y] = "Hat1Y",		[ABS_HAT2X] = "Hat2X",
-	[ABS_HAT2Y] = "Hat2Y",		[ABS_HAT3X] = "Hat3X",
-	[ABS_HAT3Y] = "Hat 3Y",		[ABS_PRESSURE] = "Pressure",
-	[ABS_DISTANCE] = "Distance",	[ABS_TILT_X] = "XTilt",
-	[ABS_TILT_Y] = "YTilt",		[ABS_TOOL_WIDTH] = "ToolWidth",
+	[ABS_BRAKE] = "Brake",		[ABS_CLUTCH] = "Clutch",
+	[ABS_HANDBRAKE] = "Handbrake",	[ABS_SHIFTER] = "Shifter",
+	[ABS_HAT0X] = "Hat0X",		[ABS_HAT0Y] = "Hat0Y",
+	[ABS_HAT1X] = "Hat1X",		[ABS_HAT1Y] = "Hat1Y",
+	[ABS_HAT2X] = "Hat2X",		[ABS_HAT2Y] = "Hat2Y",
+	[ABS_HAT3X] = "Hat3X",		[ABS_HAT3Y] = "Hat3Y",
+	[ABS_PRESSURE] = "Pressure",	[ABS_DISTANCE] = "Distance",
+	[ABS_TILT_X] = "XTilt",		[ABS_TILT_Y] = "YTilt",
+	[ABS_TOOL_WIDTH] = "ToolWidth",
 	[ABS_VOLUME] = "Volume",	[ABS_PROFILE] = "Profile",
 	[ABS_SND_PROFILE] = "SoundProfile",
 	[ABS_MISC] = "Misc",
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 3528168f7c6d..5c881ed44177 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -879,6 +879,9 @@
 #define ABS_WHEEL		0x08
 #define ABS_GAS			0x09
 #define ABS_BRAKE		0x0a
+#define ABS_CLUTCH		0x0b
+#define ABS_HANDBRAKE		0x0c
+#define ABS_SHIFTER		0x0d
 #define ABS_HAT0X		0x10
 #define ABS_HAT0Y		0x11
 #define ABS_HAT1X		0x12
-- 
2.54.0

