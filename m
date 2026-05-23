Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE82DF13E
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548786; cv=none; b=KJPUoUIFO7RDmGGlF+jnSrtmTFncacjWzM1pkGRwBgCvSy9Z7GTsPVa42vpnonmSooQvxvQJHkIl9wbfa82/aoX0dyCK0cs8BH4EnOwQM1Vfo0ll7AtfFFMaC8e2EeJVISFwAMix1EF3/zASUIH0e+Q8gKpyyPJ6OGFFUn9QjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548786; c=relaxed/simple;
	bh=MbrqTE+oeq+dgWO/Zw/DJywvgF7NBx4P8DJejtKwW3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xbcp9Nkdq11y09knB4QTe/Is0qSrgK4ZcXuphTrDCtMdKPXbg/JUhW2cgg0fsa900LMtNyHFe0y2cgPzUsEAe+nrXE9GEJtwnywd9NxWeHLdlXF3R2gmXd5DKXlzJgm6jSNSSFbm5VkcsugIG2oLkvTOqlDl+aWZdhyQAhUZMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym/pDdOe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym/pDdOe"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bcd730e090so67545155ad.2
        for <linux-input@vger.kernel.org>; Sat, 23 May 2026 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779548784; x=1780153584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaop/FfELHjwH8IoIrpe22Er/LfhYbNrGdYNh4kScCs=;
        b=Ym/pDdOePH7xlFlWMo1xSw2pGY+MBXPQA2FyNsd3fq31gTrXla8rdWwMuW+M/Zxqon
         iSqzgaC5LlbhDXu1leSXCnNGrJO3Xhc8e0NIuS5JlfWf99Zxg1taKkr8tKsyw2M4oKrb
         GZY0lv06+c2t3qWGj+2cr4YQS5idJ6106V9lW957IFQ/CXzBnpwJSqxHcUFpQPFJWc25
         mJSw256PYG0Di9WLSI5xDWgSMpDo6LlOgAU4mwNnIn45iNPEFU/vEnQiAoZhyvtNi89/
         XDd8fXHod8aDWXOOZTRVYEpRKVSImbPUtj5avdfXIx20wsAOPHckAkSMiCcA2UYopEgN
         5rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779548784; x=1780153584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aaop/FfELHjwH8IoIrpe22Er/LfhYbNrGdYNh4kScCs=;
        b=RWRVMVHlS7BdyARy05qxX4jnyPIwXdJkiisYZpuuMjXvPgFQUUVkLL9bY6UFFJINMU
         3SXJbDuLBxC75I+0Wd6uYop4vt2VJ6oJZDU3F7BYXWNsUEk14dUY3oppP3kMElmOBSt3
         UV22W2ndcxhEpzsRTBctJ3+662S1jUt9dICy76REz/U2pRW+gpoH2ZG0GvW2nJOBCMRn
         vmV/SDg8kGpiWTX03SqxbxorS1w3iG5Xeq5pwOtbEuRj9qQoEGc+oxoRbjhcNgvPbQqZ
         zKgI81PScYES/fjnOg8FZx2o7CteOFsflvtD9msSDN4E+pNj+i/nHfaucchY/S3JQbJ8
         vgZg==
X-Gm-Message-State: AOJu0Yzh7Vlgrd220QY6SfxHPdPHlLU8R1u2IE4CmCu+QbHm7vzb4zaQ
	1m9N5YSkPEqwZifVvuW5wdwnJn9OHC5bV+xO7xyLxTueKIkI02iXDAG0bHsKGkYgsZXdJg==
