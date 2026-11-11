Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380211;
	b=KZifWtfJBGh3sEZDRjxIh+eLHFxL+qyCC1hc6cnEWztuuvyrOSGQUimCKOcCe4KqgCuW
	 Jszqg2pWJ2xor9ApikGkRkXBH5Juw1B2sXbvJcvorLqKPuUR8g1dbT/6vgaiOnpi/9PBm
	 222YBDYaht3Dk7bGEiEmP8fcVELc7kzIouoAFktPzCHFsYhGo/8V2eSUEcCoDxVe6IK4L
	 65x90gMjgiukNuf8+QNtj7rq3Cf2A3Zkzf+Mtu2OvSXWF6qQjdc61ULofHEPYkEEQXElc
	 8o5/pI1g7Au00dMNukkIGwWRl1a22GgJkAH4AiwGhiJ/kAdReNFMvfIKM0ERoXc7Bew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=cOufneFrlPFyCJjGCXXVRy2+P+qm+qLl4SuCpAhzSRM=;
	b=Tcn0TdT7vWWC9RmhW1qbw0YA0yFrG00SF7V68OczL9lQmqojL0MitR4FOT51dhWPWGpL
	 CpzYP37/FhH1mpctNmH3rf9biN89QS7TgQG/g2DcCO3mUQJJqC0MFYSRwYu8scYS5AQaN
	 G4EBFKkCBeN2LJeYAPUJjIzebwuUnPlej2uz821cBhUQwWqrvDW7Xt6TPz0t/EikLGu92
	 y3OY2C5eN5h9BeJRxTIpdvZipw2iuzGQUNJGX7HTP1eCh43J/8GnijtrM0qNOcdosQ7j8
	 Zjckl+6BbM+cmV8t4MzwhuSSMank5qpu76I9wc2rIkF6BCd05HJMVsQXa7awmPP+TNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NaM7ZOzs;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704D606A98F
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D704D606A98F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NaM7ZOzs
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1aefd1bf74aso2393671c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380210; x=1794985010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cOufneFrlPFyCJjGCXXVRy2+P+qm+qLl4SuCpAhzSRM=;
        b=NaM7ZOzs4c0gC2XTIItGjk5bIEtVi+LWPOYPc8EiFg+mJ9XFUNtdgOUqkGLjNMUtyy
         jzV2KrTISBmumLvaZdSx/1x5aanARjmW5020Mcx8qMn7Zy5Ih9gPx1txuK/MWb0BFz4s
         GXHwZZo27FveDBHPWlY9YbiKKDF5BrwLPspSXxZ7wvhyJfjuDr4oBXn1GhHZjMAp7SQA
         L1544xdqNMe7YCI9lY8LYpXN/QHpMPIkJPWl39yo26ZZsesfeGd8K/hPjWx16x9ptm4o
         4Ip+1h2DCWrQ+CCeo4DMyQD11oXKSmriAwYIo83YkCp9DpX13vPeOTzl5ssJPfoconyW
         I59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380210; x=1794985010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cOufneFrlPFyCJjGCXXVRy2+P+qm+qLl4SuCpAhzSRM=;
        b=QWOLELN8nKYajx9t3fSEZoJz1AvK+BJKnVrzwIK4IvOLoBkPobHaCyoyMVbXu4fcKH
         wiD03iargX6kDAaApIFYtn2/YvNUTabNGb6VohVr4WYOwtuMi0k3cP5qvlPyc+6/LOqR
         Zx7YDhFr56IlkGyRRJGY6sJcY9E2t1g700jOZ/J/r6SvQQqzNaeUVzL2THiPQB1s+ik2
         a2JM8f73GzahSmT6r1AMj+HhSQK+B2oOFAA3wLRtxh63gRhIFiS6ntcMJ+Nw5BOlytMV
         ROCK/gkHaXFrTy3sefKJBgj3gHtUpq9I/k4vnSMFkGDd4wU51178e17wa7xMUaWYR7ez
         urjQ==
