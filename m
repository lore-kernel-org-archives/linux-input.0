Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96DF378D89
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244588; cv=none; b=oPKZyvBJkKTvH5OfUP4/G41Srusvnr4LLsJ3UX1DG/mBxJnP9LJaQCAUcAH9X0WxeX6tWa5i5djF28ivUp5p7+CwLNBTb6zeU+yYWpJKowZXjcPZc/elIxQFibI7sAlDPdCTDt2iPiqoFWJQPLC1CqObfFZLJiQr9Cw4Wg640vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244588; c=relaxed/simple;
	bh=UPqoKv2odN2alKdKmCDWKQEX8FGs9CSOoE0x0PikD4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI0ONCLSErkdAUaq6MRXBHr7aAEghO7L6IoGfdxfq4MyWS3iSQ1cw6qh/v2Ot5a3tC+lXboFVDzwUGLUTKncrG6l8qgPLn5B1zB6xR0A04ccvrm/oRNa9B7WlC9Tw5c3m+Az7CZFDkaOtWuiC7bHUE+xZMYY3qDEocOSr3HLhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8srwwIS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8srwwIS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so679244a91.0
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244585; x=1788849385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AWXzOdnKhbhpWmdwzC3tIWpczbOSi2dbzs4RTvDwpr0=;
        b=L8srwwISH37UTbJRP+eTmv5yFlTxRWqkozQ6Yas4sKgbkXEm1cNlwyygCtiA5CGyZh
         Q/CgkNxgMk7XNkemi4Lc9Df/bkR/spg0se4KsvqlhlXHH/Ck17jO3pNi0QTcWGyR0Pda
         727AepTQtuflUFOYFf9g65dS2tDQzQ5H8wDUmKDPrIYhS9s3IjW+z4z/F6VzaZeW52UY
         Tsy5DKKsAq3YFl7d1GMCRwDHcp/0GvpTTmv9l9dVHK8bjExtVqWkUEn/dxS2C5NWpeCq
         8r2lr9BTf/VV9TRsn8RHdef4f2o3obysYOeXrO0x4NxymIlkaBvP21CoqiaySKrO6Lp8
         gRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244585; x=1788849385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AWXzOdnKhbhpWmdwzC3tIWpczbOSi2dbzs4RTvDwpr0=;
        b=nt3nQ2RDQ78orkHjX1i0oUY+jVY4V2hhumweiraBT40R9vPlc9K3KS+XIqLPh6LLO3
         iInuhK6rk7wbdMJrIKDE03IaxZhaL1wbrAF8MaNhnr0kM3YSXAUCGHx0jFAxUng4zlj+
         ThW8HhpB1EPyLJv7CgbZrNJIxKe+Z4J32C17zLAeHHNcPKHaRONWGOQgRvcAwPsUVaAd
         Hk3Xw1R4uf3+Wl32YIrszkjQMhciWX1SV8T89Z+8gubMJIHrbkZS5VtyMs2dV0dXk800
         04TWyI9mqB+Sxy5M/nFOC7SN2JDeBLZZdReQQlGu8rGZ3BFtKBIS4faLb4bHENrqgvem
         UtrA==
X-Gm-Message-State: AFuF++n52mFqwkhW8hcRwPBVZ/P86KrT7nCGg6XVnAQ+8K/t/aUgp+2a
	ipkzTWPGSQkkgFNk7vtpebdxXQ4pXdMKqeYrcK/dcbKSiPoE4u7IngxNui7EfIjZ
X-Gm-Gg: AYBFou3qMMjoIfQb71c+uYWL1Rf7IkxheoSOK1SqGGEfzJrb1a1LUrebq3hUi4OrXRw
	4k668u+3G5QoO97SJ11hm0qoJsl/fIEnpEKfBlOufUHIHbruZmCQCCFNOAVdmcfIBAWmRe9VeVo
	aDYTVhbfIz6+52toc3sZW7W1WgNGngU9EaDJSAqdJtYJ8obcWfYUoBkZ++6DPgLp908apEgYkIs
	raTYy3hLwiKPEWRcHUL6KxnYBy7MFktxD2a67wTobmJQtG1kmTOA7yWRMohf/tVftsm57n4RTK6
	J5Fa/AsHtUumXtp6Cc1/eG2Xnec1EULDCUO1NcUUF+9xePHjk+nBLETYGb0AfcoZonHXeyUYGyI
	HbyQFLo58qgrwM0M235DtLekLrSCvZXe4+hG1OIxy+7RLlnUqERSmWm6eCQMuPLF4i+7sxmMQzL
	L3gR4n/hRIGBAPAJcrq3mb/XTCc2ko7LhAaLALSdAL4Es6GI5NZ3U1tX+jB7i/MqjggN3iBIyfq
	ERyxC92bvMw/w==
X-Received: by 2002:a17:90b:51c8:b0:394:ed5c:ff9f with SMTP id 98e67ed59e1d1-3990f890efamr3798410a91.17.1788244584948;
        Mon, 31 Aug 2026 23:36:24 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm32694425c88.10.2026.08.31.23.36.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 23:36:24 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] HID: hid-lenovo-go: initialize command completion before hardware
Date: Tue,  1 Sep 2026 12:06:04 +0530
Message-ID: <2421c0ebbe4a487acb20317d03e581b3438e4471.1788222001.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The configuration interface initializes its command completion in
cfg_probe(). The hardware starts and opens before this call. Keep the
completion ready before hardware I/O becomes available.

Identify the interface after parsing it. Initialize the completion for the
configuration interface before starting and opening HID hardware. Keep the
remaining configuration setup in cfg_probe().

Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index b937d11dd6f6..51e3112780e1 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -2388,8 +2388,6 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
 
 	drvdata.led_cdev = &go_cdev_rgb.led_cdev;
 
-	init_completion(&drvdata.send_cmd_complete);
-
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
 	 * initial data call after probe has completed and MCU can accept calls.
 	 */
@@ -2436,6 +2434,10 @@ static int hid_go_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	ep = get_endpoint_address(hdev);
+	if (ep == GO_GP_INTF_IN)
+		init_completion(&drvdata.send_cmd_complete);
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "Failed to start HID device\n");
@@ -2449,7 +2451,6 @@ static int hid_go_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	ep = get_endpoint_address(hdev);
 	if (ep != GO_GP_INTF_IN) {
 		dev_dbg(&hdev->dev, "Started interface %x as generic HID device\n", ep);
 		return 0;
-- 
2.55.0

