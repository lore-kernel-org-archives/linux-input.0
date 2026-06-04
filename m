Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F34779A4;
	Thu,  4 Jun 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578745; cv=none; b=YkcTPgGQ2412amkYNyOlrUuhGmluXMY/TWT+wpnAgvBDMAuePAxqfFpBvsVqOboQ7EfBMQe+gvSqK40NtdoLct+UHpsvYUjGKnB4qfoPUjS5rUMkcEPlKoOOB7oXnrZ45rhEQ1UVMJiGEpppHlAuDWgpEQcXVaatolKgPjpEMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578745; c=relaxed/simple;
	bh=pf65ju/mavuh5kTZ4r4j2wMpzNmGQTx2ej5mdAbXamc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iXLT3apXuVG43U8PbGoSRHYO5dWsXD39dvBmyNI9heTqhQpJDegpbhW0K7k/Omu4Tf0SsYGK9WwPDQTvoQtsdwCQo264d2jNIxBTQ6kQG++YxvlKZf2C6tJCVnvBkGp445umHAFeHDWVQPAc3lI9duR4i+UOnAXNVeWi5JSoE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aL4i0Yqh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aL4i0Yqh"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F1A9927312;
	Thu,  4 Jun 2026 15:12:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIytdCoCojGy; Thu,  4 Jun 2026 15:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780578737; bh=pf65ju/mavuh5kTZ4r4j2wMpzNmGQTx2ej5mdAbXamc=;
	h=From:To:Cc:Subject:Date;
	b=aL4i0YqhtiPU30zgxA3UVQErOtmEGr4FVChN49BqsJLKYWIhwMtbsYyt1g5DYv+w5
	 DjYcUbbX6SyVMh8LF3bAcxyR2Q31l4KXe+HF2QLGLgvamYDKhGIOsbo0txuaUdEB4k
	 T/tYWZOFihPIqzMGuKv98qLJ2SmGuMNxRz32uUrCB9hRRWg1hBPlPGK+QgjhD1l+wx
	 MVJZFY6JUJGlhGR5SunV0cX0RgpGrTiORUIKrsm242sv8Efblw+KtyyVWqF6+HoCFK
	 RQ2uxArF8bzpQz8jopkwnAmYMR26BGtWD6t9Xw2rgNDuOqb2kMvsiMZjydjBdXXhuG
	 9gf0EowFCJ0Vw==
From: =?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	marco.crivellari@suse.com,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH] Input: psmouse-smbus - schedule deferred rescan when adapter present but device not ready
Date: Thu,  4 Jun 2026 09:12:11 -0400
Message-ID: <20260604131211.9442-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On some machines (e.g.: ThinkPad T440p 20AWS0H800) the Intel LPSS I2C
adapter that hosts the Synaptics RMI4 touchpad is already registered
by the time psmouse probes during early boot.  psmouse_smbus_init()
finds that adapter via i2c_for_each_dev(), but i2c_new_scanned_device()
fails because the device at 0x2c is not yet responsive; -EAGAIN is
returned with breadcrumbs left in psmouse_smbus_list.

Because the adapter is already registered, BUS_NOTIFY_ADD_DEVICE has
already fired for it and will not fire again.  The breadcrumb sits
idle until some other HOST_NOTIFY-capable adapter happens to appear
later and incidentally triggers psmouse_smbus_check_adapter().  When
this happens is non-deterministic: on one boot the rescan fires at
~11 s, on another at ~200 s, on a third never within the observation
window.  The touchpad falls back to PS/2 mode in the interim.

Fix this by scheduling a one-shot deferred serio_rescan() from
psmouse_smbus_init() whenever a HOST_NOTIFY adapter was found but the
companion device was not yet ready.  The work fires asynchronously
(1 s delay) without blocking the boot path, exactly as
psmouse_smbus_check_adapter() already does for late-arriving adapters.
If the device is still not ready on that attempt, a fresh breadcrumb
is left and the work is re-queued, retrying until the device responds.

rescan_work is always INIT_DELAYED_WORK'd so that
cancel_delayed_work_sync() is safe to call unconditionally in all
cleanup paths.  All paths that free a psmouse_smbus_dev are
restructured to release psmouse_smbus_mutex before calling
cancel_delayed_work_sync(), preventing a deadlock with the work
function which also acquires that mutex.

