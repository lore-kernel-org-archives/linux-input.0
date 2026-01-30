Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F833A9D3
	for <linux-input@vger.kernel.org>; Fri, 30 Jan 2026 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788337; cv=none; b=r9AtOE5JAATl5LHlwU0Zp1SabgVkZGkh55iWZ0R7eEbPUpmlUbSkTSj/uxYm3y1dovtJmYm4Hiwq8bGKOMMyyd16rdN8j+zzBejzcWhIJIpAos+/kgiDVgdZURqmQ4uyi8I1oiu/Nny0jwvO+UDD1Aj3Zp/qDJ0dXCRotLiUwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788337; c=relaxed/simple;
	bh=aOn0zKgktrR/dJ0qnkNJB5RH5iaBZO2j7mYYORTlGns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvs/xFpxRfKGG6XAUcpG34b+dPbv92jcJ1Ga1apuK9eBPOvFXP9RTi0fUfpUsTEnHVncjMG8O34pj1EH45BwjYoCv52uYVDRdb6GnSFIznTKkjrLRmtFal/dgF5ijehcQXwlvIUpL27aitQc7tAnoyjjNLApraVEF95UjuAYAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYa/H1cI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYa/H1cI"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c551edc745eso1088171a12.2
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2026 07:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769788336; x=1770393136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0nr7kLygIkn4gygXUJpzcRLikAfYanLXoCp6q8pPKk=;
        b=fYa/H1cIK9kKTa2rdwRO6HuDIx1ONPbqWjJKWhbyt/qaSttRCKjZ+XqXmmwU6OQMjd
         vsxolgmP2mkzVX8t0OUD+Qtc81UAKVhwOEieK/JW+19LnD2lXMuvmaIX6p42EiCVG+ok
         TDOCzR5NsH0Ww4Z98OVfDlQq4OqUXpEcXT8rmAevyBge/yPsNWkpX8VjjXJeqIFPSGiM
         cEHMeNaWa5pnXuYDmiJLbLsVth7rsyEXOKXLCfshoX8sJdSku3FzPwIGJzrDZSFn2iDV
         10G00vXeB1dXEDUfSXp3U4IbQ/kH4AXz3qnmIHIoK6H4XeTNI4HaANMkrQNw3s7TJC+7
         HVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788336; x=1770393136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0nr7kLygIkn4gygXUJpzcRLikAfYanLXoCp6q8pPKk=;
        b=ObaJibp/CjoNsgiDuz9sHFHUSdq3RPKUYvYrl6PrPO8I8TjyNdgLao44YVg2C3H/Hv
         hXj0F0aoItEA0tBbZ6T3YOaHzpVvH9W2jqEUlkyq1OcqiWIg/6rY3r9QuhjS+duUGVmm
         LEFrTsCcZUTrRRGbfcyem4hWiaws4sB4eYEGIZv3w07Gjb9g/kwYyA5ETzkL0vQ+GbHX
         eX1dHjsDjzbOZzya/LyOlGb/08EFviQkxroXgruzktU50hh/7C8mgHO3aMc3mrEvE8WT
         UcPugnHZloWLK+NAD5BDTiynjAjT10IGCt5mrjHOM8ll2pklAC+5tdRm5RbCl87FhDWc
         zBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnKBrNSZWjOGeUj1NTJpIuOy92+k5R19WoCpZ8+6muoqjQT0J85LoIu5UkB59auOrfXIhUNuVsp+h/dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKut8HQd7A7edTL1RKPEnOpIjOtgVOXSB54tHcowedrFM/r6/l
	H4ZJU/oYStM9kNnE9rVNrl4NiD/02Fgr373vVeeG/A63uO0hP/vfzkJ0uWSN2Q==
X-Gm-Gg: AZuq6aI3mHM6NXID/l0EdsLTDG1c5++FaNoUoYJqFzVwGiVLdO7fESaRGBot3y5wMGM
	nzsHi3PKDK9RqeerI8ikCkQeAIxSULsXnBOuHmyeQzPIX9ybn0gWyKIax+WTBkKCy5r0Zi1TS6S
	bd/6YxsFxnteJp9ipljNX0ohkG8wAgFUHpY1DZakGOLWYV+petd9XPIPpCKKrhtVQGxQeeT81GA
	qVS2ReB6Y/HLoneOzX6AGenfIZioOSB+h3mcelUgzALmghVjraLrWU1tG23zxMrNacMR+JhCZGX
	vd5rBuI0WRJlUxiPeCeGucqqPCOgSMT1FvA/fcXe3szyayirTxpnbiC1Bo7mnnSuZnu3HFkD61x
	ajfIANoeWYWAV55I1rwhfX6IQA1uG+1diEEAC5bMfFLZbq4Wi4DNAUk19x3ekPjfcTNeFhlWT6S
	WfG08Yc5r+zJyfjjeqlCX8N9lOD6I=
X-Received: by 2002:a17:90b:5705:b0:343:7714:4cab with SMTP id 98e67ed59e1d1-3543b3b22e8mr3079599a91.22.1769788335410;
        Fri, 30 Jan 2026 07:52:15 -0800 (PST)
Received: from chandna.localdomain ([106.222.232.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b4ea8bsm10607509b3a.22.2026.01.30.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:52:14 -0800 (PST)
From: Sahil Chandna <chandna.sahil@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	connorbelli2003@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sahil Chandna <chandna.sahil@gmail.com>,
	syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
Subject: [PATCH] HID: asus: Add check for cancelling fn_lock_sync_work
Date: Fri, 30 Jan 2026 21:22:04 +0530
Message-ID: <20260130155204.96831-1-chandna.sahil@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a workqueue warning where fn_lock_sync_work is cancelled
during device removal before the work has been initialized. This can
happen when the device is disconnected while initialization is still
in progress.
Fix this by initializing fn_lock_sync_work before marking fn_lock as
enabled, and by using fn_lock as a flag in the remove path. This
ensures cancel_work_sync() is only called for initialized work.

Fixes: f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus ProArt P16")
Reported-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com
Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>
---
 drivers/hid/hid-asus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 1b9793f7c07e..bb85a36de14f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -960,8 +960,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	}
 
 	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
-		drvdata->fn_lock = true;
 		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
+		drvdata->fn_lock = true;
 		asus_kbd_set_fn_lock(hdev, true);
 	}
 
@@ -1343,7 +1343,7 @@ static void asus_remove(struct hid_device *hdev)
 		cancel_work_sync(&drvdata->kbd_backlight->work);
 	}
 
-	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
+	if ((drvdata->quirks & QUIRK_HID_FN_LOCK) && drvdata->fn_lock)
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
 
 	hid_hw_stop(hdev);
-- 
2.50.1

