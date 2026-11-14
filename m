Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636009;
	b=QahsM3ilC+anGbu+9S6qRGNQuq3pCTtTfgyvNQYXLzHV8jTR25L38EAskN0BTGFCD7uV
	 14xKQc9yy4Mh1IMw/MoY87Jf+XmgqBejANZFkh1USTOdVdwlPc659OL8OuZ7YSUmqpR5l
	 LY4Y7rDkwRlA48/z69nHV2v0cGytWBGvaejnoCPi8l8VueCPyENO3HG/ZebLJ3haxHhRK
	 sRXQIJXmqmcc+x9VQE4SFyr/HkQxmGZRqxl9uV6Hcj2LepzlOeqiJXUJu2eBxykYpHAKu
	 jFvn7tLtLvnYxmhrz4Vnrn71tWl4h7dRu5UVcGbyz96KgOxEQWd9lvF7N/VL79u2L6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=mKtZVVnVdYNwaU/trNKiWVHOkmKtGkSe73ghcg3XOGQ=;
	b=pFzoWvAn7bqwkizA2arM6MHkCc9fx+SlW62w+5ISLTEZ86VZbUpxZgleumil0gzQcWl5
	 6/Zk3N0mScyINLUiMa4NDaHpG+jmyVQp6ije9K8pA1gLd4adwoOL/L6TlQ0GYntwAQ3MV
	 j4oRj1+0jFeEH27iKW9Kv0O0h93o3s3RAQkYpNn4KawJonynIPK1M/SknLku2ciQnrZJn
	 ty1+Q2eNLBrJTKg602mW9AagFvcxUfOTjrvjbocnfpd3UyzUO/iwyIB3e0kKYN3YX5btE
	 VkuEasyPO1JXN9cnpsSJoioQ5ZttkxRIFi3KuC0pqGSk+IuVBG0QfrAIfyxSZx4LRgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZaQsH2zM;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A5606A8B4
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE9A5606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZaQsH2zM
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2107895c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636007; x=1795240807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKtZVVnVdYNwaU/trNKiWVHOkmKtGkSe73ghcg3XOGQ=;
        b=ZaQsH2zMCA7J8MgFBELmIC5gfUWbd4E4i1x97KHtv3tRj3Drf8UxcMTP/Sepu+ypWd
         VBYzwmdrAsi6p4IVv/Lv7n+HxmBF7qyk+yYwA0qoEoMPpmIDxh5ht8rwyde6+03J9B7V
         Ex6pTuLAW6BPWrcxfuL/m3a+proerp+ewwiAqiBueMtcNU2xm9zOXhnR4ZwYJh3OGb50
         bgY2XMUttGcIEOvG6DcQvX4lM0QbF1/WZ2OIoQeYAA+ggOTXDWTRkgqnX0mnrtndopMW
         7F6N4uLq5TUZnQzJvWveRRrJit7QIRig5/G6JcskiZLgxqdiTmsdRb1pm2eAYfi39fOu
         mPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636007; x=1795240807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKtZVVnVdYNwaU/trNKiWVHOkmKtGkSe73ghcg3XOGQ=;
        b=hwbt6NPW1Rum6C1qjJjsp2cukRlXyv5rXhy0//5ihU9gK34/1Us5xJrlFtaAIW8mxR
         UCC2p7TdCswZCZRa+9BBsGdGe9lvYPBNuIA4AdSwkpIyIbwn2aHBt0n7xRvMQs9NvbBk
         k4dCc1PYa+j9g3KM2TiK936cIRXe4WJVnhKFA7s2N83/cohLU/FL+83trWACNBJScPZ9
         RgApKCwiJh4Lo1AJVoi7SqORZFoua7EYZ3mUPcUSzTbaACTk/T1eQEwLVWcZURSv7txq
         0v+Cgz/DDXcdwpGwpa8ctjD3/GodsDQBWzR/e7GUIFM+Cn4IvEURcEGhHx3FRVPH1aZ/
         EDJQ==
X-Gm-Message-State: APuU4Z/vctg2kFC+6aUOQIsAwyeLeO+eJPJ6Ml60taX1feFQozKaZxri
	LJjOp0RgjA5XnT1a7C+kXDEstNfwzLqdW3DMXoGz6GVWI6GhqvO8fD7I
X-Gm-Gg: AYBFou1cijTJW+cz2B1M6qK8h7QNQRsPmwUzCnjdJz0gaonvXSfOgtxgX7ONtq7/M+r
	VtbdPiJ3nkM4dwnG1nyM1ek9IB+/3YFcsGrXKDR11Vd4UQLSMKEP8zwv7bveQrYd0WLxNQcExAo
	hmv5+eTmgp8h/0YcMQtxplKSo9Sz9XAR6XCSPhfB4GMWjpe3pQ8GmNROVlF0CVJnsvutQzuU1Tp
	TXd9QgOgE24ZI9O73nZINAOXK7uRH1CHuhQ4AP8IVvpxRBmkNIdP9sq9tPP6xb0cF+bBoB3XdnJ
	7BQhhTFv6mpvWkji/agTvo4rpiIHt8uN2sd6XmYLJqUGXHCYRf9gMigsxsamL1fPKuVlwLHyXZh
	TpIFGOyKJpNZTGGi0GQJh/x1IcoIEqHAO6JJ/4l7glnkcXvr836Wmb5Ws5bWPmX3H7668N8eMFL
	qqJR14nfIH5t87gU4QRNuE5ONUvkjAhPyJPhX+vFTZgMctZbr3sXMg6JnWQEA7gVgahgyrW7D0e
	BhSri1Ayp6U23vCVOVATIJw28ccEPZmuFd+O2vBF/VqDPrzRYg4oeVSxjb/6u8uf2jMu7QeLgBN
	TyJqjFoaT5RdwdSTndZKb3GZwK98UM9pfbZhIM9ZEUbgN8YUfGSF4sToPSYj5s21L354w5OhB3H
	xoSH5EDTHjZ/Gf5Bj