X-Forwarded-Encrypted: i=1; AL+hErHSDx19CER4bq33uUn/xUQye2o+r9PVTwXPAUN0EJ7flyQZ0qCIHgHUi2qGwV2icd0ZrBGEWue7gZQczA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8KfxiW48aQfZt8wLT6p5pURXPte776YtK9ngLUMmGyozN7uRwb
	lD/ECX0O27jpsbCnjqJzhPf1BB3FD1JKYvtvu0JmgFEqb7kyWOnY5DgCMWc09g==
X-Gm-Gg: AYBFou2KhNxkCO2ZWcg5xyUY6jhrlJ6M6fciZCrhvdaKQXE8/VVqOQSvH+Qf9nEXKqv
	gMQ7aMfw9PP8ovYNgb0SVvJlxnLia38ghPAf2E2d65PaOuMxxHDYuyMF6n7DiWxA0EIU0aP7jjx
	l8KXYA8el4bKkcqMoKFL0MPXlk43lLQNh7Kf2kDVLbq3TyLjNDyKZVtyCAxvUmFYOM9Xil2ORjV
	ZFjwxm5Fpeix5sD2gvveZSYW5lYPcGY3YTIh9fh809hYqq/fc4kOyLd1wvhu8goTypAJCGNqHyR
	dOtl6jA6a7SFM03uzyROHhjT8idFmDWQytntG1DQU6d2//89xsWFCzyQXg2WpbrlcHPrM11LC7g
	nbkWZD5h3udtrAK5V9gci+T2QlXXrLjRp5rqGJtoG/ZnpiVx8Rx4QbkFDoviYMMrWQFYvuLtzba
	tfNJCxadKBipscCpOyfz+378LEwp9ig89mOYIXZhMy4sQvYMP5rWD/VK45skodJ5iPpERYJPHin
	U6AuRVMa/E7zfHrBNcLxGcHUe2tjR9Uc/RkcyIMKL7KGypLXy5qwhItRx279agZsyTWBh1kC4N4
	kuChhm9I1o6UBCTKpY9z9pLiZcbVG5oY57y2oZFeyLy22nsVqAO/vVarhgQ62TSew+gRCLObv6o
	PRY3AQHOa76noFVJq2wcSKq4xUW8mUG5T0yJuz1s=
X-Received: by 2002:a05:7022:28e:20b0:184:40db:6bb9 with SMTP id a92af1059eb24-1b3bef0d0e2mr2414529c88.8.1794380209700;
        Tue, 10 Nov 2026 22:56:49 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:48 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:15 -0800
Subject: [PATCH v2 17/33] HID: logitech-hidpp: return negative error codes
 from hidpp_send_message_sync()
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
Message-Id: <20261110-hid-logitech-hidpp-v2-17-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Low-level synchronous send helpers previously returned 0 on success,
negative error numbers on transport/timeout errors, and positive values
on device protocol errors. Callers across the driver were burdened with
checking if (ret > 0) to convert protocol errors into -EPROTO or -EIO,
leading to scattered, inconsistent error translation.

Translate HID++ 1.0 and HID++ 2.0 error reports directly into standard
negative error codes (-EBUSY, -EIO, -EPROTO) in the core synchronous
send helper, simplify retry handling in hidpp_send_message_sync() to
check ret == -EBUSY, and remove redundant protocol error conversion
boilerplate across all callers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 158 +++++++++------------------------------
 1 file changed, 37 insertions(+), 121 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 3745d95f5bba..cf42626ab98d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -287,10 +287,9 @@ static int __hidpp_send_report(struct hid_device *hdev,
  *
  * Must be called with hidpp->send_mutex locked
  *
- * Same return protocol than hidpp_send_message_sync():
- * - success on 0
- * - negative error means transport error
- * - positive value means protocol error
+ * Same return protocol as hidpp_send_message_sync():
+ * - 0 on success
+ * - negative error code on failure
  */
 static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 	struct hidpp_report *message,
@@ -331,6 +330,18 @@ static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 	    response->rap.sub_id == HIDPP_ERROR) {
 		ret = response->rap.params[1];
 		dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
+		switch (ret) {
+		case HIDPP_ERROR_BUSY:
+			ret = -EBUSY;
+			break;
+		case HIDPP_ERROR_RESOURCE_ERROR:
+		case HIDPP_ERROR_UNKNOWN_DEVICE:
+			ret = -EIO;
+			break;
+		default:
+			ret = -EPROTO;
+			break;
+		}
 		goto out;
 	}
 
