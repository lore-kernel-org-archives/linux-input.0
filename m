Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380186;
	b=pTMey3rZp9qpDx53dCa5dUEwe6U0RxqkKxs0DatkxGBOc1/MpRtkiJfyCGm+iOlfNCR8
	 olSGN/AiC026gbN4BxzkuIyt80hIccXxICI16Qh+SNKVcgcfaAh2t+xzm8qdpdIy5wudk
	 85YaOKPFvT8e6RFpkOMHGWPtFbGKaYmbX9GYfHIZFzbzTtWRShE6ICSSFIxxvQqugRODj
	 V61ayPyGirX7WWE9mV1d6y+CmRjbe2FAGUANKy6VFe+ZeFeAW5CHcP+WMmqntwDOZtTO9
	 A+192UxhU55b8SB0xIOMADrxYJ+X/rbzCfUL8DZ4VxW2cKUPH8a+AwkpRVh+tcjC7kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=nx9IOLprpQSMfjypqpoQZ6anLGigCDf2bUI7iUAOQmY=;
	b=wDg0n12ve0yXE9zC9bYImbX+bMtmUrZgCFfTj9tg3QotIuquA/UkPP1zR1FwFg1YZbiK
	 wIuqkVMiHTAkxbIIKX7l8z7UIe3+ze+OXY3n2wGIx4ouTQ68xsbsgPbDXMGRvRj76RO5W
	 Br526sp8oxy3QJBPquvxYyTtuVQWK4SSL4hSWtCFarZWJ8foUH0ypP9IaKqFG4OqGSqZ/
	 InHixFvGIhSv/skKMXUEQ3moBWvocCY/5xrzQKztbWtibiPj960SKm1neRZx06vhNkOVN
	 oH5GDalPqQzPCJ4XjRDuRZlcaKXNnnQ2ZeN4wohxvDdXp1C2/pq1iFQzn8LLns5mhgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LLA/ZYD9";
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47460A2621
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E47460A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LLA/ZYD9
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3acec6677so4468540c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380186; x=1794984986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nx9IOLprpQSMfjypqpoQZ6anLGigCDf2bUI7iUAOQmY=;
        b=LLA/ZYD9fn/oCUqdGap+MTcTC+l5+kwkINjy3EWCM69xGKD5cSNPwlYSzTfP8iNY2b
         bnSaFWy+nxAxyqNwkxqRaFs9A2DRCrDV5WC4b9NB/MkD412k0Lm0Q0T8U/R4zKXilqW2
         6vAgtzciaIKIUzngXJsysCYUcX7fGYeWhtVnFMgq8Q3BRHkhDCuzQHX3hZZbfgjQ+gf+
         YEanGuejwqEl1HR7vFCCq7Iff0YpOKZMcOMhEC8k5bi/AeOMHSfiF0PEvM8Dkkj4kDp1
         H2kRMvrwnOkxvW1C/xMCSx+C8YfglHmvWIfznHJyJkImIIsDxUMCbYHXCA0fsTMYVM4Y
         yb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380186; x=1794984986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nx9IOLprpQSMfjypqpoQZ6anLGigCDf2bUI7iUAOQmY=;
        b=dFIOEsax7G8e+6lpCDy0cuhhbC3RVaXgeJUW+dlpa0SNic8Cax+pDsD4IxTXHW4go7
         AkiVNrXOIctudFZxv9vp/F2hyJktiCQik6stn0KDLoZqnOoI6o0yU4YC3W8ternqu7z7
         0yjgvLcS2ZOjOBHwS/PjgHn7oxCzwIKzOqtiAF3PV0xEjMwyrefrKSH1lp+50EcJlg/x
         BzRp7MDFv2K1WzlCshBc8GkNuXWiRlxKvfP4LsiW5+x/UHym/W16VA7dgeTusEgd04Bp
         TWF0w7uoCegwrP5RHWtzKS3ZQnplyNn0QIecbtVLixBCU5L6wjMgGYDvXb/XvFp7HWhQ
         W/Yg==
