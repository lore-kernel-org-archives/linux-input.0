Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7D396B70
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451091; cv=none; b=idQTYAJKB+bo2XsF1YG0xh755xEY4ieuEHXlqqgHnWJPjOTm9qXXC3jlEMDtxb5eedkMoTfx0Rx6vcLqMZ1jXX9lk8rFpC4rme48w4HMeCBJhCDg6bAU6n0L60NOwMp3emRxYhpwc+265xDjsZYWGwlxMAE+Aw5LcxKYaOFaOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451091; c=relaxed/simple;
	bh=xzeEhHEyQCRH9yR9joDMads1uaHmYunLiX/nHJEP0QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVP8wjyZhNpNFKh3QwwFrfVvXHif+iRPgCk6rx7cN1HXN72kI8r4YJThoyHTenDWK5y8cwrwQ/EsvKm6dIeM1FtAiGRBgp+tUJxBANKnmGEX4jBHK8/HZL0HHpxixN84t/MWM+AtNwG27bzWDS6UvebdjhPOoc9Es7KP4UatsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFQHoXli; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFQHoXli"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1363fe80fe8so1335900c88.0
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451089; x=1783055889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfyMoOrj1XhKeMiEVwgSjYoIFZP5QHNbRipRhkiiuRo=;
        b=AFQHoXli454V7cZcl+BG6hB+QvAWSTuMjcAEgTu+sjHXG+YKGVjC7s5ixKGwN3O2FZ
         /buHdbFyq/9aPzJjfGUgLzYghaIY0mU6766TgUSkUZWRLh8CJGYmj2so50ieAlg3t0hr
         0apV+X80Gyu7hOgU7NFSpmlZe18UDZwVBi8sumLFdCcaGAcTRdZUHVkvQbJnhyuJ80EQ
         g9CmG5ohCw2G0w7se8J72fuiRdlXbqaJb/BZ3PFGt402mwRXSdyMItKwyb1MN3zp5KlG
         +IeC8BP2MIvvQBM/e+5CZhNOejeNpqzt7EB287Ht0bTN9ZfFIrsMhWxtnh37W1/3zEHK
         X2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451089; x=1783055889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xfyMoOrj1XhKeMiEVwgSjYoIFZP5QHNbRipRhkiiuRo=;
        b=bIh4Q1ASBfYq2OqYF/eUConmBg8GeoY96ne5O4fLP+Rw4OvqqJIvvsDIZfoe13DChO
         bxVUo8xBfJoYSWk1qVGuDBICnuTm45uwtoNUCT2ppZvdsvJmbx7TIjU8XHpzLd95pVd8
         aUHxJv0oYTW8I3kYs6PGi/yypYCnP4noPseGniWLs+TgVRr4EzPhmeFZ2mRn4Rg1+ZZb
         ZbQTFEuUZbXSEA87TawBJ6u/srFqGIjs0u764eZ3ZS9gvIgyLfCzlEg6DHunxYWgbsb0
         LhmKMBquvnk2qVdfYg3WWdXaTLO2MPYT1KTCH536JAObW5GoaMnlsA8L5/fZCVHWIQzb
         QJzw==
X-Gm-Message-State: AOJu0YzoznXiaewPcenOMaF01ZHJH6wQIEJ+4SULi+V0AQp/1A8glOPs
	joVAqJ/g4ILx4GasdYI9NihWEmgLzG54M+POtkVz/XTVsxx2zM8/GIEr
