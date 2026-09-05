Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E6357D02
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613776; cv=none; b=qKYSFyU07h1Z8K2Y5xK3msx6ZBmCIw2rUexzeywSF4SBxAQ/BbMNQ0AIEvIJBE4nDOcHMc3LIU3kmN4uS2rcLtVJ/PDRk1N0U1GcbXSjgSqXOrKxPmvvAdIMdmPbXv8ylJe3RZZ0N8TY3dt6vXh1XVQ5+UHIU+JVXaWVOT4io/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613776; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FigqNdIBBbXKgWykQzt8Wq3pJbiP7ARVhUObUakjZrhV0J4CNbyIJ0EPVuZUQlhvIsf36Bwcb/BxB3EqCmzH0bJ4tiFWPfyFAXCvWpPAnggNyKzidR/pBMSsGnAhocikmIpdj8K6GaeKgzU3mCRUOZY26uLcqQUXUnTbOLxwBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFmFRufW; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFmFRufW"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97cbbdfc2e0so558419241.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613773; x=1789218573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=IFmFRufWLG0nOelfApNAMYBwtNqPS5XbX6iUCs567RT7YFVK1mBje84aIG564HG/P+
         cqHPTtZRGv7gomM/WpPNbdm23lL3RGugWACjN6+YfjDO81+/nXu1KtSWGjVUkDNh7AfE
         yepfrBT+xkK7IwcDNyygSGqVt+Q5B3ue4I7QLXaBaCbzNM9T5qES6NHiV0Mu8EReRdD5
         Ah+rAKxOAdJ1NYQiaz7c2kSX+3ATsIc2AVK6n5nAOZJgwDUa02Wi3tBamQ3p6flRZH42
         1jK87qFDvjYdyY0WIw4RVZcgFMEgFZgv5WinpQcXCLT4BI42K6tfxbYALSuZ9q/94kCB
         /4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613773; x=1789218573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=cwseOr8h+tl+C2M18b/4ZqT2qHqPizdMZsAIVDLL8otIbgkxeHJo9IDUYXJhx1E5Yc
         /b28Ek8I1QVpe7kkdE7p6OHUJvZ3cjECMZ8339GKumN9oqxGtLZfbKJIpM2Fzcx4n6AJ
         mdhJwjDvM6VAj40jhiOUQhnpcvi+ulQLVjqfdp9FvcdbT/UpeA2C9huVIebxJl8s8bmk
         1kI2MvHGMD5zSE4kNR4/cSDIPCbUGr7cB+qArGzHtfVeK0JfvPJdNoz+3T7TkEqozMaz
         m0ta5pBF0OrCi8P64l9kBDZ5yzviiRxvPOwg/6DjFmwVwcrHr1GwiNq49Na5QcZ6xrb1
         gsiQ==
X-Forwarded-Encrypted: i=1; AKwUvByVjWjYNZPYUCcfc4fliq7NkCTk+bnYL68+LHVsolUkbbOLbCs7WG3ZeGFK+RP5nojp1J7I61KyaiwjNw==@vger.kernel.org
X-Gm-Message-State: AFuF++l9tKWoleoDQrulWvY0nsBvLnWA1Np6xL8HlcuUv6vj8pw6BQXU
	2TtNrW9res70UTrtBNgICoSJ5vnqDJw0nfeiCDgjEo1MA4qAUTDwL+cV
X-Gm-Gg: AYBFou3pm8xHAPp5dXRfom5/CuZ9Bi6k7nuzbGGDvhtxh+xYgSRyneBKoPQK/vz2OYZ
	/K/geqHTPGy1AXUFCEGh5V/bqTaxgyWQAC+tSu1nDKLE0uFW1j8TpAocC4+k9FN/l5CcCE4FYGY
	IPF6t0emffYWfKk5NQ4wVQ2O2pcNxUP+4GFa6Qy7T3cfb9QOMjrH9abmepkPGRW6c8LvgGDbw5t
	83oUbUz6YomAnhHh82yVz/S9WbotkOUh3O1Ou/dFVecilqD7a1uFFaxa2wVvh7uqNTbkh9iEKBJ
	tApFuyVEV79cjyqDxglm6tmCxMYNOx1JWgas2w8joxi/jtHBB/FrI2qb8EGDrFddytfe5WmwXM7
	1V3VGxPNITLHN862SoCeTf03fTK7CyIkk1Im6+degnVZ2vOvZQd+YWXGROz8c5G998g+VxaPGC5
	kq0TP+vSTOISw5Wky5MQpKVWwpncD+tGmGo15t6QiqA9J5f22W9cYPQrtvRrTGKs1lBJTKEZTj4
	2pG91BzhQ6B0WvdU5JYclGrZ6/qvH1Hvivsb6UEsWw=
X-Received: by 2002:a05:6102:8098:b0:783:79ac:9dc3 with SMTP id ada2fe7eead31-78a4a880ccdmr3889707137.10.1788613773006;
        Sat, 05 Sep 2026 06:09:33 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47a76487sm3719782137.5.2026.09.05.06.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:09:32 -0700 (PDT)
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
Subject: [PATCH v9 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 10:09:23 -0300
Message-ID: <20260905130925.7115-1-breno3011alves@gmail.com>
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

