Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777AC36F912
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467235; cv=none; b=TaF9dxhuhdyPZBCb/vU/1alPRZ3HIFVgLklOLvyDmlzGZd3wyvbYl3DhXQ3uWg8VLwxtulPAAM/0K8Zh0Qby7aBlRvOXvO5T6ICRtljrkD+pKEETBfowX6uyOS/xcxSE6YHxGwBmO4HKcQZUHhVXBenWsNClQ9UGBo70YoJ4G2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467235; c=relaxed/simple;
	bh=Zj24FLtKgD0kFbR3Zi0nvuD1dGagIdJnjGNamuAyFxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFtMB6erQh9DAcIU2xOqF3ixocQeCitd8Ey5nbnfhSvUNipTyMx10fmYDm1Q6NesGd9xUp/XOBD11iTuYfiVYLSj3W0LcwEj+WhkdcUxc7nko39TL3MME3ZL6GGAog0ZAjtKvVnLWEhg9e1lKk7417Z46H9lbw/Bvrm0Re8E1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=wg/2HoF6; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="wg/2HoF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783467232; bh=Zj24FLtKgD0kFbR3Zi0nvuD1dGagIdJnjGNamuAyFxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wg/2HoF6Mas7yYy7z0tiRikxNRYweFT6JDqD7MFKZaGe4RcmImSVF84z/NElG2PtE
	 Lk/YPPQrjkgjPjaY+eLYGo2W+Q2LfzKzSC2S/xcSMKqhfo8zVH0RrbxU0nn5VV7Y6u
	 DesVc3UwjLTM3sUeQySSXuZSfCSIGnTrbcU8C3u3xIycZ4bmpJg9m1spYL4Uoy7cEk
	 joJP/FEe2OiXkVRc7A/9SYFDpkQ5SqIWI4x104LU/6xzEcf8IJ7tEzw7W4S66u/twP
	 DyfwTEpCtFR1bffvef6nsbfdqCKos+L3fX/k2UUoHnnbSp0B/9W2QxEWMThLqel71F
	 12sL8W8s7Ql0w==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 64D81A0D4;
	Tue, 07 Jul 2026 16:33:52 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2 05/10] HID: steam: Coalesce rumble packets
Date: Tue,  7 Jul 2026 16:32:25 -0700
Message-ID: <20260707233241.2644971-6-vi@endrift.com>
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

The Steam Deck resets the haptic pattern every time it receives a rumble
packet, leading to weird discontinuities or sometimes cutting out entirely.
Instead of overloading the interface, Steam interally rate-limits sending
these packets, so we should too.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 6029c055a6cf..553748813901 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -343,6 +343,7 @@ struct steam_device {
 	bool did_mode_switch;
 	bool gamepad_mode;
 	struct work_struct rumble_work;
+	struct delayed_work coalesce_rumble_work;
 	u16 rumble_left;
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
@@ -603,10 +604,24 @@ static void steam_haptic_rumble_cb(struct work_struct *work)
 {
 	struct steam_device *steam = container_of(work, struct steam_device,
 							rumble_work);
+
 	steam_haptic_rumble(steam, 0, steam->rumble_left,
 		steam->rumble_right, 2, 0);
 }
 
+static void steam_coalesce_rumble_cb(struct work_struct *work)
+{
+	struct steam_device *steam = container_of(to_delayed_work(work),
+							struct steam_device,
+							coalesce_rumble_work);
+
+	steam_haptic_rumble(steam, 0, steam->rumble_left,
+		steam->rumble_right, 2, 0);
+
+	if (steam->rumble_left || steam->rumble_right)
+		schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
+}
+
 #ifdef CONFIG_STEAM_FF
 static int steam_play_effect(struct input_dev *dev, void *data,
 				struct ff_effect *effect)
@@ -616,6 +631,14 @@ static int steam_play_effect(struct input_dev *dev, void *data,
 	steam->rumble_left = effect->u.rumble.strong_magnitude;
 	steam->rumble_right = effect->u.rumble.weak_magnitude;
 
+	/*
+	 * The interface gets somewhat overloaded when too many rumble
+	 * packets are sent in a row, so Steam throttles it to 20 Hz
+	 */
+	if (delayed_work_pending(&steam->coalesce_rumble_work))
+		return 0;
+
+	schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
 	return schedule_work(&steam->rumble_work);
 }
 #endif
@@ -1360,6 +1383,7 @@ static int steam_probe(struct hid_device *hdev,
 	INIT_DELAYED_WORK(&steam->mode_switch, steam_mode_switch_cb);
 	INIT_LIST_HEAD(&steam->list);
 	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
+	INIT_DELAYED_WORK(&steam->coalesce_rumble_work, steam_coalesce_rumble_cb);
 	steam->sensor_timestamp_us = 0;
 	if (steam->quirks & STEAM_QUIRK_DECK)
 		steam->sensor_update_rate_us = 4000;
@@ -1426,6 +1450,7 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_work_sync(&steam->work_connect);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	cancel_work_sync(&steam->unregister_work);
 
 	return ret;
@@ -1444,6 +1469,7 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	cancel_work_sync(&steam->unregister_work);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
-- 
2.54.0