@@ -339,6 +350,14 @@ static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 	    response->fap.feature_index == HIDPP20_ERROR) {
 		ret = response->fap.params[1];
 		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
+		switch (ret) {
+		case HIDPP20_ERROR_BUSY:
+			ret = -EBUSY;
+			break;
+		default:
+			ret = -EPROTO;
+			break;
+		}
 		goto out;
 	}
 
@@ -350,11 +369,8 @@ static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 }
 
 /*
- * hidpp_send_message_sync() returns 0 in case of success, and something else
- * in case of a failure.
- *
- * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
- * value.
+ * hidpp_send_message_sync() returns 0 in case of success, and a negative error
+ * code in case of a failure.
  */
 static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	struct hidpp_report *message,
@@ -367,18 +383,10 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 
 	do {
 		ret = __do_hidpp_send_message_sync(hidpp, message, response);
-		if (ret <= 0)
+		if (ret != -EBUSY)
 			break;
 
-		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
-		    ret != HIDPP_ERROR_BUSY)
-			break;
-		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
-		     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
-		    ret != HIDPP20_ERROR_BUSY)
-			break;
-
-		dbg_hid("%s:got busy hidpp error %02X, retrying\n", __func__, ret);
+		dbg_hid("%s:got busy hidpp error, retrying\n", __func__);
 	} while (--max_retries);
 
 	mutex_unlock(&hidpp->send_mutex);
@@ -387,11 +395,8 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 }
 
 /*
- * hidpp_send_fap_command_sync() returns 0 in case of success, and something else
- * in case of a failure.
- *
- * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
- * value.
+ * hidpp_send_fap_command_sync() returns 0 in case of success, and a negative error
+ * code in case of a failure.
  */
 static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	u8 feat_index, u8 funcindex_clientid, u8 *params, int param_count,
@@ -426,11 +431,8 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 }
 
 /*
- * hidpp_send_rap_command_sync() returns 0 in case of success, and something else
- * in case of a failure.
- *
- * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
- * value.
+ * hidpp_send_rap_command_sync() returns 0 in case of success, and a negative error
+ * code in case of a failure.
  */
 static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	u8 report_id, u8 sub_id, u8 reg_address, u8 *params, int param_count,
@@ -988,22 +990,14 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 			CMD_ROOT_GET_PROTOCOL_VERSION | LINUX_KERNEL_SW_ID,
 			ping_data, sizeof(ping_data), &response);
 
