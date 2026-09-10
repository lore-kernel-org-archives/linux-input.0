Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3309C4CCDE3
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057419; cv=none; b=tf+26Fpl4CRRJE+i2BuOAqkEO9CJClvRrBvI8NN2ElpBLNwclpnoIc06gay3Ja2w3T5aIlSllnHb5RfMgoYDHgP73JLdboyLFI8UBWEBUqK2kWwFIxt8PiB3EhCDIEaPkpq1CMM1AIMzAOq5W5q9JPAPkJH1gtdKR5weeA2LNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057419; c=relaxed/simple;
	bh=kjpF59fe4ubdCkFvENJAVeCWzv0Fgh94P0CK6dGCBfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqi9Xv+h8ePX0VfTWkG7LADiKNjsMF9wKTTSfnELWL+9cb5dKQQ1CEQpO6yAcIsfL4E7kViPfmNbmadgaqoLJEYGZS35LOefJDmUE7/SBnAOy8ybCJYtVkeqHm74OSO2ecf1JhPDkkoVBx+eZqF9Tgw82jNBsihqzNXgST0I71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7v+Z2n1; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7v+Z2n1"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e2540eso1113794b3a.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789057418; x=1789662218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ERs0ZBdo2a6X8YAmXloXdwhR0inMOSFiQbLLSRZtan0=;
        b=Q7v+Z2n17/VJ/L+PXGe7WlkcqwxZOQsbW431z/jVXAwY/ngB4i1vRxb8qg1jmd/dX3
         O9wNoHnoprUCUvLxMuv3pWQ+aq+2QhjYHQWCeovs5Db7px2eAFY2i0jTlADR1LmF21aM
         ERCHxtffTpphvgMRw82QkrGSps7QuGV/v96Iprq9hMVbilj6CYVr7XXPD4IURvW+Tc1c
         sGc3R3paHUVjmT+ka6YKddie6xBBP7DizAb4ZMSVHPyLson7Wzh4ecjguMNJgWgAK0Uk
         6tDccap6g7QLvpmymsr6kJy0ctbNObL1Rwsz1ICDhI5QocbZ3HngckeY51gJPOBfWdET
         txkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057418; x=1789662218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ERs0ZBdo2a6X8YAmXloXdwhR0inMOSFiQbLLSRZtan0=;
        b=JUOMm/1969m1Uzfd0Y/pv5t+ku1ERpJ4cmLPtXLawtjUnTj5K7MV7M5K7bDofKsEU+
         wfl5fIn3yhbQrEd2ST6x8xPvpggtpKJ7NmD63L202N8hIPytl1BMM/k2ior+ow1+jP0T
         +trUHNeeAA7plIGsiB2HDGJlYX23JgQPwqKJ5EH1Edr7/32SS+UmZue3k6auVfSkMAll
         zuvSLxpBc7JIX1S9FhmhmuQxMlR34geNaAATZ3/DEp09nckOmhjs6DI5AsFPS7SCKlMu
         etOdxamA1Q89HvYUMjUq91XqFSZ9bnqmVNoI+PBboY9mQRq6ga6wi9VmhsF56mwZ34Pj
         9byw==
X-Gm-Message-State: AFuF++k5dRHd9py1A1Mp6iy+7+o4c2+fpRwGF3PupDuaueG6M/I72Di4
	4jlmdXQSwPS9CHVv5djbpvdLUwah9lXTowmsaabhRjdiQK849/k25Jf/
