Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF678B67E
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773014626; cv=none; b=QlHX3HYZgU6tOkP7YEL3i4Y/sa2a9iuyPNsbObEuXWSTILEahEEhEGD5zLp5h5Sl7JC0038oHGWx9EqljkcNwwN7SlhflUh0CjvYsvo+E3E7gdeizc5ZBtEKTViafVzeVXOsdORDwFU7lntcU53xwj5L8eh3LFsSMa7aplxzbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773014626; c=relaxed/simple;
	bh=2CuwjY5H2zGtQt9T2CoGhnEcmdwVkk7JW6ZVqUKbW9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBKTr5rJi3HuGyPB8iFiSbSN60Ktz1s0T5myae2WTZ+mzG3ZWDuYDsyJouEpBCAQjvo74ECUKTYngqd6oOJxro9gBU3lRqOZbhKm0kgUS3sFyP464B1dYe9I/WTPlY8Sbcb4w0do7j8VjBrDNSMNmhT1o3c6rBq+9KtO5D6uY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ckpb5uF9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckpb5uF9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a9296b3926so84581515ad.1
        for <linux-input@vger.kernel.org>; Sun, 08 Mar 2026 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773014624; x=1773619424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SiMQer80U/YZH35WDQO5BKhpPq/Jh1VP3Y5MXqFJrL0=;
        b=Ckpb5uF954obzS7PDTlTqO52w8RYYIsT5quYSIvQGxob0NVgFmHc7LxSXOy31xLV6W
         Vpo2PLajqVcyAA8F7U4VY21goNMKy5cGjKOmQrZXcbX67lr2AikdzukFOcgWDtNaaPXr
         hO7qh2CxoQTZg8GVlmUSE9rBtrjrUO46CIHLQ5j5PwaYrLdvgRjfmqutRsSR/PZjO49e
         bgbDKhhuo/fXK8EjTUqTYankks/CgjP5Tro/mcey2nQzW/2gvqMkS+ZhQOrtLbQh9i+b
         mMKcaPtQ10iIH6nu1k2vRUp35JH5j0WBYyrWougH8cUIbJBH3092Iq+SXLwIv0Y7R0ae
         GteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773014624; x=1773619424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiMQer80U/YZH35WDQO5BKhpPq/Jh1VP3Y5MXqFJrL0=;
        b=DiKn+zD31vy2JC2VPSjpE2MI8SSBvVvTIcFEJleNlNAGIZgSWrffH061818JJIZymh
         632OkOYxU0febIjWeWbNNOZYgiiyieLMPJvjLEtsoSvb3i4IDEsrJP95vNgg3Zz02EW5
         Mm825K9oO9k6cklmwj7y6y3qPzS7qsE2077tSJM600yrr/aVnIeyehxDjgMG0X/P2wjg
         pOedYMQIDvjNZkPPqZahzcfVzN4iiRWwfZnttGuGu0mUiIvIwdgBQezBwclcIxg7hbP/
         HVxKdYNAE3mwBQ9rxkgl1AICgq4U41c4b//sw6p5lgslu0ILIAHWD9PBvCxff0FIagsp
         ZyAg==
X-Forwarded-Encrypted: i=1; AJvYcCUs18I9ttCVQHkMT8mdSdeEKt/e3cXtVkLp/UqGzrdGOHqDoCwd7Uri51y0mhWrCjZx+XwIci6kSVhFYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PvDh+HIFiHqE7P4S7Qi+bDvYxBlOXNb+SKCO5C/RTZK7igdt
	UbJpS0YnqCUIHVRpNCPrS3VjavnGeL++skaL+9FlZ35fnmwW5sn6ERE8
