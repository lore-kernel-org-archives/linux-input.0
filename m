Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33A399352
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384874; cv=none; b=MR1pmQaELQz3cD0yzTTUjRzp1BilmAUp45lncGcKsEzGuwQzf45SNXTPXEas2EKFCeF+N/NmoG/juou9vT0kV7DkJBIYfFBb/FxQ+q+nkREHyeX1ew7tu8X5KlhvcjOnefDtUCP5UJoCPnacN/8UvTELNNCrMtRFLStt/JVuVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384874; c=relaxed/simple;
	bh=Sid+n6SK1AmFYrzfuN3yrx/lQx5Q682njP1EbSu8QHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0eL+HcP5Di7WvcThfchAPoaQlJEnJ9A4/z08S0thDqUPlEfHPtNvNmd+Yj8qUuMr44jBF2j5/xTk3vFG7ITpZp3ZAWehl3AU0Dwye+tJCN86Tu57mhSyYoRxG4cQh59rT7aRA5aa2aMjeKohVqtnYPnHnCoHSsDYTbohoZGbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=EbvSEeor; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="EbvSEeor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384866; bh=Sid+n6SK1AmFYrzfuN3yrx/lQx5Q682njP1EbSu8QHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EbvSEeorOP7MoDyBu/uHj9ovxbBdNf8TjA8s+kX2QQZL5o7aoNBXmz0bSyjkXd1vf
	 22HwOtRhG+ZdVZoS4LREyn8BrUe5TBhy5prQjzqaGQcY9oha+rlJukYi6jwAm/MT09
	 yj6U9hMxylfR6WqTHwYMt28BbVL7C8NraXMkshAAlIgoaZSutMMfzn3Ea8BVFCqo74
	 VVH6gAvT+01UibE5MKRqakq9ohEKAODPBYlEXC3J5rpZkAGJC2fLbSdvjIjpQENXjW
	 /XFRFIJj5cd24grQIJ4Kx+2PgcHvBecPUaRatMKHOu55j+hFf+NDQondxMnSjYCUim
	 oBArgZOR0YWhQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id D70BFA073;
	Wed, 29 Jul 2026 21:14:25 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 01/11] HID: steam: Update documentation
Date: Wed, 29 Jul 2026 21:12:24 -0700
Message-ID: <20260730041251.1659029-2-vi@endrift.com>
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

Mark myself as the maintainer, as well as adding myself as an author.

It also makes some minor updates to comments, such as correcly calling the
left menu key view and retroactively renaming the original Steam Controller
as Steam Controller (2015), in preparation for support for the 2026 model.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 MAINTAINERS             |  6 ++++++
 drivers/hid/hid-steam.c | 13 +++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f37a81950e25..8f2c582f77e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11566,6 +11566,12 @@ F:	drivers/hid/hid-sensor-*
 F:	drivers/iio/*/hid-*
 F:	include/linux/hid-sensor-*
 
+HID STEAM CONTROLLER
+M:	Vicki Pfau <vi@endrift.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-steam.c
+
 HID VRC-2 CAR CONTROLLER DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 197126d6e081..a854d6360a0e 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -48,6 +48,7 @@
 MODULE_DESCRIPTION("HID driver for Valve Steam Controller");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>");
+MODULE_AUTHOR("Vicki Pfau <vi@endrift.com>");
 
 static bool lizard_mode = true;
 
@@ -1413,9 +1414,9 @@ static inline s16 steam_le16(u8 *data)
  *  9.1  | BTN_DPAD_RIGHT | left-pad right
  *  9.2  | BTN_DPAD_LEFT  | left-pad left
  *  9.3  | BTN_DPAD_DOWN  | left-pad down
- *  9.4  | BTN_SELECT | menu left
+ *  9.4  | BTN_SELECT | view
  *  9.5  | BTN_MODE   | steam logo
- *  9.6  | BTN_START  | menu right
+ *  9.6  | BTN_START  | menu
  *  9.7  | BTN_GRIPL  | left back lever
  * 10.0  | BTN_GRIPR  | right back lever
  * 10.1  | --         | left-pad clicked
@@ -1541,9 +1542,9 @@ static void steam_do_input_event(struct steam_device *steam,
  *  9.1  | BTN_DPAD_RIGHT | left-pad right
  *  9.2  | BTN_DPAD_LEFT  | left-pad left
  *  9.3  | BTN_DPAD_DOWN  | left-pad down
- *  9.4  | BTN_SELECT | menu left
+ *  9.4  | BTN_SELECT | view
  *  9.5  | BTN_MODE   | steam logo
- *  9.6  | BTN_START  | menu right
+ *  9.6  | BTN_START  | menu
  *  9.7  | BTN_GRIPL2 | left bottom grip button
  *  10.0 | BTN_GRIPR2 | right bottom grip button
  *  10.1 | BTN_THUMB  | left pad pressed
@@ -1850,11 +1851,11 @@ MODULE_PARM_DESC(lizard_mode,
 	"Enable mouse and keyboard emulation (lizard mode) when the gamepad is not in use");
 
 static const struct hid_device_id steam_controllers[] = {
-	{ /* Wired Steam Controller */
+	{ /* Wired Steam Controller (2015) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
 		USB_DEVICE_ID_STEAM_CONTROLLER)
 	},
-	{ /* Wireless Steam Controller */
+	{ /* Wireless Steam Controller (2015) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
 		USB_DEVICE_ID_STEAM_CONTROLLER_WIRELESS),
 	  .driver_data = STEAM_QUIRK_WIRELESS
-- 
2.54.0

