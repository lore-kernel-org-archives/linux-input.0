Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182617;
	b=s0T5yVipu/jjWDLpRFc7BpnLPxxPnpLFdKDt/qlm4RR11E9eGpbnRVcFqBHDFj/WdNuJ
	 kj2vR0i0kurVwGS3lGMI7IspkxnsPLWwzOcwfioCqrp3JExaVYFk9/Xigozurg7SvhSC/
	 Qj7CWqPB/Jc8mhUd7tA41hYOR3GafQZC0E54Jfl9RcPLOVHOLpY+EzfGe2Ajh2QwHqicY
	 fRgXOWDv2ZiY5nWU/qlEeJ+3FviBNeUmNQJYilplY6PAsQ59F4PlGpTjn72wggZBgQ/D8
	 4yzxw8iPudhFRZIKEcTRBFbxCEhaWBVRhaGr5RmCIsARS16E3i9vjjdXByNujLfIaaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ztkmG2EzFlJYzHneyZc8vQ6gywFDzTMFIn6AR2HWO8o=;
	b=wKiXRp7J41WbZYSNckwKialQv0tWq7Yl87oI2gH+od8//BiBQsTzLZhedNDnSCXapHhE
	 avj1LefWFKSrBGMKqrjn1IxCpGCJ4QXQRElKacx1WSnpgcwHIGvTBsNXtvZNLOTzz49fK
	 HPeIfvcH7e+KJ5ICw1F2PA+e13Bdv9CHoMepfb3SiIwKKgPyrHBMTGmYsIwLGN+TsTViu
	 bDa9YXtyXc86gFpEAvmjSid92lISLV0S2fb/RIowwCqIAV+RJgD5gvxBFmDAnhw+jOsMu
	 2z1BW81uvj5qIEJ/fJLVVsUyIO8iystw2WXite5G34I486F9mcKg/efIeK19xDc0mPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oux43k8P;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7A606A325
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 13:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB7A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oux43k8P
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06e79e152so468032b3a.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182616; x=1795787416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztkmG2EzFlJYzHneyZc8vQ6gywFDzTMFIn6AR2HWO8o=;
        b=Oux43k8PXmTenM/jfST0wFJSahrgdwOk/+WkiFOrtOq+E0jwgkafDtlFhLUkRT9OjS
         ro5B6Fgcmno392b+U27ndrq78LaKuD+eq/yYNOlVFylKoZ6GOxh2tS0gaQtS0dLBoiSe
         1MJBeyJ6mlbuWmrzzVMfv3INJ1srXHrYJ4D+YopErn7w+IObxGOdlCRAPYriiPgwOyMJ
         clprnLU+4VlFfytVSN4jscO6gXXiqW11r9RXOlli+3c8jitaLwY5SqIzcGVJ0ORy+ZzT
         u2M/dmh1rUuOnmOsaZDX04mMh1KZXgJrZBTrnaLVAgBE9gUwG9lEnLlvraHKvZD/6dOt
         Phww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182616; x=1795787416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztkmG2EzFlJYzHneyZc8vQ6gywFDzTMFIn6AR2HWO8o=;
        b=mVmkCVxW1RxFpD1cT3l0PaJRYRFQ1OHnHwDh793QEMpTMiMbGntrmXxgSY+1PlXubR
         zTSYwZL2VkcOnIXQ/z3Kg0X3nur5CRmAh1/m7kv70WNWfU5QD2mla+Le1olCsn0IjQGc
         zppCyRrLo+DDiHNBM5dqqWddjjJ4cP034RySVta0yvtysLzQEb8LpOKs11SbRZo81bZd
         zS6VEo9KsfeNRNQGv+eWE3ItQltUyPJs6fnF2tq5fXto/FOGzSPyDHBLSrFTcD/7/uBQ
         eDHYv5I9dSbVKJdEs36u5YbzOb7Tt8ih3HSJyUjVfClDq3Ftz03m5LiE21kpj80g6S+Q
         5Mlg==
X-Gm-Message-State: APuU4Z+2HBWKBg8bKqNsB0h61prIv2UsXSibkfXwGnhdztJHJv1Edh3r
	vHf20JlqFJNgAQJl+FZVi57vMVTNeAADxn+iylAb3/yKebl3qc85NIzj6X1+9mXS
