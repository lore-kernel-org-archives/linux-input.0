Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380228;
	b=JGsCUw6aBS6LSYJ6ansg5rCprle7iHked5GQ5FRuHkw3zHeHMQUzPBN5xde+kWz/3l+a
	 buZZ9PeAc8VW0dETWg+H2nihASjtWFwshkq9pmOoUuqvath0waG7NixSTNLt3ebRBlggE
	 Dm+P88hsZaHusyj/uCmxdFmFtBtM4RzxasfgVDdfR1TA7hav/BW841S9pskJ/UkAa5hDP
	 HPyldS0TZ/lfIacIVaenoJuza0ot2cDZXMXNBoWTrkVw47mRJUqKWPJaM8P50Gpe6VW+k
	 JopdwMfsLaU53/xUNrNFEDucNYOXH8e9pm+3usXHQk8lPZHZnEne4E53njJg3rI32Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=lZaigarthkYfk+LJ/id0he7EntFXTEZZC4zUNeoO63c=;
	b=ueGavXUQyp2QX6UR+6mLbKZs/aTB1LGvu0uDp4DdX1mU1hAKdhlsS9cpMy4qzVgE0RcU
	 SRoHYB/rtYGSWLfimtbkrhECre1va6JrulCDY2JH5YQyCG+ieX9n9hbUedpy3o+pMaljW
	 Qu/T1tKvybLxXgNTvgJRFBAD+ptQpwcx43xqWiLYXsOLSMF8zLYvA7TcWkDi++xtMd+yG
	 DDTWDEG+Vhn+UeeuEp8lmfxeCkM5Qc5VpYh9vnlyvedam7CWj0TPxw/gAYFlqNCcCaLsR
	 EfQZGLQXHOsaZvaPZjh9Dr6rLJcxxQpp4q3j+QH8T2Gd9cAmPZEKEZmoqACJJ1gBCvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=agOxSqvp;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD6606D352
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DACD6606D352
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=agOxSqvp
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b244fb7fffso3533181c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380227; x=1794985027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZaigarthkYfk+LJ/id0he7EntFXTEZZC4zUNeoO63c=;
        b=agOxSqvp1p3il60geexOXuGgwctrpHH59Nsqf8JNtRKhWnhpb9lxL229fRj6DlFs1N
         fgol9Txgzo5sV4VeOcDRuoUM9sAxxoIBOdd9gaXJBA/p2l5vEBrWaOVqoBR9NtYLWmum
         kANp6LqWF5ZmoBAZk/iQICAD1eR4jyIlRXDWWyWYH5kxFp9PvDOewjtGghIpntRSgWq9
         PFjaOdKTezQlCykd4yHmbxXWPqe8ogX7Rfg0athXtAcr65TNreQVlQJFo5cGTbvYnGVU
         S3uTL3d+Ya4JxPQ100M5MbF2EK9+igSP8qvUNaVYWsZb6Mw9wwHtQVFkqv2JqlilooTn
         vPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380227; x=1794985027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZaigarthkYfk+LJ/id0he7EntFXTEZZC4zUNeoO63c=;
        b=buCg883Bbljo4OhlYpfKH7s6ps6JrC7marO+3y1WhzItxA7B4u8/FqYwSuugyVdocz
         W4wt0h9OJ+wZnToAwMFylWJJy8IJ62+yS7ie4dSgw+l/nGBlMZXxHe4mE9Uf1N3g9MFh
         7+5/lkG8+EYFSPkko80w8Yq3OYPMsQIEsEUm6z52VFyMGzdwPcb2qfc6+EA9jPogVJgI
         919s9YHWOCX3EIfKOZBODP3bIc34RSx1lGqrbzZVoHovUI/qgOd7lm0axXCHCuyaRQD/
         n9z6ETO/c0QVHCWR/v8jn3LYkor6w33vdtunxmUECQmx+220GjUfIGPm/UQUMxysykAi
         Pw5Q==
X-Forwarded-Encrypted: i=1; AL+hErF+acaDhkAio/rXmDeiOv1Fbdp1mV77IxsBSTxAlCBBvKF+MRrhaWATrtPpomYxDJwWDLa+C87C93fEWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/rRFT6lEvsGPjNVmzSGQkHaSxhTC4SAMcWOmtGnjtpFYf6sXgG
	YIoI5tSQvAaDBPzWK6NHsclKWtbhmjs1kY4SAm+FcNu55BbLxquTzDEu
