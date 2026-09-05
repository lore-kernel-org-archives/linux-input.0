Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227D3B71B3
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616904; cv=none; b=f+6MtP2Vic2tLzAk7RemgkLXST0fk2JQBfpQM3xm86WM8SqP+WHAcZlT2F9IQbf7zQV8T7ROIoModIsHQvNevzkP3pPmuMiRATld8O+V9piaCmKjKvoE58UqRYqJ+fzIUtXOpBg3StTe2tnR9it4SdFJvHYi59kqs9Upn3gok8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616904; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ictFCx5BSqhPZuPydyr+/iAjh/e8j4aqZSKk/kkRCQFBa94NXHMAvwRDAQaGeyI36eZk9FZpFkMKOUGixDAZAPAQ8JicKB+IyL1UTOs9u/LSNS2i5DQOBTNGsE+CZmsmzyKCF0OmzdQ8yrFdQO3CPKvG8oe9FOdVYeBF0bJSgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZpV17zU; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZpV17zU"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7866d924eaaso1553795137.2
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616883; x=1789221683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=MZpV17zU6O8ZzOYCM6mSh6Pc5bMWELB+jnQuQi5HQCi6EKwnfgmZ0AEBpaSpAQDW8S
         16IVmCmWPcQCQ7FUoAc2mjdXI6Vun4CESOtgp7TZ/BbzPL1ysQvKYMFBk+jIWWhuCbdj
         gBI6DgINw00GjdIA9p44lmwqHYK57/id3xwbTs5uCy8v4cZNIxLxiIv0AMx2XLjAnH3C
         Ea+l+j6WgNoLX1w28TuRU6e+lpGdTNOmLFjggreQG9OFR3L71bhcUPSJ4VvBiNxuPuvq
         ddKBGzFKZUmonKqMeFOYYTi1Tw6vtCRVa1cj6NAo3DraG3ex8OCKO8Q8YmVB4pM+sOEV
         hYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616883; x=1789221683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=hR1/YwjFqXvZ2J9wjQKqp9PDMXruFW9eDpCm4AcMmO6ZKH1APSmQppV48ehFqYrNgY
         Q7eLjUBNsVtsQDoCJbOl/Cvf1tA3Hxz0BeVUG6RvLJAzS1ZRbx8S0mFsDw6EU9Mme8GO
         yAHIjEc0fjlpFApfneXLb+aWPg8lHe6yAZaN408PhFpXGz0WY/cRoXewE8d3qeqxynNY
         Bql4ql3l8sNaIkbLRXkOyMxEhIQ+m10MgjyCKPB8z5rSoVCyKJZQsoh9FKPkGUYNGk+5
         MqtKHnqSvuUKW7cOE4sXkxuASjC7GSLWsr6LxRcR8xDh3rTWUvZQX6faTBZicuHGWCpX
         fXoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwt9qsQ1QoC0HXA4ObJhFYhF+ZmXHbAxqTiyGkYbRxXxmQeLoLr/CCwU3a2canIVGz2GSpv+Jv89HBtWg==@vger.kernel.org
X-Gm-Message-State: AFuF++nuTBN1/E3S9qBr0R4lPlYWThJLrWquEZG2BxgXjk9FDfXwuJEd
	A7jxf8xCPpKHQ1qQeiY/wXgAA1i6THCApkb24Ukn7SaGdXoosa1vnj9h
X-Gm-Gg: AYBFou17TLGaTFM5D0clBbcb0wA4195TI1z2CIJTKcj0JMtx1If8ll+zrLrimw+XAjq
	kFFsWNaRsOpIN2E9tZDvb884SjG7SKq5qWKLZ69cH91yz7torv4Rk+HGaQNszK/n3vySzIryRrA
	ZeiQbTLuWMn7F898Kq9zjEkU/iOJQZQtYb3BeugHWOW2Q2/+q6otDFW48dYLLt7i1JY8m7Ya/l9
	7jZWgmB5TIAHJDF31DwwoyzOk7ju2NOgtv/BYsK++N/Lyd2z7llE1HjunbCnfI+jU9fV6qgN3cf
	PHGQE4uNMoN+5rJjNImZPt4J11SkVP/tOzVkctV9CY/WMSEaEGZjFEwU9+1Z9+EMsVN82ScObsv
	jnzqGlUI5is8eyZqgJMkxx4lVrXuDEVZ2WQaBn/X27LI4WJGFJmv/TAo5BUm0ge0bhtZhwfbyHI
	VYc9ujk/aiKaHtAl4TLUUwM6wMVyltykZ5wYpJDrcqOZeMmD43VoKRVX009BlPJS+eOWS+cmBt3
	D3yLPdJJ8xoEB/ek8mhxB9pjuLd8HID
X-Received: by 2002:a05:6102:1484:b0:785:1d9c:633c with SMTP id ada2fe7eead31-78a4a8436b7mr5213627137.7.1788616882765;
        Sat, 05 Sep 2026 07:01:22 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:20 -0700 (PDT)
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
Subject: [PATCH v11 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 11:01:11 -0300
Message-ID: <20260905140113.21638-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a copy-paste typo in the MediaTek interconnect Makefile that
mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
-- 
2.43.0

