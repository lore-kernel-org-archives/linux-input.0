Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3DF51FCD1
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059271; cv=none; b=Uvt+mvNvm2Cx7tcLcfLyZ3H6FNkfi426l8B+VgNfalWMhGmZFLOlVtiWx6pXKiP5vGn/6H7DbV9aQunF/jeiDd83KXnPxsNcRy94OAVZo31EMVvE671eSkxv9cw0KLb5lzArSL/znWxuUEBhHOZGtoIP4B8duzS9TPQM2EGeSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059271; c=relaxed/simple;
	bh=rz3yn+C2eMXZq6DDOcOzTXjjZhcgJFRoGT8TBDOfLM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2EU7utDYzl5hoLTtP/AAzbuu5GQzO3E1XBJtbGVLJmrehhIN6Rsg5Mqs8OQo2ynLwYvM1I+wgZTYih1PKOkkDzk1mFmbmuOKxwAL5Rox0PpA4BnxTgDJIQ0G2Fd2MDh9twTK5wbw9oAZYYAJb+9ldt9tbZbkIB2DUpXBBfNlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JijUUNzW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JijUUNzW"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso5982657a91.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789059267; x=1789664067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhI6MBvRN0gP2RgUEHdvGpUA0bye96IQsEzTBS/VwdM=;
        b=JijUUNzWSUh65joLpzR8k70WDaoBQGEzPcHij1mO9M6o2CRZNloO3UdKzw8tQeJB2C
         tNMFWQxko5impgbJn+A4zuIg+HEYhSmDsKtm+YKwpxfbbTeY2TqWtre/uY7eqxSS/LLV
         7zO1GQy2qX+EsfJqRR/UXGtJjGYrBX7tZMxqBgmFsyUx2k7jGn1tW/j6AEzNTU8mLLtt
         VhxseWzrZfYd/DgR688HEy7/zoSfKWX85MU0ZIqUId9xSuy1kCPdBOM25NoSwBQOWVrM
         m14MeAwv33oImlh6cBs/zHJXjuIkEdmpl0Se239YTTdDmASKNagAjLNnXxiSEaGz1SbW
         g2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059267; x=1789664067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhI6MBvRN0gP2RgUEHdvGpUA0bye96IQsEzTBS/VwdM=;
        b=ENQ4Awf5Wbqi6M2rGm1b+c9jeeGrF2Viq1JH1ltFFiGfc3cnmWTAzjjKhxcDVpv357
         yezRunLqAmBQm7Ul41LWr3VKTJ75fpbMohYd4JTi1axP9e1VmyqgTMRy7dNZ3dtu6sjc
         00aBPey6xg1rALAxxUd9aPu0y6wCz8qoDEs2nCMnxVHZFwgopBTzfvk+562gYkrAHSNc
         Xr52gcoTxvdrZA/vdxgFVv1T3FHIo/EAq8NQtKa6JN3aGRtUzKtbyg8rbjY16bqdhtQC
         QfFv7g3cOoXDIIpl30sUdaL54sFx80gA7kqojjJezckG3kKsaq06/dzQBNKCwCfBYwA3
         8Upw==
X-Gm-Message-State: AFuF++nQRNj3+fNqPEW5PZ3v4Iogl5HijBoXLgvifmxHZocf1BXfzeet
	gKUlid6nmaLt5O/wTikf0eq0/Bgev5HAxaNx/tQI//qk2bmOzOLJ4x81
X-Gm-Gg: AYBFou2FpWr+yne95wdNkfam9nksdcQkk4udDk5qOP35z5aXHQVJHl2QAo04CagPEcI
	ukaLJCbMzffFPKvpgXd1FVULj9VMff7wvZwvoEzajZKrWMkEkEzzbe7nRjxVmedbweGuqBWLcki
	5kk/+H8kSojH15qkILjCEG9hDwfY5HqUIYP5X9T+x9yUcAHQcchE5s4F4irKjHjlNUSdCU3lBRG
	9DELE2MRZ94XKbeu4tIfB3uaSYIJxUaRn6RYrNJRJzUEe6cvCgB/S+EVnAjFHdtO41BkWVmzoXi
	eyMu03ui6BlpPuPma7hzX3kabk1RDQRGuHwmGB+74DEohNgiJdtS4w0wiIxRKXIE7OVvh0sActc
	xfuE51sJRhwugaQslVjmCmJJxkSiWBe5iKxiUCs2NdY90HWBSxvihGjwiv73MEdaHDbeVjsU4vy
	g9xyVwcMAykbm0GylTwmXWUpwmMAwcgRgMRMVWK7ZXY/kbfDzsaYS6Bf9v53KBoKGh+zBmtRAbQ
	Yl5jC2IEAT5hwsP2Zm9SarDa34Jzw==
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39b261e7649mr67386431a91.12.1789059267072;
        Thu, 10 Sep 2026 09:54:27 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:ced9:ef96:e152:2608])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534152sm51965548eec.10.2026.09.10.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:54:26 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+093e05755c2d99caab91@syzkaller.appspotmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	sashiko-bot@kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH v3] HID: multitouch: use GFP_ATOMIC for report/application/usage allocations
Date: Thu, 10 Sep 2026 23:54:21 +0700
Message-ID: <20260910165421.37538-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910164229.CC7E51F0089E@smtp.kernel.org>
References: <20260910164229.CC7E51F0089E@smtp.kernel.org>
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

While auditing that same softirq path, td->applications turned out to
be walked and mutated without any lock: mt_allocate_application() can
list_add_tail() to it from mt_event()/mt_report() in (soft)irq
context, while mt_release_contacts() (timer callback) and
mt_set_quirks() (sysfs write) each list_for_each_entry() over it from
their own, independent contexts. On SMP those can run concurrently
and corrupt the list. Add application_list_lock (spin_lock_irqsave,
since one user is a timer/irq context) around every access to
td->applications, and hold it across mt_find_application()'s whole
search-then-allocate sequence so two callers can never both decide to
create the same application.

