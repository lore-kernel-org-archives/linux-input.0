Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BE38735E
	for <linux-input@vger.kernel.org>; Sat,  7 Mar 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909850; cv=none; b=Rm60P3/PKbZCpsLbA8My3sxKr+eYUUvxrXQsEBhmlokhcSkJuXs19SlfrarKGaBHtLJ5HT4zUPGOQE5C1cwg7AJEeRL7tgNtSBz4GRyym1F2MZF8H3RPighSiDJ3bHALWPCUQG3SuhmF7Txx45d1X9a+DA/tM9WwEKJzKYh7T8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909850; c=relaxed/simple;
	bh=ohZWnTOgcHl6b5ydSuDEJoSGGZ+o1J4dHKqpIcEFxd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mpMBtqvOVNQxS38GKe8E1dQWmJ8KGvzaYEnIK7FTCAseKJiwdxUzvXyqnueLyYdh2HmlQ0a2dGeW4Lbed0fGQIHYZT2R6M9Hq76RjvvLbiwvlyDIsM4gRtVSK0NOWnbP3y9YoW0Y32quzLHcQlCTHipM7PQ1XWelB1+lk33zqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP6dHp/2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP6dHp/2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b611274bso4387815f8f.3
        for <linux-input@vger.kernel.org>; Sat, 07 Mar 2026 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772909847; x=1773514647; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVKa9KQkK+sGb14EixM9ppAv5O/LJIHEZ/73SrIqbWo=;
        b=NP6dHp/2PPWnuARwla3VWPq0wD2pzD9Q137+o15rxoP3ux2a2mcf2l4WXOvbkE3Kug
         HfM870ZnBfIG2O3uASNir6tRMPfLufZqQFtUWx/HFcSJNptQLU0+rx/Hbq1svthfYcF1
         ppoE+ElorhPjc7ZByIWBMSSd2oTiLFe6XO/ucDMmqTLMb3n2Z11oCnOzhhCZEJBmFvOr
         hgku8MIFb1Irax0Jen7S9KvFPu7167MOF9QKELCfseFPDqPi4t6dTr2uQZRZ0VhthwuT
         fFaODcd+t8jZA4e/+vcyX7xEqIzdt88vB8ndvT2zPafemVUdgliSTXDN1gchFwz9etEa
         whcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772909847; x=1773514647;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVKa9KQkK+sGb14EixM9ppAv5O/LJIHEZ/73SrIqbWo=;
        b=ZPTdoT8QUHdCaFtktMF7zHYGoQrdfTxoU+gJx5HDDup0GoxfgB0mtZsF0Vw0CoIDO8
         3JFs7iYcmKZnf8avE/P5nZIYoB4E6Qi8NN9VVZ+hTHRbWWPd3j2oPMi1yfImxiiRYs6/
         /XUkniaujbFJU7nqz0tUq93O+YQf/U6YSuKaOE0YKsEa6W3rJFuUnhNzdSCIfiJIDiji
         zxmdYZ8XtM4QL4kp7RseCMDVPp1Cp/rpqRsxK8Heue+oS0BRynjDQWw44zCkWxhzVExw
         dgI2gpYei1L14w/8KQW+JMFvPJ/SB9NIf50gGAth9bOB+Ja8IE9IouhWgPfIciMuaj5U
         lIvg==
X-Forwarded-Encrypted: i=1; AJvYcCXclWNz2Nz9gT7xosvSDjQQkRFqBGOmj9icjqaCCkacNQ0KR/EHBeAXHyrJFoNLOt09nFB2mfn5V8H3wg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2n8TI6CfeLkdMXOB9Yp/9PY2tK6kj/SUCBKKpL/oSh21kyxpJ
	GeFOxFQSmcj/eSK373bvURgZDZtvu0r4BMroZaF+XMUh35K9Y3C/UUCe
X-Gm-Gg: ATEYQzy3+brOwfjgRwjnSJ440F9RSglyH6ox1ptegUcQExzcoDeiXvqHKLNoNCPK4Zp
	jfC+6UbacbozDmO/0xm5aAmaWoJ1NxmPG0Mt8MGV+PTdWt4gS4LYbzn4stAVQzm482we7kri4Hj
	p7nDsTCEGCoSRg7JXbAe3ePcEOuk549tWPyZU19y/aQhW3crRNUu5CofqQoDd7P8AEt32YQzOxv
	DkngGx0t294J56a1+ffUOlZc4m9IPi7frZgt2A0iWjLYFwQmhSCEDiG24bNu1qYgIjfPlJkanlj
	3n2BobkiQpfBlEQa+xnPqfMiOHsK0AV6vY9+ADFoqCZRYhh8lgxe5ybt+swfaJ3dmKvsQfHZCBQ
	zKRRuoA7I3Mh5e6dE5DsVxS5VrOUc8G1tMR9bv4HYKchqGwLGocCiIn2OyPxcql91etN9WLb0bI
	EGMmmfvDSbEv9ihNPsIWwc/gxH2cIhJCa8tnNBer1RdExTxwzn
