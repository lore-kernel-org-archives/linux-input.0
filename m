Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5602E413
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551112; cv=none; b=sbBwBZ1Obd7aIGXa5ocyge3RVr2zsksRqF3w/rIETpzykfFWszOoUyYyEEkHxALbA9w9A18NwW8fzur8yHD3dgECFKwARITU/RonE6jPpx6vCGqnodF8gjRJaQNtTmDlj5NnxI+CEEk9Mjam5mreoM+KsITTX6C+e+q+fft7Ff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551112; c=relaxed/simple;
	bh=xAs7soMkHl5ZEqelkAMU+KxZY7zEQ+JNb1bToXX50h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0q+KJ5jTaAefsL3KL+Kg+iOiiRmoD9mqDyUTnrS9huHG07hmjds8TVXlGBy6JOfuvzLyC92Wh4IGTPBxvyWzT3+z3wZMtnOG3IEr6/OhiO9x7EaXDKMxE0lraMI3EqlEmywGbIV0JcVZztjRYIlwBdd4Iqg9GgXix+GmtknKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR/7129v; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR/7129v"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-365f36d7b88so716693a91.0
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551110; x=1779155910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bv5IUYRwwH6Sa8774zC9j8VUEUymXFEHfk8vFZ4aRM8=;
        b=WR/7129vb+jWv3QWTRw9pmZzSjj346vj3/fEyUDHArsUiAfEHec9+2W6PwSOg9Ln7M
         5VDv7M8bgaa51u58vqz+cwgJcML719XAqTg5dzhtf4Esq/3lMt8lALx60uhlcim/8qyq
         7tyWASGeT8gJwf00KxeGtZzKm89BCptyr22h0+CY8hRt6Oa0mMHAHXokGhZWOKn/zire
         mA94RPjfsNlrSPuUlVuteCqpZIM3OSykADQYmobyp0HNA5h0KF0oHqF3QPFtm+Xoml4Z
         87RNG3uxJuk5UmOZZ3hXvkokUb6PHp4FSqJEkbcQdC37Cdb7OZefcRQW4b091vKLyitL
         UlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551110; x=1779155910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv5IUYRwwH6Sa8774zC9j8VUEUymXFEHfk8vFZ4aRM8=;
        b=L+CcYE3w2pOvBaBh3aXKEY7OnxnzJGWRfpP4Ns2ILmdYwxvFrRf7/Qa/QObdA2POmv
         FBMZRKYgm1TaATnf5VTyE1AIEbuc89ojpxkeGbopFKQjnoZkDksHO4ASiWu1CnM7wZga
         vnFhVCSvLWlEhoBPO00ONfxEHjuaKqQfZ5l3Zbo3YyF/JT9G+VIPfobsRonqjUZbwo1+
         lfooZ8t7xymbEFlSYUT8qAkaYR7Xb+ERM+SvZGwjDbQeUBYzyfdNesjdelun04XUzBfj
         xD4FPPzLcfUDnhr3NCNl/rWHrfmF0FV6/TUyI4+6CknjkYAjhq7GFHJU53INs/tkVe8P
         2XoA==
X-Gm-Message-State: AOJu0YzUsBdcpk3z6KSF++vCVUoVQ5Dz/j0j51HNJbFoJJHJrVZfjsjD
	vGFrMNfxa89JLmdqyvEv/7VrO47dyud707GQUD2sYFM9ZkUSWCGp026f
X-Gm-Gg: Acq92OEBCv3R1Sqvxy8DhXCpe4Z1+QBxTEZE51tDS15VsQQcWwOWfm+Z9KB2jaq6FlP
	VQMyUpvIi72Wup1lCp9OuHeqTWsQSDSf2zWey28jW+CTdg6ePAMlV/C7J+/8mOPAjEzfMLAEsBK
	knLHvZ6p/qCNL8k+Kjbr05AZww2ULhGt/F9+QKfi+UD+yeSma+ycxoopkIJnsYKwdxSHHaI27h/
	WJcefNoPGbxvURqOigeF0BzPPP1l+/yic5doxQnzptvrOOLDoTcfLqO9kzKn3TowKpdbuNKD0Oz
	7kB7TC4GaWzv45zYJ6u8KqioDFc1RM9hIwXfFb7n3SBuwlBndgGz8tIVEBOz4doYzoXed0/tv1d
	WYT3tBYZTX0neQEUgVf5qe0E3PJ2J6h7pfrAJriX1/xStXpHa4F2ONAYXmbHN+zW5gf5FI3QXcu
	pEE30jU9MI0Fy9fStVw2FvNiTBxBVoBpH1yoznjI2372U=
X-Received: by 2002:a17:903:457:b0:2bc:ee93:ddc1 with SMTP id d9443c01a7336-2bcee93e22amr13323735ad.4.1778551110341;
        Mon, 11 May 2026 18:58:30 -0700 (PDT)
Received: from SH-7N5RBY3.aixin-chip.com ([113.106.167.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27055sm117932915ad.6.2026.05.11.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:58:29 -0700 (PDT)
From: hlleng <a909204013@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hlleng <a909204013@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB mouse
Date: Tue, 12 May 2026 09:57:37 +0800
Message-ID: <20260512015737.8919-1-a909204013@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SIGMACHIP USB mouse with VID/PID 1c4f:0034 can disconnect and
re-enumerate repeatedly after it has been enumerated if its interrupt
endpoint is not continuously polled.

This was observed with the device reporting itself as "SIGMACHIP Usb
Mouse". Keeping the input event device open avoids the disconnects.

Add HID_QUIRK_ALWAYS_POLL for this device so the HID core keeps polling
it even when there is no userspace input consumer.

Cc: stable@vger.kernel.org
Signed-off-by: hlleng <a909204013@gmail.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf637423..c07e90dbd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1280,6 +1280,7 @@
 
 #define USB_VENDOR_ID_SIGMA_MICRO	0x1c4f
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
+#define USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE	0x0034
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2	0x0059
 
 #define USB_VENDOR_ID_SIGMATEL		0x066F
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9e88c9d6c..800b8f76d 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -187,6 +187,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH), HID_QUIRK_NOGET },
-- 
2.54.0

