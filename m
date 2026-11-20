Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164273;
	b=Jimbu3LhSOQLXw8kM0rIniBu4hngZC1V5sQ0RzToIB4GCYkZOXJW/+gEo2idHVqbnbNv
	 MzkTUkPVixPUj5mjnFN+2+ylFAO34ICnQ0Ml7T7wGJW1BoA49GVp4u32QrBlQ1ml3cSBY
	 aHlo2B9M5/li25aHP/44nNg34fV6Zh8QuIlCZuHV93Ul65mvTgK4SQDZxhNQp0mftehZc
	 Tuhf3iOgX0AqiCHgqrF2XBPoL+dLdJ3uiq2h7pBx9Wq7CIRNN50uKqQne5jrdV7Rk0zyQ
	 XVtTkrevRoTia4rFOad4aUlA96e/7ut8jh7Zr+/QhO4RgDLxUKqLWV66HU8EYQEq5/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=k3Udl9m4ZJ5E93EjC7KYeeRpBxK5leMJ3xgfW9JwgOg=;
	b=tzalSBrYv+SLQzco969L2KddQflPERHSMPZraD8cvPQ59tPPZwiUib6AqN59TLbQsyVM
	 bKReC9Mc1R9mpE/TjEGegozMAc2SNB9ObO0KAo17l6lqodGpNFTc+LXGOHRew7f/3tyC2
	 6Ro2nqzqJ3QiukmnM1ZkGNfbU3mMEFdtnMZdvgp1UGaF9ssrFfu13JR5bbKF6sZ3Vr7QI
	 3RxHFEynW8N8rnsGKjQkM3I1LQNBNcbxh9m+Sw1IDp/iG3dz7peQv44Xi8yyiviPhrIgz
	 ke2VvHtpns+Sr/2Sf9s1PX5UayIn7PqU8S4nwJHCLvXDkYk2W90pkcu9duDZkYwTfAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gl64QOXJ;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F098606A7D4
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F098606A7D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gl64QOXJ
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b546061d58so1391268c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164272; x=1795769072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3Udl9m4ZJ5E93EjC7KYeeRpBxK5leMJ3xgfW9JwgOg=;
        b=gl64QOXJ8E26/3CA4yHWXNO/ww1DNMwY+tVB5FL6PbQ6EJ1cBxf6zpknC9G15mnVBm
         eyGBfcIlxkEkH337TsLFYpUZTO3BXXF/ZxtQD7nYVqkKqRi+lhmgDZbq8BZg1NKZWW8U
         7uLxzytqsJB0chQcEb6WTka6nnVjX8OAczmOvUV4KYCQpJuv5K3/Rc+S0lgRT+1v4hlq
         RlqxmUP2WP3pve7Z3Xug1Uk2sFxPAu7RLEDbQ/+QaYjtPAdAur2ZICmsLiWCDu365YX0
         09/z82rU8YQmg2U252GbsCxTWY7AvPAKiZFsXkyQ4sdEuW60Zh0Cu3dmVLIYb1QHnS6L
         /Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164272; x=1795769072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3Udl9m4ZJ5E93EjC7KYeeRpBxK5leMJ3xgfW9JwgOg=;
        b=ffpirUaPqL9f2TAbPekarbfR8Y78MPeblaUUy1uqvKUV2Yvy74km7bI4mC2Akw0jfu
         CEW5lvMKk5QWozu/Z9Bvfka7bkwv6dSKEDTynh/HXAv+XaAfT/kGtVcmglkRoI/ME6OF
         KYDwgaj0U77vBEx1QPzTaPKFaGtvTIeJiEFSBBGna7s3uGgwJXuTRhEVkn48dWzHcZw6
         wUHVdpV2BWSNJWo+crwThp9FhGZVzA0EBR1WdB3twNZg1RPp3xxo9yD0Y5goWnN00J+E
         xKWeKZ85L8RLI1+kMZeckZ8CshT3NPQViLmOAL2CmqlADAvVIWgMvfSPzdFRt4Dsv3wh
         3Ucg==