X-Gm-Gg: AZFdTZdutzxpHtdPENnRUSpt1Yh6y71yvOZeMbkvvLatn+hmsTkOSLI7SvHmtytqd9t
	w5CYLYH5AASWtdpoqYAmwGk6ojWbsoiOl4B7cN4Dp3OvZAik+EmxXbxjnp9eN0tcOv7i9xe2swk
	AcJQWW1cbU814U3Osieg0CUtwcSIG7lkrwNwJD45/VN9yxrAUkq1vNXpwKfQBLZww3iSYZpoyOI
	Se3dAbe/lGxkhAHIXu52k1IoQdotzS3Hr/nBumzNOXHNxlfcC9Ty4MCZOMP30ZfgtP0RT3tsalT
	2zuCFhqF0Iq5Ge3VSUBmIfu7RvlePCsRFxsyih+pK+TWIdSSFX3OsuBOIFTGPKTeU7FwUjbBsYw
	YZ75ysAsUCasU8eAkIUjohwMtF974k5t7m4uFrP4e2/o1y7MoagicxO0a0SiEGVHQW3zEkHSBiY
	ifzH9n2M9ibShyPubqcs9S7uk7CsTLR1mynieRct8sd8JzvsxEuAefiosw6HBeyXAeA7gOt1cBa
	uEYBqihBmKPVy4s/y/UjBZVQRcbYmLRiglxNiThK2a4Vfo6G35NwUzsuAFz2YjlWoS0dmh6Ct00
	+YzLiZTPNrnUgqaJML7I7bZZ2kQd2JWD50bOvl/PPuS/ceNbsD4jCQ==
X-Received: by 2002:a05:6a00:2290:b0:874:705d:f63e with SMTP id d2e1a72fcca58-8c87c38b850mr2646210b3a.32.1795182616265;
        Fri, 20 Nov 2026 05:50:16 -0800 (PST)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c15asm1525086b3a.20.2026.11.20.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:50:15 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	heiko@sntech.de,
	lee@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ayaanmirzabaig85@gmail.com,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child iteration
Date: Fri, 20 Nov 2026 21:50:05 +0800
Message-ID: <20261120135005.566-1-viennaoffh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sensor_hub_remove() holds sensor_data->lock while walking the HID device's
children with device_for_each_child(). The child iteration takes the device
core's klist lock, while sensor_hub_raw_event() takes
sensor_data->lock with interrupts disabled. This creates a lock-order
inversion.

Pass sensor_data to the callback and take the lock only while examining
pending.status and completing pending.ready.

The callback also visits non-Sensor Hub children. When HID battery strength
support is enabled, the HID input layer may register a power-supply child
without platform_data. Skip children without Sensor Hub data before
dereferencing it.

Testing:
- With CONFIG_HID_BATTERY_STRENGTH=y, ran a UHID Sensor Hub/Joystick device
  exposing Battery Strength through 15 create/destroy cycles across three
  QEMU boots. The power-supply child was found each time; no Oops, BUG, or
  KASAN report occurred.
- In the same configuration, hid_bpf passed 45 tests with 1 skip, hidraw
  passed 27 tests, and hid-core, hid-apple, hid-gamepad, hid-ite,
  hid-keyboard, and hid-mouse passed.
- The full HID suite was not completed; it stopped during hid-multitouch.
- The #syz test request was rejected because syzbot's automated patch
  testing is temporarily unavailable.

Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data on remove")
Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fb951970a334aaff00ba
Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
---
Changes in v2:
- Pass sensor_data to the callback instead of NULL.
- Skip children without Sensor Hub platform_data; add a battery-child test.
- Add Fixes and correct the syzbot address; remove the self-added Tested-by.

 drivers/hid/hid-sensor-hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc5..4c447f62480b5 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -804,9 +804,16 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev = dev->platform_data;
+	struct sensor_hub_data *sensor_data = data;
+	unsigned long flags;
+
+	if (!hsdev)
+		return 0;
 
+	spin_lock_irqsave(&sensor_data->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sensor_data->lock, flags);
 
 	return 0;
 }
@@ -814,16 +821,13 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
-	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	spin_lock_irqsave(&data->lock, flags);
-	device_for_each_child(&hdev->dev, NULL,
+	device_for_each_child(&hdev->dev, data,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);
-- 