Fixes: 2a02f6c8af14 ("Input: psmouse - fix SMBus companion")
Tested-by: Raphaël Larocque <rlarocque@disroot.org>
Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
---
 drivers/input/mouse/psmouse-smbus.c | 168 ++++++++++++++++++++++------
 1 file changed, 131 insertions(+), 37 deletions(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index 7fb4cbb2aca2..704d8c2a028b 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -21,6 +21,8 @@ struct psmouse_smbus_dev {
 	struct list_head node;
 	bool dead;
 	bool need_deactivate;
+	bool adapter_seen;		/* HOST_NOTIFY adapter found, device not yet ready */
+	struct delayed_work rescan_work;
 };
 
 static LIST_HEAD(psmouse_smbus_list);
@@ -28,6 +30,13 @@ static DEFINE_MUTEX(psmouse_smbus_mutex);
 
 static struct workqueue_struct *psmouse_smbus_wq;
 
+/*
+ * Delay before re-scanning after a HOST_NOTIFY adapter was present but the
+ * companion device did not respond.  The rescan is asynchronous so this does
+ * not add latency to the boot path.
+ */
+#define PSMOUSE_SMBUS_RESCAN_DELAY_MS	1000
+
 static void psmouse_smbus_check_adapter(struct i2c_adapter *adapter)
 {
 	struct psmouse_smbus_dev *smbdev;
@@ -57,32 +66,68 @@ static void psmouse_smbus_check_adapter(struct i2c_adapter *adapter)
 	}
 }
 
