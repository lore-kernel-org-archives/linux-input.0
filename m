Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CB599A4F
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898026; cv=none; b=MQDH9Nd8L486u7kpWLAzpwo/j61BjEzjuHTtqK2kclNz5K4l+amllLI2VLukfhrDNAGvIyfS7JOq+QXM3cAEcFJtAiPJ9JsmPs7Av4jQ1ett4eVpZeQtA9CZh7mWqYR4af60fHti5+Q4nA+ZIvlhuYZ/WG0lz7rFrGuDwQpPN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898026; c=relaxed/simple;
	bh=aWhvoKxzbfaU56wQB/QeQ6Ph5VkCnhZCfLmq+NV2GOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6fW2etya8/d4TcrAF8sdjt/BR89VmGuEwTTS6sM/FxVUe/nSNrcOtWAcGry1zS03Ou+hMLtPQa9ueaAaoKJhQ9dy+A+OHcif1akakLFpvBEOYa0CoJwvAMyFeUfFmxpnpp1KCawq0y1zSTDlUZGWsjuNKf+hw0DR26/bHHvkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy8NCtPG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy8NCtPG"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-485850cbac3so3288635f8f.3
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788898022; x=1789502822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GzN6rbmR1iUu2LnxWgQWrLFKGnzUpRCvYGe9UsoaA/A=;
        b=gy8NCtPGL7lvdop/lotLGXYzhHH2rs3WyH8a4NubjS29KXnNRmazshr9AfkhBBSmAV
         wNTDG6bx5ZlRvfuz9UAxTQwGzZnnqatKaLIHSNrxJSXtFtAOkJSbrWnrq5LN1EfH/39f
         y977rGwrCVP21AHESkk8tMVN1daqU18jQNbASM9bIYgF1QGxsvFVIlGE54SNpdOaCX/R
         q01bv5FO0rOBKJoL2uOUNNMGBcV2BgoC9wNawsCSjPxaKFeN+iH0rNwrVSG6zlbIgE90
         isBQV5yYg8zKy7F8vfZhB+DgQaYBWLCV0XpjyOwCLg2jK3TCE5q/JNd9XKrTkPhsOVtc
         Uu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898022; x=1789502822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzN6rbmR1iUu2LnxWgQWrLFKGnzUpRCvYGe9UsoaA/A=;
        b=AV582hGCR+YgnOAhu2pxPEPBVCsTakzeoVMYers2HVlG1OpgEMwd6m+TbQ3OPhg7AZ
         4c+HTmv7MdCePvhMGXov1quCwgq4s2VhYQMhNLodcbAaIqmGKwrZCHujzpD17KIgZz75
         14tGOW5PgEtZBJRdBriQ0TGDe6YZ8H0aV6KRSOSzMshEOMezH/b9sbjYX/q05JA1ZQin
         y01ryRobncD70ljiIm/Xw9/4od5WzhrkWSGAxDJ1wQJiFz3AZXON7qhQLs5FBEFmPwKz
         EdqVp4n0KZh/FI2fUZnCKQeNBSsJp9SWYzI2hR3cagW9e/xTkhq85dTtuI+or6bU08vh
         IFbg==
X-Forwarded-Encrypted: i=1; AKwUvBwIO+GwH32aL//dnUpezVuil+d7tC3+5l0STsnnuVawzWXhupyhB0AAk4Dl4bLqmsiDK63rHVIddtNBPw==@vger.kernel.org
X-Gm-Message-State: AFuF++nltPxmjI1RPVl7BeodTMPJEnwlkP10Lj8wdZXeEIFdgaFyBXoR
	+8Z3BusWLmlafcX0NOWTNDzskYbATAGQh3PoA6N+Zud8DGM8O43eEqnY
