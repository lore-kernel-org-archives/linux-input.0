Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164255;
	b=c9pFLI+tXT0U6e9IvXZJhns4Zhqdfu3xCFYKKlaQkuYHs9HqUCYRfOK8NZq4HwFlqurP
	 /YxCYtVRppYR8wgnOYbytNSpNCG4TkmnZS1ixp5Pfpql8kMBMqgr/sjTSZmRSCfGu8Kff
	 KRXW/wv6TQesBibHT9l9FN9Bc4tEKp19ysgsFFQ4xl8Iq/P0hgonxFz6TahAIadpiPGH1
	 jA9bCyW8gYvL4hZmY84e3bIBs2CAa3mq8639lci6VkLAbfRjZKuF9MIOKCHtXGVJA5WH8
	 6IXwUJSwPFxU42sU7Y+4oMc9D3KmDCG1wDgET/+BkjnHHAb7SGJP6xbSK4KPh9k11hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=V8ZwfTPG8jGpcsaM/I32hjrBsqSSwwwpQT8qhPi47RI=;
	b=jKWwZSOkRACiTfR1eAXeg/Vt+tgaJgVC5tB8RQymaR31Cc5ELNfZpuIlw4Cdo7Bdlw5w
	 vtZUkFcKaA0qrfrfKGsjqUoZBw1DspLgNVQyWdzYnMrIt+Jk42vyOywWj0XFeAxJmSRXV
	 pNVWBTBpZ0LudZaeoHl1O6hEr4MY9TH/feQzIuLIdmgu0FhKSCw5JSeDT0T1BIgr4P8xY
	 sRLueU+1td9GxR50K3gphVDy8jcUGd3aZUZ+zW7/mF78KHq8eYAX53cOwOcNs6hDns72w
	 vPIeB0yELT+H4Mc88jT2pVYFz0dbYwp31hU2IhHe601gNCve6E+DXCdvGjvCxhWdaQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s+IOzwVZ;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C3606B4B8
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 871C3606B4B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s+IOzwVZ
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so1139280c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164255; x=1795769055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8ZwfTPG8jGpcsaM/I32hjrBsqSSwwwpQT8qhPi47RI=;
        b=s+IOzwVZ/6+3+Vr6SI/DdKZ2cuiUy2PRsqIMvTld6qzNTaUqucXfW2ZbQc0eUBRwhr
         0GjjPSPrfgKZBxq2OGAWWrPdWFudDlzaZBxst8cAA8Rd/P34Gh80OG7+MyO0zX2OOwKB
         5I+iAL1bEEYaZ52yhG2jpC7PWn4fYlXQrB7yier1Ff03pP21KKNW71jBu0V4iaarlZk7
         bJ4ZgubpeckJ2DVPdy8DdeQ5b9AcYI4WKeg3B6FdAkDL6x7eq5hIrWpzML2WypVn0UbF
         xQh+X3r74ludX1iKQZcSQavsPnWA/nfXsOokhdf5vBOIXaqlEyW2+Z2SWRtSij4G1vk/
         sipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164255; x=1795769055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V8ZwfTPG8jGpcsaM/I32hjrBsqSSwwwpQT8qhPi47RI=;
        b=hvH2KzVumQz6rmwFV2/U8LeZaCgxnElVnr0c7UOTMjmpVWabLOLpwC40vaQeZEXolE
         QsJBgsKT1fEnyEl76/bRCn6DZGMQmRKssL8oeB3zgbF7sSqPvjDzTKHOkAOJ+QyDMHhc
         m/YC12E9b/Qy/2H3VHdvB6wR0DZmH5uvadKstB+RDc4EPOhqNMfZfQ3uXQ8/GBeZOXXd
         ungC2NNSTRlE3nB7MxjhqPXuxpGv7trxdMsw1RbvNdavJnfrtMubqGDthfozv2IDv2L9
         oME/EDYftP/3/ejsHqg+490naF1ldBQESoSSjux8amQO6qpwNuw3WP6nPd5HUffB96Dz
         zZEQ==
X-Forwarded-Encrypted: i=1; AL+hErFQGqfqHz/b9Q6Ck38nIvIBENnwYJn8/T2ktx6KLtXqe88PoYWMwjgMu+K1W8f5Rfrr9aPKh4JV/Q21mQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z874b71lk3o5DgxJdpFrTIf9uYOTieH5I0Gi7xm91u/ZvnNTtHL
	K5o7QxpniDeFOViIoB8qSe2R/tQjb401elbfJA5f3SncjaU4Dx5XQ8pT