X-Gm-Gg: Acq92OHi73yNSnlHqKEcUkWD6wiwJ+2U1LrAH+cZGjBaRj5QsZBLFphj0ltMWnvDDJ5
	MQ16H6aPVgtD2c75WHNeZOHFii1PMrdmou/s9UX9iJ7khD7vV1Hitc7xXz+cdVYM5lNFwllerXP
	x5wkwT7NTMC79QGitHCJ9mNmBTPSMFuWZ7y+h4htOubYcbVONKhhqk3IFv6cI+1xA+f9eTrBAzz
	cyFiyhqS6A1Ce3LfWQpWnR3FAdG3KJq6gvtGUrI0OQW3BHz6//9lvjlbAF3CMUs9zDu0ma+LJXH
	EOhBCRFxcezkpcHC7AQj7ZemUoiZNXDzU3/cTkAqC+s7lXsGI3alu2491j2a5pDW6Ir8ow0Xr4q
	t88YTanjCa8VtYkBQ0Jc8jWLruv9ETg4DD82WV9+Hd7i2qsWzep2Ru/Et26zNvTJc6pwJh4U8W7
	/MtOJY/t4hgxUm/3Xb3gswernR9cRleDo5hii0VDAxzrqPTjPh
X-Received: by 2002:a17:902:ce92:b0:2b9:7ad1:bf2b with SMTP id d9443c01a7336-2beb06924e5mr91047545ad.29.1779548784174;
        Sat, 23 May 2026 08:06:24 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695a29sm45674735ad.11.2026.05.23.08.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 08:06:22 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v2] HID: wacom: fix NULL pointer dereference in wacom_intuos_pad()
Date: Sun, 24 May 2026 00:06:19 +0900
Message-ID: <20260523150619.615565-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523150101.611473-1-jinmo44.yang@gmail.com>
References: <20260523150101.611473-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() dereferences wacom->pad_input without a NULL check.
When a Wacom tablet is created via UHID with parameters that route
through wacom_bpt_irq() -> wacom_intuos_irq() -> wacom_intuos_pad(),
but probe did not allocate pad_input, the call to
wacom_report_numbered_buttons() passes a NULL input_dev, causing a
general protection fault in input_get_drvdata().

Add a NULL check for pad_input at the top of wacom_intuos_pad() to
bail out early when the pad input device was not set up.

The bug was found by syzkaller on linux-next 7.1.0-rc4 (next-20260522):

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000052
  KASAN: null-ptr-deref in range [0x0000000000000290-0x0000000000000297]
  RIP: 0010:input_get_drvdata include/linux/input.h:390 [inline]
  RIP: 0010:wacom_report_numbered_buttons+0x37/0x210 drivers/hid/wacom_wac.c:4210
  Call Trace:
   wacom_intuos_pad drivers/hid/wacom_wac.c:643 [inline]
   wacom_intuos_irq+0x29a/0x32b0 drivers/hid/wacom_wac.c:1042
   wacom_bpt_irq drivers/hid/wacom_wac.c:3275 [inline]
   wacom_wac_irq+0x12ed/0xaef0 drivers/hid/wacom_wac.c:3545
   wacom_raw_event+0x677/0xa90 drivers/hid/wacom_sys.c:184
   __hid_input_report.constprop.0+0x39a/0x4d0 drivers/hid/hid-core.c:2161
   uhid_dev_input2 drivers/hid/uhid.c:618 [inline]
   uhid_char_write+0xa8a/0xfa0 drivers/hid/uhid.c:776

Also confirmed on a Pixel 9 Pro (Android 16, kernel 6.1.124) where
it causes an immediate kernel panic and reboot via /dev/uhid without
requiring root privileges:

  KP: Oops: Fatal exception: comm:wacom_27qhdt
  Reboot reason: 0xbaba - Kernel PANIC

Reproducer (unprivileged):
  open("/dev/uhid", O_RDWR)
  write(fd, UHID_CREATE2{vendor=0x056a, product=0x0020})
  write(fd, UHID_INPUT2{report_id=0x0c, size=10})

Fixes: c7f0522a1ad1 ("HID: wacom: Slim down wacom_intuos_pad processing")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85..251ddda3e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -515,7 +515,6 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pad_input;
-	int i;
 	int buttons = 0, nbuttons = features->numbered_buttons;
 	int keys = 0, nkeys = 0;
 	int ring1 = 0, ring2 = 0;
@@ -523,6 +522,10 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	bool prox = false;
 	bool wrench = false, keyboard = false, mute_touch = false, menu = false,
 	     info = false;
+	int i;
+
+	if (!input)
+		return 0;
 
 	/* pad packets. Works as a second tool and is always in prox */
 	if (!(data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD ||
-- 
2.53.0

