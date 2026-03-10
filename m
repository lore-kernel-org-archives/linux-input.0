Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B72749D5
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120036; cv=none; b=NVd88pLqh36OHrFJwr0PkXMtgnvaI2WMCg21OTSPj+arS5fFck4gg01JMcfTX3gnsjAUrWou3Sio2FqoKM4slY4GWrPq5W9uqCvP7rDhlqzy9Ves0leFdu4EFocC00owEYb8rF9p0O9vcIa3ECymoHcHVtT6gU8TZ2WPhf6M+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120036; c=relaxed/simple;
	bh=JlLOn/CD66eR9aDh4it1990Nhinx/S78BaFBPP9ho4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxAjwOT7jZYAH47hcyOCiRWhv0T9W3UaxrYuy749/XS2oe9a1kQi5Kxymqc/JJEgxOhnfhucjNyXRLcbcfozCtwFNz7aiSFztGJ9XLwT+4ZYYUr3kHXIY2Ss5/SsqjL9mbiIA81P5jWLhrqfJTF7WRw8RlaYZIm62QjQg349o80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=dYvXrTEk; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="dYvXrTEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120034; bh=JlLOn/CD66eR9aDh4it1990Nhinx/S78BaFBPP9ho4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYvXrTEkvGFCFf6b3apVtqzQg8/U4H24wOzwNBcBwnwkmb9rTK9m+DQFsjk3nYBrD
	 4IeEpakoXQfNpNNyiFsEapODtEOdQJ4BTCGekUafesTsQPTM74SDZj9UftMcE0quPE
	 1eZFr9LYmdM5Nc/i5H2AkyZT6NhQux7ujl1PXeBcf3JjGMmbPru3zzR3eIdqbYAwU4
	 vod2QfQmgBx/A/HgsLOhKLJ9acJ841XJe5R4caKdM9VhXM3VmsWfshzQsAlDVFhaHi
	 Sq1Bb4EiO9tn63jQCYwEVmjn8qoxGjK86E+LQBOjSDsDzHqBlJzEnqbfknd51wEg4c
	 rub3RHVgo/UnA==
Received: from microtis.vulpes.eutheria.net (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id 3F41EA0D2;
	Mon, 09 Mar 2026 22:20:34 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 07/10] Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
Date: Mon,  9 Mar 2026 22:20:01 -0700
Message-ID: <20260310052017.1289494-8-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310052017.1289494-1-vi@endrift.com>
References: <20260310052017.1289494-1-vi@endrift.com>
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
index 337d2dc81b4ca..23aa2787e55b1 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3505,13 +3505,15 @@ static const char *absolutes[ABS_CNT] = {
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
 	[ABS_MISC] = "Misc",
 	[ABS_MT_SLOT] = "MTSlot",
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 30f3c9eaafaad..34245cd6f22cf 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -875,6 +875,9 @@
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
2.53.0

