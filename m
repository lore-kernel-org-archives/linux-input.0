Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D52437136
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782825; cv=none; b=QtHaqzjChdv9Zexn+GAp4YHAkXWGnvWjV8RW9mdB0XPKalcq7gZ3TSP0Xy9tS2Cvh/b8Url0LpRyO7KAO126RLI/Pbg2Q0k538c0kEfid+kotyoHtXUDR05nvWcHtBVcNBQifDNkl2yNKdDr3FIi5xOmIiLeXJ+NdofCr0lmm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782825; c=relaxed/simple;
	bh=jpAOqaBdI7XZv/2UrjAfgGxJNhTK/u5+yBOK2+bVK64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHRzIpkbsfg95//fXUJ1z+aA3lkYTjGqscE/e6gIwkbZYsh8gvQawOtVC9Ibq0o6MZ5EF3OS4dfqwekf2MjDH08SDnQSUvF5YhDzeVqbT7xic0n81BsuDqXaHuQ8KvtDUlSAOuosoWbeEOei+23NnfnNB7DaadXLceT5wUeVKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw9gI9k9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw9gI9k9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38f620399a0so2994234a91.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782822; x=1786387622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkuSCqc+yAADDamWfiyKN/ep68Wue9ZrU0Qqd8Kmzk8=;
        b=mw9gI9k9psH2ucd/5v+hM7lpApumvm1YDsiCptAJtPp0syc2YadfzB8db2XcsXHRCA
         yXgWnMvR2wr20udYKK3CUfISVdV2vPrQWUz4IbvS7D7zgI7MPBr6JU7If5ZTu7pIRnFG
         5pnm6SjA5lWp1GV3K/+CO51N3aHYAw0+1dR2zeDodtdg7eMB78wHA/qxIvQkrfywCoaQ
         c5CCm96cCWMJXFUdoHT+jZbKPljT3ny5WwwyQbEJNJbzjcp/C9h3hVUhroQk6E0e3a91
         meEO9QctT4ETOCXGsOIZrAr/R5MTPaLGH+sk49Ss5a9Uj23Tw6fsey30BzvOfMcW8e7P
         JxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782822; x=1786387622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkuSCqc+yAADDamWfiyKN/ep68Wue9ZrU0Qqd8Kmzk8=;
        b=lZ75s+YJlsOxQ+zAhs56pOKtEviRY5JPefjLUgW4cDemyX/5vT5V2IeENmTIlLbJ8/
         4UjzUNiaOkb3jyp3aQ0ao6i72ICMCZuVcNuayv1HhQ//MISn+rOmJ+qvC9LGnjMED4++
         OU8tLEb2Ba+LrnRkCPzfDeyMulcoZtRj6ppd/PKSKDBv0hdcrqLVv7mwC5rhnpHvn24S
         2MaJ+71e8dq7ROI1c1+dEIOMVcxzzh8Ukvgt2gi8I5cxws/jMiLlt/x/f6RiAiE1KhA8
         bXBvXSvDU0+3opoy0ng/hydTBeVlbZ2+G3l6i6cm8nED8GvVg7CHhkCTviW4EiUqHb+M
         isdA==
X-Gm-Message-State: AOJu0YzVgcy4VsLDvBKqLJd1uhwivlcsKjsUQOuDF6rvUBAvH7jcvBmS
	+IPZj7G6xzvhlNWHuUgb5i9Eyo1g7RMx+mc5dGFFCKxPsEbSWyJBFIsN
X-Gm-Gg: AR+sD12I5sdVdS2r+mu29eRSMVwYXkIChCpeAgLB1CW5l8Tqhk5bM/El5FhGOLbH+jH
	tj5jNu8JDJrHUGb5oHQJplSlAtMDKJNK38fI/QAhGANsvkgX/8KqvUylLQbv4ROza6M6wRzaGiN
	7Yj+ZUfi523nLqAvnwzmMSgBDAZg4r1sBkDYafv1G6awLd16qVca9LbgWr6D/YV6AWYgbzu8q6j
	mcm72urkAoeLb5VSosjSx9avfZHqWrRz0igpoXMKa0DnjKIQAgXbO5myVUbcL+0fo7ouN7Bs+fe
	+7ZjZekHBwc3NfCo9CQ8SqRd+Y1lyLtt12GWDQ2Gm9K/7BETSi3ecxIdhsHQUZctbMTipJu5GcK
	/WPFK4FpAIp7aIQwDuDeB42z+Jm4M3L4AgUadR/dxskm0OtuhZJEyOKl1bFPfObCbcgfVSQXKwc
	9OnXXN+LET1vsBvESJqdmmM0Mt7LqJxi1a8s+tjse7c6SQtu1bBVGEw6Fx8zQVRK8FPVaKAK4Un
	AWWpnSF5b1wlfwh9KXV6PhtCDok8kL17oOLHV4xVinbQV/5ACA6
