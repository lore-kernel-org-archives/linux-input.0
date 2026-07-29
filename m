Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBA31A7E2
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290054; cv=none; b=lkvtTswle2wmC4VYoy3Pa3pXFd6/2k+vRdyBkvXBeazMu7W9lB1Zh72/CV9q+FWk5r3joTfoNnGztfZTLPDoHs+FJe7tEyCpcLGLTM+8YhTM/g7UzTFRLXT3rSzWMLPRN01zS7g+0KDI9dhhYCYq+z/pztAntucLOK34tvs7Bq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290054; c=relaxed/simple;
	bh=74LUm2u/f40Dl3j5nr0bBn+aGcUEKvxU1mRP2ttmUyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF0eGbF/8iq++HcxAX33tY2Sz2kAeWG8n4cGm0Q/TScQy7KAVPReQURamS6WWBsG2qbqusPGhT1HjWqOOAjH48w3XUAz73bSccIcATu+RPljeLZgUkyxxjiXgU6KMP1giRCA5VihChVhTtRIAIeY+IcETnfRsayAHLgW3zoF7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=AJFKtkVJ; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="AJFKtkVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290046; bh=74LUm2u/f40Dl3j5nr0bBn+aGcUEKvxU1mRP2ttmUyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJFKtkVJVKuQv4a4nAXVCPcoM3qYaFmCb8qsGqwXOR48IjDj4QIb16XVdxKJneEbD
	 mhIlKN8BWm+YF/oA4U6mONqt9Xf74ZnMbEVTRDpzA6ctcitytUuyiTUB07UdXOXSxk
	 nLQ9YRWD1wJlG5CXl60CX83JANool8l+5hyH66E9I0Hp+7sQyb0/k5ScQG06ru8uQI
	 HRErcHqrZx0uNPPXkrj++ClICFKoS2ygsl7Z+OHdcw5qyufJg5PABGtd3j27mwH1HJ
	 K7+zzTqvrU4dTm07VQpbZplUYEbWGxXxDlz1oTIpm/CcmpdEKqio5hD1yCZq38Uo6e
	 x661Xw1qutJvg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 08FA4A0AD;
	Tue, 28 Jul 2026 18:54:05 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 06/11] HID: steam: Coalesce rumble packets
Date: Tue, 28 Jul 2026 18:52:28 -0700
Message-ID: <20260729015243.1170573-7-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729015243.1170573-1-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
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
index cabecd250072..a200878db8ac 100644
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
@@ -602,10 +603,24 @@ static void steam_haptic_rumble_cb(struct work_struct *work)
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
@@ -615,6 +630,14 @@ static int steam_play_effect(struct input_dev *dev, void *data,
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
@@ -1359,6 +1382,7 @@ static int steam_probe(struct hid_device *hdev,
 	INIT_DELAYED_WORK(&steam->mode_switch, steam_mode_switch_cb);
 	INIT_LIST_HEAD(&steam->list);
 	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
+	INIT_DELAYED_WORK(&steam->coalesce_rumble_work, steam_coalesce_rumble_cb);
 	steam->sensor_timestamp_us = 0;
 	if (steam->quirks & STEAM_QUIRK_DECK)
 		steam->sensor_update_rate_us = 4000;
@@ -1425,6 +1449,7 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_work_sync(&steam->work_connect);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	cancel_work_sync(&steam->unregister_work);
 
 	return ret;
@@ -1443,6 +1468,7 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	cancel_work_sync(&steam->unregister_work);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
-- 
2.54.0

