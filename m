Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204693;
	b=U6MJH35/ytre67xDI5IxbG1iSLkgIadOe6j6AAqBLPF4KlKy16z7Av8Zjw/aAa6qutcf
	 swfTOJXm1nI1XVZBGKWZS9soSHg1YWctks4nNk/gjZBsVGdUqgUUC9Ma6JhFBUItLneJ1
	 RAIBYZAfl4dfxqiBerqNLoRQNIgd2zzmcG+xQrU0Kxjrdx0LnfIcD8jLno0RMwTq3tICv
	 0nMwqwSamHkbbElHa4+dFIf2PYhs/EjAq9s8yzARAPKtcgebYwHnKYyEKwRmP8hdXebsJ
	 MT4RLIVu6Vkgd83QTQSpRygoCdwD57Ekh2qPJk6spIbwGDMgsaX3bduZsvbUTd6CyXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0xl7+ifBBMfaxcMk5jiLeNDltkpISce4f1u9SG00i1w=;
	b=l7FrVG5nXoVL7dgid+YCKiw6xZv4F3d1X3FS+XQncC2GubJ/Ol0k3ZtB4eJCQlfL0ktF
	 /tpbkNpwsc0s8h5EgAVqhlC4bQH/cmaOSgBCClz2/e2t9F35KwK/fYzCaFEVVe7L6r96O
	 mUmEDnUXNAXsKoDMuYikgLlqxTCCUj6Z6L1F59IM+izTH+J/nXxETY/KMiYHiQu3e6oxx
	 6dvEehfZjXSwxbLsQc5mxaUCc0bqbvzQojWCIyLArOcMVfCr9YESfacymnnqa62EfGcJh
	 4xD0P+Lb5BGHCYNdhc2h6jmOpmkoWU8PVloqnz+PMvRBkmNWCs05/Q2X/Wmbd4qTU2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ71j16w;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685A606EEBE
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8685A606EEBE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ71j16w
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3282db206d3so1192118eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204693; x=1794809493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0xl7+ifBBMfaxcMk5jiLeNDltkpISce4f1u9SG00i1w=;
        b=KJ71j16w6lyq9m9jFFdpXfEgPbC+X2wFIKTXLGQIiwWR59R7+9d+gAFX1g5W1hx6+S
         ey1t9EhrlIsze76zV2c5/E015AXAZ7S0P3rFbFaAYYDAze8Tuj/MCzQirQZ4DEEAnNHb
         tfGuBBP6xUa4xwIXcYYjdtw5WgP+vIs/zq4xHsQE17ABtSD5oSGl4+ACrtIbIBP+1j7p
         mFz/Hp9rNYLd5yfTkvsgw58St5IDlFLAK7uwcQeDxTovDF3WM0K4yAJJSPyLxTA0E7nd
         XHjuyiBw0Tks4pIZff3Fb9GtGHuZIPJBS9eotgByXtryBa23EwvL/NF4SnaSDisl4vRm
         Uf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204693; x=1794809493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0xl7+ifBBMfaxcMk5jiLeNDltkpISce4f1u9SG00i1w=;
        b=PoZi5ki0lLDtMg9zfsEd9J7a2gBjDHXl5WpJuDPb/gNJhqcjXXQhH/VW9gYMtxicma
         RplQrralSuTLWJg4R1HacXEAoFGn9kCJ/58o3X9t+BF0MgLu8jCWKpZ36L7ImFhx8i99
         J8mDZq0Tdgnej+Wpc3Eoz6PIc7mtUG70RK9BMPm5S0etFwaQljElFkNhjCMRKeugVriB
         ypIwqk5LspMc9AofzlWb87HErdjL6L2hnFPUkEgd9bFPeIdrSMQAPatpsK8WkhO+XoG8
         ec3qk9PcPWPvERdKBWd1ymhgk/5PNQ0be0tTK0lbL8kDJkq2vAHUAnQUSAtIlGe700OT
         g9Gg==
X-Forwarded-Encrypted: i=1; AL+hErEfZASgW0I0a5aQym5pdhbERKLd0BEWbqi/i3Zj0cwFd3sC8wigCSyvHoju4ZAG7jk3iguGJs6cz1XETA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+CPLoUfEJqU2ifvxdCfDUfIIJcEueI3reefP5K+orSXn6fg8y9
	WbODcyZrmKHSmimq/d4jJFyPYKYDcVl/18H81hypbEMNxgnLPSLlF66QwR+3yA==
