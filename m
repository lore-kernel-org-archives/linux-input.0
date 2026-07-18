Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C232FA30
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401293; cv=none; b=f4f6VQ9JyK9A+1pk/bPetRFkiGaS0gG52PWfg6tWnx5V7c6MQp95CQwHK7NvVmSi21Og+59OqQAAPUlZpZgjDYb8S0pTVwpszks8s3GWKe2yPmFIavmV7mpKVlMpAkzmGzZNZ8sAFSRnOiKQGspheOwEptZXLf0fBwZKAILVWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401293; c=relaxed/simple;
	bh=1O/nO5nDn1eCPTImqeOYZsAwBJiQGVLCGmgejk1P8rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJOrGKzSKD5q7gCBOM1+BPJ+w0kLbxSabt0PDOJJnhYDYcdUCjOl4Ddy5BT4fyXslV6UgIxzxp9F7t01V3dmUGMq1/stFshv2aXRS5rGD5XvUYu2AngKzeKyOngqzk4Hpn0CBX/3VLTdEz7JbWDcCqY7ONd23i1WxnQsHpY+Pio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2ujbCzY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2ujbCzY"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so3279414a12.3
        for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784401292; x=1785006092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBTXZ/oF5RrKnMHUw1UdjpAZc/QLgvk0CAMv9ZG/8QI=;
        b=p2ujbCzYWRTMiD3qwpg8C5d20buO5t/jcpVxqUczrMfG94N0Nk6N1WoechEGrPMUZi
         548MvKb+/P6JQ9rSmLyr5LRm/JLoveqhMhSqE4i07Uvj6vwfh4vzNZem/C5KvDaXUvKi
         RoapnXkJ9S2lVL+Nj1+0rKJzerj7QXlDJ7Hq+6Muufjd2m9X9I6SD2bbywI5jnyZ8NGO
         ots0p5i6b1OPoth1e6+jTToeqM5CLBMPpWRgM+yfOGkRzeyK+qcIj9x3m1HmnEJ+FHml
         2RtXlGcHdQ8aUD01fdpopfXIyjz0k2k/SHBN+2bmISop2Lp8j+xZ6Gp7gWrhjPVza98P
         QkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784401292; x=1785006092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBTXZ/oF5RrKnMHUw1UdjpAZc/QLgvk0CAMv9ZG/8QI=;
        b=bn6pmoy7yKJfJNvuogBuvabWc99Nd9XDIUcMlXlyc4W8XrbhnvNUFNoSG11d2HiSjI
         hISlX9Wndke4846GksqrBMdZwlWVdJ/9NelWICEgawyFKnBHurOpvx7s4+uDrw7BUUCX
         h1QwfynB7y/09/G9weo+oOlMjkZvjFZ6TdaMWK82VH+wCnjWDPZBGtVsVc656GUDoYz7
         /Vd8uyU/i3D5u/3dfnob8fr3neiB0ZrFHs+aB60nWhR3d8e2F++mALVfGy17IocHYO7M
         gQPHW/YJ05yvogiHKGDFgyCGdHF7an7KxKMJbbZt+EcRr9eN6Yu8VS6GA/npUckFOM4m
         aMrg==
X-Gm-Message-State: AOJu0Yyv0BBgx8aCLrTz4BsObGRKuajukd/fuIK5y6252IlSiwZehHWm
	4zNeNlvVDlyXIpQyV3Tboyhaf0/jYVuWsMJC2yLsO+q+5kVLMtr3W5sJPiRk0Rtl
X-Gm-Gg: AfdE7ck5O8ILKu09QBLnlkoU5SQsvL9DPEMPi3m+gnl3kuIssB+m8Z1R1otDv/j8hfq
	EQW4OKslACt2HMhVLU/udW2VwxTFi2c0Q27vfCp/bNVMTc5W5SXixKVVPve3Yk11cFzK6AqEK0D
	D/Gquo6PfLY4LkqpEE2DAFdkWG5MeDo9CuW2MfSbn+OpBXe1xHDwlmEddtXttUtm1kffO1NuJsE
	6kA1XSyxZkV/O/nyWbpVDdVaDR+W3+EhTuJDUQ3B1Oa6mAiCVri1MfsnaIvEkykX4Lwrf5r+fWX
	mQmGCiF7rIl2rt3n1rrCJNz3vk/SzQIy6xfikiRX8hKv1Tf9Cu6yw7OMRhB3KXEIG0RRnUD6JQa
	cpnx8AWuaL+ypJGowUtVUBHdQNdVv9cEeFLmsrR9DRtTVdYB+76dWRfUAaXuIfOxiclcp728beP
	YkYkwH+eT7o/kE9gAhyfyXnRieH0M=
X-Received: by 2002:a17:90b:2f4b:b0:37f:9cdf:f03e with SMTP id 98e67ed59e1d1-38e4b540acbmr8552698a91.33.1784401291676;
        Sat, 18 Jul 2026 12:01:31 -0700 (PDT)
Received: from ubuntu.localdomain ([49.43.243.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdbd45sm19806998eec.12.2026.07.18.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 12:01:30 -0700 (PDT)
From: Bivash Kumar Singh <bivashraj750@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Bivash Kumar Singh <bivashraj750@gmail.com>
Subject: [PATCH] Input: gunze: replace deprecated APIs and fix warning style
Date: Sun, 19 Jul 2026 00:30:40 +0530
Message-ID: <20260718190040.10613-1-bivashraj750@gmail.com>
X-Mailer: git-send-email 2.53.0
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
 drivers/input/touchscreen/gunze.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 2baeb4f3b941..38450cabdd11 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -41,15 +41,19 @@ struct gunze {
 static void gunze_process_packet(struct gunze *gunze)
 {
 	struct input_dev *dev = gunze->dev;
+	unsigned long x, y;
 
 	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
 		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
-		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
+		dev_warn(&gunze->serio->dev, "bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
 		return;
 	}
 
-	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
-	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NULL, 10));
+	if (kstrtoul(gunze->data + 1, 10, &x) || kstrtoul(gunze->data + 6, 10, &y))
+		return;
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, 1024 - y);
 	input_report_key(dev, BTN_TOUCH, gunze->data[0] == 'T');
 	input_sync(dev);
 }
-- 
2.53.0

