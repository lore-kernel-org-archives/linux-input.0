Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954069;
	b=pyuX0bF/nJsoXrqxMPW+PcX49RJAinihEEeSR7pNqYYNpz657LZvlUSGo7V5dSyrYVHS
	 Xrzj8Jn7QcVnDQxuHFkOlQ5x4vcQh5keEZmIop/KfZU0exAa5cxu5rVdbCzPpYpAum9tm
	 RU3EMBjbrMI0gDmDgrYbyEPMEaow23k4LjF7L3cY5q/McjwylET+DHNK1EGGKWdAxl2TU
	 rTQRng5A71kdvayAYMpUmYzQlDKxtBXqThUgRFsQLs9yQ24DtaapaQjQloB89wCU3CDXT
	 gpSEDSZUWIGvyKOpzMyUaIOSBQvbyQgdaFocVIPV6c62Cb7SrTFzkSEeEXh798ymf2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MXb7pO3sdUb2tVH9tQJHPvfD0PJ6M9Jq2AVgdOqIcF0=;
	b=okYAryR+qmutc59+lTIJDIVmH5YrwMaSfyMcIwPImFna2NGbTKXOnpaGR5KSiudIkeSX
	 huaFADhZQgu0ptR8o/jwYoB64kRTLkrH8TXpaCf3jg/Vfok2YbX4JqD4o8ZxwxRxq4G+k
	 PzwDBhaVoDTd0kp9GjGwZDTZgtCmrVujmjizbhOfvKoQ9GpCociwao/hht1dEv50bwUo3
	 H0V97C5iVL5rYR1MlpLFrZmFW7P5K4R5TyHz0Ehz+xDTwf3kcd7nvlvmWKXQBzj9aWvpm
	 YfOg/zcRn3s5QwBpJSLH9U0VmD5+VQfDL1I19JFJDaiGfDgdlViKdyRcx0hfZ1yVNkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AncYDq/M";
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60A606A328
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 08:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F60A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AncYDq/M
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so773688c88.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793954067; x=1794558867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXb7pO3sdUb2tVH9tQJHPvfD0PJ6M9Jq2AVgdOqIcF0=;
        b=AncYDq/MLvihYjaq9mD3QHYPGHU0EM/d2UJGKvW3ulkmK8iDbOdFEuuTOGeZJIDwGR
         zSsx+f16KNXCj+gTIcYkJ7ZXixdeclDdyGGKY+OktrTsUtM4a5aYco1ZAJfBAt9efoX8
         qEGrIMgq7zTKUeRh9em8fGVq3MiQe61mXr05Y9IR9UFTU+aGc6zwv/SNYqgrDw7QdIae
         UxPrMAP+Cse+pQy6QkLjIBWY8r9tdUbSYPrewWyoe0cgsf+xqtBx2phl5CsaLkBkL2uW
         EbgKqUKEx/M2rsS+8gkyGbhzyv5DbHnNzr2/PnNmRxhd7C5l2iN99KujJa2yBwBp+AIb
         9Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793954067; x=1794558867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXb7pO3sdUb2tVH9tQJHPvfD0PJ6M9Jq2AVgdOqIcF0=;
        b=TSHNS29j7VXBIAI6RsqxIx+xRKwhGwEwvnWXpWeqJOp/UeuNP4c4FZwYNtUL1NgnE4
         oxQpJN1k1tKA07ZcymyoVY7FaWiYZyYBV6Hw4YJ/qVa+N0ZvBYvsfk7EWIEyllE7Ce/e
         CwtMRM+xaS28IBEEkH0PURZQtULPQdInVbku9kdnYkvqpNP1H1HbS/n0W6hlSlMeeoZy
         owukDVi+oUAiYYwYgGAVvycjGfNSFrRzV0ZWiNfhNqlOMk8baY6uaYbOAZEnp++ucFkF
         xrUbr1VnWGqg9oMpBGaW5dLP3nBzJUr43SBLCZD/mTkgSGamf+lagqSHNfXRSraHTJrh
         pqwg==
X-Gm-Message-State: APuU4Z8ImM3SsT5b3qCuQl//H0hy8rwIU1lui4dxELGWohowKnEdpKSt
	UVjgvekEQl0zES4mPF5ENOd26jNpat0HIN3hwyLaU2iHYfX3slJ33PLG
X-Gm-Gg: AYBFou0v25CFTpydMfoPWlT4SAIgjbVlIJdBkkLKC7u8QPY0ibYzx2jKgzvfEIfOzA0
	tjub66dS9SnF+J4/Dl04BmrAy0DqxvZUYXiZHm463NwksmMIiEoP0R1xY4tomxV/MeSTBlsUAZK
	EfHAC52xTsm7t7YgcCA4Cu6nY/ZFIWRAdgROGrUWKzJp56/Mms66V21GdXiwfXttQYWQhHEfm/y
	5mALOxR6KiGGHjrVSEfsRMm0C+t21a1jppirtpeD+KUvPV9PaliZQiiuhGTfMqRwEtWR+LuZ8wv
	6Bcg+VSqW2551MiXGBSBbltkN7i8YJtKObYswhXRlXn31ko+RGxVBwYpS0yP07h6GLnKilBZ+HZ
	5a4h4vQs0OMlcVMOJ4FwmPM6OV5cLSOpEasD7GAiU6RaPhhYnWgClX8UVrPA7F2YkBQHMYo+7jf
	Sxm02irMSC2gmXpZ+BluBcIJTuqYsqilyw6FlyN7bECr8RusefQOwOtDQgCdVJdT9qmzAhdhsM0
	EZ1JT7bnjxbScloAt2+cI5TgxOQH/Yd/Nh6+vf3RtAQPL4vni9I8P1Fo8Lj88o/0oF6dbOc5WLH
	L4u8nJSdOcD38EVskcPmxaH3a5KcfLOeU/QeNiNBZQfHQKIEPWF5HnTZdOlJb0zYURSYgfFZV6u
	X//p0kdVAS9eD12UuLKeTJtoh3hw=
