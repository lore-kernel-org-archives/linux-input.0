Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C31DA60D
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648931; cv=none; b=Rjh3vJgWDa4W/q6gaxdwGGyuAg9zAKG0np5PT2+mkbxLnZZ0JZydJaBo3x2ZDRZSbb4aETtKs/LJ4bfSBRTotv+cBnpH6lS0ENkTL9GEYqFoWjSo4K+00oR0VtES6+XLtMVpvzYNZe6VbRyLzGak+O80DEzpKfkx2jyUTy3gzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648931; c=relaxed/simple;
	bh=WJPdS9gsKF4SNv18epRYdmu3VAurQ2u8pHH337iyQtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDm3J7Iu6ZjN1FwZLW1BukJQN2+S7ZbkawGAM4eIssr8ziza/bMOjuB+40chrIb3eR1kpU2msX2BXeWVhRD3cOjiebkIrUGMSA7xgqGSUHpd6S6jbl6jF25F5KENwYAqKbaumzJxRk+VVn+g32n24tIBXXKB7s+prpYJoYx+Evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Pm6bQcYm; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Pm6bQcYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783648918; bh=WJPdS9gsKF4SNv18epRYdmu3VAurQ2u8pHH337iyQtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pm6bQcYmxUanaVgp5caz+P9CUQ4PSTtwvwRxtfsGlbehgzkmmk4SRaJ7OmY96HdlL
	 swKD+e+qBaUA7W3VD4seN24lmhp3ynmJeDRLT8WvCNC4JfKJfeOuunHSRMN9vgRl/T
	 Jn3/IEKx9mK/3HyICxU/ruf7X8e2K9BH8rC/H7caT24R7RFD9aDUnr+ASI3N3q/1DB
	 bX14gK05nD+3HOdBK8atuUzelASDuGycM5ebaZ/7WZu+h0wrAWudqkpdX6OPpV0A+n
	 GlXEdiSI0HreBhrBZKJs7mRho66DXmwSLGKjTHFkEU1RBCfwEG0fSS+MW5qQCZUoCd
	 9Mw0YMaLyNMxA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 740CC132030;
	Thu, 09 Jul 2026 19:01:58 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v3 07/10] HID: steam: Rearrange teardown sequences
Date: Thu,  9 Jul 2026 19:00:42 -0700
Message-ID: <20260710020048.2337655-8-vi@endrift.com>
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

This fixes a narrow window during the teardown sequences in probe and
remove where callbacks could still be scheduled during cleanup that would then
have a dangling pointer to the now-freed steam struct.

Signed-off-by: Vicki Pfau <vi@endrift.com>

HID: steam: Reorder probe
---
 drivers/hid/hid-steam.c | 67 ++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 0771ad4f5f2c..9dc77cd76edb 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1328,6 +1328,7 @@ static int steam_probe(struct hid_device *hdev,
 {
 	struct steam_device *steam;
 	int ret;
+	unsigned long flags;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -1353,6 +1354,14 @@ static int steam_probe(struct hid_device *hdev,
 	if (!steam)
 		return -ENOMEM;
 
+	/*
+	 * With the real steam controller interface, do not connect hidraw.
+	 * Instead, create the client_hid and connect that.
+	 */
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
+	if (ret)
+		return ret;
+
 	steam->hdev = hdev;
 	hid_set_drvdata(hdev, steam);
 	spin_lock_init(&steam->lock);
@@ -1369,22 +1378,6 @@ static int steam_probe(struct hid_device *hdev,
 	else
 		steam->sensor_update_rate_us = 9000;
 
-	/*
-	 * With the real steam controller interface, do not connect hidraw.
-	 * Instead, create the client_hid and connect that.
-	 */
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
-	if (ret)
-		goto err_cancel_work;
-
-	ret = hid_hw_open(hdev);
-	if (ret) {
-		hid_err(hdev,
-			"%s:hid_hw_open\n",
-			__func__);
-		goto err_hw_stop;
-	}
-
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver connected");
 		/* If using a wireless adaptor ask for connection status */
@@ -1398,14 +1391,22 @@ static int steam_probe(struct hid_device *hdev,
 			hid_err(hdev,
 				"%s:steam_register failed with error %d\n",
 				__func__, ret);
-			goto err_hw_close;
+			goto err_hw_stop;
 		}
 	}
 
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev,
+			"%s:hid_hw_open\n",
+			__func__);
+		goto err_steam_unregister;
+	}
+
 	steam->client_hdev = steam_create_client_hid(hdev);
 	if (IS_ERR(steam->client_hdev)) {
 		ret = PTR_ERR(steam->client_hdev);
-		goto err_steam_unregister;
+		goto err_hw_close;
 	}
 	steam->client_hdev->driver_data = steam;
 
@@ -1417,18 +1418,20 @@ static int steam_probe(struct hid_device *hdev,
 
 err_destroy:
 	hid_destroy_device(steam->client_hdev);
-err_steam_unregister:
-	if (steam->connected)
-		steam_unregister(steam);
 err_hw_close:
 	hid_hw_close(hdev);
-err_hw_stop:
-	hid_hw_stop(hdev);
-err_cancel_work:
+err_steam_unregister:
+	spin_lock_irqsave(&steam->lock, flags);
+	steam->client_opened = 0;
+	spin_unlock_irqrestore(&steam->lock, flags);
 	cancel_work_sync(&steam->work_connect);
+	if (steam->connected)
+		steam_unregister(steam);
 	cancel_delayed_work_sync(&steam->mode_switch);
+err_hw_stop:
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
+	hid_hw_stop(hdev);
 
 	return ret;
 }
@@ -1436,25 +1439,27 @@ static int steam_probe(struct hid_device *hdev,
 static void steam_remove(struct hid_device *hdev)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
+	unsigned long flags;
 
 	if (!steam || hdev->group == HID_GROUP_STEAM) {
 		hid_hw_stop(hdev);
 		return;
 	}
 
+	hid_hw_close(hdev);
 	hid_destroy_device(steam->client_hdev);
-	cancel_delayed_work_sync(&steam->mode_switch);
-	cancel_work_sync(&steam->work_connect);
-	cancel_work_sync(&steam->rumble_work);
-	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
-	steam->client_hdev = NULL;
+	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened = 0;
+	spin_unlock_irqrestore(&steam->lock, flags);
+	cancel_work_sync(&steam->work_connect);
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->mode_switch);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
+	hid_hw_stop(hdev);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
-- 
2.54.0

