Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FF4A9D60
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054674; cv=none; b=OxKrU6yLoggGnQBcW77vDI8lA+Re69spvciDndPpjbv9uKIRln+iCXUubT2XFvR0DDaiIv7QoGpvTp1GTBCen2vyl5P1NuABo1fdnKER8QXDz9yT5kg6pyQOoxlyM7jCzKbzW9YRXXmgEVOMA0ktQsENkNofrYm2PNlhYJLHyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054674; c=relaxed/simple;
	bh=HQijiPlwvDLFO+zIPNo2HBbu3dtpiVeMOBm/adtycNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9cahnvcw+L2ahDWmrpDX4mt/nCScdr77YGJJ3zFfNVF8AA8NnljihBJdTK2M9QIvxSjodIGVXvsI0dz1CbgNwQSk03kYvmjAdwmzTGAzAFyP6TWLogltC0d5lYVwrtvlnoNuS/+J6q+USIJBfFOrjOMWOLE8AjLaJbBt+FrKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec/3s7um; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec/3s7um"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb750so2387948a91.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789054672; x=1789659472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xf27/e13zSRzdWtLn2ZnVwbWOxwXcFNzloo83ia2tDo=;
        b=Ec/3s7um9niKH4ZQGpW77I0l8Wi0ooJnlbA9vQrVM2jtjZ0TNh5ZK2Cv1Z+ErO4IP3
         x8wPBynl1Te1Lul1+svaOTFxXokMbRiTwz7LCEmdNXKjSE1d4KBWKAIzc+9Fte6yU+Zg
         KLR3PcgnPR7NVqsHoG7GJtU/829CPN0q3ThDxFProQIKU8jDf0RSEI/zvboSdrWz8/9K
         77R914K5mvYiwewaT2GXaABu3wA7DTAu1UXLnLTEiqwvq+TixaQz2MrwFEhU5cjb29AO
         kh1GBNotoImdhEHDXiHKxe9R+TqQliIPLQg69VJvSJsOenwuacRc/UzNMtWpejDJx9TG
         YLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054672; x=1789659472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xf27/e13zSRzdWtLn2ZnVwbWOxwXcFNzloo83ia2tDo=;
        b=GmRiPOZUXBMO330ot6/MgV1grogWeBMCLQQucJiUAE9KkJmZq4sJLB2Lj+MX6tm48r
         UOT3ukRiZGs++NnUiGUr3ZoxtTxcXHbfPuTGWNNg3XXeEFkwq1B3kNM0h+PP6jVV4j7E
         UKZQMy53eDOZE+HP8J3o4fotKpwmOEC1YZdL9KUq7vxKP1pIiEhROflxLIdXKqn+XACs
         SQfDN0hjESOjLx6ZJWozzu66UV3qM6vLQs4LLi8tAuZ1rBQmoHpIO6BqODP4G/BHAmRt
         C9G7pHm24SD7jllIcxWYf2GUSyi5yCNINWX+y0cKJRY2M46iY0yeV4H0i9U9yVZT6IOW
         YcZg==
X-Gm-Message-State: AFuF++l3Je4UBTENO8nvJ3quwwSyoZ3d1JmDrHuHTXwY3PwwlPF0sLyY
	+YJnv//ceSnTHhUKEzairqT9pdlMd7G6ATgN0qyKM0Z84yW0pePWBtdIr2YqcA==
X-Gm-Gg: AYBFou1t0K26E9CA8T9v/bDFF/ufbe/3aBRJY+NXkbXpEn22k5ldv76kitSYXrX6z+6
	SfK7qaxf6GGTyXI+bq+ILNiX0w0IR+tvln962pFNuuob0agMdMJf9yUAhG+c100j4T1/Cs7XNEK
	rLai9HbpdctRmxKZuST+VriHCbUyK6m9B1nLf4tPzSKbGlmIKhDO8ZxV2uRl0ZXMdb7HbFrlpyK
	d4PHdCZ6TItN9VDy3Q8cVG2RcMT3hn4wcbw7rxGniCGykP+/E/0uUwwYNGjXAJKHnzPmJznZ8zw
	NgW6B+sXzNxlbnY9yKH1sKwEa03QGncQYTDOHD+R71FDAdQHNM4eu9qYODivygGDotMlSDbyGtX
	HIy7LK3YBpJM9yO/NRmyWjlgybs5WNXlhcENoHVR7n/GB4eBjsPs5L6dxQY12ARAvy4ijfhFNnQ
	ZEWcOkKb5pB/86nkXN1EqCJtFdnDtuJzOX3XqNnBMhxQyhUnak/bUPc6YHfWF/0AQ67nomT7KD6
	w5+jDTEu6wFbxaJW9I=
X-Received: by 2002:a17:90b:3d89:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39bac3f9063mr21283299a91.20.1789054672086;
        Thu, 10 Sep 2026 08:37:52 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:ced9:ef96:e152:2608])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94b9334dsm170730a91.3.2026.09.10.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:37:51 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+093e05755c2d99caab91@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH] HID: multitouch: use GFP_ATOMIC for report/application/usage allocations
Date: Thu, 10 Sep 2026 22:37:46 +0700
Message-ID: <20260910153746.16222-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_allocate_report_data(), mt_allocate_application() and
mt_allocate_usage() devm_kzalloc() with GFP_KERNEL, but they are
reachable from mt_event()/mt_report() via hid_report_raw_event(),
which can run in (soft)irq context off a USB URB completion (e.g.
dummy_hcd's hrtimer softirq). GFP_KERNEL there may call into
fs_reclaim, which lockdep flags as an inconsistent {SOFTIRQ-ON-W} ->
{IN-SOFTIRQ-W} use of fs_reclaim, alongside a "sleeping function
called from invalid context" splat.

Switch all three to GFP_ATOMIC since none of them are on a path that
needs to sleep.

Reported-by: syzbot+093e05755c2d99caab91@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093e05755c2d99caab91
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/hid/hid-multitouch.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 2c41bacab1ca..6b68e43fd885 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -604,7 +604,8 @@ static struct mt_usages *mt_allocate_usage(struct hid_device *hdev,
 {
 	struct mt_usages *usage;
 
-	usage = devm_kzalloc(&hdev->dev, sizeof(*usage), GFP_KERNEL);
+	/* may run from hid_report_raw_event() in (soft)irq context */
+	usage = devm_kzalloc(&hdev->dev, sizeof(*usage), GFP_ATOMIC);
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