X-Gm-Gg: AYBFou0DG8kXbf1Xk3qhcc8F1JqXCIDcnTu/UdIpM1WFCEKtjtqSte5Y1uLdTWi3w1g
	NljVk3ASnkYOGsnWiF4JF962/Oc0yanJjwofdH1n1uN2LQfONxW97x8BXZDJg5R/1oa5giC4ZrA
	sPtEQqDSZ0+r/rCwwsDwp5hmem4G1MlU3kmV/D8zkBfVdnGgs7nIwy8tWYV1u2omW0Kix9OGaup
	GGaSnwVoLG1qiiD8uR8p64hcFd7SzUfssOJ3LMGuKb5SgU51Gr5wrO0KoMNB1gu87/OyFlmZCDW
	iWHUN+Py2JM2pKfl86bL23le4DmICv4PJQbcnKXDzh2pudlHfqbp5xBZ9GGA/aIo7E4rKtaPh/K
	fnyKIzcv/vA/CVWILzjgT0zLIeKQ4fRzvIRW3XrehSoehcnjh9p1lmYBY3faCChhvT3ptXSdK13
	klogr4J90B2BsyHxL50BywrCVZea2ZEZhuF2x1Dr7r4P4rjb7PugC9l7+OgGD9FVdWgDfFiuWfz
	xw8XMWg5YniYslOyHyOna8Gt0jXBOS3ecIyFDOFeP/vCtn4qL+Xo3IrTNcVgO5eV6YfJKqZMPFE
	fOdZkSbYmUD/6WAORhjNxLV+wlUoiBnsk/I6NpzajjyViAMNI4d305C8scf9vrjPBUmfVEzJXQj
	4kjGZnG42AIfT/LSljA==
X-Received: by 2002:a05:7022:f907:b0:1b2:558a:d781 with SMTP id a92af1059eb24-1b5567b5788mr1842460c88.5.1795164254561;
        Fri, 20 Nov 2026 00:44:14 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:13 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:43:54 -0800
Subject: [PATCH v3 03/18] HID: logitech-hidpp: return negative error codes
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-3-ba39242d4336@gmail.com>
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

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 158 +++++++++------------------------------
 1 file changed, 37 insertions(+), 121 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f7e654d82805..44a7b4dfc9d9 100644
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
 
@@ -1461,12 +1430,6 @@ static int hidpp20_battery_get_battery_voltage(struct hidpp_device *hidpp,
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
 
@@ -1609,14 +1572,6 @@ static int hidpp20_unifiedbattery_get_capabilities(struct hidpp_device *hidpp,
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
 
@@ -1699,14 +1654,6 @@ static int hidpp20_unifiedbattery_get_status(struct hidpp_device *hidpp,
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
 
@@ -1963,13 +1910,8 @@ static bool hidpp20_get_adc_measurement_1f20(struct hidpp_device *hidpp,
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
@@ -2143,11 +2085,6 @@ static int hidpp_solar_request_battery_event(struct hidpp_device *hidpp)
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
 
@@ -2235,12 +2172,6 @@ static int hidpp_touchpad_fw_items_set(struct hidpp_device *hidpp,
 
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
 
@@ -2305,12 +2236,6 @@ static int hidpp_touchpad_get_raw_info(struct hidpp_device *hidpp,
 
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
 
@@ -3498,13 +3423,8 @@ static int g920_get_config(struct hidpp_device *hidpp,
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
 
@@ -3707,8 +3627,6 @@ static int hidpp20_reprog_controls_get_count(struct hidpp_device *hidpp)
 
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index, cmd, NULL, 0,
 					  &response);
-	if (ret > 0)
-		return -EPROTO;
 	if (ret)
 		return ret;
 
@@ -3726,8 +3644,6 @@ static int hidpp20_reprog_controls_get_cid_info(struct hidpp_device *hidpp,
 
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index, cmd, &index,
 					  sizeof(index), &response);
-	if (ret > 0)
-		return -EPROTO;
 	if (ret)
 		return ret;
 

-- 
2.56.1.750.gf70dc682cf-goog

