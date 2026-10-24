Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812652;
	b=NOQIwJsqvylmOX33upGnJe+Wb4Drh/ZWNB8MXERJHbnhdyeTJXvBE0aiZQr+lKs2Afev
	 OCyuff0HUTXgALZsFRphmh7mvmNutVjmUr7Yg1cDQCnHbCu7/WGkkTUpKcShOrq4SFcz5
	 1UI0ONRioxWY0Xj+NkNlOV7Qd4Lh2+uXuxtzpvlG0bj2g9EzXk41NxWA7qFk1ZX5gmqVX
	 nTgw7SCozv0Zw34VI24mcp9sQEDs/nFuPg9cLz/j/49kgKPqXTxrNSqo12+MUfHAigKYo
	 rggTFz24FxFnd/d4EUSV35P7urt2knUqpop30J4UTSnSo/mXlu2Wuw3jb9pm2eroo/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
	b=XvCWvKY+hg1V67QiBv2TTvDO1q2fK06gaMvCD3SOnsJQ1dVADUda+OZ3c1KIqxH3++6/
	 Bja5DfJ2/vAh7A1unHLMNliKHSTnlaNqzzb6UaKRcFv6+baGh4LFByPmfvLc7CiG2mkew
	 CjCiJr/9JX96uoPcLJch7JEtyV5Kn22QBkCocgoz6uDDUwICekRzY2B5qVnLhQ3RonR8P
	 n9OiftdDfc/cAMCLiSjdqAu2xO1DxOKUTeLFL1ileIQFanEGb46dB3Vi01Ywaumrh7onm
	 evkwrhuPzcMvFwzEId58aY5dOcVjofjxGnALueESmbJhIDVo/uGEOUGofPY4Go8m4+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OaYUfg69;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF8606A325
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 03:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECF8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OaYUfg69
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35943f55c06so1843038eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812651; x=1793417451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
        b=OaYUfg69N1J1Iso7WW7ZdQub0LS/FbjQzBk2ABKdo4pTNiWo6tI09IS8IRhvOd4abF
         pLbBjQ8fXiDA3TzwOCuK51w9RcfcJLHQsmUW34gM6cpKsDRue3QGjLSqvQDCcNwMvxDT
         aSiqvir0m0dN7kuglHbZcGA9kM5IRM9NvmsZROdiPbLcAhDyXBK82RSaTUwvOJUrHnjW
         pyblJW2jLR5EZrxRKBnUB07KvRbGZkIBIXMj01B8iYuTl1VPLgHDHFsgIrq0e5CbSG5C
         7bxCSSOF+vw2l+q3RNr0sctKW+XCTPCWDjJK+X1nwLohO8arg3SvbV5fjixlIoR+3Whg
         /WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812651; x=1793417451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
        b=Qtge0lZHTaboXYHNprxXbpMP99uXthw8Ccwt68ukw+8Zc5fjGa4w+Lp+pdOl2SV9PF
         7JdkWetQrzceJ4fp27kLBW4bhc+3ugSd+VH2DXEIwXDY8CnuxmJI8RBjSuPVyrYla5xJ
         GVecWJfOV8PLmULBdhv+rvw4+pKhA8SGDn2+iE53kVFMDFwQbBcaRQHPCqsBoveaScgv
         qDCa5Xq7qM4lM7KoGgyF28K2oaOqLCUMaMOZ+ggUAflBUs66E1NlOzJbnHq9dEft6mKS
         bVCc/Qdr0tNN3OQrKikwoAA5WF7ZLaB9VF+3JXD7Z77RMwDfheP3yzqPi8roF5JvSq4Z
         kUZQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4npyDZ3shjCtSLAEomTA/asoIBCBkaG/DPkoumzS+sP0pwWCKwMso0OqzVeV60yFfYIroTbKaFwOamg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKlXMuAdDAS6SdZAeJQXD7m58BNQVlskbgCOBQdjQGgO3HUMuou
	woUUQErwGljJIYDijoyOaKl2uemWIEB82XSPfLQGRK3LmSDDY2m9SYAC
