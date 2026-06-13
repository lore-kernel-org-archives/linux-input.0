Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E237DEBE;
	Sat, 13 Jun 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364650; cv=none; b=LrsG+e0AC+0bVT6XH9vSeuJ36kOSb8fFA5NY4N7E4l5yQJbTcYzf2UscwyEzIS3ZCIY63XzNPpCJb3B0/SQlCZLnpvTusAZks99pFQSslLXfN3Ocrafs5kFNX042+rGVo5PRX5skroj6xFu9hpBZo0ywenAmFMXtqSiTHXPUeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364650; c=relaxed/simple;
	bh=4A9C+MRJonHGH8AKMnqTFw2JppVk6sqJ3bJzAHwgYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU8zjywl2BJV+wpZ+pPDZXmPPeuoc8RFYZkk7/4U+2QzJY7Kw/kNtkMfrxNAje7ze2o9szm5YAaizTZGAn1tvtkYLIxBk9G5iQntzTOxP1iBdkB0G3qA9TISZPWbF9zZLoWiF7yCk4p8Sa9lyFGruFgD+uAvaKBN69FMEM8e19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VcVzC1BX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VcVzC1BX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781364640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjPR/AWg2T6hDawoDr1XEJbq6oh85/Vhn3lYrwS/uus=;
	b=VcVzC1BXW9tJoBIEf5RrvQ2FEe+rtpBk72V4RnOhmDSvSbFi5828+3RaUrS9aaNR5/LfMH
	DU3GJAIGG1iiYH5sS8mIG2jcZkU6DtIUTZz0UgmDQr0RJNdLKQV5xO19J2MCPM6xz1wty5
	dEBLjmWo04/6ca7IBDTay6g8Vgqw76A=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	"Connor Belli" <connorbelli2003@gmail.com>,
	sahiko-bot@kernel.org
Subject: [PATCH v3 6/8] HID: asus: prevent a late KEY_FN_ESC to trigger a use-after-free
Date: Sat, 13 Jun 2026 15:30:27 +0000
Message-ID: <20260613153029.2559774-7-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-1-denis.benato@linux.dev>
References: <20260613153029.2559774-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A late KEY_FN_ESC event can trigger asus_event() and unconditionally call
schedule_work() after the work was supposedly canceled.

Once the driver is removed and drvdata is freed by devres, the workqueue
could execute asus_sync_fn_lock() and dereference the freed drvdata.

Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
Reported-by: sahiko-bot@kernel.org
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index a6467172c455..a65a28137f0d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -148,6 +148,7 @@ struct asus_drvdata {
 	int battery_stat;
 	bool battery_in_query;
 	unsigned long battery_next_query;
+	bool fn_lock_sync_work_disabled;
 	struct work_struct fn_lock_sync_work;
 	bool fn_lock;
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
@@ -416,7 +417,7 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
 		case KEY_KBDILLUMTOGGLE:
 			return !asus_hid_event(ASUS_EV_BRTTOGGLE);
 		case KEY_FN_ESC:
-			if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
+			if (!drvdata->fn_lock_sync_work_disabled && (drvdata->quirks & QUIRK_HID_FN_LOCK)) {
 				drvdata->fn_lock = !drvdata->fn_lock;
 				schedule_work(&drvdata->fn_lock_sync_work);
 			}
@@ -1497,8 +1498,10 @@ static void asus_remove(struct hid_device *hdev)
 		cancel_work_sync(&drvdata->kbd_backlight->work);
 	}
 
-	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
+	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
+		drvdata->fn_lock_sync_work_disabled = true;
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
+	}
 
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
 	drvdata->wmi_work_disabled = true;
-- 
2.47.3

