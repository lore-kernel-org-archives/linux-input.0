Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCB3093B8
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512819; cv=none; b=vC+/fyfGRWSzivU4R+cLjqXgT4W0tNLGQNT4VyHrP6rStC0ugC3mKS8xnuCbvfHE5HrvuFqLzxVmcLqiuaY5z91AYC11XxFdop3qBTa5xdZ66DPFJi3+MzTPrinYwDIgyVXi8m6S3cVFSHHqtLkTeWzDZQ3L8PXumTWmLs45DZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512819; c=relaxed/simple;
	bh=6e1rj9pQmI2NVnlVXO7bywMrIJiFKSD9Je58nrGA+q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IN/i8/vsiGLNyG18rApdEhkr+t1qbcVfd65FJlVvQTmPx/Z+LgZKqqxh5tsxpabyPMbPGaIkOPwVMCG90TP7Rmo/p+LtM7O1VmViB+4n4IRkj5Y6HRFOvMsGc++L6pjXdLxqU6gi0JwAJYD1BJO3fZfU7hTWrJfk3rbwbZCYJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xaf6lhHH; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xaf6lhHH"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304545e6c7fso1388787eec.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512815; x=1780117615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMrKJOvw6kEjwpBuF6gaRm9aW0Ujd/cJV12X/xp77Po=;
        b=Xaf6lhHH9Es8HN/J95veREZ0NWfGov8ZXSPbEhac6pZgNHsjwDxHL6Q1/qrKrnGVRy
         uNSMSdm5LkMSIbsf5Xoj/FHOsUHHzp8WDyf2stQ0bDO471a+A6VvtTxoDcOv3TYQkONK
         Fs1pck2WXWIJyUib4AqpjliZvs1TAXaegkSssTNeV8s1k9nIYA1vsbkrOndlSqlL0XCo
         XVqlH7OWstbMDB/8mjPTHOjkLXTqkQW0KC28TkfP5lDWqrFyzWp/SPgP3QIr/yYcHeKs
         UJ+5xucWkGzwvzuGxppDFPquShaCQbqUJH6Ey9dJbfTIJQDgPFqHF54IGPzBVojleQ9z
         Ik8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512815; x=1780117615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMrKJOvw6kEjwpBuF6gaRm9aW0Ujd/cJV12X/xp77Po=;
        b=gUWEjB9+Wg/axL07ms+iAVgF/cabUo0HJd/AEJfHNzoriFcx501xc0+pVa3oF/BRQn
         oHVxilXJGMJ1DrALYLXRTAn6dth6eSxaZWzJdq70sk7N0ljI2B6KzJDQWQEM9L0gZbXq
         dzS232RBxxV8CiHDUfSQdbIhBzB3vc3NkHJ0sZOIaPfwWG+b/ij+3c24bCCiXW7aoQGr
         RSRW8D70Xs1YJ1kWn7z+62U+sfFTexScMD7kvJwKxfVzMjlzoqZVKnI2G4zg83V0wd0A
         U+wMdGMkvgHWLsvXHWcKTz+83TriAQ/hyAZbJ/fl+IYVnMwFfXNcQXuF0HTu5aC44LdU
         Y1fA==
X-Gm-Message-State: AOJu0YzyGTAOl7gSEYt1LFcC/X5O4MQu06bqVtENl+QsdvsIu1fEiz4L
	dEMpAUmuNlWPnCec/YPTYYZZkrGTEm7NLvbf36EBXFY+AuMTHR0KMRoypPNRrg==
X-Gm-Gg: Acq92OGqc/Wi4hxwDEFu7XGdGHuZTpfqqTBkrrtRAXeiBor6xKIxQQD2Qfv+MlO83UZ
	tk5p5N/ifYNctDsX/xSV/u6Rro5FaYpSBzFJLbaZ+v/gW+Ln4jBKvDWSdUqUSNdOTC27Kl4pI1M
	JwtCtTfC5Nnlx8OoMScQLNmpy2GUs6vfIJALr4pwyblm9WiuI+S6qhNFCv97oFRQp3+Z65ww54L
	o0aKKhPOgIP7L6SJjzRownycOyuz+JvPgUen8VczKr+1rU6oMqNinyatlQ0y6a2+z3WbmQ3Baqp
	Oq3T8HDQPVeqzMZuGng2XUN5UcnF0KMyOzZPiPICTsoBVqzlUdooG1rWqAPysAE+aDfJ65YyV4A
	tRGo4UF3t74OCohIQzb1oNSCFpt95l+dHStkGgza9NJll5WuWlxJUt/tNtNc+jMb4zZR4hUETJk
	10SUpgjJAKiSlIvn+G+Jq757rE0HNOrQLutaA3Q5rJq7Gk6a1NmJ30PQmobSDPMzG/wBJTqFiQy
	mbneF2Sj3OdRQ==
X-Received: by 2002:a05:7300:434a:b0:304:2e9b:8f57 with SMTP id 5a478bee46e88-304491337bemr3631797eec.34.1779512815376;
        Fri, 22 May 2026 22:06:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:54 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 09/11] Input: ims-pcu - fix DMA mapping violation in line setup
Date: Fri, 22 May 2026 22:06:27 -0700
Message-ID: <20260523050634.501509-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ims_pcu_line_setup(), the driver uses pcu->cmd_buf as a transfer
buffer for usb_control_msg(). However, pcu->cmd_buf is embedded in the
struct ims_pcu allocation, which violates DMA mapping rules regarding
cacheline alignment.

Use a heap-allocated buffer for the line coding data instead.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 23e576500890..3b119bc81c85 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1790,11 +1790,16 @@ static void ims_pcu_stop_io(struct ims_pcu *pcu)
 static int ims_pcu_line_setup(struct ims_pcu *pcu)
 {
 	struct usb_host_interface *interface = pcu->ctrl_intf->cur_altsetting;
-	struct usb_cdc_line_coding *line = (void *)pcu->cmd_buf;
+	struct usb_cdc_line_coding *line __free(kfree) =
+				kmalloc(sizeof(*line), GFP_KERNEL);
 	int error;
 
-	memset(line, 0, sizeof(*line));
+	if (!line)
+		return -ENOMEM;
+
 	line->dwDTERate = cpu_to_le32(57600);
+	line->bCharFormat = USB_CDC_1_STOP_BITS;
+	line->bParityType = USB_CDC_NO_PARITY;
 	line->bDataBits = 8;
 
 	error = usb_control_msg(pcu->udev, usb_sndctrlpipe(pcu->udev, 0),
-- 
2.54.0.746.g67dd491aae-goog

