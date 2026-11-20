Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164270;
	b=OkaicSqXEKpw9znQ2904cic1ua3AkaCf3NoyfxoSZCEJLOfNWT3a5P8He6+ZEoxKfELS
	 /ulU2622vfWGdT4HhrD6Tyrw1Y0+38bW/aJHkLEK7NZXkVwNn/CqFv4V5dgPUGFsycsAZ
	 5OyovD8nwgVpsvDh4IeopFXEp/r3ZJem605jvU75Qsv/jK7x6GmXW/ENLYEl3jzjr4p20
	 UX6mB3H5L6LWdTbbwAHQhLzWNQZ8GhsDFtXbgacvL41ec1Hk2FOoJ+CTF0IPtUkyjM8XD
	 gW8JjMceXhfTbhYJyZhQnK+aAAs58RhPFzn2YXQxLO/urp3DzQRrzGl51wGevIpWAhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AXkV0k6Xfrn5k73f3TaWD8N4csl7C8uRYph441/Su9o=;
	b=rkpwmPaDQxCKUxGQrTqpPSg9zxyG+rnnns55zlCHBnZVnnpuwA6ooPilqT3jXUU6oAFS
	 MVwlm0Tyn6yDdWcIbrVOB6S6/lCVIoVigFatvJIk+LFZSBt6CNW+azrHUxafaM1ScSa1w
	 94PkY4E5bOKgU7ygp2yrn6PYNQ5m9ZfjWDYtWIFxznKOU7gsCqlP62YBsMLXF6h8N3/im
	 /pE99XCPK3Eh1DsKprv5pjaKbYSb6d6bgbZnFGansQwgMCluV1SBsL8r4efgo8jh58A+z
	 in31pUZchq+BwsMxiRCiY3XiIyLOe/0vN8TtcgXBuOxhezFhphIQ1mfoBZda5BLhUkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="irH/rjJ9";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4060A6F6C
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD4060A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irH/rjJ9
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1ae58d17cd9so659579c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164269; x=1795769069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXkV0k6Xfrn5k73f3TaWD8N4csl7C8uRYph441/Su9o=;
        b=irH/rjJ9NRx/EyIbX5urK3G5MDBjsgd5zUmo92edP4uBGDcnXNj8oKyeURkWMhbO+7
         yQ69dlGRvJZDmwM4sh77x2B3burrr+2EhDP8KL3XuRop425V1g4sQe+aqAjQ2LQK9N8t
         nwvCL4JDXxSAkh9xBGiGcRIHqVt/c3uxVS8OPr+bO6AN7Lfq/qU9lLCyP3p+2MKqkq1u
         mbNBhWxl0ihOpJ8NiJBBUa0GPPkl6a4lXT4WFPlOV/hmzqlwBMAS6TzvUA21wUzHZAxA
         frLbnyMCyRsX/aLxRTMvuZlufSDG4iRHEYSn7PNltQa0AXeNOm4oN1DrgslURi9cseBb
         0Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164269; x=1795769069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AXkV0k6Xfrn5k73f3TaWD8N4csl7C8uRYph441/Su9o=;
        b=MqK3TKnlfLMnMzjusVEj5yQuQoqONBW48CGtyC5dHpEIbjb02nm5kyeaeuzYfj708A
         Rvynbgb/OlkLpSnPft00XeFBK4UEZ0/KHKqIiXLr3yM+5dHBxk/JUHiaFS6WGLzrErui
         RRvlt1bwOwD/pDS1w/B72+J8Mwa9pQJznrvKFN4T4TDqxDHuSprPs8ja1k4awquYLg3O
         xIYYJ0gFlw6Qmts4bBhR1z5N4k2FSJ1lT/gPmqVwtpH/bI3TRpBoxojgo5WLtRcyt6Gy
         TD5eiXgty+T8ElcPbOSSpP3tGsoqnVgEhHO+VNGU5CYVKxO9LjwBbUjkl3pIK2DWB5BK
         WAUQ==
X-Forwarded-Encrypted: i=1; AL+hErHnOL6oYti4NNWRQYgEd8BGXCkQbWzzkNR6qwN6FTT1btw7+03PrIFo2XnqFhO665cs5UVWDsbkASKktQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ulUJ/f4175TKVmexjDA8tRnoogj9CV1Q0MQKEKDq5BZen7RUV
	CMfQWb7x3MtZJYh/fyClktvx46AV0gyKWJFf3NdCHR5ogQ3Mqpa9rtPO
X-Gm-Gg: AYBFou2iHcu/xpVUFvfBD0YIsEAZ4uKGo1+Ay1Y7cTnQ4T6girXjr9wZ6w8M+/C9Tin
	lmtkKbvmcpr3Sm7AwH0CM8tQqGtfcufAVDe2lWBEqBtae0B54SkhtXC7g1xy6LEwIl3IKkFVwy9
	sa5NSyKK4Kc8GEwxwiTvhb+ERwi4qnkpnlx3TM9a1kEh1K+Yva9wjMELpUG1TYtumMhvK1YzrVF
	bTrRrrGuIAeppFnrAYcSBhcZ0+2XFy0SbakXxR+hmWOulvIhigWFJO8eDehnbyywbgWbqnUlxVF
	4NSUo3tNKMVg90NH3Re3zZcQyoY1GPJ3tY+XtHgVvMcDDKIXMFymE1q1CZd3MgQzhUL1f31usXf
	uakiDvS64PUR1YWsdPYMAreOnUX3d9KM+368OXVcngMhNHsnY1n9ZxCi0c+adAt/3qUbHeMub1k
	chEWHjM3OZR5VNBYNccxg5V0HzPZX/K5frSqfTO3brebnIsw9PZHVfssjS2U3lEQxMZ3FDLP1ni
	kROk0csvczXKRidyGjKv3B/ieZ0agD3wVesMcYQ7IHUeKhUakMnrBEwfHP4MCM3BbwNoMp+JAHj
	yOUWlgJz+TUv5j5n5Dw8KGLFI8dEjulBbam790dAly6yp3ki0ly2MlKo8lQ0pfrPIuULrr5VXuP
	44KcMHNPCx2cFGeNdiQ==
X-Received: by 2002:a05:701a:815a:20b0:1b2:4e29:92f4 with SMTP id a92af1059eb24-1b5568eaf10mr1948385c88.39.1795164269206;
        Fri, 20 Nov 2026 00:44:29 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:28 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:03 -0800
Subject: [PATCH v3 12/18] HID: logitech-hidpp: store device serial as a
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-12-ba39242d4336@gmail.com>
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
index 16fb52634437..053cbfe8cb6f 100644
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
2.56.1.750.gf70dc682cf-goog