X-Forwarded-Encrypted: i=1; AL+hErFU7Dwuq6EtAIpzQrA5E4aH6nEtXwWt4p2GYD3sCbbFsIuyb41L6c2k7hxGWovgEFCKh3Q2uCxZP8A/Rg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/tLzXaTXn4X4/XSumxrcS1kut2lQi8i7E8l1H74Pdnx0mlUDHX
	L3Nre/ogAE+xcZbRWwmS0X1kxWDPERYaB/Tan/bGJv6k9/bYzelmT12t
X-Gm-Gg: AYBFou2bKnWSP+esbLvXlUMCScufcWewx5BeJb5zvMya1BGkR6Jm/uMACfA4/UHXy9X
	7BFW6Coq9oRXxsHZRmPSAGY0/onbCAzPHfQMeLyLUkpOW2KyCI5eCZVVmgbwURx/w1CHMBhSmXg
	iHza3+6f063EzhTAMr9j8xWZDGtr/lsFBlEVcmUMjt8BL3/bCfTA/3MfZtLmAyhzO3Ev8K1a7f5
	9oDhJnN0qKfogMXYFV0+joRvT43pukfZ3tB6up/JSiLuQr8DrZmhsBiTiOiyYuB8mppjgo7ZPQc
	da/KHepgC3CeOw8Y/8Hto9k2NJK8RMJIyuiayCajy0vzek4cqE6ABk07zAjjD6vr7vybzWhkRAw
	O/K7/DSt+AkdEyjNlojXS9+MswNozzNQKeikQx2TnHTd+AHRyl06K70naNC88OhonHYb/pNGSLj
	QUivCuMOhVpew8zxx6+W6q9QOv1Tcwr+PFGbftfhtvPlsaC1HcI5c7TI2c3usZdh6CaQ81Ci/si
	tSyuT2C+//K8r4KwM2mUHqOnHebl1rKsKFflIg7EKW2FurzC6yR7IC0FBDSbEPqTJwoCI5Fvakp
	prYfDimX8uoRrDN/zOZZfSGAoLJjnUEJCj1nxU7obTlHZ/n53bRzlB9BVYZnnILa5sTttYLu611
	nMs78CvVvz+C5fMN17A==
X-Received: by 2002:a05:701b:20ce:20b0:1a4:3169:cb with SMTP id a92af1059eb24-1b3c0311b8dmr1605411c88.17.1794380185575;
        Tue, 10 Nov 2026 22:56:25 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:23 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:01 -0800
Subject: [PATCH v2 03/33] HID: logitech-hidpp: drain G920 FF workqueue
 before closing transport
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-3-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Probe no longer keeps the HID transport open indefinitely, so the
underlying USB interrupt IN endpoint only stays active while the HID
transport is held open. When the last input user closes the device
after input core flushes active effects, or when the device is
inhibited with commands still queued, releasing the HID transport
shuts down transport I/O unless another client holds it open. Queued
force-feedback commands then fail to receive their HID++ replies,
causing command timeouts and leaving stale slot mappings behind.

Override the input open and close callbacks once G920 force feedback is
initialized so the force-feedback send queue drains completely before
closing the HID transport.

Fixes: 91cf9a98ae41 ("HID: logitech-hidpp: make .probe usbhid capable")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d9342a3e8122..d5f53b35ac6f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2815,6 +2815,22 @@ static void hidpp_ff_destroy(struct ff_device *ff)
 	kfree(data->effect_ids);
 }
 
+static int g920_input_open(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	return hid_hw_open(hid);
+}
+
+static void g920_input_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct hidpp_ff_private_data *data = dev->ff->private;
+
+	flush_workqueue(data->wq);
+	hid_hw_close(hid);
+}
+
 static int hidpp_ff_init(struct hidpp_device *hidpp,
 			 struct hidpp_ff_private_data *data)
 {
@@ -2897,6 +2913,9 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	ff->set_autocenter = hidpp_ff_set_autocenter;
 	ff->destroy = hidpp_ff_destroy;
 
+	dev->open = g920_input_open;
+	dev->close = g920_input_close;
+
 	/* Create sysfs interface */
 	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
 	if (error)

-- 
2.56.0.542.g3ef89b7020-goog