X-Gm-Gg: AYBFou0AuK3bz5FQ61/VVUc1I1NwK8ChkBuHkgRsVWYfiehrDxoQN/4tlSN+hS76KGZ
	8twDU/otVVXWgKfOI/d8KrjllcR7+YCdKhYkgI69sCw2dAq/FSLR6BVYLUoWEKydVE0ZERgWg6x
	AthAJ4tBD2weThuWOdLhhOWqSq2nxNZ8sxDYl4u2T7cQuyukGjM/qxlnMjVJnFGVlpy1nE7HD/D
	2MQEMJ/NOJ1LU0STBRPVarU5fqZKKzFxYbBeniWd4+IjWcYOGbVJplZ70zNh8IAE/8kNbuDv0rl
	0LxOHYzpwlx5tv3mFHGO5A4K9Z+zLe2sK0zrCf7vl69xO0OpBmF+FeNl9HZotqWSaDJZZzkaf+B
	CyrI63+S5+HFN32R073j+ZDdn9Es7+aP4E9B60+QEcahbQTWpN3EDvpb/DwtUvp6Lb6Yf9SYT8O
	P6WekR3KhgoPDlpHjgx+Hxg4JfRlKa72CsL4KEiP53TtIwFc4necnQP1gFJeaCFeYIumEpqnjAR
	x8rqsyrwQ5eLEwnMMLF017NxHAh8MV8qR8eeJ9FiQX+dBfcYZui073e8SFrEC83CbqRFLTBwt92
	B6Pm4m/OhrNSiAzNWImYCeZaNmvVbTxkhZE2MOr9ZmTizvIUo6To9eqqKSDK2VYYmgywJ5IvJo3
	stIPo0PQTPxd8YmOEqA==
X-Received: by 2002:a05:7022:ea4a:b0:1a3:9936:d11e with SMTP id a92af1059eb24-1b3c034aff7mr1595237c88.41.1794380226714;
        Tue, 10 Nov 2026 22:57:06 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:57:05 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:25 -0800
Subject: [PATCH v2 27/33] HID: logitech-hidpp: store device serial as a
 byte array
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
Message-Id: <20261110-hid-logitech-hidpp-v2-27-30743e91d83b@gmail.com>
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

Device serial numbers are read from 4-byte protocol payloads only to be
formatted as raw byte sequences with %4phD. Storing them as u32 requires
unaligned pointer casts and dereferences that depend on endian-neutral
memory layout, and the FAP-based serial helper reads from the RAP union
member instead of the matching FAP payload.

Represent device serial numbers as 4-byte arrays, copy the payload bytes
with a fixed serial length constant, and read the FAP device information
response from the FAP payload directly.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index df0bcaaf8647..181b791b3e0c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -48,6 +48,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_REPORT_SHORT_LENGTH		7
 #define HIDPP_REPORT_LONG_LENGTH		20
 #define HIDPP_REPORT_VERY_LONG_MAX_LENGTH	64
+#define HIDPP_SERIAL_LENGTH			4
 
 #define HIDPP_REPORT_SHORT_SUPPORTED		BIT(0)
 #define HIDPP_REPORT_LONG_SUPPORTED		BIT(1)
@@ -898,7 +899,8 @@ static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev)
 	return name;
 }
 
-static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, u32 *serial)
+static int hidpp_unifying_get_serial(struct hidpp_device *hidpp,
+				     u8 serial[HIDPP_SERIAL_LENGTH])
 {
 	struct hidpp_report response;
 	int ret;
@@ -912,11 +914,7 @@ static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, u32 *serial)
 	if (ret)
 		return ret;
 
-	/*
-	 * We don't care about LE or BE, we will output it as a string
-	 * with %4phD, so we need to keep the order.
-	 */
-	*serial = *((u32 *)&response.rap.params[1]);
+	memcpy(serial, &response.rap.params[1], HIDPP_SERIAL_LENGTH);
 	return 0;
 }
 
@@ -924,14 +922,14 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
 	const char *name;
-	u32 serial;
+	u8 serial[HIDPP_SERIAL_LENGTH];
 	int ret;
 
-	ret = hidpp_unifying_get_serial(hidpp, &serial);
+	ret = hidpp_unifying_get_serial(hidpp, serial);
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
 	name = hidpp_unifying_get_name(hidpp);
@@ -1031,7 +1029,8 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 
 #define CMD_GET_DEVICE_INFO				0x00
 
-static int hidpp_get_serial(struct hidpp_device *hidpp, u32 *serial)
+static int hidpp_get_serial(struct hidpp_device *hidpp,
+			    u8 serial[HIDPP_SERIAL_LENGTH])
 {
 	struct hidpp_report response;
 	u8 feature_index;
@@ -1048,22 +1047,21 @@ static int hidpp_get_serial(struct hidpp_device *hidpp, u32 *serial)
 	if (ret)
 		return ret;
 
-	/* See hidpp_unifying_get_serial() */
-	*serial = *((u32 *)&response.rap.params[1]);
+	memcpy(serial, &response.fap.params[1], HIDPP_SERIAL_LENGTH);
 	return 0;
 }
 
 static int hidpp_serial_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
-	u32 serial;
+	u8 serial[HIDPP_SERIAL_LENGTH];
 	int ret;
 
-	ret = hidpp_get_serial(hidpp, &serial);
+	ret = hidpp_get_serial(hidpp, serial);
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", serial);
 	dbg_hid("HID++ DeviceInformation: Got serial: %s\n", hdev->uniq);
 
 	return 0;

-- 
2.56.0.542.g3ef89b7020-goog

