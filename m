Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46109DF6C
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784439699; cv=none; b=cCRzIMDG4LLdDGGSGbnB7gq5VX23rydnQoVsu5i/yZuMFSV8M/w1O05PUgXueDVkD04nyGRQNVYl3PfGjZ47+JFWL/067MIkdBDzx6Od7f/7zJPTIQqYMrEE/0yPmihMNd2a0lpGUO9tZotqYKr7MR0YQqS/Da/0suPiCSV1MA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784439699; c=relaxed/simple;
	bh=/lyz4bNvDYiehjq9IwxaCtkc101MYGswjnK9d28IIqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJozZZ+mVZV7JQ63mOG4xUZRz0c+vjUTYQtgdlhWLji41rChbi7drymiJEEykRIlKKa4xtVkUOpYr5759Xgo7gOtlFOapVslbJWBGLjkrCsOoPyC5IqaI0pQMK9NDSnnULoqNegFxb9kDlEgsv6wa1N5ENH9kV2KEhwQmXd26jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5beXsUf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5beXsUf"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423f236418so4581151b3a.1
        for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 22:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784439697; x=1785044497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dwbFx0tij0m1EPEdHTcGHLdglrqXjXtpHL1LFxxMN4I=;
        b=X5beXsUfv4UY0r+o3fFf3V7E2GV2jyS7Ce3tq/Lk6vYLNVoH/IhjxPo8/nitKUySAJ
         UGawXW0Bppq7Xhuc2Rt4sPih3LxGiptPA2Zapv8TMWmg7TaBAR7ULon1GlmrtzOzt95p
         LFW22ntOnOpXTFsQETr4UM5Cvn6Pp/B4lO+S0uZgxE9egCXC40CjzlK43DYENe6n7lia
         QUJKSnxhSUpQveVFUOI+oB2JFNNTL0shySMwM2Ov1siFoRiFtZ/tvg9GytIqj+HWWMuW
         Y4mFlbSVGlQtf6WfQ80Uk5ZkA8InqQkKIpwp0NDSoc/tzw9eoxYSf6TjsOBsDdmKdu0x
         cl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784439697; x=1785044497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dwbFx0tij0m1EPEdHTcGHLdglrqXjXtpHL1LFxxMN4I=;
        b=euvPmFHpQ8BGuEz8a/HVwMI0t1Ww7H0xHM9VAy2s7G9akQ5uBPsFuTbZHlnmuKDHEr
         qHXP24Z7OXOqwlI/FTT2NInUa6lUS0U5Qkdc+OFZ1dlqoscRP9+FWuNzjn1dbhTYTcFg
         YlVpNU7/TW+Ty2c3UiNF6HL7iV8o4H2O0Cdfxnea4s7PtaLBrsoewO7W3l11bSbZU/sK
         WahNil0StZCY2uD+yU8ULdxnhZNuJSPU3omfpx0F2N595E1/Tc0ktp7MGvluVsiEe/lU
         Rm++dHpAO8QNyf6kPFaYjL8bd9WMi11UXuILT1TNDgUmd/kwbQeOE7ebVcNYxjND+cj6
         8WGw==
X-Gm-Message-State: AOJu0YzXtqbKB+FSOC+YCGpQ/CdMkEuXSqhDjEEi++2HApoXwiYzgHpf
	ys6kcX03uKcZDBT5TQXu2jmOJrL7u2Cao8+bku1GgTvsAn9+HjCYHKwW0TZoyZ9Z
X-Gm-Gg: AfdE7cnY7QhLKJq/fN8rhVM/37LUaHRoqaCIfXJ5tOg06VINy+pBgxMEj6ATWT2WrG0
	TCSVABOZkVRWL5vzcVqdcS+RFwLfRnV3sk5A8N+UzZqlpQNmckv7TUg+Yyb0WIBBhxpuvRy/FNa
	yJQ15vg4u9vn4E/TTYtilGhdpKtQEH7c59Zxyk+NErIznBqEyGJ2aOp+2FPLDaJ0ACEj3YcH777
	v4s81TEHFxX6RG+qNghcIIUw/+yxw+NEnAz+Ns5DE7AxneSZoyTnnh4cYptnBJkC0KGXfRe045V
	3tOWrK3wE82otuG37ZWHnRWUg7gP2LF7HY0VuG05QYmknlmstimZaX4QwF5s20MLfoucodb1qAO
	N2QEieZ+0STqGkI1pMEGQgHebA7FDF6TsFoYRzg6SWENseUiOuRCywhZTqqVqB6z+XyFIC17nPH
	Yb213zKBUAx0GPvOUZtoSZQ0lfLeM=
X-Received: by 2002:a05:6a20:3946:b0:3c0:9c19:b27a with SMTP id adf61e73a8af0-3c3adb17968mr8707454637.72.1784439697415;
        Sat, 18 Jul 2026 22:41:37 -0700 (PDT)
Received: from ubuntu.localdomain ([49.43.243.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dd90fsm22801211eec.22.2026.07.18.22.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 22:41:37 -0700 (PDT)
From: Bivash Kumar Singh <bivashraj750@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Bivash Kumar Singh <bivashraj750@gmail.com>
Subject: [PATCH v2] Input: gunze: replace deprecated APIs and fix warning style
Date: Sun, 19 Jul 2026 11:11:21 +0530
Message-ID: <20260719054121.5917-1-bivashraj750@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718190040.10613-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace two uses of simple_strtoul() with kstrtoul() as the former
is deprecated. kstrtoul() also properly handles parse errors, so
add an early return if parsing fails.

Replace printk(KERN_WARNING) with dev_warn() using the serio device,
which is the correct logging style for driver code and removes the
redundant 'gunze.c:' filename prefix.

Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>
---
 drivers/input/touchscreen/gunze.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 2baeb4f3b941..e9c028430420 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -41,15 +41,24 @@ struct gunze {
 static void gunze_process_packet(struct gunze *gunze)
 {
 	struct input_dev *dev = gunze->dev;
+	char buf[GUNZE_MAX_LENGTH + 1];
+	unsigned long x, y;
 
 	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
 		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
-		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
+		dev_warn(&gunze->serio->dev, "bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
 		return;
 	}
 
-	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
-	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NULL, 10));
+	memcpy(buf, gunze->data, GUNZE_MAX_LENGTH);
+	buf[5] = '\0';		/*NULL-terminate X portion: "1234\0" */
+	buf[GUNZE_MAX_LENGTH] = '\0';	/*NULL-terminate Y portion */
+
+	if (kstrtoul(buf + 1, 10, &x) || kstrtoul(buf + 6, 10, &y))
+		return;
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, 1024 - y);
 	input_report_key(dev, BTN_TOUCH, gunze->data[0] == 'T');
 	input_sync(dev);
 }
-- 
2.53.0

