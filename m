Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714621019E;
	Sun,  8 Feb 2026 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770555396; cv=none; b=GpSlba8/jamxF1tfUnna0cDzEnHLMCpDWjBiSPWh4NH0zF0qEg5t73mW+O6iplaICsZ5l2778eW3K2rVO4T/5wj5jefnMX9MIwpoF4T1FCvLRX27LfPvfj+GaWjorkLiUpDXuPqJ3oum3zqHRoKRyIgT67V6I0BmCpT8gpFJlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770555396; c=relaxed/simple;
	bh=dqIHyIdrKH2pIyGagg0Pl6ZamfIlR0QKPd3urgnZKWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSXtlg3BsgwNtMSV1+Bco/h9S8aNwvHGiFKBlhAwYjL9M5m0dfWUCXLlHhlPATsVvNNoo8Scp7Ha6gl0SCxm5OiVGVyaubXV4ve0QGABm3V7/jzeQvSFYzhXCdzojh9hVCUcT7aTO3sFdtH7Fw4uYGzTf/PEGvjj3TSjGQa7pLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 61365104742;
	Sun, 08 Feb 2026 12:48:52 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Staudt <max@enpas.org>,
	stable@vger.kernel.org
Subject: [PATCH v1] Input: joydev: Don't expose DualSense motion sensors as jsX
Date: Sun,  8 Feb 2026 21:48:36 +0900
Message-ID: <20260208124838.2085186-1-max@enpas.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this, DualSense (PS5) gamepads are allocated a second jsX
device for their gyroscope/accelerometer, confusing programs such as
/lib/udev/js-set-enum-leds which look at jsX device numbers to
determine the player number. Ideally, we should have only one jsX
device per gamepad.

This follows the schema started by:
  commit 20ac95d52a28 ("Input: joydev - blacklist ds3/ds4/udraw motion sensors")

Fixes: 402987c5d98a ("HID: playstation: add DualSense accelerometer and gyroscope support.")
Cc: stable@vger.kernel.org
Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/input/joydev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index ba2b17288bcd..f2fdbc814a8f 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -753,6 +753,8 @@ static void joydev_cleanup(struct joydev *joydev)
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER		0x05c4
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2		0x09cc
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE	0x0ba0
+#define USB_DEVICE_ID_SONY_PS5_CONTROLLER		0x0ce6
+#define USB_DEVICE_ID_SONY_PS5_CONTROLLER_2		0x0df2
 
 #define USB_VENDOR_ID_THQ			0x20d6
 #define USB_DEVICE_ID_THQ_PS3_UDRAW			0xcb17
@@ -793,6 +795,8 @@ static const struct input_device_id joydev_blacklist[] = {
 	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
 	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
 	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE),
+	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER),
+	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER_2),
 	ACCEL_DEV(USB_VENDOR_ID_THQ, USB_DEVICE_ID_THQ_PS3_UDRAW),
 	ACCEL_DEV(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_PROCON),
 	ACCEL_DEV(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_CHRGGRIP),
-- 
2.47.3

