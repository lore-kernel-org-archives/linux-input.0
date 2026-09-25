Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6461A683E
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790315635; cv=none; b=nyYVBxCTQ8Kg6NmMT+tBfpdhEhBx8lDtFTGpPy2X4rTOo1WfPpISQpamrFgeeJXgRTUDjdikXS7HTwA1NwTT8YB8iT2JAEz/Si8ebRk5LPja5R7qkqNzlmjOJaLzhGBE71xZ/gULPQUS+wKA3Y7m4BuYlybFo1MNd0Gf40lJQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790315635; c=relaxed/simple;
	bh=9UoWjWaESjDMUlMyTkMRgNrA700dRx0UDrmL4E4REhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaYheTU4LFQAZ28kEE5W6XghqFotCacS1px3rrKQQ4zbp2PjvViKzTLtp5nYvKXtEOtK6CdZK/TKIBiTm99D475zHeyV/Z1fJ9j8V5Q1zmwFIUWHNkN+vmg0w/dmHbc1d6ysDSgpPjW0SteUCsxvvqWLi+vrFW1PHCavMfj9r2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZSKiJYo; arc=none smtp.client-ip=74.125.229.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZSKiJYo"
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e59607d38so166219eec.0
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790315633; x=1790920433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Vi3IxgwSsOevvydlu8/IZa5og6w6hJIIh0I+gaTv90=;
        b=bZSKiJYoMTwJhrmGWV25DYu8UWBo0uoKrVYo1wzFdMiHO4utqa3RE8NNMZQba59Hy5
         eDL5dvbsGNrdLFRpNvmUJvZBTerGf+6yrOapfQkBANbuhJvJgfwPkNnndKtcdMHK+PnY
         es5mG93GCqslMLWD29snrpzmVTKg2R1sFhzbgkLu0gzpx5gjR7/eovqc04NabeWcC0c8
         uVxxiYlkhnqMpKUKlAS//mDU/dotU37vJ2Rc8I4K30N/fVyllPyPq2cLZe59B1ljXkO4
         mSn0JzoZvevMgj1k60nwXDu6mD0KnoWZm7xpeypWM+iw9934BQ3jaPB234gXywijQQkh
         7AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790315633; x=1790920433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Vi3IxgwSsOevvydlu8/IZa5og6w6hJIIh0I+gaTv90=;
        b=p+wJpKoEfEqKZ81py7sFyWJGhtJTedbdofNlu1a+FuIqDvPMfuUVlbIUzi+Kg2ZEGT
         auMDEBZiM4OjB9xSwuCo4L9SOYoDywrgQ77JgWmjDqptn4xEBF4/121JcPVBQq7yfT31
         U/2ggEiOSaTizkmQrZnfORCc1XFSCH9t3HSW7FYT37OD4OWMc9e4XwYAO/ogUw6fyRXH
         aoJGMIGp9c9JoMWMsFeDNPyojhuybIExMYNT79ZNVQ4ixNtuicRDVKuATp3z3Zfn6CQ+
         3/Gxm1f0PDN0mZi1b3akL/aqGLmmmyCcQ/ump/tefvjD+f4uY6jQEK1pgKMyRRfpGpgG
         5UeA==
X-Gm-Message-State: AFuF++lL9lyuDEYG+YKrm9CvAvmTqrFmqBd0SXHizVhWDxBr+ZVr8BI0
	nu916kdTYAh9reUTEm0hlCkiVUDsUsvtpjUz7Lt4HA19QCCJ2j4MXz1d
X-Gm-Gg: AYBFou3OxAQPn8O/gk/ccmTs9aoiQWmrsJzfQm0o/peAXI9PvIAMeVG+3udeOy4+9gn
	3VI8QZpnRIUQZZy6sd3hTOkfnKYE4wy8bMaNE7W4FY4S3xXxMGWD/CotSyTzlq5feodhsFR4CUQ
	Zs8WLPB42M0H/NJh9263LRoN/caVb5p7Qg0jPry15OLYITleBU+HxkkpbpFVcV2TEqSLsQwSbVq
	vQcWS9rPVQRZgzkmOyiAkn2PXMagB3rPltAA5Y9TmIdzgRDWRDlp5akLjxIMkQDpC7P7T27LMv1
	wF7K4iZFTc8ErCBqdE+61IiBVhIJFEjbQxtNU7EUufhEQ81V7EVwsn2PnB0DB3ziBNB4NT5Odig
	ocad9xfVzX08gbkI9x9s7XMDhFkguJS0TCtbYg9gvdmMZHzn6mfvjXoPA8tUmqTRYSVk7WOCwGh
	SY7ittWpON7YqlCMlaeSw938yPaHrkRWF8x6Ce80YXwImtELFsAUr25aF2bm54UagWsi5J61Lyq
	1/dUW1w/foSxKi16j4DmR7YUAiKFdjMmT227llUhaSbWMj13pNe
X-Received: by 2002:a05:7301:6197:10b0:33c:2308:c0af with SMTP id 5a478bee46e88-340048961afmr3706889eec.17.1790315632351;
        Thu, 24 Sep 2026 22:53:52 -0700 (PDT)