X-Gm-Gg: AYBFou08+qUCcgtCetMANc7bkTn+aW6YPbCZeltnnPApXRCvKOZD+FuwgNw/Qev/QkZ
	fxauugnNOShLSrfKsA0JMpMrZLiyUy8aJDn1sTt3ncm5h7rQ9DvNDcnLMGhTtnx8z2SCdywFeuU
	EEULAY3X1sZqLolYfilqkz5pwT8Q/d+FGvcFU50ImDOwdtdYgGpxnqlkGEXYIKhG6KZ7GK1iYSa
	ufRvWcq3QtZ8D4ZJURnnFwdyWr5I9JAwfyukw6PU8Xsz5KRCO6+rWzZ0um9O5xMNcXmXt5T+gtF
	gfriFtbHxQXXFmah9hwkRAhHtYMtL/JiAn8/G0TRHr0376VwNaFWNxXV+iMeBv7ddmyIWUcP9ek
	Dtl2xw0LtWF3szqh06sC9k4qYqJmaOk7+ef1+Fywm5rvtVCXb/Ux33rQsr2DmzbTZ77BDKTA6hR
	Rhaci0w0qu8VU+h4RKmFFt+MYStp4j5xaRhem2j30n+7KnvrZclmKoU2b6jrpkNzy/FKVgl6g70
	YrCNCawWZb9Aw3n8s3mL/c147hSqAsNkI1L8y2yxFkNiOGS4Krr41GqGdUdIkwkskAY2ION51Sy
	/w/KycGfZHk+oy9SG/+UetbVsgszlPxDdQVcMkbmxlGucLXb1KzoeLTF5NKWgQ==
X-Received: by 2002:a05:600c:1d08:b0:49b:96a0:5c00 with SMTP id 5b1f17b1804b1-49cf825168cmr334965715e9.13.1788898022462;
        Tue, 08 Sep 2026 13:07:02 -0700 (PDT)
Received: from xenia15 (30.21.143.157.bbcs.as8758.net. [157.143.21.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbe5b252sm365683295e9.3.2026.09.08.13.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:07:02 -0700 (PDT)
From: Nazarii Tupitsa <nazarii.tupitsa@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: core: Avoid leaking field ordering on repeated connect
Date: Wed,  9 Sep 2026 00:06:55 +0400
Message-ID: <20260908200655.139098-1-nazarii.tupitsa@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_connect() builds report->field_entries for every input report. Some
drivers stop and restart the same parsed HID device. Wacom wireless does
this when the connected tablet changes. Each subsequent hid_connect()
overwrites field_entries and leaks the previous allocation.

No physical Wacom device was available, so the reproducer was built with a
Raspberry Pi Pico. It emulates the affected wireless receiver lifecycle and
repeats the tablet connect/disconnect sequence.

The ordering is owned by the parsed struct hid_report and remains valid
until hid_free_report() destroys the report. Skip initialization when the
ordering has already been built. If allocation fails, field_entries remains
NULL so a later connect can retry.

On Linux 7.2.3, the Pico emulated a Wacom 056a:0084 wireless receiver. An
unpatched run with repeated tablet connect/disconnect cycles left multiple
unreferenced 512-byte allocations in a kmemleak scan. With this change,
repeated cycles successfully recreated the Pen, Pad and Finger devices, and
scans after removing the receiver found no leaks.

A representative kmemleak entry was:

  unreferenced object (size 512):
    backtrace:
      __kmalloc_noprof
      hid_connect
      hid_hw_start
      wacom_parse_and_register [wacom]
      wacom_wireless_work [wacom]

Fixes: 22f4b026c3dd ("HID: compute an ordered list of input fields to process")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Nazarii Tupitsa <nazarii.tupitsa@gmail.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f..9f4ba5f60 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1802,6 +1802,9 @@ static void hid_report_process_ordering(struct hid_device *hid,
 	unsigned int a, u, usages;
 	unsigned int count = 0;
 
+	if (report->field_entries)
+		return;
+
 	/* count the number of individual fields in the report */
 	for (a = 0; a < report->maxfield; a++) {
 		field = report->field[a];

base-commit: 23da087d9a636d9b2046f3aa3b7470ae51b89c8a
-- 
2.50.1

