Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25BE39A05C
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384876; cv=none; b=Zol6CRwJVsqKX2cwnCf15+qne1j6QBte9Px7a7cj8otvBZz7iPt/H8rFFxrsTUyc9KYr/ajCq65YlfbZHtOBHFYlSRqsHeDoQ7vEgl4Tl3x6jpbOklIH5Hg+YM+zlUNVV5eFdtiPEc4XVVty+nNo2+0t8wyEPao7Lz3ly9jaymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384876; c=relaxed/simple;
	bh=XPnhSMiT/d0gznbRi5pLU7+hiyh6qvka/ZcsaeGuFVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtjaoPY9HMC+cX7tk5yX7a0qkKtgMpEqeRcfFfC1ypjWG1I5GW2G147dQZekZrS56UVAj0WFaUzLaWLTH6Ay0xF3JeBCy3nrobXzbgvzGXpecoHOgajProhNPwD+5q1ChMH8CGfULJ6mBqThxn5wSoEEHm6zXmsl9z7FKDBvJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=KiwhGyyO; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="KiwhGyyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384867; bh=XPnhSMiT/d0gznbRi5pLU7+hiyh6qvka/ZcsaeGuFVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiwhGyyOMH3DMD4LVzm6pHP5AFyQtOxtp0ikG0N2DZq+PaaosXD15docjES2KHlB0
	 au2SSaxGdwGW+zqkb7Gab+BOdJUYXHWPxyzlvmn2lNbdfO24qHUhRT563E06Nn4NJT
	 D5X62Fp0RPv0AGPRbD4qj5b5EpcUY5PyUCk9HWT/1EayzGyuL0RdtV3mmflF2o/xQg
	 A2nv7ZAw88zXDws3Vjx0unr8aiwJnNYSVe3IBooy18CUZgVAx6BlTS7oWbG1Qs0Kp3
	 wkcZv9KiiBuTt+QM8F3gIkiw/fLNvOjkMNST6qBz/hzfMHvoyXfwbAO4wxrHsfQbGD
	 jOMGOs5BMZ7vw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 8E9B6132034;
	Wed, 29 Jul 2026 21:14:27 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 05/11] HID: steam: Coalesce rumble packets
Date: Wed, 29 Jul 2026 21:12:28 -0700
Message-ID: <20260730041251.1659029-6-vi@endrift.com>
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

The Steam Deck resets the haptic pattern every time it receives a rumble
packet, leading to weird discontinuities or sometimes cutting out entirely.
Instead of overloading the interface, Steam interally rate-limits sending
these packets, so we should too.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 1ceb044e170b..87b3817a2f69 100644
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

