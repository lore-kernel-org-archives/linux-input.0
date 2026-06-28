Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00832293B5F
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665309; cv=none; b=TzeeFXv1/zBStJuHvyhPBrxlq1w6m1Yzz8drRZOJVun5+cYnWOlIqQqlsA5tDa4dlkyWN6BjHNYzTX+qRHtA4Uk7n/vzWs+Xv1tjbvLe6UIWpGXF+Ws+8H/TVbharI/NzBGgtDwVaGxyFw9a5+3LMNOWHROXhZvx8fFfSVoAQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665309; c=relaxed/simple;
	bh=cf6yj5xifZFmTr357rW0WbouH8QTIDIjipjpL5fIZzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyswIhpjTbgs8Xd93JnjwVj2uwbUJCsP6dGSKOq38FsMbhmf0SbiDEJFab6DI/tR2Xw7Ghu+X2t3/mmUDdo+MnBsGZ4VCNQ9BNh8wAOEdSv4uKSyi7MInQVGFmLucKnoZFQPR9d3FyNJWXSVM6P85JB4F17JNHZLZBnzWKsljCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drAefT3a; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drAefT3a"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664d7863920so191009d50.0
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665307; x=1783270107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUvNQVwVpofTw7oTT69Ez1d4kozO3VZdDLOAGHgGSy4=;
        b=drAefT3aoUUPqnd0OPz4nFF4gCSGGxt2xVYxfCETmLnyrGUDpNuTt6wjZVkhaAime/
         2l/zP82VjyG1iiDHKlBw7/xfpFR32a3PtIkVhYdfjyp38aVDuFZGZpDnSNMlQLupYM9M
         TTHVdFpLFegYXi2YEaKg0ZHAQ+IX2utQHqSyi2pDc0R72+NI3xXmZbM0oKrP20kDo5sm
         6T7pI/vLvVokGOI+TKIeNvjTOq+XLTq63sGyDvlM8JMCu6VkO9YVukI5LB2KFyhXty/o
         XY0Q6Gx5tktc6S/zLHhsQfddTEzG0yYkPY3VFqYl2TzHDDPSYQWc8i1aAdTHeM85UuPa
         7i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665307; x=1783270107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUvNQVwVpofTw7oTT69Ez1d4kozO3VZdDLOAGHgGSy4=;
        b=haosSmHAVNYu5BLlhHvPJK+2vPxMD+9SJlto411hlzQ9pviU3kFaX/ptDEPcHyIsXa
         lxJ0jO6hEB3KZw4Pd2gv7Tdjp2nF5NB2IRNuMEn+CpRb2g7Nx6fdbnQPTnZepK9W4mxB
         +TO4W0Eo+je6r16cyqV15lQSudmp/4OGQRTmk0yN8ukRLHf09q+VKI/ZsMeGBs7yKEHv
         +oDm/l+YpNjqTGhj5aRuLny7Tvh+rtxcRz7H9+s7uuEgN385g8kjA/PkcXhhk29TuL0+
         D6B7e1GYV4v/rKm2lLu79RwpBYRF6B8ENkMZoJ8MW/hnTBWznk828gUo3wVNwdN0XD63
         jo1A==
X-Gm-Message-State: AOJu0YxD4iS8Yo6GNZpPAL17QinTfj4iDkeGbbogSPNE0+EyFNc7rMKD
	G3ycivXGyCaGnsCReMZHI/jGTQR+LzXoMgIjHbh15o77Pn9V0/WkxNXrgHMrJzTWHrT2Ug==
X-Gm-Gg: AfdE7cluR8tWVh6LkxoQZ7+kgEMEqP+YPxDd8iR1KaPXAlhXOKSeddpAUomkhfx/lcC
	c23m5idxZijV/a0jQIW47kVdXT5cn69BLnzpMUwH0mBMyw9jYTeEYGiHtFdzOa8/Gh0Nv4wxNhX
	3OTgNOK+S8s4v4qiQxlMeV8gsJOqeuteq7f55VaQYiRywGkAcxIRQ77PVljxvgItyGm9hx1kNXY
	/ngRBirh38pukQ6yfOReLWqoNWUx7wVJDmHRY7Qw69Moxiju3QMwv96TW8ibrVn2lIoutYCLRI8
	4hwDT0UWXYBD6NxAVvF2onW5PpHGjPDqW65iueUZokzWyzrvqSTZ3e9VqmO4P0s01Yud9BwJy4c
	8Mch0b3988PzDdFRpC43FJ5eqm9vxFxAtkB8G2z8kN0/sLs6WwN70YtlNhMmxJWqTUhRm+4zDfc
	8Vf2ptnP8xN5YZjf4uUc2hyMQvqJ5jQMqxKQ2J
X-Received: by 2002:a05:690e:120d:b0:660:5bb0:7ff0 with SMTP id 956f58d0204a3-6648801f1d4mr12732204d50.53.1782665306986;
        Sun, 28 Jun 2026 09:48:26 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f785f6bsm5980279d50.6.2026.06.28.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:48:26 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: cp2112: validate input response lengths
Date: Sun, 28 Jun 2026 18:47:31 +0200
Message-ID: <20260628164731.17614-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cp2112_raw_event() parses transfer-status responses as a fixed seven-byte
structure without checking the report size. It also trusts the length in
data-read responses and copies that many bytes even when the received
report is shorter. A malformed USB device can use either path to trigger
out-of-bounds reads from the HID input buffer.

Reject short status responses with -EMSGSIZE. Treat truncated data
responses as zero-length reads so the waiting transfer fails instead of
timing out or copying beyond the report.

Fixes: e932d8178667 ("HID: add hid-cp2112 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-cp2112.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571..f2988659a5cb 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1430,6 +1430,12 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
+		if (size < sizeof(*xfer)) {
+			dev->xfer_status = -EMSGSIZE;
+			atomic_set(&dev->xfer_avail, 1);
+			break;
+		}
+
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
 			xfer->status0, xfer->status1,
 			be16_to_cpu(xfer->retries), be16_to_cpu(xfer->length));
@@ -1463,6 +1469,12 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 		atomic_set(&dev->xfer_avail, 1);
 		break;
 	case CP2112_DATA_READ_RESPONSE:
+		if (size < 3 || data[2] > size - 3) {
+			dev->read_length = 0;
+			atomic_set(&dev->read_avail, 1);
+			break;
+		}
+
 		hid_dbg(hdev, "read response: %02x %02x\n", data[1], data[2]);
 
 		dev->read_length = data[2];
@@ -1494,4 +1506,3 @@ module_hid_driver(cp2112_driver);
 MODULE_DESCRIPTION("Silicon Labs HID USB to SMBus master bridge");
 MODULE_AUTHOR("David Barksdale <dbarksdale@uplogix.com>");
 MODULE_LICENSE("GPL");
-
-- 
2.54.0