X-Gm-Gg: AYBFou2/xg6Yf5Ot0ijGJiF3re49w/jJL2Sn6B2c4ZzgMhDriQM6ate7PW3+2FbHG52
	T3SBHaNGOBF9I7YZ95OfgBkcHEPcQenGqcvDt8C3vpC3ShZsz7t6IIXDqjx8NVB1Ll+bO7CoPk6
	dBl1n4BA0oPzJq7bYR65/liWl1P7dK7GcTBUGTz4Js+CUMdffzoEU5GOaDuClZvNK0dbnn5Zng5
	eg+v7ZpHwur9gutXPJR8rKMjMMzl+plOXcuarQVVg/HmnAeI/kNH071EEBdjoZgtNTsgleU9fTJ
	hKMrH8nCAqrGJMvS0hDh4Yen7Vz/VaJfZp626Sm7GHM9CKipGlL9wLxXfr/ht+UdFcHwia9wEWC
	6SDOMPTVeOfUl+zKT30N4+c+/VoC2MTrUUNhMUkl/WHzqWNwiuIGcbZtRz63bDzv03rWsMuOlhm
	+jL4LsAqIEZVwm4UTLL90Gm+4rKdBDrT8J8PceLb1P7C4BcI+kYDLhzzllqttq9rx+UUJTvfvfz
	2SAKTqrKqxQWCL/N63EI2gBV87WmwAVZn+o1X+qoUB3aVUESAGIFd3V5U+8ZnMk+NsxsjViG0TX
	dsn3gEW235mtEnFSyGSr86KQwLmVVg53TqEMOIx2a2rQfZgXgaEuP4DqpTHYIu7OadrZoANjFQd
	nZ18+XhWdK/hqTrhd7T0CTJHELN7dGzUypTRQEQ==
X-Received: by 2002:a05:7301:1702:b0:36d:394d:e696 with SMTP id 5a478bee46e88-37256ee9e6cmr6253369eec.29.1794204692549;
        Sun, 08 Nov 2026 22:11:32 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:31 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] HID: logitech-hidpp: use __free(kfree) for temporary allocations
Date: Sun,  8 Nov 2026 22:10:59 -0800
Message-ID: <20261109061103.2887636-16-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Managing short-lived heap allocations manually with explicit kfree()
calls adds boilerplate cleanup paths and forces callers to hold
temporary return variables across calls.

Convert temporary message and device-name allocations in command helpers
and device initialization paths to use __free(kfree) with no_free_ptr()
ownership transfer where the buffer is returned to callers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 44 ++++++++++----------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index bf13e5fbe142..7f5de4caf118 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -390,18 +390,15 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
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
 
@@ -413,9 +410,7 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	message->fap.funcindex_clientid = funcindex_clientid | LINUX_KERNEL_SW_ID;
 	memcpy(&message->fap.params, params, param_count);
 
-	ret = hidpp_send_message_sync(hidpp, message, response);
-	kfree(message);
-	return ret;
+	return hidpp_send_message_sync(hidpp, message, response);
 }
 
 /*
@@ -429,8 +424,7 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	u8 report_id, u8 sub_id, u8 reg_address, u8 *params, int param_count,
 	struct hidpp_report *response)
 {
-	struct hidpp_report *message;
-	int ret, max_count;
+	int max_count;
 
 	/* Send as long report if short reports are not supported. */
 	if (report_id == REPORT_ID_HIDPP_SHORT &&
@@ -454,7 +448,7 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	if (param_count > max_count)
 		return -EINVAL;
 
-	message = kzalloc_obj(struct hidpp_report);
+	struct hidpp_report *message __free(kfree) = kzalloc_obj(*message);
 	if (!message)
 		return -ENOMEM;
 	message->report_id = report_id;
@@ -462,9 +456,7 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	message->rap.reg_address = reg_address;
 	memcpy(&message->rap.params, params, param_count);
 
-	ret = hidpp_send_message_sync(hidpp_dev, message, response);
-	kfree(message);
-	return ret;
+	return hidpp_send_message_sync(hidpp_dev, message, response);
 }
 
 static inline bool hidpp_match_answer(struct hidpp_report *question,
@@ -910,7 +902,6 @@ static int hidpp_unifying_get_serial(struct hidpp_device *hidpp,
 static int hidpp_unifying_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
-	const char *name;
 	u8 serial[HIDPP_SERIAL_LENGTH];
 	int ret;
 
@@ -921,14 +912,13 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
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
 
@@ -1142,7 +1132,6 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 {
 	u8 feature_index;
 	u8 __name_length;
-	char *name;
 	unsigned index = 0;
 	int ret;
 
@@ -1156,7 +1145,7 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 	if (ret)
 		return NULL;
 
-	name = kzalloc(__name_length + 1, GFP_KERNEL);
+	char *name __free(kfree) = kzalloc(__name_length + 1, GFP_KERNEL);
 	if (!name)
 		return NULL;
 
@@ -1164,17 +1153,15 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
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
@@ -4432,17 +4419,15 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
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
 
@@ -4489,7 +4474,7 @@ static void hidpp_connect_event(struct work_struct *work)
 	struct hidpp_device *hidpp = container_of(work, struct hidpp_device, work);
 	struct hid_device *hdev = hidpp->hid_dev;
 	struct input_dev *input;
-	char *name, *devm_name;
+	char *devm_name;
 	int ret;
 
 	/* Get device version to check if it is connected */
@@ -4547,11 +4532,10 @@ static void hidpp_connect_event(struct work_struct *work)
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
2.56.0.506.g506a7eabc5-goog

