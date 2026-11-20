Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164063;
	b=Dcg/ny2M74Po5rCwRNPryUHRmVOuFCK1xJjeiCpzxtHT9UrclQha7Sswl+hRkkT9HtO5
	 SJQzrXS2aVXVPPVWB8AXOkzekUftLwe8ejzK42+zBwX7bEZ8zpI4tW7LKAriyi6+3rpbZ
	 hvoYtLHSPK/sxybtMxgYxUjwpzEmtS/hH9PQtTDCWbwWJb0NbUcO9s9GUF4RmFO0DBpQ1
	 9jKBQ1Cdi0M0GWgIm8qRYu9dE57W9w1q0YIHVTKspc0tDgcw852osgneIuNEFIODPRbqI
	 ndPIN1dfAnMvmZI19iQVNisXgWosBXcjMx1IlwbMfWrAoG9Wu+7+QcbQ6FlP/0zFYKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Qt1Ybyqn6dGdqD6Fu8N2/lYm0CmAcHxTPwGIdEQURII=;
	b=WIvJOa+bC0+nVa6OfedFYIkPAm4qbKKaus8e48DN8CG1gjv5chzHdVmNroMLYo1BoXRb
	 YGTdtrMgjciWiU57koDoQIJ327KdQr4nSctWoPkELxh0eCqOZ3B5SF6M9qq7px16QKwCB
	 cVY3/DvYVt4mn3DWVjw2QvQYWq3P4JwyXjuCpO3NK0t/tYLn9R4UeU1HnCUEia9Lihgri
	 nzaW4IT8KXeWHUsh3/LiVSN5jNFTOT3KfRkRcEGCSeUbivo02pL40u8Uz6ztzZ3XuQY1K
	 +yg2wyrC0ug2LQupoiqeX8mf0C5Gt134xldRdIK3uIWNr1dLIx9nj3+/a2jM5hss+Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNBO5qbH;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243060A262B
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E243060A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNBO5qbH
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-385d8a00598so493611eec.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164062; x=1795768862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qt1Ybyqn6dGdqD6Fu8N2/lYm0CmAcHxTPwGIdEQURII=;
        b=FNBO5qbHu5un6qZDgqdgOTovjvjk1B0NCyZz8G96RXegY/7Jj2TYhD9gbeXWx6gRjf
         4/xKNjdHAozARhc9/qHe3nYRcuTxe4wIX+31WM9TneaJranELlCDCBxpgQdvJZnSmZqD
         XH2l1Sl+Pw6UO2UPeO11gCUJ4Fu2lJqgg5GIf6KvAjuORAwP9CeCO0oNYh/EUqrSBnh2
         euFi6JLkmEwdd97PPb44xKzZ3pFZlHGR8ZtTml9T2kdAG4kRRu7DwiSrCBVaGHyqKJ+1
         fuqV1aisW32oPFAlAkbznbZ1Jx/DK6oq5ItzHOYTnkL/5XZJFVouy1gtaaQVy/oOFgAK
         xREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164062; x=1795768862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qt1Ybyqn6dGdqD6Fu8N2/lYm0CmAcHxTPwGIdEQURII=;
        b=bjmjS2HwPwUqBfdyp+CsvsQvYrc9BcmHnw2eVKvQOTOm0ssbPyYwcZTOkWDjbaZ7Ii
         NgmNmiCZA8YyzmdSb6jH39tgreClwlpWJv7FZN2nPEFEcQJE/AR7qKG0DYBG59/73MuO
         owySBGMVax6BlZY8tRG560DgSAMaz/dVxZOWDg2oEVjHnCN5hF2Z+JesKic6L4tT9/np
         IJn3Mszvj5L89paVP6ZCmJNRjw3/bo4DUOkBrMXRXtiliefIZae6+EfdU5yl41gMVMgO
         h2lOvLf51uvOeswg1oWLVqPbKotHwBqEkrW9ORrZg85f4pd/fhqkkgaDOQEaZ7AOQljZ
         aKZQ==
X-Forwarded-Encrypted: i=1; AL+hErF3uWIE/Wjnyywv370v7IPRD/Ybt5Xd5V319qDE3TRNgchwXXIw9sGRcPJlxIfVwfreWksW2xD5MgYZJw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+pkmmMTb7SrFQkbPbIKQLdjxvAQ8nNyDyX5NUxeDLZg5CCPnXs
	hUzz1pNyxn5qDj6KOD6bahidmJkK0SHRaoDuogQByVxV8sWHiZpZS00i
X-Gm-Gg: AZFdTZcq0xQt+9emIFpa3Ubd+ijdXcQ5C2FCOwWhMhisgZF4nBK51aw996p9Nptm8lZ
	T0JDHsFnxB83gj5eQoQmClRxkavT9qTL0G26e1llbZn1b80xC604RH//gbYwff4N9fSHu3f5ccw
	T8y8mP9GAD964cVhKWjxwkApPY8Y3mcXI8C21A0SW+PoeYb07120qnWeLMIEs9ZLhh5Ot9JXUoq
	KnJT8l544ir0/OzuijbLQTmfTvTwKwC5Px3q4RvZUvEje2Cf1TFuGeNYx+CFcobqQAG+5Gkaej4
	a2pzOQKrSKVHNd+sdvw8hp6u5FvKWcVv9qKQHrxjA2Nwjd5b0w73QcYqZhknvX2zOGbskjFAyV1
	lKBYp2h1bQljlxhvthnfGjyerscoMGqGcWOq/mlfycTGIsyPoRi9BS6cElvpYPUiW6+puJfsHU2
	x7VytqgvAIOgqe96UofmAEGDWTfbAiNzbsacIekGVzgqZ0bhTmInL10Y+xO0jXNWHIDH49PhFIJ
	X2DL7SEELa8RsDOebiUgBqioj4MJybOsncXDofc56mzX2gGHnKl2Ty+Pd10iZm/GcCa1F397kH6
	5rnjdhD7shR3k78uhC0UyOyATpj1oHU0KCoGWMNj6ZozwPd22HDoYIMCitH6Ls4I/+XBXK5Q/3O
	HjzO05/3Z218mc4JUgA==
X-Received: by 2002:a05:7300:cf87:b0:386:565b:4f9b with SMTP id 5a478bee46e88-386565b529dmr81358eec.36.1795164062085;
        Fri, 20 Nov 2026 00:41:02 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:01 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:51 -0800
Subject: [PATCH v3 03/14] HID: logitech-hidpp: drain G920 FF workqueue
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
Message-Id: <20261120-hid-logitech-hidpp-v3-3-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

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
2.56.1.750.gf70dc682cf-goog

