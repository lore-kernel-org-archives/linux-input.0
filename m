Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450E13B58C
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172584; cv=none; b=p+IjRaa9cf7DciPogmk3R1XJUpszeHix1WKMMLAKq3z77EiYl7a90tefihSF0HamUiXpjBSf9y+T2GbKV3PryCG2Vv7gXp9NnlWOCHHo6UdzMtvN2XYLVQJObPI8RcOrPVwNGYWy0Gaxlu2OnyptISaQuS0ID1dGwe9kG4t2mKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172584; c=relaxed/simple;
	bh=C/ntNuH7/T4V0mo/sAmWBhHUovXH2mX+woiBShNBDfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTVTkrsWKQHSPXr3RXLRYMAqnx7Y/aoMrqnaXFuWcjvFgq8kFD/RsV5kg75eyWUmxirWRBBGVW762tWHZkrNvyeZnsuT6PzR1ys4iNGZcI11MNOJl6ohJc7DCR3wgdocFsRA+sqi6Kv1w8UPKPfzOJd84lUYMZqMwzH1q8H3FJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWP47adl; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWP47adl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so1974005e9.1
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789172581; x=1789777381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a76hBPXYrcoSmtn4Q7RocQBlCM+IbZbkHYVvSI8P1K4=;
        b=FWP47adlnxicZz+lZg2e0nRmBhvXFIldq7jGMPwERkXLLfcrWZR7WK0LkTY+GjF2jd
         LTQgYV+RZ282s2sh+c+zv3BNGXnXtxiSH3/KPmDyndBeYB/qXJd/pPYcj98H94mq6tDe
         UZUySs9tz3Zwko5zqmndwQpmW2SsoxISk5rzx5bXvpk4y1z93uFN9k6xjtUfefiuyQHf
         7vfTwcMuClUbJ7PoA80CbyZz6o2VF1Bb67xWlXnRij/TdJbAmAStYt6dwWVVHHc3f08z
         yDl2fdLR/N8jk9DXLryYDTYjAcQ1JZvQLiEqJAOaNVAdvY8Uhq8fUPECeQ2T3r+Mpopc
         0+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789172581; x=1789777381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a76hBPXYrcoSmtn4Q7RocQBlCM+IbZbkHYVvSI8P1K4=;
        b=nCIT5mod4TK6glr1s9D+y5Q9qYTv5T5D1akf3EgjUZEe6dhxE1UkM7BKc2UKJ5aLw4
         ZwtMF89K1l6MFvKh9onTOkRfoxhoxnBMkGP0JcIXJnWPJTUvSkzx2+gZS9bhzRlQWmWj
         ZHm/mV5Yyn0O++rrwR8g7SP4AZ3xbKslZabjs1n+QDrkNdaS8k/8hocXsE69kBsP3vj3
         pMpEFynydwNIJbLqlsDROOOUQ97W4AnCLiBDheGvIvGULU1btYbX70N2MTX3qivPLxCL
         ySQ98C5sYx8nHZQJMnLQ7172JAu7L7nnzAwM4EkKAblLdIQPWfoKRw5BI74UmYLM0a/G
         A/8Q==
X-Forwarded-Encrypted: i=1; AKwUvBza/RPTBnFYCcsBEqHFRm1RWhd/3oCMXBzhoAzmiG3UWyBROq7wbEOpEhi64qnR/BJfkBfIbTBYV7u6EQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mYtGVTd7WQ1JPPnRWAdTR7KvZWu3HquiwJWqfY4oo3iJXv3hUe
	ag/olpgVD7/GkMbiKwEbbJEEUpzzUlngR3/nHTy+67FhzUgd56tSLO2/xkwIblag
X-Gm-Gg: AYBFou3Yw+5LPdDcyd6a3smYRcm6qLzMJYMa+ycC9JUcnjDT3LuPTWkNN9X0tym4DCC
	ZxMn2GLZh8IUbSxOz0ETDKCeRWhGF02Z6eyzTi5aB6JxhuOr9YLbDMIAQ5disb5eqy+aa9eIVF3
	xZkPZkUSPU4sVEG261xnOVE33v1b+p0tO25IpdelOiI9L5aJ3SfiWfz6wJ2/cTj/8NlGl54jl8i
	ZHl9krL8qlwBsjpV27E/j+4oHpcQExfq7j87raf7ON90RhfW+0gtsXHdqY+mpqBbhlMTA5mDtQH
	O8Fw0S9ABNNdIwifCId4nwZxw02YWYMoL0+Z+7Ikpm3GViob9BXgwfqEiOHXBfpk8umygWS/GqZ
	igcx8E7pMwSZE6yI+5n94jn1bj2UdTiJELvYSwbXprUeHIpVlDUq6zdZXqNUJbJgll4daElgcV8
	unhTl98mZVB47ug3pLXLbJST5m2Pvoc72x02fdT/WegytYhlyufJYxJ41euglfaL+nw05xhxkO8
	MtLgNcJYrvBCXgjY/x0wy8P5/0xCTGvOG/4FSeRXiJhQ3of4ygloUrEmhPNxxpMX8cZUQ5qKvF8
	im+JAeiOOmvo+0Di47wM+svfyxq4+6Z8MyXo
X-Received: by 2002:a05:600c:698d:b0:49e:6865:904e with SMTP id 5b1f17b1804b1-49e6865921amr43495635e9.12.1789172581015;
        Fri, 11 Sep 2026 17:23:01 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e69f02e0bsm26924275e9.2.2026.09.11.17.22.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 17:23:00 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-quicki2c: Fix the return value in quicki2c_dev_init() kernel-doc
Date: Sat, 12 Sep 2026 02:21:43 +0200
Message-Id: <20260912002143.35091-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quicki2c_dev_init() returns an ERR_PTR() on failure, but its kernel-doc
says that failure returns NULL. This mismatch was present in the
original driver skeleton.

Document the error pointer returned by the initialization paths.

Fixes: 61bb2714dc3a ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C driver skeleton")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 0d2ad7bc3648a2f227db2ed27ad9cbe18955bc0f..aa601ef613c91729f4fc90bdc1674cb838921421 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -380,7 +380,7 @@ exit:
  * If success, enable THC hardware interrupt.
  *
  * Return: Pointer to the quicki2c_device structure if success
- * or NULL on failure.
+ * or an ERR_PTR() on failure.
  */
 static struct quicki2c_device *quicki2c_dev_init(struct pci_dev *pdev, void __iomem *mem_addr,
 						 const struct quicki2c_ddata *ddata)
-- 
2.39.5 (Apple Git-154)

