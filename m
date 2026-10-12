Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3524F55C2;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839642; cv=none; b=L3+tYIwjSBMyieW8jARsrhqQ2lc9erV2K+PiJLLR63T1k3W40VNc9B0B6rE4aU+b5hx7XPGu6n7JGrea+wwmwova7rId+GilXj7mHERjOlXmRmeBNog9sf6vtVdhJdu7+ZFaids7kxeRleV99084v168REJf3LYqiFLPL5kWLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839642; c=relaxed/simple;
	bh=IQfwp0RUGlW/wkQzSf9qCtmkP6zQfG1uJceVBTRyXLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wiu9ViLmmRpYfpvLjQJCRfvc239e/eTVqnpOIoayg0qIS/jBSoHorwzU9aMEyw+XLjPpAE7V/VYeZk0NFsAtVsy2i0PPuOqHeFeoOwtyDjfVix7/Nj3yNtBgWfF5xO06GW28SYNbAPda+JHsGknXSoexaS993+r+4cPQlzWNkgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mgsc4nn7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mgsc4nn7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 572F3C4AF09;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791839642;
	bh=IQfwp0RUGlW/wkQzSf9qCtmkP6zQfG1uJceVBTRyXLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mgsc4nn7iFmc0upbPtd0GXeuIzkZQTIWV5iy++ahNtf63M4tDf59IB0GRs2/OKt1G
	 Hb8EN9EXrCK5fkvzHDSlMt3aEKcyA2C4Jjw/wDOa4oxz95czCErDC2zUPgOyZZcD/T
	 LMdW7OQE8SNpKqIv4NNUlJEdvSar9emt3F8SfW8gwN5spnWQ4SDw1gDXG8+hTkTUWt
	 Ser7HctX/o3r4zwTJj6KRyYQvtolUI1+sxXbfQH30h+Og5gKxD+xffitp58V6nj27k
	 1Zd74rYhQO0X1q7ybsBRVvRfvOZpCGx9nUz82VhGEcBE6xmqU78fY2QsNREr78ViGC
	 RxRmnqUwiIzsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB7ACA9ED2;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Date: Tue, 13 Oct 2026 02:43:58 +0530
Subject: [PATCH v2 3/5] HID: UNCTRL: add periodic battery reporting using a
 workqueue
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-unctrl-m1-battery-v2-3-bd6752021753@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
In-Reply-To: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791839640; l=2525;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=S/iwkyiYWY5KlJarMssEtufNSZyNsbm0pqfQ6KsO5GE=;
 b=KGqB3z+XQmA+NXz5Q/WkXNb+P7/tVlB5L0BHG+iBkYoPLm0OHv7KL8cgY5tD78PrsLoVpWbWE
 gX51vPBfjhbDO8RbQfWmlG09D4g1rbHV6z1IDwJ2VK54e7rE6jUUgY7
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
index 3896468ad..d7e2f207e 100644
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
+	queue_delayed_work(system_freezable_wq, &dev->battery_work,
+			      msecs_to_jiffies(UNCTRL_BATTERY_TIMEOUT_MS));
+}
+
 /* Register the power supply of this connection and start reporting. */
 static int unctrl_battery_register(struct unctrl_dev *dev)
 {
@@ -155,6 +171,8 @@ static int unctrl_battery_register(struct unctrl_dev *dev)
 		 dev->battery_desc.name);
 
 	unctrl_fetch_battery(dev->hdev);
+	queue_delayed_work(system_freezable_wq, &dev->battery_work,
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
@@ -283,7 +303,11 @@ static void unctrl_remove(struct hid_device *hdev)
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


