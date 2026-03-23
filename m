Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0383A9DAF
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270064; cv=none; b=WMpi5wN4ct0I6CISHkusgZYg4gpARc6qZz2epMPZow14poNiCTlMDqPA5rgU1yG/v4Zz/JuRfUj4eHJ8b0tShYYp+dVa7KUDly3yaQDTiFHtkIKIySPKW0ImxIwlY7X3TISR8ixS0///ZpBZV3qToK5XhJdzuXrcPsImoRdW+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270064; c=relaxed/simple;
	bh=FPy5DMKzxSPiAP71gLkItOyOW+8j23ia4aqdfyJTKpA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ASqFM2VywCE2w4RTX2OlORBhKVtcZ0iseAQlV+rhXs8N9Sc3TqUsGafFhXiCipgGgtYmx3dJ+EsgTysCrroAaxVrk/F8x3gyVxqgW4XprEuKP0yeqDmLI/5KUz/ZvPyxkbkgY9LtJxOSDhWXlAz6PG7Xhd9RZ1ozSrUdrxpmiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJ1U2ng9; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJ1U2ng9"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43b4dcdb372so2149992f8f.0
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774270060; x=1774874860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTk88O6Az6LW1fqafxLDYIbj6PJZ1YEruBsLXP4TxP4=;
        b=QJ1U2ng9kTpxnMSVKbjqmZEWl2MEU1IeHEIp4wI/MIunfRmtTVAPXGNcpE2C6ZusHk
         zCTY6yZ8BcCmenzhmS0AGoLr/GW1Oi2WbwzPXd+c0Xh9Y3V7szqOxnuBJ/bvhREygW2v
         kuhge4vB0PD9/uLsr43iOlt5H5Z6jiBYOayFmWx0Tt2sa4zhH/lfqCZJEFc2KtHFgdbm
         vDRtJ94pPa277Io3oeoYml/3d/hMkNcY4CpGiNuxNtlZVb5XThulmFlH90fz/mbVzoWu
         TFzcdvGYSKp1xNU3aIVOmSoRWxqsmQljJ5S7nkXs5gY1OrnKy8SWX1RxjT8Ed+5LL8Jb
         DBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774270060; x=1774874860;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTk88O6Az6LW1fqafxLDYIbj6PJZ1YEruBsLXP4TxP4=;
        b=F15VCInETztNyucj+5mun20z9IYfNyil0LggGwlSHtRcUSgL/qdYEwThVGNJTEeVQM
         hxC+kUXdQLUy4cpcLKmjQVGa2zs/6Gsl1+V9pQTusuf/UOR6Tb6xgMa+Ba0wYsTTpKFd
         Glzja36Ch/FsLGcCbVOYMftCTSbK+lwLL80P/f2IhKbNFiOv2ttRwPzSP2JnWUR449ht
         Z9/YoL3NXUIyMFXxh8u0uoPUhN1H+M9R788EY51gMNfEv2fS9bCX3hAz5KDjGAy9kpAe
         Q9PlL05/weFLjPzobz+/d+pi0POwWnRb1ZoPbFqS/EYMG5bWVNNDKywUjRRJLFI5/T/F
         HKAQ==
X-Gm-Message-State: AOJu0YyPQ0JP4ky9z5/VjK7ujgjAvCq8HNv3nUmLQeS7/2IiKwJ93arJ
	Heojqr99fTjiSu97Z+UsN1yDRU+KhWYtX3aBO/ZHO/jecoY3og7/rW2q3/LtyHKytK8Pay1R8Pr
	wP9VxZvVZYg==
X-Received: from wmjk5.prod.google.com ([2002:a7b:c305:0:b0:485:2e9a:31b4])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5294:b0:486:fe46:b647
 with SMTP id 5b1f17b1804b1-4870334cb27mr115435455e9.10.1774270060394; Mon, 23
 Mar 2026 05:47:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:47:37 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260323124737.3223129-1-bsevens@google.com>
Subject: [PATCH] HID: playstation: validate num_touch_reports in DualShock 4 reports
From: FirstName LastName <bsevens@google.com>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Beno=C3=AEt Sevens <bsevens@google.com>

The DualShock 4 HID driver fails to validate the num_touch_reports field
received from the device in both USB and Bluetooth input reports.
A malicious device could set this field to a value larger than the
allocated size of the touch_reports array (3 for USB, 4 for Bluetooth),
leading to an out-of-bounds read in dualshock4_parse_report().

This can result in kernel memory disclosure when processing malicious
HID reports.

Validate num_touch_reports against the array size for the respective
connection types before processing the touch data.

Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 drivers/hid/hid-playstation.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 3c0db8f93c82..c43caac20b61 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2377,6 +2377,12 @@ static int dualshock4_parse_report(struct ps_device =
*ps_dev, struct hid_report *
 		struct dualshock4_input_report_usb *usb =3D
 			(struct dualshock4_input_report_usb *)data;
=20
+		if (usb->num_touch_reports > ARRAY_SIZE(usb->touch_reports)) {
+			hid_err(hdev, "DualShock4 USB input report has invalid num_touch_report=
s=3D%d\n",
+				usb->num_touch_reports);
+			return -EINVAL;
+		}
+
 		ds4_report =3D &usb->common;
 		num_touch_reports =3D usb->num_touch_reports;
 		touch_reports =3D usb->touch_reports;
@@ -2391,6 +2397,12 @@ static int dualshock4_parse_report(struct ps_device =
*ps_dev, struct hid_report *
 			return -EILSEQ;
 		}
=20
+		if (bt->num_touch_reports > ARRAY_SIZE(bt->touch_reports)) {
+			hid_err(hdev, "DualShock4 BT input report has invalid num_touch_reports=
=3D%d\n",
+				bt->num_touch_reports);
+			return -EINVAL;
+		}
+
 		ds4_report =3D &bt->common;
 		num_touch_reports =3D bt->num_touch_reports;
 		touch_reports =3D bt->touch_reports;
--=20
2.53.0.959.g497ff81fa9-goog

