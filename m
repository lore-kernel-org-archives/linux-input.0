Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C743CE42
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320392; cv=none; b=dUu4ai1bP/omO+eT98YtzCWidCNWl+9Sh2MKqMABrDXV/0oFj/DCQrmF1ThFu9iDfEJiLEkY0bf1Z/psEsM0i3hhWdtpf71blHNimj9LI7lOmJ44w/anL9tDGa1pwN/VizzvQRKG6VexkeB3PxJsWKlmhl2bUbc/KkBiTwQeuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320392; c=relaxed/simple;
	bh=pMlevOUHaAs+yLCrVQSukB0TzZvpytiFNk11dfVCvwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkpiOmwTEi3PCXWFmpx5CcrmBTsd1sd+RYeta0akJlKql5woovzA1WA/GPWFTKzWRe8Y0Hz4GdqP193yI8igItY/KtVs1J9fwnPEi6M2mWnFNK9aFNF2fR9ivUKMs54oh4hthrpPUh/wtblP5dOMOWgMBZYVs/82pOw7PrxkA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e592Ugg4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e592Ugg4"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1189435a91.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320389; x=1792925189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGDdVL59lE6YQrzdfZRCLyb309tREeHdYWSa4H5qVuo=;
        b=e592Ugg45aG/bD7cFvlyFFptraMc8KvZxxz1W/n6Z7DB+gB2FTs/sM1QDuWcCnUdON
         Ox9C83klf2Wi+bkQ5kuypniJFR+8pvaKK2sURkrBO20utIA5q2GigSnqHVHj+1LAW2RA
         QhW0+QLsywR3aMXJZthpfFWPx+A3juB6J4kbfVjAZTyZ2QgLZ8k5Dnrrp/oML4svWSPo
         AIW4YsHXxyvyJNZ8QmNTuua3XiT5GOYbWtI9Hmy8yfpUFKX8qvSaFXGDqKD9aMmM0tx5
         AioPXqCCkzqcSYXlSTIXq8tofcNVBcI1Md90qrK+feTZVT6nVg1RloychgpyF6GG0a6b
         uYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320389; x=1792925189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGDdVL59lE6YQrzdfZRCLyb309tREeHdYWSa4H5qVuo=;
        b=hHc9JVMPm1/JZIzRqYfC+ov64lW+FZ6Lc6FOVzG1GUWgpFN+8Xd9ALtbqyaYnKKYBE
         Ks1xZKO0bbKwhYF8W8DSuGLm0f3yvwl0NNiP827JxEJSj5uys7jbkyh2o3UMQpWCtbEQ
         /393U4cvpqZmT1vEJ9DiCDJT/lM1d/gs8xZ7ySFPNm4v/qtK3k54WOoCmSoaWRAyEZOB
         3eHl7jDzhCfHC1TzuF1vkLsSGLgzR78rsh/lA4pL9YMQn3UfyWFAXndDZ9IXO6DZVoRQ
         IMM4jYnS5FgE0mTwVXzuiIkkq/xilJHtREvT3rAGYFKxEPcNYcWrjNiaMpe9SSAB4yDT
         IIpg==
X-Forwarded-Encrypted: i=1; AKwUvBw/I3VFdEKOM1Dcz1gkblWVRNtAS/3xYicNjEJBqtz/K2BvdgoTtBF0N57LThcjZzHPiYgpERO7JbQrdg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIpe+ROa32K5+/hQqeepHofWCzljoVNS3BcDAOX/oaaD9uGHWsI
	b352FpFouE9BBz4u1egyx07YPosVbpEppl2cINwF6httwEw+hxiTdUIk
X-Gm-Gg: AYBFou3D5/kXKu1GbrADrzyVRYQB4bXHu1Tvg5h0zn1OxQQKLx1GtVvQlEU/8JOaQhp
	JfA8+VmkaKGFqzt69Xb95vlud7v5B99mvk0/Y16HM7IrQPg1C4SYcYehBsxcZg7QPjXoZIiR3jq
	z8dt+DxeXavpGsrQEA+22cpK5PWeH0vuXHI2UbWlqqp1u+fXWr+iLsDeM8q8N6zrSjm18jzu6Sz
	Pgb4mLEmwA1SYUvE2NBf3I3FjRbgcp9hpBvVYwEwUiekAciaQDpKNh7P8Nol1pjxhjklZjlEXKW
	AbVeDWj8dwXKJZM9AuHpZaob6vVS5adP08wQw8g/bgn1c50KT3btI2TnZtzw52IHvbezMi5mmw1
	5rj/+HJSF5VqxeRsiC9x+LzEJWd8N7kwhq1NMZamVAVh5phwJa9pgdX4hr02I5kyklaDegAshWu
	qtofTW55Ctd5gRTD0ULm4MAgHar2O9YCwlg8R6ACg8igLCF8C7bhBNqeORIcI4V6ZL+T78N/+jw
	uQo+0cg7CrUYWhzxU0kq/4=
X-Received: by 2002:a17:90b:53c3:b0:3a0:bbd8:5ba7 with SMTP id 98e67ed59e1d1-3acef63e059mr4177929a91.62.1792320389532;
        Sun, 18 Oct 2026 03:46:29 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:27 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com
Subject: [PATCH v2 2/5] HID: wacom: check the input devices in the legacy irq handlers
Date: Sun, 18 Oct 2026 19:46:14 +0900
Message-ID: <20261018104617.743771-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018104617.743771-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
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
interface (the one exception is GRAPHIRE, which is pen-only). Rather
than scattering checks per branch, validate the expected input devices
at function entry and bail out early if any are missing.

wacom_dtu_irq() gets a check too. Its only dereference is in a
dev_dbg(), so it does not fault with CONFIG_DYNAMIC_DEBUG=n, but it is
unconditional in the source.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 567b01882eb1..aa08afb3c5ef 100644
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
 
@@ -293,6 +317,13 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	unsigned short prox, pressure = 0;
 
+	if (!input || !wacom->pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: expected pen and pad input devices\n",
+			      __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_DTUS && data[0] != WACOM_REPORT_DTUSPAD) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d", __func__, data[0]);
@@ -349,6 +380,12 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
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

