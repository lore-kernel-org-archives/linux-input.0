Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D764369A
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648929; cv=none; b=Tg/JG25IX1QPmnw9rjbQzogDeisBZHw/JGruvXPc6Ldzyosk2xW4XbSmzS6qES1ufNVG/BeCjl6qcUuf3YpdBxSpGsFrm3hKQ7uTif9OdqFcfjQ3sksVfQayJKqfDhCz/dD9xRLXSbPKVvgm2+7E+VxzAB6qVk5ElfPmTuYHkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648929; c=relaxed/simple;
	bh=q5UpsHz/krcp9G/Vmy66VY51+9SeRHyM/4YaQPC3Cuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GguMvSHTWJ80qcpxPznjbY8/6qtxbtSW5cyY/g1KC2FRL3T5o794fb0C5qr0Hwff38Zt/1C5WskIAVpxL1YJ0gRzv66AXhOw+03C9vvXvZN8Svmwrzy+FCrATx+hFxQnnmqq4AHnHPIY51iB2LHBvOrUlsIMdhNRC2+tkpaTvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=rV43FKZY; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="rV43FKZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783648916; bh=q5UpsHz/krcp9G/Vmy66VY51+9SeRHyM/4YaQPC3Cuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rV43FKZYka23rn5hHYgdvCDFndd4hb6oZw4YuYOP/8faJM3RVjG6AYeEu877A9KaB
	 rHLERk1HkFPa96r4PgsBHaks3vdSTPEEmemuRLOTSS4cRIc9syFDWhBJposQH5iI4P
	 rDQ1NbuNXNoZtoT19a+5vDYEAIYXzECyhQV57sP/+fEta9s5Nm7tqzWoBm7fwRragb
	 mQO4bzzBqXK3I9p+wd7ruvCrnvM+OWWIPWGfUmyQDb/zWCx25b5oOoQ/bbsRla9oiP
	 HIBSlaD2EbN3CXjzz5Ka5kyf4UDZyIIVA3sj2ENUilrD15u6IVsVF3bbiiF1j0Y4kF
	 mhZu6tTcLnWBw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 0BD2E132022;
	Thu, 09 Jul 2026 19:01:56 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v3 01/10] HID: steam: Update documentation
Date: Thu,  9 Jul 2026 19:00:36 -0700
Message-ID: <20260710020048.2337655-2-vi@endrift.com>
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
index 4ecd282f8f52..2ed29e970023 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11500,6 +11500,12 @@ F:	drivers/hid/hid-sensor-*
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

