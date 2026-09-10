Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FD31E844
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057640; cv=none; b=O0EvMh4ytPotFxJZOKWiqYOLhxPLgfbLz/kngEhvmCPybX7fLF8+CK9DdVLy8zv655s7uMrzacXl14Q3CsuoC4TwdNgLikfRBy6IA0d9imuHsFTuZ2Cj19c+QmI9Toy3kMPLmX/ROGdw+q9tGb8jJbZd+ZgGnZ390U33WhUnBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057640; c=relaxed/simple;
	bh=kjpF59fe4ubdCkFvENJAVeCWzv0Fgh94P0CK6dGCBfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owcsMKWXIlRYupvNwJl9XJSyP9WSZhIuBTRxt4bmG9i3QXOqtCoeimuGFoAjaq3cm57b7faRYOvBM0KVCi+9ABjqk/MhKjdiH3EFqYYWi5aG80ueyUS5TRSWIeBwZLMgKhw6KNPMFacjo8Ivd7S9MJIAimVyS8GYzLpmXSO1IxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgFsEhz7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgFsEhz7"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso14276875ad.0
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789057631; x=1789662431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ERs0ZBdo2a6X8YAmXloXdwhR0inMOSFiQbLLSRZtan0=;
        b=qgFsEhz7ugg9aVwp1qHOEX6snmbPNbKUsH8NfxKlTcNf7SuQZJrXXDxe4tcJv4GptL
         c3TRxdt2FRM+ZPhOH/TkymuNDjL5v1c85TO0m8VkaJXzR8nMN8cgYHCXI15o3ar/3AAs
         pPE5ZbaAct3x6GaLHJkwt1KXK04yLEWeplQ24wblQhTrKmS7nXSNrSmkbmukmyo/D/wC
         gOcE3cTf9rQU88YTedleE0YrxNlsk7q7jbjb1CjfI9t9JY0AlE0FF8+1w5D5foJnE6VC
         oJoBRk/zYSx9EEgLPUrsC9105H4pT6fQ29cy6OF5Nor/C+PUkpNTfVuuYmMhteNoYA2J
         z5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057631; x=1789662431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ERs0ZBdo2a6X8YAmXloXdwhR0inMOSFiQbLLSRZtan0=;
        b=byOcsQf2b4Ow43gR0y61sA2tVYUX10sW6TncZUrQ9XJdtcwJ1QTixIJ5IUh2WyMc8+
         y1NClTemYhnq76q1/UCI7L6EZR/irtD9/gfxyCGDCMJafeGqX0M9WXZDmO+y6Ebips5v
         WOmdwk2Mze8/9I7FRhpnrA7CR3t4WYO9A/jPX/JL0sWDkMI94FFCPsSQ62oBcnlKZsPf
         LbRpqvGXFzsuvLZz7ptcn7QPeoD8LYBfVTvvL+9EiRXoxpPLnue1ZIWbNGnFnZ5hhQWQ
         8LEQ16NClzyANflDP/g6v5X+KYbAr2qNm32sDAC6Rzc5xwXh7bSl1IHn4FMDQ8rtKU/G
         V8JA==
X-Gm-Message-State: AFuF++nLyEUw/uQCytgFw41NUXAM+a0O00F1iODkoy6zq9Qon1ApVAki
	EOz2RlkO9H5FxiI20G8DafSkGML2fs9qY//gQ2Zh78VG7DYcOwMhkCbX
X-Gm-Gg: AYBFou1OuaBtGI3vKcobKctBXiPZ4Q1beTBAos2iT2hoAkr7NCKFllDdsO+3VQNp+9D
	tbFZDIXgA8j28zwDCD73ZfDdeW33684Erj7FbWWmu4t0bkaeaesdvVnmUxxk+uJ3O0RuiqU8SpC
	cmzErOKdBJmkWM6vUpfSgazkJ5AQJdk7zFueixolF7TDw0cN0dckbB89Ni75cKoEL1ssIpvH4b5
	pYVsvqNiDcQ6wJ7qkLUL1oNzHB/zP4h2W/1BlODhbNzsSquYHeDRTrG8QnT4Yb6+RxgNDc5x/RZ
	R0ldqVz+l1Vm69aRfRKp1BYAlklJFj38R9FZkd7SkxNpOMStIikZmh7ZwqL1N/6sZ/oPuWdPeYX
	VAYZsDiL65P+80OA6PqgWYyJabURagm2PUR46Z5cCtSZa0Vsjk3ddjS1Yr2CcatfWSoXfFvVM+r
	euuwIIIpzxegpoL1tAt9rl8/c4ZWdpNl38Sl63tatD2Btg4vFORD+aBz2ewoj7YFt7pvVb4+TIG
	J6bt/6f+hdjZlAHE/I=
X-Received: by 2002:a17:902:e745:b0:2d8:d4d1:3139 with SMTP id d9443c01a7336-2dd2a3502demr2362075ad.16.1789057631038;
        Thu, 10 Sep 2026 09:27:11 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:ced9:ef96:e152:2608])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497da04sm91233845ad.34.2026.09.10.09.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:27:10 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+093e05755c2d99caab91@syzkaller.appspotmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	sashiko-bot@kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH v2] HID: multitouch: use GFP_ATOMIC for report/application/usage allocations
Date: Thu, 10 Sep 2026 23:27:05 +0700
Message-ID: <20260910162705.31975-1-ngocthang2710.1999@gmail.com>
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