X-Received: by 2002:a05:6000:3112:b0:439:b4c5:cef1 with SMTP id ffacd0b85a97d-439da65bc86mr10783110f8f.13.1772909846734;
        Sat, 07 Mar 2026 10:57:26 -0800 (PST)
Received: from [192.168.178.21] ([2001:9e8:fba0:be00:22c9:d0ff:fe7b:79cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9fbsm12530995f8f.23.2026.03.07.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 10:57:25 -0800 (PST)
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Sat, 07 Mar 2026 19:57:09 +0100
Subject: [PATCH v2] usbhid: tolerate intermittent errors
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-usbhid-eproto-v2-1-e5a8abce4652@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMSw7CIBSF4a00dyyGS4JFR+6j6YCX5Sa2NFCJp
 mHvYucO/5Ocb4fsE/kMt26H5AtliksLcerABr1MnpFrDYKLCxdcsVc2gRzza4pbZCiF7bWxBpW
 E9lmTf9D78IaxdaC8xfQ5+IK/9Z9UkCGTqhcWubtyY+7TrOl5tnGGsdb6BQ1V1KKqAAAA
X-Change-ID: 20260208-usbhid-eproto-152c7abcb185
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liam Mitchell <mitchell.liam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772909845; l=2884;
 i=mitchell.liam@gmail.com; s=20260207; h=from:subject:message-id;
 bh=ohZWnTOgcHl6b5ydSuDEJoSGGZ+o1J4dHKqpIcEFxd0=;
 b=wvPQ9LTVGcnBcWJBP1UX/KdL/QZgvPr/b6Fgb3fA6Vc0X4SE1j62vfkLgfNVzakCUCNGfALum
 vddJfzfWKYKD9iWoYUqCmU8MOs//fhGIrqsBTzeig53A0CiCVt078vC
X-Developer-Key: i=mitchell.liam@gmail.com; a=ed25519;
 pk=Y9mPqBk1OuHZ0OaUZ5a8Nc5X7YHs7+SKiNwUfcLfPmg=

Modifies usbhid error handling to tolerate intermittent protocol
errors, avoiding URB resubmission delay and device reset.

---
Protocol errors like EPROTO can occur randomly, sometimes frequently and are often not fixed by a device reset.

The current error handling will only resubmit the URB after at least 13ms delay and may reset the USB device if another error occurs 1-1.5s later, regardless of error type or count.

These delays and device resets increase the chance that input events will be missed and that users see symptoms like missed or sticky keyboard keys.

This patch allows one protocol error per 500ms to be tolerated and have the URB re-submitted immediately.

500ms was chosen to be well above the error rate of a malfunctioning
device but low enough to be useful for users with devices noisier than
mine.

Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
Link: https://lore.kernel.org/linux-input/CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com/
---
Changes in v2:
- revert changes to hid_io_error
- add more specific fix in hid_irq_in
- Link to v1: https://lore.kernel.org/r/20260208-usbhid-eproto-v1-1-5872c10d90bb@gmail.com
---
 drivers/hid/usbhid/hid-core.c | 5 +++++
 drivers/hid/usbhid/usbhid.h   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 758eb21430cd..939e095eddfe 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -313,6 +313,11 @@ static void hid_irq_in(struct urb *urb)
 	case -ETIME:		/* protocol error or unplug */
 	case -ETIMEDOUT:	/* Should never happen, but... */
 		usbhid_mark_busy(usbhid);
+		/* Tolerate intermittent protocol errors */
+		if (time_after(jiffies, usbhid->last_proto_error + msecs_to_jiffies(500))) {
+			usbhid->last_proto_error = jiffies;
+			break;
+		}
 		clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 		hid_io_error(hid);
 		return;
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 75fe85d3d27a..6aab9101fe34 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -86,6 +86,7 @@ struct usbhid_device {
 	struct timer_list io_retry;                                     /* Retry timer */
 	unsigned long stop_retry;                                       /* Time to give up, in jiffies */
 	unsigned int retry_delay;                                       /* Delay length in ms */
+	unsigned long last_proto_error;					/* Last protocol error time, in jiffies */
 	struct work_struct reset_work;                                  /* Task context for resets */
 	wait_queue_head_t wait;						/* For sleeping */
 };

---
base-commit: b91e36222ccfb1b0985d1fcc4fb13b68fb99c972
change-id: 20260208-usbhid-eproto-152c7abcb185

Best regards,
-- 
Liam Mitchell <mitchell.liam@gmail.com>

