Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304ABA34
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782608370; cv=none; b=DE5AnqKI8iPorfmniA9zlxd41mqW4iCDxxTsmSeuf+fuftW7RwWdEOujEmI7acf6cQCBDuRNeL6tNhMcKb+zOc84KI5MwYly1w3kwgB2KxBIvWyeab3cVNUiLVOZXZv0/1JPe6TimoS+nU8dbVhkPVrIKUQgzxLbP7tk9qF7LJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782608370; c=relaxed/simple;
	bh=HH8DXuGoo6q7yDmbqdUQp+c9UiZ7eP1WtfZ/rSjfu1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSuGbG55KLPaHvsCFAVGwTndySCpsVEqB3nvk9cFdTe1UKPLqSyIXqV4sF4FG4WRrK1REvPXHQHnEh3T4r6Qo7GY5gR+AaNtOvpUaIvAyhC5VPXrYpeO5xl6mZMT1J0RzdojPAHHWqXw/V/1cOjsZVmitfc69oOVN/Cja9YtICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MANPC7dm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MANPC7dm"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-472a14c9965so150979f8f.1
        for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 17:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782608367; x=1783213167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oK5oPb2GANqw5JzI4rOCdahZaDvKfwmzjw3hsqc2CkQ=;
        b=MANPC7dmE0ro7RIF16ki9Kbe+Ti9v2SmzC5kus0rtnU2hInvvV/glNqioAOrMMFf1U
         ybB7Yu6Dvg2Aftq60LpNEgHUL1fu/kQPtjmkrb6GY7x9yEJVpP/dOGgyoTmxILf1l60w
         I6Klm+7ZKPqVp3H71WUcRk+CAqqZVldoz5f0ecVNK+lkEd1c0gvxI00uLT+1qOUtXofW
         +6wTAuDqhcXlnVeK2bPbF6O6GRUyZmHC7uEm8QVewpRgB9XXv5SajLta2rsZG4f1Xauw
         ZkZUYiFbFKvOqvWMXpbhCWMOjefWDHA+KTTm+5+WKnckft2NDdjSnVq3hdhB734aDO73
         nvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782608367; x=1783213167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK5oPb2GANqw5JzI4rOCdahZaDvKfwmzjw3hsqc2CkQ=;
        b=Ckz8QKBnRwQRKwYbG9HYI0oHA+YWDtdfCGAjtYMtf5QPZY+qSh4narbR6HctUygnrr
         r6D74YduCSGYWz4pJJzIk1F4Vl8Uw8rQwWoWLGNewB3EmpC1q6Q8rh87vI0OzihJ1vHj
         c1CxhVTGe2KwWqBlxPlrqkFRRNatgkdT/Pp5Pl2rGjM+iDSDloFLwGczV6x4FwBH01uR
         tTWnH1gSfGzQQaqJ+e6ItZvBmlfE/hB5CdUQhn/M1uKGq7jY/bOMF+4sucQDY1Vf2pPR
         3nAedgk/8z2V3G7eHIsVd0A9n7qn8/Om2plScDHGW/wDX8kRb1tWeEDTnlu3o1j5piy/
         Fv/A==
X-Gm-Message-State: AOJu0YwOgIjP8IRqknbiGSif7op6/FaWdfCJrFqsDeAZdMMjzrH9z1AV
	VrAJP/Sf+UajegM4OMyJcNKWmvsEpGjuQbUnoMFgYpIIxwGtyBsc08PuVAo8s+WuCaQXvg==
X-Gm-Gg: AfdE7cmxutF6ZiT45zmzo8wklmgAQ9URTtTB7A+FqQwqYIQQTBPc3x8dA2gt167ErwX
	5Aqu1LvVSX2qIeSc6D6wXMkngPuBfMTREKyP8GLd78KeIUBF1mCVRGiLg01ceBTSO4MXkhd5jdQ
	tkUYLwk1oPZRU/43Qro4L1I3CH0c7Q5yYpYYIrvk6UGg+7PIMiLHh2we993zTsTiHD+JIz5LgnK
	PykltyQigKzUMnAiT18WSSIJbLnTuNUfwxU0YiSmvYOFJL0t1mkdDKTV2uCxXDZ4w1qBMhWUpEw
	UZlPdvnx4Ruk7IvUZpGnqq4dmedXA8fIANNxUx4kU+TQXopoq0K3fKb4gJg1TxHJPlgWPzZboXF
	KNBdgEdiJUKo9H5vjxpQc9PxxFHlzOGRjpLyjAtTKMCe+A6M8w8HakItag0IUTNGqe/vMLsrRI7
	7dL9svP83Iz2mqePv3UicTF7qSVuOobUeU/U10
X-Received: by 2002:a5d:5d84:0:b0:462:d07e:4bc4 with SMTP id ffacd0b85a97d-46dbfe8cd8bmr18348279f8f.7.1782608367189;
        Sat, 27 Jun 2026 17:59:27 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f978dc0a9sm14014990f8f.15.2026.06.27.17.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:59:26 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: synchronize input before cleaning up a failed probe
Date: Sun, 28 Jun 2026 02:58:46 +0200
Message-ID: <20260628005846.31248-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_device_io_start() allows reports to run concurrently with probe. If
the probe subsequently fails, __hid_device_probe() releases driver
resources and clears hdev->driver without first excluding those report
callbacks.

For example, a report may enter hidraw_report_event() while the failure
path frees the associated hidraw object, leading to a use-after-free when
the report takes the object's list lock.

Stop input before performing failed-probe cleanup. This reacquires
driver_input_lock and waits for any report callback already in progress.

Fixes: c849a6143bec ("HID: Separate struct hid_device's driver_lock into two locks.")
Reported-by: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9eebf5f6544c5e873858
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 41a79e43c82b..469b849b7a2a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2835,6 +2835,8 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	 */
 
 	if (ret) {
+		if (hdev->io_started)
+			hid_device_io_stop(hdev);
 		devres_release_group(&hdev->dev, hdev->devres_group_id);
 		hid_close_report(hdev);
 		hdev->driver = NULL;
-- 
2.54.0