-	if (ret == HIDPP_ERROR_INVALID_SUBID) {
+	if (ret == -EPROTO &&
+	    response.rap.sub_id == HIDPP_ERROR &&
+	    response.rap.params[1] == HIDPP_ERROR_INVALID_SUBID) {
 		hidpp->protocol_major = 1;
 		hidpp->protocol_minor = 0;
 		goto print_version;
 	}
 
-	/* the device might not be connected */
-	if (ret == HIDPP_ERROR_RESOURCE_ERROR ||
-	    ret == HIDPP_ERROR_UNKNOWN_DEVICE)
-		return -EIO;
-
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -1091,12 +1085,6 @@ static int hidpp_devicenametype_get_count(struct hidpp_device *hidpp,
 
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 		CMD_GET_DEVICE_NAME_TYPE_GET_COUNT, NULL, 0, &response);
-
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -1115,12 +1103,6 @@ static int hidpp_devicenametype_get_device_name(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 		CMD_GET_DEVICE_NAME_TYPE_GET_DEVICE_NAME, &char_index, 1,
 		&response);
-
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -1273,14 +1255,6 @@ static int hidpp20_batterylevel_get_battery_capacity(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 					  CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_LEVEL_STATUS,
 					  NULL, 0, &response);
-	/* Ignore these intermittent errors */
-	if (ret == HIDPP_ERROR_RESOURCE_ERROR)
-		return -EIO;
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -1302,11 +1276,6 @@ static int hidpp20_batterylevel_get_battery_info(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 					  CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_CAPABILITY,
 					  NULL, 0, &response);
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -1456,12 +1425,6 @@ static int hidpp20_battery_get_battery_voltage(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 					  CMD_BATTERY_VOLTAGE_GET_BATTERY_VOLTAGE,
 					  NULL, 0, &response);
-
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -1604,14 +1567,6 @@ static int hidpp20_unifiedbattery_get_capabilities(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 					  CMD_UNIFIED_BATTERY_GET_CAPABILITIES,
 					  NULL, 0, &response);
-	/* Ignore these intermittent errors */
-	if (ret == HIDPP_ERROR_RESOURCE_ERROR)
-		return -EIO;
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -1694,14 +1649,6 @@ static int hidpp20_unifiedbattery_get_status(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 					  CMD_UNIFIED_BATTERY_GET_STATUS,
 					  NULL, 0, &response);
-	/* Ignore these intermittent errors */
-	if (ret == HIDPP_ERROR_RESOURCE_ERROR)
-		return -EIO;
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -1958,13 +1905,8 @@ static bool hidpp20_get_adc_measurement_1f20(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 					  CMD_ADC_MEASUREMENT_GET_ADC_MEASUREMENT,
 					  NULL, 0, &response);
-
-	if (ret) {
-		if (ret > 0)
-			hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-				__func__, ret);
+	if (ret)
 		return false;
-	}
 
 	*status = hidpp20_map_adc_measurement_1f20(params, voltage);
 	return true;
@@ -2138,11 +2080,6 @@ static int hidpp_solar_request_battery_event(struct hidpp_device *hidpp)
 					  hidpp->battery.solar_feature_index,
 					  CMD_SOLAR_SET_LIGHT_MEASURE,
 					  params, 2, &response);
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -2230,12 +2167,6 @@ static int hidpp_touchpad_fw_items_set(struct hidpp_device *hidpp,
 
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 		CMD_TOUCHPAD_FW_ITEMS_SET, &items->state, 1, &response);
-
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -2300,12 +2231,6 @@ static int hidpp_touchpad_get_raw_info(struct hidpp_device *hidpp,
 
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 		CMD_TOUCHPAD_GET_RAW_INFO, NULL, 0, &response);
-
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
 	if (ret)
 		return ret;
 
@@ -3493,13 +3418,8 @@ static int g920_get_config(struct hidpp_device *hidpp,
 					  HIDPP_FF_GET_INFO,
 					  NULL, 0,
 					  &response);
-	if (ret) {
-		if (ret < 0)
-			return ret;
-		hid_err(hidpp->hid_dev,
-			"%s: received protocol error 0x%02x\n", __func__, ret);
-		return -EPROTO;
-	}
+	if (ret)
+		return ret;
 
 	data->num_effects = response.fap.params[0];
 
@@ -3702,8 +3622,6 @@ static int hidpp20_reprog_controls_get_count(struct hidpp_device *hidpp)
 
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index, cmd, NULL, 0,
 					  &response);
-	if (ret > 0)
-		return -EPROTO;
 	if (ret)
 		return ret;
 
@@ -3721,8 +3639,6 @@ static int hidpp20_reprog_controls_get_cid_info(struct hidpp_device *hidpp,
 
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index, cmd, &index,
 					  sizeof(index), &response);
-	if (ret > 0)
-		return -EPROTO;
 	if (ret)
 		return ret;
 

-- 
2.56.0.542.g3ef89b7020-goog