X-Received: by 2002:a17:90b:3c86:b0:381:f7a:2e0d with SMTP id 98e67ed59e1d1-38fbc51f884mr10395038a91.33.1785782822529;
        Mon, 03 Aug 2026 11:47:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:47:02 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:44 -0700
Subject: [PATCH 19/21] HID: megaworld: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-19-1dc9bbacd88c@gmail.com>
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

The driver currently initializes force-feedback in its probe() function
after calling hid_hw_start(). This is racy as the input device is
already registered and visible to userspace at that point.

Move the FF initialization to the .input_configured() callback to ensure
the device is fully prepared before registration.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-megaworld.c | 51 ++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-megaworld.c b/drivers/hid/hid-megaworld.c
index 81acdbc3a00f..d5c868974275 100644
--- a/drivers/hid/hid-megaworld.c
+++ b/drivers/hid/hid-megaworld.c
@@ -35,21 +35,16 @@ static int mwctrl_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int mwctrl_init(struct hid_device *hid)
+static int mwctrl_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct mwctrl_device *mwctrl;
 	struct hid_report *report;
-	struct hid_input *hidinput;
-	struct input_dev *dev;
+	struct input_dev *dev = hidinput->input;
 	int error;
 	int i;
 
-	if (list_empty(&hid->inputs)) {
-		hid_err(hid, "no inputs found\n");
-		return -ENODEV;
-	}
-	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-	dev = hidinput->input;
+	if (!list_is_first(&hidinput->list, &hid->inputs))
+		return 0;
 
 	for (i = 0; i < 4; i++) {
 		report = hid_validate_values(hid, HID_OUTPUT_REPORT, 0, i, 1);
@@ -61,16 +56,7 @@ static int mwctrl_init(struct hid_device *hid)
 	if (!mwctrl)
 		return -ENOMEM;
 
-	set_bit(FF_RUMBLE, dev->ffbit);
-
-	error = input_ff_create_memless(dev, mwctrl, mwctrl_play);
-	if (error) {
-		kfree(mwctrl);
-		return error;
-	}
-
 	mwctrl->report = report;
-
 	/* Field 0 is always 2, and field 1 is always 0. The original
 	 * windows driver has a 5 bytes command, where the 5th byte is
 	 * a repeat of the 3rd byte, however the device has only 4
@@ -82,30 +68,15 @@ static int mwctrl_init(struct hid_device *hid)
 	mwctrl->strong = &report->field[2]->value[0];
 	mwctrl->weak = &report->field[3]->value[0];
 
-	return 0;
-}
-
-static int mwctrl_probe(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	int ret;
-
-	ret = hid_parse(hdev);
-	if (ret) {
-		hid_err(hdev, "parse failed\n");
-		return ret;
-	}
+	set_bit(FF_RUMBLE, dev->ffbit);
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
-	if (ret) {
-		hid_err(hdev, "hw start failed\n");
-		return ret;
+	error = input_ff_create_memless(dev, mwctrl, mwctrl_play);
+	if (error) {
+		kfree(mwctrl);
+		return error;
 	}
 
-	ret = mwctrl_init(hdev);
-	if (ret)
-		hid_hw_stop(hdev);
-
-	return ret;
+	return 0;
 }
 
 static const struct hid_device_id mwctrl_devices[] = {
@@ -118,7 +89,7 @@ MODULE_DEVICE_TABLE(hid, mwctrl_devices);
 static struct hid_driver mwctrl_driver = {
 	.name = "megaworld",
 	.id_table = mwctrl_devices,
-	.probe = mwctrl_probe,
+	.input_configured = mwctrl_input_configured,
 };
 module_hid_driver(mwctrl_driver);
 

-- 
2.55.0.629.g250fe7f194-goog