X-Forwarded-Encrypted: i=1; AL+hErES8EBDthM/m93piFeiZKeKkNoCWRveK1gZDnzX/j3/+bDCIVx4fm04UJiyBBJzcb31btlPifr7xrBBjQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9F3Q6A6Qr+dg6a5gjikbTFzvkvAoCpguV0JBgOZ1fFIes6WZ8V
	S7mURLByaBnTQZv5z2Akscmf8UumxVMVoMCCFqgHSv+Mt7IABzY/eTFq
X-Gm-Gg: AYBFou3XX3SZOv0gYR7sLJzQXmDU5knAZihW0NFGgUu+FaaXw0EI4KB/eDSV8Tf4o9k
	na8yAGbjE/rTZTdiZf5NAySNcilWcy0Ot+wdg7bVt5Rma3SwMEOjsidpTxCBeyG951FSx5x5ugr
	6uMdc7cQiSgxYDTBnBUeqMgRQDn7l2hPKl+kcJTq3NP7d/SEYiK1xSJTKF58oVsdac9+KeBds8y
	/Zo8AQvYABtsdClAkYK7HbXODmRAfKVomtQPWkzzmvbY0TnTe38z8Z9Txxgc/Y+6A4msVUr+PyL
	ERJl3UHY9UCGj4rqyNJSQk6I43caPKmLOo3SEhmB1S0HXpLgVcXEw0sheLA3CYU6HxvC8AIqwlZ
	1z9FDUbsF1oD+KZZYiWMU7sVX0Pfb0wclMh9JRk5kUbVBAIYusrtPwN0GkeGvtLkczOaaSf1Tfc
	1AxoHBgUBQLZq2gmNXsttafyUDmFs+fmUbTGw4uobo9mlBwOCe5qiSJSHDM6MG0OIIDtheWfEe/
	boMpcckD/u6j55acdJyH8bQBaMeLX+Ndf7HpE84se2yzY2drSNql1dZph5GVDnG+SDPVCnO2upl
	uDhZEOJtKVKuaclwx+slEUQcnTnJGyz3hPP6p70HJqd8xBjyOK/hn4M1M5u4a40wLhDPa8hobDS
	nTcnLYupJu1auEPpkLg==
X-Received: by 2002:a05:7022:294:10b0:19a:bbe8:41a8 with SMTP id a92af1059eb24-1b5568c876dmr2160403c88.20.1795164272459;
        Fri, 20 Nov 2026 00:44:32 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:31 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:05 -0800
Subject: [PATCH v3 14/18] HID: logitech-hidpp: use __free(kfree) for
 temporary allocations
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-14-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Managing short-lived heap allocations manually with explicit kfree()
calls adds boilerplate cleanup paths and forces callers to hold
temporary return variables across calls.

