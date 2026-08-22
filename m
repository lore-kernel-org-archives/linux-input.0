Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C5390CAA
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434849; cv=none; b=TKHFZiLf6euooeMz0B9jmyTWWbUwte7li/8XvKUvjkrTFMiXkMp4S9TJjlve+LYPkMaay14GVEhFGrmclEmWYzNjIeKpIBCFb+swpaZBHDYi1pON42xUuh1SstDMu0P7FqGXPJwf3xkdL4Elago3zUczybu6hT8p6OlQyvlsWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434849; c=relaxed/simple;
	bh=tSaYsW5ZA87m0Wg9YJ+wfmB/gHIRTOyA3syuwyg8qeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayk5GA7YAdtZGAB69kwKQp4c0Lkr/HiU4f0XTMEPO0fi2MqO3UIOc9MtbWt33oEXCB/l1IzRQU1TLfZh+lX1ZWpc/Vk6iRDjpQFnbWcg3qZgqZ8Tcbelwx+s/bUFaWFfO7lDdWpcLrxIR+rPOlIayDPKx0FNTxhmV70Eb0q20lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTQtPDkb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTQtPDkb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1712a04ddaso364468966b.2
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434837; x=1788039637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4eLlaKD/QchVb0r7zAM59fvM/PJvb2qK03bPG46mJc=;
        b=oTQtPDkblPAwvUkJILdH3vavLZI6Uk5u13K9Ty3z0sAfJwsMNIn5HHspUOj/MbClK9
         i/gC5WT6TRpLrB/v+f4+FSlpMYBxviJFaHQBbWx5OZe/3PxaCQfXjb8ODwmWqN0syodk
         PLGE5SeHFYlu1aei1esnpmpkwSibc2rwC6ldYusk8RW4WdhxJvRfAmp1/LRo6rbdBiAQ
         U7J3Cq5XVpdfa9sC1fGgaRtqjhxRUWHLMFolk6SUDVl1QLN14Dyi/obQGb+72Ajt7+Mo
         uIY4ZI1I6AGcHImG499TdlfkMy6BnBy8w09JaqLNU2wB+P0wn7t2KRWHAnl2WG75vGbN
         b24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434837; x=1788039637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a4eLlaKD/QchVb0r7zAM59fvM/PJvb2qK03bPG46mJc=;
        b=pNkJx8fVjH3nZ4csgVQo4m9vXg9B0KeEUfJxhESTjyMG2lQqOX3An4Vz8n6c8UtCE+
         jSEeeNRiZnAlAZ9Ih0F34Rjkp6Y4U/TW8JSqsVZ0EggxWMMx3hp50CA7lSqmFv1d1El5
         Vrw5QYWgiPMIjTaR3iCXINn/54dUwJAzpMy63ouSgr1uP4xUIlOpM8+EJenfnL6kR91T
         z1PYBNIX8yhMG7EW2htgd80TwT45zdNSM3xeJxODhNA31ZTGmDR10qSzlZBlJ6vsGKFT
         ChhM4lAV2WWApRbaAU2Hj591cMU0gTVlX3o8OG/TbI4eDzVWu418ynu2VO3/gwXqteeN
         x7Lw==
X-Forwarded-Encrypted: i=1; AHgh+RoUyZ891GHjDCOI/l4K2Z0FjhDhfevdocgoGjS4ICPX/hS6WDSpXjHUdWnYCdjLVDHF+UJi6wY/K0y0gA==@vger.kernel.org
X-Gm-Message-State: AFuF++ncHyVz7KjeLLGsKCmSyhfhRDDhCd/nNF5TJkHc7wqLJO2zlvmk
	JyoBU8vg9lkHfJwH+NT+FWHM9BZplY/FQn299Uqvs4pdTBk0On4zWbNy
X-Gm-Gg: AR+sD10xE25diXGhgNv/9hXToKTrIhvn9IV852moF6U1O/Nzo0efQnhoqEx5tkCnouW
	12RmV2wk9rQqBSjh5cpOFr/91XowDwRXYdQFQIzLhnI2V3L61vJdb0suyWXH6vyzWi7xgRvPweS
	4g7IQgrqcr9RDmfsLqczJsMH/doPV/w9nqbN+/rDBB1WpVkjeDNBtrxb/z2uVCsNeahrlwYSHFm
	g3VJOZ3xPa/u8TfZdchR0c241iWjl9dano/e0cv+qTf+J5lNTIoy0XyBXl2kVbNh18JD5Xm9IuW
	YegrTpyKu1WFrBsUQvKSxXx189b0hYaypRC+DICXB+DtFRW+tSudZcE45jwfx3rvONMP/d3AI43
	weW0W1AvBLI/Rv41DxsUxHrWkoInf/bhb9UqPmPNGb3Yl62W2EqS+ddnXeL44O2bKOMJktMz+19
	brhGgSsRqj0ypHC0n8fJB65Y+gipKJFCEojtgznJGrq/Y0BwcOghYEdCrHBtPHvpSdHCNlFQ==
X-Received: by 2002:a17:907:1c27:b0:c21:382e:9a38 with SMTP id a640c23a62f3a-c2491c2a110mr884931266b.2.1787434836795;
        Sat, 22 Aug 2026 14:40:36 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:36 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH 05/13] HID: ft260: i2c: silence sysfs store big-numbers
Date: Sun, 23 Aug 2026 00:39:33 +0300
Message-ID: <20260822213941.98882-6-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FT260_ATTR_STORE returned the feature-report transfer length from
ft260_hid_feature_report_set() instead of the sysfs write size. For
values like 1000, userspace writes more bytes than the HID report
length, so the VFS retries the remainder and reports "Invalid argument"
even though the attribute was applied correctly:

  $ echo 1000 > .../clock
  bash: line 1: echo: write error: Invalid argument
  $ cat .../clock
  1000

Return count after a successful parse so the full write is consumed.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 4435a39fce23..8db896f164cd 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1479,6 +1479,7 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 				hid_err(hdev, "%s: failed!\n", __func__);      \
 			else						       \
 				func(hdev, req, name);			       \
+			ret = count;					       \
 			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
-- 
2.43.0