X-Gm-Gg: AYBFou3WSQ/gNr3eWiaKzvq3Z8vORJszxGDczl/UxEwmbfZRH7Ai3Ia7L+t2Fnti3NB
	4khlUJ1U56fP5YkGDAZ/Vi+aRvRP09n5qwACqe1rbXxImn4+CNQ5wcyW96qaga8nUlPSJqta0Hw
	p3+VdWg7yRMzBM4EaJBXUIOGRKTE+uxCBIVpKITJrIDPF2fUwzn4IYaq3BuMcrIaijHDp+YTaIS
	Vst0HBZErUu2yL7czABLuiQF2+89kO12MPonio6wr/9G9QLOFgjzgQ0mbjCyw/ZAVpG9umdTvwi
	s2RrjNPzt4p34gJPKzJrNPbnu2oG1XKt2KlHIdKBtF3EIeXpu0u3pTKnypcCXGplb+Af4DROdZY
	/BrZ0uIeq6AM+NIsKOsq88/Dzdmh5iitCWaVNx6ZfbBxRCRTrbX+X9X8HpB4ODBKnhT8Iy0Utbq
	JoKQph31a5ZArGb7nHVLzwjFTlM3oRCigLULORSKdqCyWK2fd6BSx4icmkOvUmI15sDbJ1RfcWV
	RB+Ku8kMOeY8+QzTaWZLiI2mfVMyIMCj1/Hr1SsSBdeRpTj9BMJCgdjE8REqS8OIxV5ikMX9U3R
	oYo/B5Bvb27jrDwhaz9kscmMhY61
X-Received: by 2002:a05:7300:f582:b0:360:aeee:9b8a with SMTP id 5a478bee46e88-369e8483665mr1419425eec.8.1792812651295;
        Fri, 23 Oct 2026 20:30:51 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:50 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 2/6] HID: wacom: check the input devices in the legacy irq handlers
Date: Sat, 24 Oct 2026 12:30:36 +0900
Message-ID: <20261024033040.316652-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261024033040.316652-1-jinmo44.yang@gmail.com>
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

wacom_penpartner_irq(), wacom_pl_irq(), wacom_ptu_irq(),
wacom_dtu_irq(), wacom_dtus_irq() and wacom_graphire_irq() dereference
pen_input and, for the latter two, pad_input without checking them.

As described in "HID: wacom: check the input device in the shared
report helpers", a partial interface leaves one or two of the three
input devices NULL on a fully successful probe, and wacom_wac_irq()
still dispatches to these handlers. Seven locations fault, each
reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write.

For wacom_dtus_irq() and wacom_graphire_irq(), all hardware served by
these handlers is expected to have both pen and pad on a single
interface, with two exceptions: GRAPHIRE (pen-only) and DTUSX (pen-only,
no pad buttons). Guard the expected input devices at function entry,
skipping the pad_input requirement for those two types. For DTUSX, also
guard the DTUSPAD branch in case a spoofed device sends a pad report
anyway.

wacom_dtu_irq() gets a check too. Its only dereference is in a
dev_dbg(), so it does not fault with CONFIG_DYNAMIC_DEBUG=n, but it is
unconditional in the source.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 567b01882eb1..bec8dbec5bc3 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -128,6 +128,12 @@ static int wacom_penpartner_irq(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 1:
 		if (data[5] & 0x80) {
@@ -174,6 +180,12 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int prox, pressure;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -233,6 +245,12 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -263,6 +281,12 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int prox = data[1] & 0x20;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	dev_dbg(input->dev.parent,
 		"%s: received report #%d", __func__, data[0]);
 
@@ -289,16 +313,26 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 
 static int wacom_dtus_irq(struct wacom_wac *wacom)
 {
+	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 	unsigned short prox, pressure = 0;
 
+	if (!input || (!wacom->pad_input && features->type != DTUSX)) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: missing input device(s)\n",
+			      __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_DTUS && data[0] != WACOM_REPORT_DTUSPAD) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d", __func__, data[0]);
 		return 0;
 	} else if (data[0] == WACOM_REPORT_DTUSPAD) {
 		input = wacom->pad_input;
+		if (!input)
+			return 0;
 		input_report_key(input, BTN_0, (data[1] & 0x01));
 		input_report_key(input, BTN_1, (data[1] & 0x02));
 		input_report_key(input, BTN_2, (data[1] & 0x04));
@@ -349,6 +383,12 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 	int rw = 0;
 	int retval = 0;
 
+	if (!input || (!pad_input && features->type != GRAPHIRE)) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: missing input device(s)\n", __func__);
+		return 0;
+	}
+
 	if (features->type == GRAPHIRE_BT) {
 		if (data[0] != WACOM_REPORT_PENABLED_BT) {
 			dev_dbg(input->dev.parent,
-- 
2.53.0