X-Gm-Gg: AfdE7cmGe+fGLGjp9msdHxl+QrDtw102oy1ycQ1oXqDSnBQZkg2Ch9vVTRZJyrDZ3RT
	dVlYkcfv8amr9pztFW4bbpBi1fBNiQ/J8o3dRJS174Oc5mm77nzSck/UDgTlN5PRsFFEZPy1OD/
	+r12ziaFDBCEeuo+Q6qht4/H8bnvAcXN4+ZnYUL/4i3NVcKTEWH5skLGn3ufKRqknetkdPDiqTD
	PTiL7C0BtpNvJnnTjWrFzz0ghkvTpmJdkUIPGHTkTBfYndd8854M9QvkBmcgZ+iVcaPuvGOcyu2
	UcyjESUOdvRu7cXAHXpp0X/cOeCZczX2ci2/B1uO6OXsD63nrC+dI/2y0ujqj04+dv1G0hj2Gzt
	qLXR3rTHoBIBQLWwwVnRxEJ8x6XvZxNfgvDtNJ9QGJ689SbDKJNYHxcbfZdaoIAlwkYevSYWRjA
	K187kNIwnEbMQQ5luzC13QjR7StseufVkcVYLXcboJnDgmuf7mIasvKeIb259ZwWxa4pJ++8NAL
	yvmWebENOmiEn4=
X-Received: by 2002:a05:7300:7246:b0:30c:5a5:df4f with SMTP id 5a478bee46e88-30c84eb9cf8mr6385940eec.16.1782451089397;
        Thu, 25 Jun 2026 22:18:09 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:08 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 03/10] Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer
Date: Thu, 25 Jun 2026 22:17:52 -0700
Message-ID: <20260626051802.4033172-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

rmi_f54_work() reads a diagnostics report from the device into
f54->report_data, sizing the transfer with rmi_f54_get_report_size():

	report_size = rmi_f54_get_report_size(f54);
	...
	for (i = 0; i < report_size; i += F54_REPORT_DATA_SIZE) {
		int size = min(F54_REPORT_DATA_SIZE, report_size - i);
		...
		rmi_read_block(.., f54->report_data + i, size);
	}

report_data is allocated once at probe from F54's own electrode counts
(array3_size(f54->num_tx_electrodes, f54->num_rx_electrodes, sizeof(u16))),
but rmi_f54_get_report_size() computes the size from
drv_data->num_*_electrodes when those are set, i.e. from the F55
function's electrode counts. Both counts come straight from device
queries (F54 and F55 each report up to 255 electrodes) and nothing
constrains the F55 counts to the F54 ones.

A malicious or malfunctioning RMI4 device that reports larger F55
electrode counts than its F54 counts makes report_size exceed the
allocation, so the read loop writes past report_data (and the V4L2
dequeue memcpy() then reads past it). On conforming hardware the F55
configured electrodes are a subset of the F54 physical electrodes, so
report_size never exceeds the buffer and well-behaved devices are
unaffected.

Record the allocation size and reject a report that does not fit,
mirroring the existing zero-size check.

Fixes: c762cc68b6a1 ("Input: synaptics-rmi4 - propagate correct number of rx and tx electrodes to F54")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 8eac320c43e3..75839a54656b 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -104,6 +104,7 @@ struct f54_data {
 
 	enum rmi_f54_report_type report_type;
 	u8 *report_data;
+	size_t max_report_size;
 	int report_size;
 
 	bool is_busy;
@@ -548,6 +549,13 @@ static void rmi_f54_work(struct work_struct *work)
 		goto out;     /* retry won't help */
 	}
 
+	if (report_size > f54->max_report_size) {
+		dev_err(&fn->dev, "Report size %d exceeds buffer size %zu\n",
+			report_size, f54->max_report_size);
+		error = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Need to check if command has completed.
 	 * If not try again later.
@@ -678,8 +686,8 @@ static int rmi_f54_probe(struct rmi_function *fn)
 
 	rx = f54->num_rx_electrodes;
 	tx = f54->num_tx_electrodes;
-	f54->report_data = devm_kzalloc(&fn->dev,
-					array3_size(tx, rx, sizeof(u16)),
+	f54->max_report_size = array3_size(tx, rx, sizeof(u16));
+	f54->report_data = devm_kzalloc(&fn->dev, f54->max_report_size,
 					GFP_KERNEL);
 	if (f54->report_data == NULL)
 		return -ENOMEM;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

