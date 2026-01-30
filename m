Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588A244665;
	Fri, 30 Jan 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761741; cv=none; b=fUQ8g7blzNaEYC1qO6izukSskQyaHCvqM2ChqiVt0a76v8dDZE7iBibHMpc1YJS+fWSVQ1A0zgSEyVpISFM4HHIfCE/ylCgKRl0AZ1KgrXsYTYEotN2MzKKsViatK/TiStprCQXevXlAL2TdD70+4j5WrxsF93aRwb8u46b7P5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761741; c=relaxed/simple;
	bh=XLz7V3T64sYDkK4boKiBW5SMhsneLfchLPLdY92rAEg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oCAspA6gMqYCjUOt3qYSyA2XLCW9H7kTTNi+6MPvbiSM/XbjwFvw4myt3bGgcYn2QyZj4DNc3AsqB2QejLe2uKERMjCyWv0xOFWq1vBKzO7FLFuFJuti9lYv3xwzRWY0gtK8U+dcDRtex0GvcSHyV928dkA+QtOQ96BSc6eOGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ovuNjcLE; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ovuNjcLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1769761732;
	bh=c5LAZSvLaXMTIzcYCLzLelwXC15DKWo3ivlV0IoC0+M=;
	h=From:To:Cc:Subject:Date;
	b=ovuNjcLE77aWNNmJPCIogcmvia4jShw45v/0fvNxUpfLCFRi0di8rmgxJEU0M+0oT
	 PvGIj3tHbLi/m8NurKitdv5JQqsqNebBbYKU8ni332sAK7VDy8Jq/Sd0mBFQ71TEp3
	 d7ocICWzwDQnE0HkLtHGIwOuOdzStQnnjt3XPHUQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 732B380F; Fri, 30 Jan 2026 16:28:50 +0800
X-QQ-mid: xmsmtpt1769761730tes49g04u
Message-ID: <tencent_749F0CCF85B8DE47007183515D4112782D0A@qq.com>
X-QQ-XMAILINFO: MSavithc86ZZzzaj4DqGeRq1OwuDrX3trcBvk+FZ8IBm3dwgtyEtmrWpDo0Igc
	 +wmmMzALwigkZ2uP/ELmWjvH4PtQ3IawueRAFST4MonyoFw4cxmS5SznftxQ7QB9HdhZv3LOBQCB
	 sfuiWpqjaXgCY1AbMiax8HEwcZbfOKl71ZKj75ZHI16yh7Z1DGzT5zz+/OcyO6f72wSlhVXMkhFt
	 qbrSgjJWKIlWm3wU+8Hw8He7mllxbyBswDZGfLVlDy+5PUeoI9lASS6JN1tFaWRlfywzgufhqD0i
	 tpXAvTOHs3Sa7ejrTOAmCDIgDlA5pYyoZxPR15ZueTXKuCXQh2+CIuJPrp/R10eKXk7bWy35B4ZB
	 NsXbnYApWK8c6Ep7mUio9ZMfzHH044PxP05QS/pQOIIY4Fw36zQ564m7alM0THc6vyNAjJ5xZ1Y2
	 mR3Geif/nfInFEN8q+FI4lu0QXl6neSPn744/vAlhwUXmz62INOV95/UyRU3gyT7p9J1GnyT2NF5
	 /V7JL7WGokGH3YbO6emibZJl2BKtvWCEM5C7K6KHPXzAvcfYlQp80JHlvfT0irI6c1VqBuLehjC7
	 c0azflGQ1h516tI/EBIQ9ZH/X7B+UbMLHvLq8njpmk3njtzORoHvK0a9u6LFrJp/JIVFMvdPs+my
	 PmyaMeGYmSMoPaOOBmJTtBjHDcdELDGMzdOgKth2jp53fmSpR2+T8yNYCbeJfiAvF0xKFVYOwxIJ
	 kz40sInBBT3yHYjH5QJmsmYy/QYClqYgKNwvOBHneX1nuw/XSGXRGUDKYZflPXaeK9Z9Kf3+MmO0
	 eQFjMWFuHn2FqYmqiJ/K4+qM0JjZ7rKTD5c4Ww3shQNM9fjeo78EiwvLzwMhEXzQdWgF6HWwFft3
	 3IBkAPlvddw6vXApnmuzoCO6f3yDqkGyxnlzkpfDKL/mRUJ2v9c85W9XMoD+7AqrlZEI25leqYts
	 FemYSvqkyRXLb2LEcS3+/WFs6zlsSD/xme+hPsDq533MdNAZ0sVON0EkZjeQbejugI9HzYU7Dwha
	 e4/6qquSnMs8aBwmYyu6/8c4SLIGbp1I7Urb08DzaddMth8VMjUe0JWZnENuKap8T1USMMNA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: xiaopeitux@foxmail.com
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] HID: asus: add missing code in asus_event
Date: Fri, 30 Jan 2026 16:28:29 +0800
X-OQ-MSGID: <be78c122906f558cc8ad519fcdfed2c62412793b.1769761639.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

In the commit f631011e36b8 ("HID: hid-asus: Implement fn lock for Asus
ProArt P16"), there was FN-related code for asus_event, but in the latest
linux-next branch, the FN code for asus_event is missing. So add it.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/hid/hid-asus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 1b9793f7c07e..8e34063216c7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -354,6 +354,8 @@ static int asus_wmi_send_event(struct asus_drvdata *drvdata, u8 code)
 static int asus_event(struct hid_device *hdev, struct hid_field *field,
 		      struct hid_usage *usage, __s32 value)
 {
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
 	if ((usage->hid & HID_USAGE_PAGE) == HID_USAGE_PAGE_VENDOR &&
 	    (usage->hid & HID_USAGE) != 0x00 &&
 	    (usage->hid & HID_USAGE) != 0xff && !usage->type) {
@@ -361,6 +363,12 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
 			 usage->hid & HID_USAGE);
 	}
 
+	if (drvdata->quirks & QUIRK_HID_FN_LOCK &&
+		usage->type == EV_KEY && usage->code == KEY_FN_ESC && value == 1) {
+		drvdata->fn_lock = !drvdata->fn_lock;
+		schedule_work(&drvdata->fn_lock_sync_work);
+	}
+
 	if (usage->type == EV_KEY && value) {
 		switch (usage->code) {
 		case KEY_KBDILLUMUP:
-- 
2.25.1