X-Received: by 2002:a05:7022:1583:b0:1b5:dc3:209b with SMTP id a92af1059eb24-1b50dc32734mr2517153c88.22.1794636007187;
        Fri, 13 Nov 2026 22:00:07 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:06 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:54 -0800
Subject: [PATCH 04/12] HID: rmi: fix device lifecycle, suspend, and reset
 work handling
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
Message-Id: <20261113-hid-rmi-v1-4-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Incoming events can schedule reset work before transport initialization
completes or re-queue it during suspend and removal, power management
callbacks can dereference uninitialized device structures on failure,
and failed resume steps can leave transport interrupts disabled.

Gate reset work scheduling and power management callbacks on device
state, track suspended state to prevent work execution, ensure resume
re-enables transport interrupts, and permanently disable reset work on
removal.

Fixes: 0b2c7a897378 ("HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4")
Fixes: 8725aa4fa7de ("HID: rmi: Check that the RMI_STARTED bit is set before unregistering the RMI transport device")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d9181fd66c5c..8783edb7fd6a 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -31,6 +31,7 @@
 #define RMI_READ_REQUEST_PENDING	0
 #define RMI_READ_DATA_PENDING		1
 #define RMI_STARTED			2
+#define RMI_SUSPENDED			3
 
 /* device flags */
 #define RMI_DEVICE			BIT(0)
@@ -428,6 +429,8 @@ static int rmi_event(struct hid_device *hdev, struct hid_field *field,
 	struct rmi_data *data = hid_get_drvdata(hdev);
 
 	if ((data->device_flags & RMI_DEVICE) &&
+	    test_bit(RMI_STARTED, &data->flags) &&
+	    !test_bit(RMI_SUSPENDED, &data->flags) &&
 	    (field->application == HID_GD_POINTER ||
 	    field->application == HID_GD_MOUSE)) {
 		if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS) {
@@ -469,12 +472,16 @@ static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
 	struct rmi_device *rmi_dev = data->xport.rmi_dev;
 	int ret;
 
-	if (!(data->device_flags & RMI_DEVICE))
+	if (!test_bit(RMI_STARTED, &data->flags))
 		return 0;
 
+	set_bit(RMI_SUSPENDED, &data->flags);
+	cancel_work_sync(&data->reset_work);
+
 	ret = rmi_driver_suspend(rmi_dev, false);
 	if (ret) {
 		hid_warn(hdev, "Failed to suspend device: %d\n", ret);
+		clear_bit(RMI_SUSPENDED, &data->flags);
 		return ret;
 	}
 
@@ -486,27 +493,31 @@ static int rmi_post_resume(struct hid_device *hdev)
 	struct rmi_data *data = hid_get_drvdata(hdev);
 	struct rmi_device *rmi_dev = data->xport.rmi_dev;
 	int ret;
+	int err;
 
-	if (!(data->device_flags & RMI_DEVICE))
+	if (!test_bit(RMI_STARTED, &data->flags))
 		return 0;
 
 	/* Make sure the HID device is ready to receive events */
 	ret = hid_hw_open(hdev);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = rmi_reset_attn_mode(hdev);
 	if (ret)
-		goto out;
+		hid_warn(hdev, "Failed to reset attention mode: %d\n", ret);
 
-	ret = rmi_driver_resume(rmi_dev, false);
-	if (ret) {
-		hid_warn(hdev, "Failed to resume device: %d\n", ret);
-		goto out;
+	err = rmi_driver_resume(rmi_dev, false);
+	if (err) {
+		hid_warn(hdev, "Failed to resume device: %d\n", err);
+		if (!ret)
+			ret = err;
 	}
 
-out:
 	hid_hw_close(hdev);
+
+out:
+	clear_bit(RMI_SUSPENDED, &data->flags);
 	return ret;
 }
 
@@ -787,10 +798,8 @@ static void rmi_remove(struct hid_device *hdev)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
 
-	if ((hdata->device_flags & RMI_DEVICE)
-	    && test_bit(RMI_STARTED, &hdata->flags)) {
-		clear_bit(RMI_STARTED, &hdata->flags);
-		cancel_work_sync(&hdata->reset_work);
+	if (test_and_clear_bit(RMI_STARTED, &hdata->flags)) {
+		disable_work_sync(&hdata->reset_work);
 		rmi_unregister_transport_device(&hdata->xport);
 	}
 

-- 
2.56.0.679.gc527c65306-goog

