Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591F28688C
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290353; cv=none; b=gSidI9PmVhiSNyTNOtr0/WtcpH1FNuQbxvJXmBwUXaJ26+SlBOrxQgXMXqZkS0ubVGIuCqNSaavOBtFkKkUm9faI5/yscvGbMEa44jWhwTuOYkqe9XwtPxXlUTzC2LWQAPYccoFwIY7oBaKYAfcFG8nNdAWU7P/h5cFnh9mzn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290353; c=relaxed/simple;
	bh=Sid+n6SK1AmFYrzfuN3yrx/lQx5Q682njP1EbSu8QHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1dv5TGJm8m3OsykiSTdjmzO47oEl/mQ6RhaZ2MaYHS0lyi5kAGijqnVhVHl/g2I8xCE5in8vrJXvuaKuM+aaA6hwXHirMdIDa3Pmnx8f9iv9lIp0MMV2sgSmymo+Dh1+sXPV6sz4TKclyy4Oe5Rzd/+VuP78SuhebAciJ2s/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=vyDQnu31; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="vyDQnu31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290044; bh=Sid+n6SK1AmFYrzfuN3yrx/lQx5Q682njP1EbSu8QHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vyDQnu311YmWNiPQDqFpT83rBC/raOrNZEKwCtQfut00ZGzakPupe4Uurp8lh4BiI
	 lU0HInnCQN9Q5hpo05i1ohshZdSJ6nC5cZUgQXyVLh9XOBIsIVM62QHpVxXwbP9Ilf
	 8iY5s7tC56wULmk7MMUJdUapFtd9pM4sKs6O4C0vA5ZtN6WGwSdtQjT+oInfXFeOwa
	 B47MYtyQIgwcoB2qpSXLX7UzZgX4fE+1IO/3Zs2ITFHg0VDnfZn1EtEXY/nX8jKX2o
	 AqeAYkfUvR6dpchvPSA5LJDq6TaO7HQh/gkLsPoVMBfayo05YhG97rs8FMtUPsSRR+
	 UVXv73g953Tog==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id F3AA9A090;
	Tue, 28 Jul 2026 18:54:03 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 01/11] HID: steam: Update documentation
Date: Tue, 28 Jul 2026 18:52:23 -0700
Message-ID: <20260729015243.1170573-2-vi@endrift.com>
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

