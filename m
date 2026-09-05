Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2A4A2A65
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613039; cv=none; b=I9OWMz3WvzuRlP0xk8K6u42x8i7IauO3wBvkfzMeLhviKLZ9qpeGnkpNkKA59LKCz+A7hkjtC+8tAD2nRR6mhCVtB0LdJfWi4rwec7dmyrkk/wVyU2vACuVCvlMsfqHPgAi82hehLLZin8Qcve6qvJdUm6cT/4G1DiRDn1Bm+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613039; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b61CqNhN5dFX5rE24w4FeSAaNWAqBQB4Q590HUM2sX1O+h9oSz6IPUOWCT7VTyb5iI8EYWgfswgArVmNXavzBfoMvJO/gfreluHiUMWUpPYlgJHpB4W/XkC0fidEhr8WKTi5erJUw7KlTJVknTVaqmpGFJ2ifnLVVKtr8wriVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL8ASA3Z; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL8ASA3Z"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c65d654c23so799951e0c.3
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613036; x=1789217836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=kL8ASA3ZzaDORw3JpnCIdBM1mjUHwetTUGXP1cwZET4VOCUvyFczdeNhMTX6ISdq58
         zN92li02djVah3SvxyGVjnc3hgWWk40ksdMDbqP7oYHDEyDNUuAvmNC/0bjRp3lCJojR
         v+Ec3RLj4vzkC/wJGT35ieS+N5mcTSO/4XYX3g3lw9i3m2bnSC+j8goSkZGDZ8ClqNST
         f1aotRGpCvbsMLJp5+pp0UVXapEnNrTWrGVPyn1pB+bo8eCesMhbAv7Rde8YW+CIRO1e
         IeyG5rs6guNZH92u2ieioeO5ytwQCMCfbFkc6+YSE7g/oGUjV+EWxwOOMx/Xgd7IGw3Q
         pUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613036; x=1789217836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=bFNzExDFw09zvPOyp1ucQZhv5htH2EJ+uN4UPlIaQgYNKfxAXXwsy2uR1e//xYYuRQ
         G+zWzOFYs8s/F9uO0UBgHxMlT+zesfO4IzULcPHV2td2TW8QoQ4NRkgEsOCUDfJ6sAuW
         1H7srRK3d8N8XpQCgqmtLr8qfbGPFzggLCio8yLqgJ+tAy+CeCLxbuXVRxojtZ3xQSDK
         1Zh1hun/HE+BMSpsztNuCgm5Eh3LtI+I+9Oa4IqTpKtvRtR1Lyu1R6aH5wyjKJbyxwWH
         rq1gvmzGk2XGjJRvMNaOvJClHuGEWiUDO2buRRh9By/8o87ume4p9XNFcqs0FnuA0ttA
         5KzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzX0cBhdqsZ1SasfVgkw9sy7Uja72Bp6Kk9TskjMhTvaluqUnL0ZZ6CKwF1H2rHD7tyzto6KbTL5iHqpw==@vger.kernel.org
X-Gm-Message-State: AFuF++ktZOmcd3U99F2WCqD9/VOVd6KR83x2Pizjk1X1jImasLI0A3jA
	enSTXpBjihpfky6bODd3GhOrWHKY8xp7AeB+f80sI8C1BtE3SJ+KjOsl
X-Gm-Gg: AYBFou3QjvWPC03KANH2p1VSYeBcIJpNkUeiLRkb63G84Y5wQcWFn0Bg9FCcCREOfin
	xl8T3MhOyKqm4zOBDx21L3PTVYqf/wbToYtul6mpOODAUtT5IyYkRs28eTNbIMG/vMNgtycdIkC
	QiWP+7i5lSkrK+i2qaOJY8pR1ac93SAlQSOpENmHnoTWOlFSe3tP7qb070upPkBu7A5QkPDos3b
	w1LtM0eENbqgUUWZ69gsZNYXAVORcxG8sFXXMVSzyEB7ds0V0SSop75dzgFmmhLMyUBLK8O0t6U
	ULcw96EuEBld08tqHr17aLsIxGLvImwNR5gmi+gNuZFde61Ade2KLS3Cg4mgDUUVLBdw19lJj+3
	aRkNcGtMx/ik2nqiTssVm2BFS41v9kKuJuhxjBII7eiYXQeZFv3WTaG1+tVcZkGPD4qWEKxrYkz
	NL+tWsSwwL9VZT+0x4nqAz/ttzZ0QvE8FK7rjHh2UbJwTRRQV/uoruM8naC1itwBqgzmKpH2TU9
	htVcxTE4aQCLZhb2ELc73cb3l/BTrxKLQ5V6Yc/72I=
X-Received: by 2002:a05:6122:32cc:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5c7ed0c4c20mr6435898e0c.0.1788613035512;
        Sat, 05 Sep 2026 05:57:15 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1ef7a5sm4349416e0c.5.2026.09.05.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:57:14 -0700 (PDT)
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
Subject: [PATCH v8 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:57:04 -0300
Message-ID: <20260905125706.6550-1-breno3011alves@gmail.com>
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

