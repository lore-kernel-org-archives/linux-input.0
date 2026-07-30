Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9B39AD49
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384876; cv=none; b=eRVmdJBsetSA4VGzSWLgnG/qHaf7GOYWpdpvnUROcHOapUxyl5fKy8vI0dzAw14DMFGPQossxosVvh8ic8z7ZBHhfxNq2Sq1m8lPOT/E28Jy+3hb1nzoTJxx7urZgKT5StETY9v/Fupj9IUca2al75gbth9EzRJ547gdbcgAn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384876; c=relaxed/simple;
	bh=RDqovF8HKQfVEDypBjUTleQORNNmBfmdUPj8y6Cepv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHrGMFoQPeQlQF/vOC/ZT4a8zMyicfRZoZHryyN2PgVJ4rCgK0HdvE3P6M18iZAlA360DH6IfjJl/Rfavr4C+N+Z453fzanb/VoPcndc8U7hjUkHshT3sGTIPP2qyDIRwoUQWkzg6ABO/HIQjPWa/wtev7qF2xLZCHQiNUFb33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=d1rw8o9b; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="d1rw8o9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384868; bh=RDqovF8HKQfVEDypBjUTleQORNNmBfmdUPj8y6Cepv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1rw8o9bEZkjSn00sAcSJH6Wrt1Slxpj/KGJ9J3JC7mIvjdmmGLpSfjKOeGMbRovc
	 sYYMwWdUnzxZkOeqnfuarWSAalH5R2in/Q2vTeFVfrbnb1Wvmegm4jW9alxYmPkWOO
	 yu/1qLNkiiTnH3drF1Wx713oN8cUudK+K3/BE1QoYiWOP3Pjm5SE1mITWP8ioMPUg3
	 xzYXqwDP7uf7dD0KFG8poRu3PoOwf1BZs1STFT3EMzX0ZSV4vFn36IPU3f13yes6+P
	 EAAv9glA63+JBRTGlnewoO8Vh7TX2/R5gTtQXntmNJF3aW9UtLrj7kQSD5UyyDZicZ
	 uOkokn3M9bpMg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 632C4132037;
	Wed, 29 Jul 2026 21:14:28 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 07/11] HID: steam: Rearrange teardown sequence
Date: Wed, 29 Jul 2026 21:12:30 -0700
Message-ID: <20260730041251.1659029-8-vi@endrift.com>
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

This fixes a narrow window during the teardown sequence where callbacks
could still be scheduled during cleanup that would then have a dangling
pointer to the now-freed steam struct.

This also puts work canceling for rumble and mode switch in
steam_unregister, as that shouldn't persist while the client hdev is open.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 12203d61922f..663fda8a86fd 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1156,6 +1156,9 @@ static void steam_unregister(struct steam_device *steam)
 	steam_battery_unregister(steam);
 	steam_sensors_unregister(steam);
 	steam_input_unregister(steam);
+	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->mode_switch);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	mutex_lock(&steam_devices_lock);
 	list_del_init(&steam->list);
 	mutex_unlock(&steam_devices_lock);
@@ -1441,25 +1444,24 @@ static int steam_probe(struct hid_device *hdev,
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
+	hid_hw_stop(hdev);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
-- 
2.54.0

