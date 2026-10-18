Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA049B5CD
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327691; cv=none; b=uNUQ6DKoCC+UPkjJYq5dJQjJIqFN33mys3SWaP7RDN0q0CicR/ChZ7r0lpHeBsSNdGjKxwb3XNqDntYqMVZYhroJFYHuIbdRwi+eFrXSKFdUsUVnrSaFbArFTIoqpAJUkKX0+kZCtpelLc1zs7gsZnb2f8s1XQCoOIFBkcIijcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327691; c=relaxed/simple;
	bh=HHtEDiwhC/456QFtVdTHrYlbldjpTf9l9yv6EsNsOKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beAKgn6Hxnr8hypNugNKBWXz7FmWNGcmI7732772qLTadOGzkx46OLouQoV0L3vEmtcSse9uA+cGzXRT5DYDpzAEU1UU7xeB98kEc0WG6pUTyfsVl4SUGNED2QxA/ZUeBZA1e1F3rFy0rPCVzPWyNA10f0xZ3UUMyOQFZts6mWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abzor3Rm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abzor3Rm"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso308612a12.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327688; x=1792932488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
        b=abzor3RmCbyI2VfSzIFSAZ6Q5D7AQAJLauAJ/FlsTTQ62a/o//gALnryFSjlbIVS05
         kwtDSIrNz2MiriyZ8SFX8bE0XLBLoJ9qFy792CEE8Lf7Zyhv1mbZpb8BpJ+XbfGwfkth
         DbD5CGdD1j4GZjOBmUEW8rqxFz1IXRSEg9qG/D1QAjpAk+gF6B4FQEKJAimGgiQJUFJM
         iylcQjc9pki57Fm/Zu7+7xahsBHvbOgAtVtWxXp71iyBtKahdLnb9d9r+su2pB+qTGKW
         pZG6ZjSJ9QwPxN4Uu6fmSgYqdXTzG6awkxmxSLNujuzSHof1OxtJAoWLwCy5YVdzM6Dp
         Up4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327688; x=1792932488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
        b=GK+ytF2MBTUdCpXOwzSdmIpUpmLJSw69oQ6yb2zEjHCG4BKEeM7YmZzWmOdLNixtIk
         nYt0jGZi/fs5X+6xEY4leNETSb8xP/TCiooHJ5ULY6DezGXfEZZ5aKr+U3PVBXRzEDiS
         udTkfPT+cb7+BtpyBhEER54zrxELI3yDd6gXpuPmtHRsdYv5GPYdEu/dMnzB4EGDeY6p
         Yd5J7CWDzTQhjVr6a+LhNPUz2zTp68PipMjBtk71CO+JzXkBqUaD79ZOggs29sctt7i1
         yA8u7bxwBmsgQ5UNS3jAyI1diHY6oeHapasoYREHBFgPRKzC38QXlk2uXkYSkgB4j4zz
         tLZg==
X-Forwarded-Encrypted: i=1; AKwUvBw2N/oYbByGp3oK0BtUcdKJP+EmgpKAehSUlORK3tHReJetOwoyKbU9rzGCQ8yTA6eTDfEByvPaf4vsEw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKz1vF8rdq62E95TZ1wlruvmYSV58Pr2Mp8GDEdEsk64A8CoqWr
	Yhg+ZrnGc0neH4dHDgtYyDqZp6xDL30oTpo5i7bUfL14nMYdXKFIbUc8
X-Gm-Gg: AYBFou1rTXNsOtiO0LdvnUw4YCTaV+M0sROwMTg7/9gs5RsP41LlSAhkIlZGKDQeCuy
	e5k9I2ATO92wM7MgJw+CVKeDLnBenl37vtN1/8fQ6mKFBK74TMiMHsjGeUSX3b5dceEIHM6Q8H6
	6MxibVCAKL1WGDAxcHRYmorPiIZHTXKLBn9NHBIB1De6mq6+bjp+rGsuiUY0K2I4bULn3lGr9gL
	WHcHmwDA6t9gRAPO040vCuZyAB8UiY7YliiSo1KudWRJ5pjTRUU0h84670dVjgTuwDP9jFl9BC0
	CnAPGB8aNwUHLXFHI/TewbPGxCnBq9j6SKFCyygYpsc1TnHuwKiy6NPXSQCzbJstI2cQurquwXY
	zZecENE9/ejJ4PbQcKCLRSeKh0uKomxs9JA8Qp6L0R9J3TGFKEkeFjsJ+vUvWtKWGsSwnqQlAn/
	vUXFTUHUl21u8fYfnffk8LJLkz/7BDBSsjLbXIFW9gHA1Olr1yz3pVDIkp++x1xIAbBuZucy262
	DS8jPtTrZCrYLFWdUUb2eSL
X-Received: by 2002:a17:90b:44:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3aceefc61f5mr4344430a91.14.1792327687925;
        Sun, 18 Oct 2026 05:48:07 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:07 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 2/6] HID: wacom: check the input devices in the legacy irq handlers
Date: Sun, 18 Oct 2026 21:47:51 +0900
Message-ID: <20261018124755.850888-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
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