X-Gm-Gg: AYBFou3qarhVDnjcSjhPk3wspRrF0iINiSMZK5uEtw2GPK3xI79KDSEMGVFQj+J1CRH
	WgCW+eyr6cFqBBYn5fh4amv4RNEkg/JwSgwA8Te0muLcKuqemz4QY09PEhKlPX5GOeoCCpkQJMD
	e2jmP6K5321SiDEmJLqw5PgmXyg12eSMwTd8wEanT+6BWwrDGYuPPbN04PNRCwDvQ5+Y9haACki
	1htMK6mFxAYfFQFmWFwDaJm9ET7UlzS5kCKjulzbej10AW41p9fM6pGissHDNFhNtN9bbTFTA4U
	+5FIohDK6C1skvg2bmMvxROMgYF4J0/6xBZG5iQK8+I4vdwKaX+x74Qe0HHFe5rkN0EY/K0qXBt
	gfKejZ+PzOEk9fFinyoSTA35hrYPo0gkX0kHjbNNddR19Ty+3KfJm4Rinf0TEcRkJGPPHs8LlSb
	5fJxLOxJUrbggDtZvcGIseoa1PCqpDgeBZUFRhINZQbAiLreXPWVGiCD1HUwJFCeoqcW+XIE7ws
	AazeH3XBsTAqAcLt1c=
X-Received: by 2002:a05:6a00:80f:b0:857:7384:b5f7 with SMTP id d2e1a72fcca58-8694801d67bmr8118952b3a.19.1789057417450;
        Thu, 10 Sep 2026 09:23:37 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:ced9:ef96:e152:2608])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86343e6dae6sm6895066b3a.11.2026.09.10.09.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:23:37 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+093e05755c2d99caab91@syzkaller.appspotmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	sashiko-bot@kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v2] HID: multitouch: use GFP_ATOMIC for report/application allocations
Date: Thu, 10 Sep 2026 23:23:31 +0700
Message-ID: <20260910162331.31578-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910155305.58E4A1F000FF@smtp.kernel.org>
References: <20260910155305.58E4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_allocate_report_data() and mt_allocate_application() devm_kzalloc()
with GFP_KERNEL, but they are reachable from mt_event()/mt_report()
via hid_report_raw_event(), which can run in (soft)irq context off a
USB URB completion (e.g. dummy_hcd's hrtimer softirq). GFP_KERNEL
there may call into fs_reclaim, which lockdep flags as an
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} use of fs_reclaim,
alongside a "sleeping function called from invalid context" splat.

Switch both to GFP_ATOMIC since neither is on a path that needs to
sleep. mt_allocate_usage() is left at GFP_KERNEL: it is only reached
from mt_touch_input_mapping(), which runs at probe time (hid_hw_start()),
never from mt_event(), so it does not need the downgrade.

Reported-by: syzbot+093e05755c2d99caab91@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093e05755c2d99caab91
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v2:
- Keep mt_allocate_usage() at GFP_KERNEL. It is only reached from
  mt_touch_input_mapping(), at probe time, never from mt_event(), so
  the GFP_ATOMIC downgrade there was unnecessary.
  (feedback from sashiko-bot)
---
 drivers/hid/hid-multitouch.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 2c41bacab1ca..9b78f8f23fcf 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -604,6 +604,7 @@ static struct mt_usages *mt_allocate_usage(struct hid_device *hdev,
 {
 	struct mt_usages *usage;
 
+	/* only called from mt_touch_input_mapping(), at probe time */
 	usage = devm_kzalloc(&hdev->dev, sizeof(*usage), GFP_KERNEL);
 	if (!usage)
 		return NULL;
@@ -633,8 +634,9 @@ static struct mt_application *mt_allocate_application(struct mt_device *td,
 	unsigned int application = report->application;
 	struct mt_application *mt_application;
 
+	/* may run from hid_report_raw_event() in (soft)irq context */
 	mt_application = devm_kzalloc(&td->hdev->dev, sizeof(*mt_application),
-				      GFP_KERNEL);
+				      GFP_ATOMIC);
 	if (!mt_application)
 		return NULL;
 
@@ -692,7 +694,8 @@ static struct mt_report_data *mt_allocate_report_data(struct mt_device *td,
 	struct hid_field *field;
 	int r, n;
 
-	rdata = devm_kzalloc(&td->hdev->dev, sizeof(*rdata), GFP_KERNEL);
+	/* may run from hid_report_raw_event() in (soft)irq context */
+	rdata = devm_kzalloc(&td->hdev->dev, sizeof(*rdata), GFP_ATOMIC);
 	if (!rdata)
 		return NULL;
 
-- 
2.43.0