X-Gm-Gg: ATEYQzyAyGv2jblbX73p1s7huXyWlxkgODhUQEdR7o99pu/sDilkxW5n413mRQMxe9I
	QnHLlip3I7RxK5hOe+sWCAHyRtskRNp4f9FvkeY2DRFENwlh/tHqW9WtePsxSmgpDiqphV+R6i8
	fJahm0MAoWpP0M34thdVWYbdce0ZKuV8MoCorZBcYnI9GntNH9sJLU4SLVzVsM97wHL0Gum2uSK
	yqS8DN7WTmPuKdLT1Ej+J5Jhamqn9F7tT8BBUJscQaBclPRW9rWOblxo55hNs64tBen7Zy3Ifoj
	GSzG2hNik23vepPBjhv2RC0erl6AiXYSn0zsvxAFoZUypAB24lsuxviC9xke1l7ZZ15qKYVyJPo
	dxwwG6V9pDoafUzpkE7K9xCRijM2zfbaJaJp9JDu4saunOmg80jzDRo60xGuf5988FB7Ii+Rpfz
	LcvC7bS5sDpaTvtDvQFql4CS8HWjb9BDCfsb/UT6UAiepSfPqgUdDdqDHwHQ==
X-Received: by 2002:a17:902:e745:b0:2aa:d60c:d48a with SMTP id d9443c01a7336-2ae8241815emr92567495ad.7.1773014623892;
        Sun, 08 Mar 2026 17:03:43 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9b9c6sm104845405ad.29.2026.03.08.17.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:03:43 -0700 (PDT)
From: phucduc.bui@gmail.com
To: krzk+dt@kernel.org,
	geert+renesas@glider.be
Cc: krzk@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	jeff@labundy.com,
	phucduc.bui@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	robh@kernel.org,
	wsa+renesas@sang-engineering.com
Subject: [PATCH v4 0/2] Input: st1232 - add system wakeup support
Date: Mon,  9 Mar 2026 07:03:17 +0700
Message-ID: <20260309000319.74880-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

This patch series adds support for using the Sitronix ST1232
touchscreen as a wakeup source on the Armadillo800EVA board.

Patch 1 documents the generic wakeup-source property in the
Devicetree binding for the ST1232 touchscreen controller.

Patch 2 enables the wakeup-source property in the ST1232
touchscreen node for the Armadillo800EVA board, allowing touch
events to wake the system from suspend.

Verified functionality

* The "power/wakeup" sysfs attribute is present for the device.
* The system resumes correctly from 'mem' and 'freeze' states when the
  touchscreen is touched.

Additional test information

Demo video showing wakeup from suspend:
https://youtu.be/POJhbguiA7A

Kernel config and boot logs:
https://gist.github.com/BuiDucPhuc/ac7d5d732658ca293af4323ad04accca

Changes in v4:
*Drop patch 3 as the I2C core already performs the initialization, 
 registration, and management of the wakeup interrupt, making the 
 implementation in the driver redundant.
 The original intention of patch 3 was to expose active_count, 
 event_count, and wakeup_count to user space. However, this is not 
 necessary since the R8A7740 SoC has some specific characteristics 
 in its wakeup interrupt handling.
 Moreover, modifying this driver could potentially affect other SoCs 
 sharing the same driver, so the patch is removed.
*Going back to v1 design.
*Update the cover letter

Changes in v3:
* Patch 3: Removed debug dev_info() log messages for a cleaner
  production-ready implementation.
* No changes to Patch 1 and Patch 2.
* Link : 
  https://lore.kernel.org/all/20260306111912.58388-1-phucduc.bui@gmail.com/
  

Changes in v2
* Drop description for wakeup-source property as suggested by
  Krzysztof Kozlowski.
* Updated commit messages for clarity.
* Added driver-side wakeup handling in st1232.c.
* Link : 
  https://lore.kernel.org/all/20260306104025.43970-1-phucduc.bui@gmail.com/

v1 
 *Link: 
  https://lore.kernel.org/all/20260305113512.227269-1-phucduc.bui@gmail.com/

This series depends on the following patch which has been
submitted but not yet merged:

drm: shmobile: Fix blank screen after resume when LCDC is stopped
Link: https://lore.kernel.org/all/20260226054035.30330-1-phucduc.bui@gmail.com/



bui duc phuc (2):
  dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
  arm: dts: renesas: r8a7740-armadillo800eva: Add wakeup-source to
    st1232

 .../bindings/input/touchscreen/sitronix,st1232.yaml           | 4 ++++
 arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts         | 1 +
 2 files changed, 5 insertions(+)

-- 
2.43.0

