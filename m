Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAD3BB115
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101841; cv=none; b=HjW+GViwJmrx8tUKrGAObPtDkyJY9Z0ON0trY0Qs5+HzJqOWi09qi7zDDrIzvsY3OWRr7eMYfCsYekoMMlxlqci9ZCa0zYnWrMy4Pg3yoOCiHA8BEsFOQIbYpgUFy72swgfg9blFj84V1iY4al2P4GfqCA+NzvqYsuYRNjq6mrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101841; c=relaxed/simple;
	bh=b1F0QGdcNcKqjBmJqPYaGuRqoPzwEbKHfEf64wpPqLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcSu6gDihhL4tsZLEZ1qQ+yqJYubVWpbVCZHQlvb/Dbj/YLUHo2+MaLR1ahSwXp2sHMDtsgk3g574oEGJ4IunbjdQmkk2avjbuquA3oiFt2Km1eLhNIZvQrpHaJUAB3j8D4smRaP2obnwLBVVoS0vQkhceYnlE/j2fq2ABVLUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xghm78Ci; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xghm78Ci"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso2264756a12.1
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788101840; x=1788706640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ia2lwM8sH8Xra67OChYDjtdRyZ6AcvO2JIxbnOb99b4=;
        b=Xghm78Ci3qo7kzjWYs0B91LTgEo0GhheRNJYGNGAZG8kHIOen4ku5zXU7l+FBcarGM
         cGZUBZOsDupgwQAeNpod5uaxMOaLI0syks5A5vohJ0McDlvzhwjLrnxTgpDYyku2LUFO
         rjf6yz1luOaMQ3xaJNr+SOHFeqAAjUA6orJozW+8MC2MGM9UHIvGXj2qLQ2eoA2gGfgc
         /DweK3wOuHd/7KR0zUYPviFcOGY3XNLP2dL2jh2npIDW98P4lUQqjILEl3UkYRZlq4In
         T6DAUdYeOzobuvf7m1o3gMYwdRWPYHeykCvX/EiE4GSSr9NJvKTDKzGmWw7di4CMSiX+
         AfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788101840; x=1788706640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ia2lwM8sH8Xra67OChYDjtdRyZ6AcvO2JIxbnOb99b4=;
        b=nHtWTix6tjDZ5bqQMXb+4ZM4pQMxwHzdMTETvQlTpYf9dBUhcB7wpHOsKJRoKbZnly
         Xywvp4oauocylfhorxg2yBsk8vLOYjqpAZFiGwmUAZRG42q4bfYor1akcEGe7JDuCkN6
         UF7vtQZVnJ1FwbB+l+VdYqeLbbdETKmkMZ/b8z/6Muxs78FwztGD/u9F6wilT1DGu/uW
         vltHJpyZkjz7bx+TCFJn93GJf3SMF6oackx9acWmQXNxYuwQ7r9XSuE8oLS0fBmzi1d2
         h+PjWIfx97GH9oTpZLgROlUCpxJPpJ+TryUyEImxh8+T0/BGJBVlLWd1DatKc3bgF5L4
         dMkA==
X-Gm-Message-State: AFuF++nLXCW8FotHDRSpcoJk9Cg6cfviscqiedBCUy60LZxsS8zE6Zuw
	kiRpECeoQyQfBXa3QHao2Gr7CA2w4GoiGDLbXQ3dnjutcCTGy6BZ8sO7
X-Gm-Gg: AR+sD13gbFVjx9zOyzQdF+orz42uY73dfnB5IY4KuJYxyiZRN9mEOKZHVt9Bwbtdp7j
	aqfMb8PFRGKANQQEvMXG9Joe0XKKO9/1fIlN7UvhLtgx+ahwTgrt3ECanPKiHWa8ll/kwLbEX6j
	ZMl4APF7d6jdFBo/SaAFZ8NPgNrbzbyip7FCXjCP+tGvh3abbdn3TiwsYQhP9H1vDNxsKfL6U/d
	yUg+INDQ2W5azAP+YPDu8dA5+7Lw2gE9VJViWk7giPCd4k4OMtovF1GaOfnw2Tef5eilPFADV4T
	Mqm7AKOnQWw/KcVDPbKGWho8r65jdNb79B7tS8wDc0sxbfAExkNGpLMoTtNuqty6T8wjalbArLY
	/+JfuIWJ5Zk909sstRsYnh9++r6Hj6coNdqVpXpGBBeDZKg9yY32HUVo/ukuoR81opgzhcXZ/2f
	s1PNelWcbrS14X7+LHI/dyGwbPUx98DpOXmQ4H8ymMRVqbDkwNizJ4l0QFZSL+HnExO9Z6DaLVT
	ThIFeUhtngK905w25o=
X-Received: by 2002:a05:6a20:9151:b0:3c0:b943:f984 with SMTP id adf61e73a8af0-3d2658376f7mr29403739637.3.1788101840016;
        Sun, 30 Aug 2026 07:57:20 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm23198024eec.15.2026.08.30.07.57.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 07:57:19 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] HID: hid-lenovo-go: normalize calibration failure status
Date: Sun, 30 Aug 2026 20:26:56 +0530
Message-ID: <c7b6d167fae5846377d49b57b0f542063fd80ad1.1788096668.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788096666.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver stores the firmware result byte as an index into the
calibration status text. A Legion Go 1 returned 0x08 after an idle Stop.
The status table has only three entries, so a later read returns -EINVAL.

Keep the defined values 0x00 through 0x02. Treat larger result values as
failure before storing them.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index dbfacbb70394..c7a2e621a4ad 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -648,17 +648,22 @@ static int hid_go_light_event(struct command_report *cmd_rep)
 
 static int hid_go_device_status_event(struct command_report *cmd_rep)
 {
+	u8 status = cmd_rep->data[1];
+
+	if (status > CAL_STAT_FAILURE)
+		status = CAL_STAT_FAILURE;
+
 	switch (cmd_rep->device_type) {
 	case LEFT_CONTROLLER:
 		switch (cmd_rep->data[0]) {
 		case CALDEV_GYROSCOPE:
-			drvdata.gp_left_gyro_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_gyro_cal_status = status;
 			return 0;
 		case CALDEV_JOYSTICK:
-			drvdata.gp_left_joy_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_joy_cal_status = status;
 			return 0;
 		case CALDEV_TRIGGER:
-			drvdata.gp_left_trigg_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_trigg_cal_status = status;
 			return 0;
 		default:
 			return -EINVAL;
@@ -667,13 +672,13 @@ static int hid_go_device_status_event(struct command_report *cmd_rep)
 	case RIGHT_CONTROLLER:
 		switch (cmd_rep->data[0]) {
 		case CALDEV_GYROSCOPE:
-			drvdata.gp_right_gyro_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_gyro_cal_status = status;
 			return 0;
 		case CALDEV_JOYSTICK:
-			drvdata.gp_right_joy_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_joy_cal_status = status;
 			return 0;
 		case CALDEV_TRIGGER:
-			drvdata.gp_right_trigg_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_trigg_cal_status = status;
 			return 0;
 		default:
 			return -EINVAL;
-- 
2.55.0

