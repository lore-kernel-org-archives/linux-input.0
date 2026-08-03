Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2556435507
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782800; cv=none; b=B/6tGzwJZ9LBszZkDrZwSr/t0thUCE2IjgjLgwaW3d5qcsfIL8MNJPMlVEfXLyRad7rxXT+JcjydZAw1GPxVsEX49A1F7nA0MvETeZ7Xp8zBY//1sMD8KU2xPGs6Mvo69HwHz635HLIEUlHLxuPp5vJpMJmbL3H5WKSk3hgunKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782800; c=relaxed/simple;
	bh=zTvGTNkJ/wqnyMbPR7YJxhbtHyE5HaI2GyeFefAOijU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1QMVTt2C7virc3/fLmh8o4ahg9muXYUXV+nSa+B3W6z4oij8qZ3C+OfpsGAIdvUgM4ifHghV6gBOqapN39YA1Gwd08/AigZouYlZo6qQaxIVUNUip5NCrrWkSfPm0rzVmU3pgWdDBTsDdontXY0xM5Ah4DGp30nfIwpYH39hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeHBCcSV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeHBCcSV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so3556188a91.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782795; x=1786387595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDX03Rc6Co4fp263PbZY9y3DOwf1pY8yl2EntzRzQTY=;
        b=aeHBCcSVl8t3n8TKdHm7kuAHzkasUis4mHZl0wezNnlQ5w0kjis1D0fjUKjcNnSF4i
         ZfefXAmM/4qqqFkxUQ/po4R9Evh9RawpGWQYTisgsTcQYJ7ZnQ/mGeItv/GZPMmeWb5n
         g0xey8asHyNrsahRlwFBwi9FE62JIR3f6q6Djin0ZUPKa/zyjuncnfhV1Rdf51MW3Q8U
         PU0eARE2hgHLvUbQPRN/iiCIol1CA0EfkwcJAXQa5k6XJCGOMrCxMRfYBrbA9MXN652m
         8MGOwODxSbWFoye0EyWHCaj/YywuL1WMcFmZVI8AoD42fXRDxxQLUDAX+bOisAbD5+AN
         py9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782796; x=1786387596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fDX03Rc6Co4fp263PbZY9y3DOwf1pY8yl2EntzRzQTY=;
        b=dds8ZSwOjJGHlGexlH3CykPWS8Q7jnAQJAI8rtENWMbdoNCiWP4EfngaMXTUaey6kb
         9A8iJ85RBEZNd4NJ6Ta/53PHE585CPiYKt4O3ZZ/6LpjjknF4yPbQRFCaLeYHegXOw62
         c2aqdWcVOfkCTfdutQvwlUV6jvCoEK3W+t3ty5Jv06RcHXRipwqCKNJ/EeBiLV9/UhSA
         XTEB1Cb3jYdVkbD+II565MJzuCULd59499M7dEw6wzzs2Q9VEcIBg7aHN1sLvUavL5aN
         V5vLqbW7Px9f9cRiggV3+6GqndBVDKI4Huo/x8DuVkbipIMKTSh3bbtkEAMw1JNb5kSR
         WcEg==
X-Gm-Message-State: AOJu0Yz/IuOojpsJQ8twLuyBSoMlIGwZYihm+q+j6Df7RlMPQCq+E3xN
	tLuDIboAWAVlYk18+rfe6fsnCF/4eWc2Syc3Ljv/jT+rgZ71tva1YxtL
X-Gm-Gg: AR+sD1181+9rBQ6HuBTOhNmrkV4gvdLF/14Qxi+3xuBYjxYkWDVLINhwSTNifjHfmXN
	WiZnofmjmhE4HMMVCp95EdkmYkglEY76eyknHgYyqdzWTVj1uj7VNvXFz5sdSwGuTRJxGglFXAm
	Wlqlz+77y/0CGLzZTfgerg2s+iyB6/1vtkEIvX9/n2O66r4tHkjl/1eAhz2mbuz+Itky79lXz1U
	nVxQwVZfEEim7EtN+goCxIF8NM9dBvxOOvk9E9NvyIgGo2RrZ6TbHZZ7sXhVqjy1QfUaCMSltku
	QGQsS7scLYBcw57bbiOMuggPg8uWxRGeRSV+YUxi+pVNrz66WaE2PWOYwAL23Z+gSKyKmxc94ef
	9ritKX7ogAWGnG/ZI9q06bl6znRFwjbPLE2VDBguApjYkyReAhXfp/SrLnIo7QjSVvjVPOlZ1TK
	mJaxPnirABSzfT40ODKY29fFjW91B9b9bugef9lvslAq1eLdMtRG2JS+OjZDBx5rFgVN1pxshre
	mHM23o4s32qoIo+cJx2XxiYbKHiCubsyF9PqYwszAsxq7ueeFk1
X-Received: by 2002:a17:90b:540b:b0:38e:e9b:ffa7 with SMTP id 98e67ed59e1d1-38fbc51f1e4mr10231317a91.28.1785782795558;
        Mon, 03 Aug 2026 11:46:35 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:35 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:26 -0700
Subject: [PATCH 01/21] HID: core: automatically initialize generic FF if no
 other FF is present
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-1-1dc9bbacd88c@gmail.com>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
In-Reply-To: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.16-dev-b242f

Some HID drivers initialize their own force-feedback support within
their .input_configured() callback. In such cases, we should skip
the generic PID force-feedback initialization to avoid conflicts and
redundant setup.

Add hid_has_ff_input() helper and use it to check for existing FF
capabilities before calling hdev->ff_init().

Since we now have a dynamic way to detect if force-feedback is needed,
the HID_CONNECT_FF flag is redundant for conflict resolution and can
be ignored in the core initialization logic. Generic PID support will
now be attempted by default for any claimed input device that doesn't
already have FF capabilities.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f107f5103b35..2767a171eae9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2287,6 +2287,18 @@ static const BIN_ATTR_RO(report_descriptor, HID_MAX_DESCRIPTOR_SIZE);
 
 static const DEVICE_ATTR_RO(country);
 
+static bool hid_has_ff_input(struct hid_device *hdev)
+{
+	struct hid_input *hidinput;
+
+	list_for_each_entry(hidinput, &hdev->inputs, list) {
+		if (test_bit(EV_FF, hidinput->input->evbit))
+			return true;
+	}
+
+	return false;
+}
+
 int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 {
 	static const char *types[] = { "Device", "Pointer", "Mouse", "Device",
@@ -2336,7 +2348,8 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	hid_process_ordering(hdev);
 
 	if ((hdev->claimed & HID_CLAIMED_INPUT) &&
-			(connect_mask & HID_CONNECT_FF) && hdev->ff_init)
+			(connect_mask & HID_CONNECT_FF) && hdev->ff_init &&
+			!hid_has_ff_input(hdev))
 		hdev->ff_init(hdev);
 
 	len = 0;

-- 
2.55.0.629.g250fe7f194-goog