X-Received: by 2002:a05:701b:2506:b0:195:e4b9:d326 with SMTP id a92af1059eb24-1b25d305837mr2299612c88.12.1793954067223;
        Fri, 06 Nov 2026 00:34:27 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:3827:c357:8cc4:f558])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm4594322eec.1.2026.11.06.00.34.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 00:34:26 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Nikolas Koesling <nikolas@koesling.info>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH v2] HID: pulsar: print errors with %pe
Date: Fri,  6 Nov 2026 14:03:18 +0530
Message-ID: <20261106083419.29334-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
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

%pe prints the symbolic errno, which is easier to read in a log than the
raw number. Convert every print in the driver that logs an errno so they
all report the same way.

The prints that log data bytes, battery readings or a byte count are left
on %d, those are not error values.

v2:
  - convert the remaining errno prints too, not just the battery one

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
v2:
  - convert the remaining errno prints too, not just the battery one
v1: https://lore.kernel.org/all/20261104150055.33028-1-sinha.aryan03@gmail.com/
 drivers/hid/hid-pulsar.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index b0b34849f..495ce3b5c 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -162,8 +162,8 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 		spin_lock_irqsave(&drvdata->raw_event_lock, flags);
 		drvdata->pending_event = CMD_NONE;
 		spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
-		hid_err(hdev, "failed to send command 0x%02x: %d\n",
-			payload[1], ret);
+		hid_err(hdev, "failed to send command 0x%02x: %pe\n",
+			payload[1], ERR_PTR(ret));
 		goto out;
 	}
 
@@ -295,8 +295,8 @@ static int read_power(struct pulsar_data *drvdata)
 		if (status < 0) {
 			ret = status;
 			hid_err(drvdata->hdev,
-				"%s: failed to read status: %d\n",
-				__func__, ret);
+				"%s: failed to read status: %pe\n",
+				__func__, ERR_PTR(ret));
 			goto unlock;
 		}
 
@@ -320,8 +320,8 @@ static int read_power(struct pulsar_data *drvdata)
 
 	ret = exec_cmd(drvdata, payload, response, CMD_TIMEOUT_MSEC);
 	if (ret < 0) {
-		hid_err(drvdata->hdev, "%s: failed to read power: %d\n",
-			__func__, ret);
+		hid_err(drvdata->hdev, "%s: failed to read power: %pe\n",
+			__func__, ERR_PTR(ret));
 		goto unlock;
 	}
 
@@ -411,8 +411,8 @@ static void power_uevent_work_handler(struct work_struct *work)
 
 	ret = read_power(drvdata);
 	if (ret < 0) {
-		hid_err(drvdata->hdev, "%s: failed to read power: %d\n",
-			__func__, ret);
+		hid_err(drvdata->hdev, "%s: failed to read power: %pe\n",
+			__func__, ERR_PTR(ret));
 		return;
 	}
 
@@ -584,10 +584,11 @@ static void pulsar_init_work(struct work_struct *work)
 	}
 	if (ret < 0) {
 		if (drvdata->type == TYPE_PULSAR) {
-			hid_err(hdev, "failed to read device info: %d\n", ret);
+			hid_err(hdev, "failed to read device info: %pe\n",
+				ERR_PTR(ret));
 			return;
 		}
-		hid_dbg(hdev, "failed to read device info: %d\n", ret);
+		hid_dbg(hdev, "failed to read device info: %pe\n", ERR_PTR(ret));
 		snprintf(drvdata->battery.model,
 			 sizeof(drvdata->battery.model), "%s", hdev->name);
 		goto register_battery;
@@ -615,8 +616,8 @@ static void pulsar_init_work(struct work_struct *work)
 	    devm_power_supply_register(&hdev->dev, &drvdata->battery.desc,
 				       &psy_cfg);
 	if (IS_ERR(drvdata->battery.ps)) {
-		hid_err(hdev, "failed to register battery: %ld\n",
-			PTR_ERR(drvdata->battery.ps));
+		hid_err(hdev, "failed to register battery: %pe\n",
+			drvdata->battery.ps);
 		drvdata->battery.ps = NULL;
 		return;
 	}
@@ -639,7 +640,7 @@ static int pulsar_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret < 0) {
-		hid_err(hdev, "hid_parse failed: %d\n", ret);
+		hid_err(hdev, "hid_parse failed: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
-- 
2.46.0

