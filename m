Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F33B7777
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616908; cv=none; b=BKOp/3Msp/VkXY/7kH3bTbu+Z8sdVOrJymSZh8+csQNIeMGOePjXFKTId0Dj5i41Mz16pvgqqhxkzskXXHCRsrKHE0WtU4BpDN/kdVhH7IP5sw4u3xanUAGCqnTrxeqWUgcY+VtCChKsLJXfOzxvEO9pG53RRNX667u46QPu7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616908; c=relaxed/simple;
	bh=EizzPFcHBTIh2Y7GKphJQqpoh7RMlGuXmOyHqJPayZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnOh43XmiDoaKmTBkDPpLXiEJHLnTY/SstKlT+DLzB1uhEKrGk0ste6XtJEfoV5hSvkCDR7NWiVqLhWJUSSeMhiBkGtsNFjLHF1wF6lYLYr2uYIyHe4JI498JLnxkQRIZ6jqHvODCtK9X0JQqiIR7oZ+Ht+iyBl1uCokD0yk1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAWHDYpH; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAWHDYpH"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-777c2d69446so1503105137.2
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616889; x=1789221689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1isrg7TbqEnfLRqiu7vL3P60u+Hz9D9A7/6IXKBZk8=;
        b=ZAWHDYpHOMJ2pb1rznJGqWziVaas9dmvZpinpC8dpdVqj28oQXoc8EcWh4t0vpBJzr
         OfhyVTe5DH/gmR5zTbIvGvTij3vy5znr4MnvveqiDbMkf1FnVpTTGTs6pPzlKhmqp3sz
         3YkwoIj1bZPG4c5xVmHJvjO423C0j8ygBV7y8w96COK+Mrg6bjL66EJZ8f6zhaipTXCA
         shq6D7fnizDyjnuKBYcpdih1sLm8oHZjgJYRBxZorjypAjnKdQNVQabQdDtTPlev5008
         KLDjEmNRmj3wxviz0WV5c0/pYxoL+Vd+BAWA+ZhPGQWWDpR2WZGmObxm4RgatpKhkaDT
         jmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616889; x=1789221689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1isrg7TbqEnfLRqiu7vL3P60u+Hz9D9A7/6IXKBZk8=;
        b=ihg+HmfHRQGajL+C6/XZthIKobdLHTctXvS45yS9tgRa+T8J7oH+w2eiYdmODOLgkT
         bSV8FysztNyRRklqkvnF8QkqrwwEtZWCGe8UEDGFrp8PbHm7NZf4/jnHMFL2knVHD93L
         fNKIPFrER69rJbP3buUP6ir3AWSKrjme9plhq5bosi+FPCKRgkVNGUsbpFrfdAzrteWV
         D4NKpzRYoLFseER42d8F63Ure6UbKbma3VJpwduidRn0SpZVSumFmb6wpGBIqaD15365
         bCnDoNy4fPgCe8PulKY8+Q53LfJzq9NR03G6BxCD2Pz6MhaNwxBpZbr/bgQmSba4kM2E
         6LOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdFwDuNzzYhLBxQtTdosIMgEaYzfSfNMFymVzCa+EtG1jM8EAzVMypEtMtCyV4n20/jv+DnOjD63Gu8g==@vger.kernel.org
X-Gm-Message-State: AFuF++kSfKDQ0Vy0cMADWeBGWtw1osrNimw5jm2XuJyJ6LYoTOCy72Lf
	O9uEKprOBKocOxyn3ZnCJ+j/gSapg5PIBef5UpfXNV51LHwcZb6CbSMA
X-Gm-Gg: AYBFou087O/4aFqD1yJF7dTyzgTaVUsYL3dNvpyn6x79hiLUqprtp8Kvn0m9/k40t3G
	MJHMP9xVxqgensjmgMZ9ZqsV17x0uhMy8Uu9A9ZcUdN35IkNHoptsoskfheIzDyndtC/vmZMFEV
	5wVPP2yuVSMZJffpyddFpT3nc5CZpflLVXVHRZ43gFVfPGCh0C86Fb1hBXwbqe01JhCCtNTQG0O
	fggOu+Kscx5nWBgAAgvrVkWFdK1USoJ1d99N6LHnBm+oEpJNXH2S0Y3YOu/JwPH2SVVX0yI34Dy
	HmGziksQLyxxcMGIHU31yNsQogs49Lloy/sBd3b3I9a2hvFVFCGkNSSdiZoBQtqoH9M3mh/fFuD
	ysAYbW4ESYibMkVZAEALzYoHPtvbYLUGfDEDQ8oMAWxNEw2fw/nZBn7fgjI7VP47Q7Oa3eNAGC6
	BPa/dOtjl4sa9BXdUCdBZ74k9yQI1aATjH5bqlIMOKvV4HDcErm9FPe4PAOiWv1jPrVq4XqzByZ
	Icgu8IrV1W2S7G73/ynt+hdlrHZ30wK
X-Received: by 2002:a05:6102:e0d:b0:789:5b58:e105 with SMTP id ada2fe7eead31-78a4a90fdd3mr5362480137.2.1788616888537;
        Sat, 05 Sep 2026 07:01:28 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:26 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v11 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 11:01:12 -0300
Message-ID: <20260905140113.21638-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905140113.21638-1-breno3011alves@gmail.com>
References: <20260905140113.21638-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a Makefile typo that incorrectly placed the mt6316-regulator object
under the old CONFIG_REGULATOR_MT6315 configuration flag.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/regulator/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..3a0db1be6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316) += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0

