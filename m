Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23692D5432
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770229239; cv=none; b=oQKaSEx797s2cmHVkaiHkUjUoj8gVkRCun+G/WY6xzD5Qs8BzGrMpKcCN34pV4iKA/D3qjoj7emPnEX3PuW6Q9yVdZRY7oD8NqpyICWrnxtYnXOHBwNaCWVqgC4A+2Ex86OFtU4XL1rwgeJlhg5qpF/4+OIpfSp/swH+IlXlPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770229239; c=relaxed/simple;
	bh=1OJZ9w3pH+0A1cqNN4yRXjWvRKrooGbIMxdW91jxkb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mW6g3jiVSqjdnxhD4kEFV9kVk7eLwTte59Tj1Tmjgd+JGWb6CfZyZIVTUmIcAEYd1R9DyLoqHNdqD1kWdH4eki2jFB+Io/7DjjBbXM0zcKTfnH+M3eVNTNQUpW77Dhql64ZKDqj4lSmLOQ4GvA3zplPeAOmHlzPHfj6F5XBYtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4VyrFv+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4VyrFv+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a90055b9e9so685565ad.1
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2026 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770229239; x=1770834039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUEqY7Elf3v+fO71b69COKkIcYYp9M1x48maF82X5UI=;
        b=d4VyrFv+NkIxnobpzENEk9w65w68Mky8v9v/eYlAa7/nSwCzOJZSEnSt72/XNRmtur
         HE4Y61aP6zQeHzR1wE+mwdd1HIbzK1nK8dBk5h7IjaJSB/D2Yc5ZvWDhbkAuJ2ec1itN
         4ajTLjf9Sz5bnjk4ZdIJoHQcchyHu0CzRTN9+1cNQbcIT8mAnPT0AyZ5OAeAdlaEezwZ
         b4082v1zEOf+JFAaJf+6wnWExLdQ3cFl/CTv/FIk0tJ2fn445OerqYTxLp7yAx/XG7wR
         8p0BgaxEH010wvBardYuxLn89OOV2s6XEFa/aVgnx3dpFIL75ZWux/NrV3834leDnKIt
         l/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770229239; x=1770834039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUEqY7Elf3v+fO71b69COKkIcYYp9M1x48maF82X5UI=;
        b=ArBlRh+HaH33UQc6cVHUPYUxA6wMJilHhF0VomV8OutLDBYCtkru8vmrS9SLgAASqz
         SlM9U2zNeDZUVRt3k6ajLe0i66i97muvObLGWb1pYYrHZccQ7KGfoc5t+9FIFpX72Wv+
         muuSCP+SUPYu+dZRFJUPNFHB+8g/dDkCahgQdiY1iJtg8jdsk1JKcdlgYveWiAsy/6Oh
         H+Tg2qMk1hmx9H/sjAtzhVQNov8Ii08aH8VMVdndTbqTkSG9kfXYLFf0wnq+0BjBG8NR
         McGzOZ+7wWqhvnbm01f05jwTAe5jxa1jt05/JxIF8ofNJ1xq55W0oR3ktxDc5IwAXMU6
         JQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCUbBYNC8GR+gFKZ92ceVIue0lityy/i2BmxEYhzi4yv/Eq6pHTFPTbuAnP0svg08tRi7MRyYNAO4l37Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3sQp849PlCuHK1hj2SJvSqJ7jVmc6O4f0xmusag4c3HcXLdJ
	vnf5xFmo8BxdymdspTrmXN1h1jL7iEUpYtQTfIHHxwHrFy3b+Gdvu9YU
X-Gm-Gg: AZuq6aJkfIV2mgAknD0+W8CSi/udSehaAQV54VjN1L6DGA5afYc9wOuNtEvK73zQUER
	pzgYL8jM4bL8PprNAyIQM5dMKE3YwJzkQa7K0P4nSVFy2s5jN/mS2upISXjBjw+sk1x/48Zs5Z+
	qhLbh/BTDUdXVZIUvzh0MZT4E+dz5aL5cxczvaBimMzHc07AfK7KNSaJWUQzyNEWmyFj15/ElaI
	FilpHwvs6j/QXoE5zRpkW7PMyDDBE9C3Ln/scPSfmKOX8iWeFIixM9KspEXha47wQ/vNFr7/0be
	OUvt/52n+UQlHWYgt5pSgqEHIHW5CtIJj3MpGYvIjpYcGAkH1GPIyI7pEVPKfvIxMhDCN34AR6o
	P3LU9yjRxP1eyAngMwawRfolYsMtME6Wyx7D1Umkc/33PbKHgvOb4PKQ5/TfF6DNhMQM9fhf/da
	6KM8ebWfCiBA7bbvyv2Unxn0p17A==
X-Received: by 2002:a17:902:d488:b0:2a8:a133:dfed with SMTP id d9443c01a7336-2a933fdc6bfmr35752495ad.55.1770229238979;
        Wed, 04 Feb 2026 10:20:38 -0800 (PST)
Received: from chandna.localdomain ([106.222.233.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397ee2asm30417715ad.98.2026.02.04.10.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 10:20:38 -0800 (PST)
From: Sahil Chandna <chandna.sahil@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	connorbelli2003@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu
Cc: Sahil Chandna <chandna.sahil@gmail.com>,
	syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
Subject: [PATCH v2] HID: asus: synchronize fn_lock_sync_work initialization and teardown
Date: Wed,  4 Feb 2026 23:50:29 +0530
Message-ID: <20260204182029.278659-1-chandna.sahil@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a workqueue warning where cancel_work_sync() was
called on an uninitialized work_struct. Fix this by adding a mutex lock and
initializing fn_lock_sync_work before marking fn_lock as enabled.
This ensures cancel_work_sync() is only called for an initialized work.

Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
Reported-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=13f8286fa2de04a7cd48
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>
---
link to v1: https://lore.kernel.org/all/20260130155204.96831-1-chandna.sahil@gmail.com/
changes since v1:
- Add mutex locking between init_work and cancel_work.

Testing:
- Reproduced bug on local setup and original syz reproducer.
- Tested with fix and original C reproducer, issue is not reproduced
locally.
---
 drivers/hid/hid-asus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 1b9793f7c07e..2d6b6e363bde 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -147,6 +147,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct work_struct fn_lock_sync_work;
 	bool fn_lock;
+	struct mutex lock;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -960,8 +961,10 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	}
 
 	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
-		drvdata->fn_lock = true;
+		mutex_lock(&drvdata->lock);
 		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
+		drvdata->fn_lock = true;
+		mutex_unlock(&drvdata->lock);
 		asus_kbd_set_fn_lock(hdev, true);
 	}
 
@@ -1258,6 +1261,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
 	drvdata->hdev = hdev;
+	mutex_init(&drvdata->lock);
 
 	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
 		ret = asus_battery_probe(hdev);
@@ -1343,8 +1347,10 @@ static void asus_remove(struct hid_device *hdev)
 		cancel_work_sync(&drvdata->kbd_backlight->work);
 	}
 
-	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
+	mutex_lock(&drvdata->lock);
+	if ((drvdata->quirks & QUIRK_HID_FN_LOCK) && drvdata->fn_lock)
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
+	mutex_unlock(&drvdata->lock);
 
 	hid_hw_stop(hdev);
 }
-- 
2.50.1