Reported-by: syzbot+093e05755c2d99caab91@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093e05755c2d99caab91
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v3:
- Add application_list_lock to serialize td->applications against the
  concurrent softirq/timer/sysfs accessors flagged by sashiko-bot
  (pre-existing race, not introduced by this patch, but fixed here
  since it's on the same softirq-safety path).

v2:
- Keep mt_allocate_usage() at GFP_KERNEL. It is only reached from
  mt_touch_input_mapping(), at probe time, never from mt_event(), so
  the GFP_ATOMIC downgrade there was unnecessary.
  (feedback from sashiko-bot)
---
 drivers/hid/hid-multitouch.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 2c41bacab1ca..dd17bf4abfae 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -37,6 +37,7 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/input/mt.h>
 #include <linux/jiffies.h>
 #include <linux/string.h>
@@ -186,6 +187,11 @@ struct mt_device {
 	bool serial_maybe;	/* need to check for serial protocol */
 
 	struct list_head applications;
+	spinlock_t application_list_lock;	/* protects applications, incl.
+						 * concurrent add from softirq
+						 * vs. list_for_each_entry from
+						 * timer/sysfs context
+						 */
 	struct list_head reports;
 };
 
@@ -477,6 +483,7 @@ static ssize_t mt_set_quirks(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_application *application;
+	unsigned long flags;
 
 	unsigned long val;
 
@@ -485,11 +492,13 @@ static ssize_t mt_set_quirks(struct device *dev,
 
 	td->mtclass.quirks = val;
 
+	spin_lock_irqsave(&td->application_list_lock, flags);
 	list_for_each_entry(application, &td->applications, list) {
 		application->quirks = val;
 		if (!application->have_contact_count)
 			application->quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 	}
+	spin_unlock_irqrestore(&td->application_list_lock, flags);
 
 	return count;
 }
@@ -604,6 +613,7 @@ static struct mt_usages *mt_allocate_usage(struct hid_device *hdev,
 {
 	struct mt_usages *usage;
 
+	/* only called from mt_touch_input_mapping(), at probe time */
 	usage = devm_kzalloc(&hdev->dev, sizeof(*usage), GFP_KERNEL);
 	if (!usage)
 		return NULL;
@@ -627,14 +637,16 @@ static struct mt_usages *mt_allocate_usage(struct hid_device *hdev,
 	return usage;
 }
 
+/* called with td->application_list_lock held */
 static struct mt_application *mt_allocate_application(struct mt_device *td,
 						      struct hid_report *report)
 {
 	unsigned int application = report->application;
 	struct mt_application *mt_application;
 
+	/* may run from hid_report_raw_event() in (soft)irq context */
 	mt_application = devm_kzalloc(&td->hdev->dev, sizeof(*mt_application),
-				      GFP_KERNEL);
+				      GFP_ATOMIC);
 	if (!mt_application)
 		return NULL;
 
@@ -667,6 +679,15 @@ static struct mt_application *mt_find_application(struct mt_device *td,
 {
 	unsigned int application = report->application;
 	struct mt_application *tmp, *mt_application = NULL;
+	unsigned long flags;
+
+	/*
+	 * Hold the lock across the search and the fallback allocation so
+	 * a concurrent mt_release_contacts()/mt_set_quirks() never walks
+	 * the list mid-insert, and two callers can never both decide to
+	 * allocate the same application.
+	 */
+	spin_lock_irqsave(&td->application_list_lock, flags);
 
 	list_for_each_entry(tmp, &td->applications, list) {
 		if (application == tmp->application) {
@@ -681,6 +702,8 @@ static struct mt_application *mt_find_application(struct mt_device *td,
 	if (!mt_application)
 		mt_application = mt_allocate_application(td, report);
 
+	spin_unlock_irqrestore(&td->application_list_lock, flags);
+
 	return mt_application;
 }
 
@@ -692,7 +715,8 @@ static struct mt_report_data *mt_allocate_report_data(struct mt_device *td,
 	struct hid_field *field;
 	int r, n;
 
-	rdata = devm_kzalloc(&td->hdev->dev, sizeof(*rdata), GFP_KERNEL);
+	/* may run from hid_report_raw_event() in (soft)irq context */
+	rdata = devm_kzalloc(&td->hdev->dev, sizeof(*rdata), GFP_ATOMIC);
 	if (!rdata)
 		return NULL;
 
@@ -2060,6 +2084,7 @@ static void mt_release_contacts(struct hid_device *hid)
 	struct hid_input *hidinput;
 	struct mt_application *application;
 	struct mt_device *td = hid_get_drvdata(hid);
+	unsigned long flags;
 
 	list_for_each_entry(hidinput, &hid->inputs, list) {
 		struct input_dev *input_dev = hidinput->input;
@@ -2077,9 +2102,11 @@ static void mt_release_contacts(struct hid_device *hid)
 		}
 	}
 
+	spin_lock_irqsave(&td->application_list_lock, flags);
 	list_for_each_entry(application, &td->applications, list) {
 		application->num_received = 0;
 	}
+	spin_unlock_irqrestore(&td->application_list_lock, flags);
 }
 
 static void mt_expired_timeout(struct timer_list *t)
@@ -2127,6 +2154,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_set_drvdata(hdev, td);
 
 	INIT_LIST_HEAD(&td->applications);
+	spin_lock_init(&td->application_list_lock);
 	INIT_LIST_HEAD(&td->reports);
 
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
-- 
2.43.0

