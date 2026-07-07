Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE4C373BE6
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467235; cv=none; b=IayHdZEZCD+PHwdkKVwbvDvEbHgkKRX8zPyET53eSVcf3+rzTPp2Lg2DWY3N6iB5M7UBMSI2/JptdfwtFKb++vWbDxv63Ggp7hCMNW7TxIj2gzhIVBZW+vXFTLWpHU6N5E9BOYros2LYQPAAQlSB9a4SQEhGlHYUIpJ7+KmCqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467235; c=relaxed/simple;
	bh=YwJECNepvqjYfLzHK1VzgCrGYfZt19I9VczlhpKNuwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejBGz7sVMFLXvr5ggbXtI8GTSIarPk7nSnIxiuGAvYQVeLTMmLzjMsdVX6K5vHA8BoOUKrL9omvOgfEtTenKBHxMk7B7F3lgJ8XrbKKhkIItjwXaWP+W9dSalrwxdPB3rtRYmD2UpCSVg+d+0fXO52ZPB5NpJmrif9QR1ofFJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=mT/rVCUf; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="mT/rVCUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783467233; bh=YwJECNepvqjYfLzHK1VzgCrGYfZt19I9VczlhpKNuwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mT/rVCUf984M4H36lXCswWd9Ij9FjzZIA+kaMbNGVOz/9VJjjYCQ7jeqpg4TflHuj
	 lrutFpOa/leIpSJhWtdl8vs2r3eWyRYSrxZPcqYuRTHP2yUAzX+rf8Qy1BsQSbdqyv
	 fiRtL6xzs4Z2UMaNnUgrF5tf7gDsXBCSeiSXUms3OsjFKw4s54FEZZOblvuBuvZH6i
	 gayhnAYYR1TY98EqfQPMFwaZmTnBYA1SB0Cy5gijB4AuhI1PlDZvANePEmZCYSlcaf
	 D3sKEjQ6qpJIG5NzgvkrZG0Ro4WJxrSt704BH0m+shJkTwhHGbGJD5Y2mkZc399DKD
	 Ccomp4FgTp0AA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 35680A05C;
	Tue, 07 Jul 2026 16:33:53 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2 07/10] HID: steam: Rearrange deinitialization sequence
Date: Tue,  7 Jul 2026 16:32:27 -0700
Message-ID: <20260707233241.2644971-8-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707233241.2644971-1-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a narrow window during the deinitialization where callbacks
could still be scheduled during cleanup that would then have a dangling
pointer to the now-freed steam struct.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 3f1dbdcad23c..296ced2989a4 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1327,6 +1327,7 @@ static int steam_probe(struct hid_device *hdev,
 {
 	struct steam_device *steam;
 	int ret;
+	unsigned long flags;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -1417,6 +1418,10 @@ static int steam_probe(struct hid_device *hdev,
 err_destroy:
 	hid_destroy_device(steam->client_hdev);
 err_steam_unregister:
+	spin_lock_irqsave(&steam->lock, flags);
+	steam->client_opened = 0;
+	spin_unlock_irqrestore(&steam->lock, flags);
+	cancel_work_sync(&steam->work_connect);
 	if (steam->connected)
 		steam_unregister(steam);
 err_hw_close:
@@ -1424,7 +1429,6 @@ static int steam_probe(struct hid_device *hdev,
 err_hw_stop:
 	hid_hw_stop(hdev);
 err_cancel_work:
-	cancel_work_sync(&steam->work_connect);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
@@ -1435,6 +1439,7 @@ static int steam_probe(struct hid_device *hdev,
 static void steam_remove(struct hid_device *hdev)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
+	unsigned long flags;
 
 	if (!steam || hdev->group == HID_GROUP_STEAM) {
 		hid_hw_stop(hdev);
@@ -1442,18 +1447,20 @@ static void steam_remove(struct hid_device *hdev)
 	}
 
 	hid_destroy_device(steam->client_hdev);
-	cancel_delayed_work_sync(&steam->mode_switch);
-	cancel_work_sync(&steam->work_connect);
-	cancel_work_sync(&steam->rumble_work);
-	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	steam->client_hdev = NULL;
+	hid_hw_close(hdev);
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