Convert temporary message and device-name allocations in command helpers
and device initialization paths to use __free(kfree) with no_free_ptr()
ownership transfer where the buffer is returned to callers.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 44 +++++++++++++---------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 49f21d7adebb..12b499fe08e7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -401,18 +401,15 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	u8 feat_index, u8 funcindex_clientid, u8 *params, int param_count,
 	struct hidpp_report *response)
 {
-	struct hidpp_report *message;
-	int ret;
-
-	if (param_count > sizeof(message->fap.params)) {
+	if (param_count > sizeof_field(struct hidpp_report, fap.params)) {
 		hid_dbg(hidpp->hid_dev,
 			"Invalid number of parameters passed to command (%d != %llu)\n",
 			param_count,
-			(unsigned long long) sizeof(message->fap.params));
+			(unsigned long long)sizeof_field(struct hidpp_report, fap.params));
 		return -EINVAL;
 	}
 
-	message = kzalloc_obj(struct hidpp_report);
+	struct hidpp_report *message __free(kfree) = kzalloc_obj(*message);
 	if (!message)
 		return -ENOMEM;
 
@@ -424,9 +421,7 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	message->fap.funcindex_clientid = funcindex_clientid | LINUX_KERNEL_SW_ID;
 	memcpy(&message->fap.params, params, param_count);
 
-	ret = hidpp_send_message_sync(hidpp, message, response);
-	kfree(message);
-	return ret;
+	return hidpp_send_message_sync(hidpp, message, response);
 }
 
 /*
@@ -437,8 +432,7 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	u8 report_id, u8 sub_id, u8 reg_address, u8 *params, int param_count,
 	struct hidpp_report *response)
 {
-	struct hidpp_report *message;
-	int ret, max_count;
+	int max_count;
 
 	/* Send as long report if short reports are not supported. */
 	if (report_id == REPORT_ID_HIDPP_SHORT &&
@@ -462,7 +456,7 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	if (param_count > max_count)
 		return -EINVAL;
 
-	message = kzalloc_obj(struct hidpp_report);
+	struct hidpp_report *message __free(kfree) = kzalloc_obj(*message);
 	if (!message)
 		return -ENOMEM;
 	message->report_id = report_id;
@@ -470,9 +464,7 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	message->rap.reg_address = reg_address;
 	memcpy(&message->rap.params, params, param_count);
 
-	ret = hidpp_send_message_sync(hidpp_dev, message, response);
-	kfree(message);
-	return ret;
+	return hidpp_send_message_sync(hidpp_dev, message, response);
 }
 
 static inline bool hidpp_match_answer(struct hidpp_report *question,
@@ -919,7 +911,6 @@ static int hidpp_unifying_get_serial(struct hidpp_device *hidpp,
 static int hidpp_unifying_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
-	const char *name;
 	u8 serial[HIDPP_SERIAL_LENGTH];
 	int ret;
 
@@ -930,14 +921,13 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
-	name = hidpp_unifying_get_name(hidpp);
+	char *name __free(kfree) = hidpp_unifying_get_name(hidpp);
 	if (!name)
 		return -EIO;
 
 	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
 	dbg_hid("HID++ Unifying: Got name: %s\n", name);
 
-	kfree(name);
 	return 0;
 }
 
@@ -1131,7 +1121,6 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 {
 	u8 feature_index;
 	u8 __name_length;
-	char *name;
 	unsigned index = 0;
 	int ret;
 
@@ -1145,7 +1134,7 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 	if (ret)
 		return NULL;
 
-	name = kzalloc(__name_length + 1, GFP_KERNEL);
+	char *name __free(kfree) = kzalloc(__name_length + 1, GFP_KERNEL);
 	if (!name)
 		return NULL;
 
@@ -1153,17 +1142,15 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 		ret = hidpp_devicenametype_get_device_name(hidpp,
 			feature_index, index, name + index,
 			__name_length - index);
-		if (ret <= 0) {
-			kfree(name);
+		if (ret <= 0)
 			return NULL;
-		}
 		index += ret;
 	}
 
 	/* include the terminating '\0' */
 	hidpp_prefix_name(&name, __name_length + 1);
 
-	return name;
+	return no_free_ptr(name);
 }
 
 /* -------------------------------------------------------------------------- */
@@ -4314,17 +4301,15 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 static void hidpp_non_unifying_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
-	char *name;
 
 	/* Bluetooth devices already have their serialnr set */
 	if (hid_is_usb(hdev))
 		hidpp_serial_init(hidpp);
 
-	name = hidpp_get_device_name(hidpp);
+	char *name __free(kfree) = hidpp_get_device_name(hidpp);
 	if (name) {
 		dbg_hid("HID++: Got name: %s\n", name);
 		snprintf(hdev->name, sizeof(hdev->name), "%s", name);
-		kfree(name);
 	}
 }
 
@@ -4371,7 +4356,7 @@ static void hidpp_connect_event(struct work_struct *work)
 	struct hidpp_device *hidpp = container_of(work, struct hidpp_device, work);
 	struct hid_device *hdev = hidpp->hid_dev;
 	struct input_dev *input;
-	char *name, *devm_name;
+	char *devm_name;
 	int ret;
 
 	/* Get device version to check if it is connected */
@@ -4430,11 +4415,10 @@ static void hidpp_connect_event(struct work_struct *work)
 	}
 
 	if (hidpp->name == hdev->name && hidpp->protocol_major >= 2) {
-		name = hidpp_get_device_name(hidpp);
+		char *name __free(kfree) = hidpp_get_device_name(hidpp);
 		if (name) {
 			devm_name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						   "%s", name);
-			kfree(name);
 			if (!devm_name)
 				return;
 

-- 
2.56.1.750.gf70dc682cf-goog

