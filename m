Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC64E80DE;
	Mon, 12 Oct 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836134; cv=none; b=W7nfamGwArG/47XhhL5g0bxin7CBdAlPhVoRdYKv8Ywy1Yp6xIHau0yAdSOpD4JsCW2PUArV56+ktFnPZvoK1ACUk6Y1WAOoDJPaNx6NyW/L1MRisgCHLlAjYnz30XZE18pAGgFrP1JBUNAoClTpylnAk9Xf3Ge/aSm9N3L2A5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836134; c=relaxed/simple;
	bh=LSFjTSKmjhTYWJ6kXM3dpe8F+tRbjCSorwmuwVpJJPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVa8QDeHecUjN/iNzYhINdV5CJ2tV0AG5XLDmdgU/z8FEssTBLFn5YMoMshai2b2tj8AP87Z0KVjNZ8BABAIQ+PkITg8YuGRBLv8PK7Ogi7gz1B5JsGNYn72PYyEVf7Cz+/jG3d9VBWSPaMnsPcYb0UJKH7GyWPLwI0WsaSRen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tztKarDj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tztKarDj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 166DBC2BD00;
	Mon, 12 Oct 2026 20:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791836134;
	bh=LSFjTSKmjhTYWJ6kXM3dpe8F+tRbjCSorwmuwVpJJPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tztKarDjIiVGTUrN78+f5+S/yXlrnexv/G+VlwJwT+Swy+04+CVQtXACSH016xtuH
	 BfzhQBAKghkdk0ePQO+tkdpgj0ZV8YVo81dgIZMtYGw/Mfbd0RKCjanphAUtGGfMmg
	 pEokwGXbWaUJZyyriCXnD4JVJrQft88U6TpKnHWrRYzrOOz7k67aGbZVQuoaFUeZZI
	 N1aNwak5hRan+P8GGojGQh7kOZ3RV8bbxZ0v4Y9gp5iwsP0O62BMcwNaG8Gp/+jMve
	 V6wGhvSkfcoWhHe2EBYyrT4COyRZRi6PpES54Ef9cTapP6aU4T1hlp3tGYSwHo/dy3
	 m2y5hZrKWIdBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0877CA9ED2;
	Mon, 12 Oct 2026 20:15:33 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Date: Tue, 13 Oct 2026 01:45:25 +0530
Subject: [PATCH 3/5] HID: UNCTRL: add periodic battery reporting using a
 workqueue
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-unctrl-m1-battery-v1-3-4a50203b7177@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
In-Reply-To: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791836132; l=2489;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=cZg7tXXlrf9MFCB4wrzOmscX9rpVeRP9MmWnFJhdM4M=;
 b=IPYFwJ5o+MWEnoEXUZuWaerA5M1RpXYfzZuJ31w5xWWJsW9LDjH4l8nriYt3rd67kSMNLq3Rh
 kGNb31vYwu0AB4nEcyLK4ofQ+zbRlbPYyrXwkaE+PvsmGiuaN7ywu3F
X-Developer-Key: i=contact@bishwasaha.com; a=ed25519;
 pk=bW8B6BzX1VU4IIcYagrb5nNRxBho+rTXaQZ8fLx8CoU=
X-Endpoint-Received: by B4 Relay for contact@bishwasaha.com/20261012 with
 auth_id=1168
X-Original-From: Bishwa Bhusan Saha <contact@bishwasaha.com>
Reply-To: contact@bishwasaha.com

From: Bishwa Bhusan Saha <contact@bishwasaha.com>

This patch uses a workqueue to check battery status every 5 seconds.

Signed-off-by: Bishwa Bhusan Saha <contact@bishwasaha.com>
Assisted-by: GLM:glm-5.3
---
 drivers/hid/hid-unctrl-m1.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-unctrl-m1.c b/drivers/hid/hid-unctrl-m1.c
index 59259dee7..1e73cad1e 100644
--- a/drivers/hid/hid-unctrl-m1.c
+++ b/drivers/hid/hid-unctrl-m1.c
@@ -22,11 +22,14 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
+#include <linux/workqueue.h>
 
 #include "hid-ids.h"
 
 #define UNCTRL_VENDOR_IFNUM 2
 
+#define UNCTRL_BATTERY_TIMEOUT_MS 5000
+
 #define UNCTRL_MODE_RECEIVER 0x01
 #define UNCTRL_MODE_WIRED 0x44
 
@@ -47,6 +50,8 @@ struct unctrl_dev {
 	struct power_supply_desc battery_desc;
 	struct power_supply *battery;
 
+	struct delayed_work battery_work;
+
 	u8 battery_capacity;
 	u8 mode;
 	bool online;
@@ -132,6 +137,17 @@ static void unctrl_fetch_battery(struct hid_device *hdev)
 	kfree(write_buf);
 }
 
+static void unctrl_battery_timer_tick(struct work_struct *work)
+{
+	struct unctrl_dev *dev =
+		container_of(work, struct unctrl_dev, battery_work.work);
+
+	unctrl_fetch_battery(dev->hdev);
+
+	schedule_delayed_work(&dev->battery_work,
+			      msecs_to_jiffies(UNCTRL_BATTERY_TIMEOUT_MS));
+}
+
 /* Register the power supply of this connection and start reporting. */
 static int unctrl_battery_register(struct unctrl_dev *dev)
 {
@@ -155,6 +171,8 @@ static int unctrl_battery_register(struct unctrl_dev *dev)
 		 dev->battery_desc.name);
 
 	unctrl_fetch_battery(dev->hdev);
+	schedule_delayed_work(&dev->battery_work,
+			      msecs_to_jiffies(UNCTRL_BATTERY_TIMEOUT_MS));
 
 	return 0;
 }
@@ -200,6 +218,8 @@ static int unctrl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	dev->hdev = hdev;
+	INIT_DELAYED_WORK(&dev->battery_work, unctrl_battery_timer_tick);
+
 	dev->battery_capacity = 100;
 	dev->mode = UNCTRL_MODE_RECEIVER;
 	dev->wired = hdev->product == USB_DEVICE_ID_UNCTRL_M1_WIRED;
@@ -277,7 +297,11 @@ static void unctrl_remove(struct hid_device *hdev)
 {
 	struct unctrl_dev *dev = hid_get_drvdata(hdev);
 
-	hid_hw_close(hdev);
+	/* Stop polling before the transport goes down. */
+	if (dev) {
+		cancel_delayed_work_sync(&dev->battery_work);
+		hid_hw_close(hdev);
+	}
 
 	hid_hw_stop(hdev);
 

-- 
2.56.0