Received: from Raccoon ([113.30.177.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407ea69sm3628692eec.7.2026.09.24.22.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 22:53:51 -0700 (PDT)
From: Rohinthan P <rokinthanp03@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ae7f998154426e723cbf@syzkaller.appspotmail.com
Subject: [PATCH] HID: wacom: check for NULL pad_input before reporting pad events
Date: Fri, 25 Sep 2026 11:23:46 +0530
Message-ID: <20260925055346.19890-1-rokinthanp03@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Wacom device interface does not have pad capabilities (for
example, when wacom_setup_pad_input_capabilities() returns an error
or the interface is configured as pen-only), wacom_wac->pad_input is
set to NULL.

If incoming HID reports contain pad packets (such as
WACOM_REPORT_INTUOSPAD, WACOM_REPORT_INTUOS5PAD, or
WACOM_REPORT_CINTIQPAD), wacom_intuos_pad() assigns
input = wacom->pad_input and proceeds without verifying that input is
non-NULL. It calls wacom_report_numbered_buttons(input, ...), which
dereferences input via input_get_drvdata(input), triggering a general
protection fault / NULL pointer dereference:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000006c: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
  RIP: 0010:dev_get_drvdata include/linux/device.h:991 [inline]
  RIP: 0010:input_get_drvdata include/linux/input.h:396 [inline]
  RIP: 0010:wacom_report_numbered_buttons+0x37/0x210 drivers/hid/wacom_wac.c:4225
  Call Trace:
   <TASK>
   wacom_intuos_pad drivers/hid/wacom_wac.c:643 [inline]
   wacom_intuos_irq+0x2f8/0x3430 drivers/hid/wacom_wac.c:1042
   wacom_bpt_irq drivers/hid/wacom_wac.c:3290 [inline]
   wacom_wac_irq+0x196b/0xab80 drivers/hid/wacom_wac.c:3560
   wacom_raw_event+0x6bb/0xba0 drivers/hid/wacom_sys.c:183

Add checks to verify that pad_input / input_dev is not NULL in
wacom_intuos_pad(), wacom_report_numbered_buttons(),
wacom_intuos_pro2_bt_pad(), and wacom_intuos_gen3_bt_pad(). In addition,
in wacom_intuos_irq(), return immediately if the packet is a pad report
to prevent pad packets from erroneously falling through to pen event
handling routines when pad_input is not allocated.

Fixes: 49005b9fd052 ("HID: wacom: Refactor button-to-key translation into function")
Reported-by: syzbot+ae7f998154426e723cbf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ae7f998154426e723cbf
Signed-off-by: Rohinthan P <rokinthanp03@gmail.com>
---
 drivers/hid/wacom_wac.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index af76e49..6a13724 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -529,6 +529,9 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	      data[0] == WACOM_REPORT_CINTIQPAD))
 		return 0;
 
+	if (!input)
+		return 0;
+
 	if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
 		buttons = (data[3] << 1) | (data[2] & 0x01);
 		ring1 = data[1];
@@ -1039,9 +1042,10 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	}
 
 	/* process pad events */
-	result = wacom_intuos_pad(wacom);
-	if (result)
-		return result;
+	if (data[0] == WACOM_REPORT_INTUOSPAD ||
+	    data[0] == WACOM_REPORT_INTUOS5PAD ||
+	    data[0] == WACOM_REPORT_CINTIQPAD)
+		return wacom_intuos_pad(wacom);
 
 	/* process in/out prox events */
 	result = wacom_intuos_inout(wacom);
@@ -1475,12 +1479,17 @@ static void wacom_intuos_pro2_bt_pad(struct wacom_wac *wacom)
 	struct input_dev *pad_input = wacom->pad_input;
 	unsigned char *data = wacom->data;
 	int nbuttons = wacom->features.numbered_buttons;
+	int expresskeys, center, ring;
+	bool ringstatus, prox;
+
+	if (!pad_input)
+		return;
 
-	int expresskeys = data[282];
-	int center = (data[281] & 0x40) >> 6;
-	int ring = data[285] & 0x7F;
-	bool ringstatus = data[285] & 0x80;
-	bool prox = expresskeys || center || ringstatus;
+	expresskeys = data[282];
+	center = (data[281] & 0x40) >> 6;
+	ring = data[285] & 0x7F;
+	ringstatus = data[285] & 0x80;
+	prox = expresskeys || center || ringstatus;
 
 	/* Fix touchring data: userspace expects 0 at left and increasing clockwise */
 	ring = 71 - ring;
@@ -1515,8 +1524,12 @@ static void wacom_intuos_gen3_bt_pad(struct wacom_wac *wacom)
 {
 	struct input_dev *pad_input = wacom->pad_input;
 	unsigned char *data = wacom->data;
+	int buttons;
 
-	int buttons = data[44];
+	if (!pad_input)
+		return;
+
+	buttons = data[44];
 
 	wacom_report_numbered_buttons(pad_input, 4, buttons);
 
@@ -4220,9 +4233,14 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask)
 {
-	struct wacom *wacom = input_get_drvdata(input_dev);
+	struct wacom *wacom;
 	int i;
 
+	if (!input_dev)
+		return;
+
+	wacom = input_get_drvdata(input_dev);
+
 	for (i = 0; i < wacom->led.count; i++)
 		wacom_update_led(wacom,  button_count, mask, i);
 
-- 
2.53.0

