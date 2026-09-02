Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29194348C66
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311069; cv=none; b=JLCKwr3KpsZfvzTnkFrjHuToRRcUbO6fypa6lkIUIvPGov3EDpBP0GfDqzmfO3aLfe2zgzOfp0rsXJsvGbUaMiETWOio5bCE5JU4d3rCom/zoxp+9uqY5Dz4Xtqm+NNsls1ucgyi45YBYumH0dOCHADH7ANlBeKx0QF5TQdYr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311069; c=relaxed/simple;
	bh=WkZMpc4CWuTucwIkcTPv4ta1znN9gM1Kt2vmjLU4iiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vimc0Xt1WUcgx2ifHtxznRhpZMSZ5dCl3RU2rauqCr0lrHybVGwIVWoKWDDm7KAGtuJvAaGN0RMTYprwh7MkzK3YxJv3Xc5YazHUTIlr9Z5qO/vKMlDuJxm/jG62z94UacQAHW2/Mzx7LxSdz0STLy4jzoJ85eagUf7/7PpoAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=qibwl6/o; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="qibwl6/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788311060; bh=WkZMpc4CWuTucwIkcTPv4ta1znN9gM1Kt2vmjLU4iiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qibwl6/odzxlBiPZ3qJJWzw6LTzlzN3hcCELTBGlyJU1w3VR8kImaJSnVyGaqNgZ2
	 toEnOrsX1388lEUgv0GShDRsz+vrT5a5CbjYMvGcHeRO8ndgND9LzAHQV95sRSEKQP
	 H9Sn2DAY0sH3LIMRcDLX5pqOMFanqT/1A3VLb7vXpqdY43UspL9e3/0uoNxbsOcgyI
	 gfEM9YpUM6ZLIH1VZhc7eglFGZa/wjBN/0l1sBtq+TTrdcpJ6LIVU9xSAmzehGS87T
	 UohxKfm65Jubp24Em68IIEM9J427u8JLODqXwHUijqQ+l3y+Ubq4RZ2GaqMVZKTR9h
	 WZHjSlJZhgXIQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 5AF6313208B;
	Tue, 01 Sep 2026 18:04:20 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 10/12] Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
Date: Tue,  1 Sep 2026 18:02:31 -0700
Message-ID: <20260902010237.865772-11-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902010237.865772-1-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
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