-static void psmouse_smbus_detach_i2c_client(struct i2c_client *client)
+/*
+ * psmouse_smbus_rescan_work_fn - deferred rescan when adapter was present
+ * but companion device was not yet ready during psmouse_smbus_init().
+ *
+ * On some machines (e.g. ThinkPad T440p) the LPSS I2C adapter is already
+ * registered by the time psmouse probes, so BUS_NOTIFY_ADD_DEVICE has
+ * already fired and will not fire again.  If the RMI4 device at 0x2c was
+ * not yet responsive at probe time, nothing would ever trigger a rescan.
+ * This work item closes that gap by calling serio_rescan() asynchronously,
+ * exactly as psmouse_smbus_check_adapter() does for late-arriving adapters.
+ */
+static void psmouse_smbus_rescan_work_fn(struct work_struct *work)
 {
-	struct psmouse_smbus_dev *smbdev, *tmp;
+	struct psmouse_smbus_dev *smbdev =
+		container_of(to_delayed_work(work),
+			     struct psmouse_smbus_dev, rescan_work);
 
 	guard(mutex)(&psmouse_smbus_mutex);
 
-	list_for_each_entry_safe(smbdev, tmp, &psmouse_smbus_list, node) {
-		if (smbdev->client != client)
-			continue;
+	if (!smbdev->dead && !smbdev->client) {
+		psmouse_dbg(smbdev->psmouse,
+			    "SMBus adapter present but device not yet ready, retrying\n");
+		serio_rescan(smbdev->psmouse->ps2dev.serio);
+	}
+}
 
-		kfree(client->dev.platform_data);
-		client->dev.platform_data = NULL;
+static void psmouse_smbus_detach_i2c_client(struct i2c_client *client)
+{
+	struct psmouse_smbus_dev *smbdev, *tmp;
+	LIST_HEAD(orphans);
 
-		if (!smbdev->dead) {
-			psmouse_dbg(smbdev->psmouse,
-				    "Marking SMBus companion %s as gone\n",
-				    dev_name(&smbdev->client->dev));
-			smbdev->dead = true;
-			device_link_remove(&smbdev->client->dev,
-					   &smbdev->psmouse->ps2dev.serio->dev);
-			serio_rescan(smbdev->psmouse->ps2dev.serio);
-		} else {
-			list_del(&smbdev->node);
-			kfree(smbdev);
+	scoped_guard(mutex, &psmouse_smbus_mutex) {
+		list_for_each_entry_safe(smbdev, tmp, &psmouse_smbus_list, node) {
+			if (smbdev->client != client)
+				continue;
+
+			kfree(client->dev.platform_data);
+			client->dev.platform_data = NULL;
+
+			if (!smbdev->dead) {
+				psmouse_dbg(smbdev->psmouse,
+					    "Marking SMBus companion %s as gone\n",
+					    dev_name(&smbdev->client->dev));
+				smbdev->dead = true;
+				device_link_remove(&smbdev->client->dev,
+						   &smbdev->psmouse->ps2dev.serio->dev);
+				serio_rescan(smbdev->psmouse->ps2dev.serio);
+			} else {
+				list_del(&smbdev->node);
+				list_add_tail(&smbdev->node, &orphans);
+			}
 		}
 	}
+
+	/*
+	 * Cancel any pending rescan work and free outside the mutex to avoid
+	 * a potential deadlock with the work function.
+	 */
+	list_for_each_entry_safe(smbdev, tmp, &orphans, node) {
+		cancel_delayed_work_sync(&smbdev->rescan_work);
+		kfree(smbdev);
+	}
 }
 
 static int psmouse_smbus_notifier_call(struct notifier_block *nb,
@@ -166,23 +211,29 @@ static void psmouse_smbus_schedule_remove(struct i2c_client *client)
 static void psmouse_smbus_disconnect(struct psmouse *psmouse)
 {
 	struct psmouse_smbus_dev *smbdev = psmouse->private;
+	struct psmouse_smbus_dev *free_smbdev = NULL;
 
-	guard(mutex)(&psmouse_smbus_mutex);
+	scoped_guard(mutex, &psmouse_smbus_mutex) {
+		if (smbdev->dead) {
+			list_del(&smbdev->node);
+			free_smbdev = smbdev;
+		} else {
+			smbdev->dead = true;
+			device_link_remove(&smbdev->client->dev,
+					   &psmouse->ps2dev.serio->dev);
+			psmouse_dbg(smbdev->psmouse,
+				    "posting removal request for SMBus companion %s\n",
+				    dev_name(&smbdev->client->dev));
+			psmouse_smbus_schedule_remove(smbdev->client);
+		}
 
-	if (smbdev->dead) {
-		list_del(&smbdev->node);
-		kfree(smbdev);
-	} else {
-		smbdev->dead = true;
-		device_link_remove(&smbdev->client->dev,
-				   &psmouse->ps2dev.serio->dev);
-		psmouse_dbg(smbdev->psmouse,
-			    "posting removal request for SMBus companion %s\n",
-			    dev_name(&smbdev->client->dev));
-		psmouse_smbus_schedule_remove(smbdev->client);
+		psmouse->private = NULL;
 	}
 
-	psmouse->private = NULL;
+	if (free_smbdev) {
+		cancel_delayed_work_sync(&free_smbdev->rescan_work);
+		kfree(free_smbdev);
+	}
 }
 
 static int psmouse_smbus_create_companion(struct device *dev, void *data)
@@ -199,6 +250,14 @@ static int psmouse_smbus_create_companion(struct device *dev, void *data)
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HOST_NOTIFY))
 		return 0;
 
+	/*
+	 * Remember that a suitable adapter was seen; if the device scan
+	 * below fails (device not yet ready), we know to schedule a deferred
+	 * rescan rather than relying solely on BUS_NOTIFY_ADD_DEVICE (which
+	 * won't fire again for an already-registered adapter).
+	 */
+	smbdev->adapter_seen = true;
+
 	client = i2c_new_scanned_device(adapter, &smbdev->board,
 					addr_list, NULL);
 	if (IS_ERR(client))
@@ -212,15 +271,32 @@ static int psmouse_smbus_create_companion(struct device *dev, void *data)
 void psmouse_smbus_cleanup(struct psmouse *psmouse)
 {
 	struct psmouse_smbus_dev *smbdev, *tmp;
+	LIST_HEAD(orphans);
 
-	guard(mutex)(&psmouse_smbus_mutex);
-
-	list_for_each_entry_safe(smbdev, tmp, &psmouse_smbus_list, node) {
-		if (psmouse == smbdev->psmouse) {
-			list_del(&smbdev->node);
-			kfree(smbdev);
+	scoped_guard(mutex, &psmouse_smbus_mutex) {
+		list_for_each_entry_safe(smbdev, tmp, &psmouse_smbus_list, node) {
+			if (psmouse == smbdev->psmouse) {
+				/*
+				 * Prevent the work function from calling
+				 * serio_rescan() after we release the mutex.
+				 */
+				smbdev->dead = true;
+				list_del(&smbdev->node);
+				list_add_tail(&smbdev->node, &orphans);
+			}
 		}
 	}
+
+	/*
+	 * Cancel any pending rescan work outside the mutex.  The work
+	 * function also takes psmouse_smbus_mutex, so calling
+	 * cancel_delayed_work_sync() under it would deadlock if the work
+	 * happened to be running concurrently.
+	 */
+	list_for_each_entry_safe(smbdev, tmp, &orphans, node) {
+		cancel_delayed_work_sync(&smbdev->rescan_work);
+		kfree(smbdev);
+	}
 }
 
 int psmouse_smbus_init(struct psmouse *psmouse,
@@ -249,6 +325,12 @@ int psmouse_smbus_init(struct psmouse *psmouse,
 		}
 	}
 
+	/*
+	 * Always initialise the delayed work so cancel_delayed_work_sync()
+	 * is safe to call unconditionally in all cleanup paths.
+	 */
+	INIT_DELAYED_WORK(&smbdev->rescan_work, psmouse_smbus_rescan_work_fn);
+
 	if (need_deactivate)
 		psmouse_deactivate(psmouse);
 
@@ -290,6 +372,18 @@ int psmouse_smbus_init(struct psmouse *psmouse,
 		}
 
 		kfree(smbdev);
+	} else if (smbdev->adapter_seen) {
+		/*
+		 * A HOST_NOTIFY-capable adapter was already registered when we
+		 * scanned (so BUS_NOTIFY_ADD_DEVICE has already fired for it
+		 * and won't fire again), but the companion device at 0x2c was
+		 * not yet responsive — typical of a cold boot on machines like
+		 * the ThinkPad T440p.  Schedule a deferred rescan so we retry
+		 * without blocking the boot path, mirroring what
+		 * psmouse_smbus_check_adapter() does for late-arriving adapters.
+		 */
+		queue_delayed_work(psmouse_smbus_wq, &smbdev->rescan_work,
+				   msecs_to_jiffies(PSMOUSE_SMBUS_RESCAN_DELAY_MS));
 	}
 
 	return error < 0 ? error : -EAGAIN;
-- 
2.53.0

