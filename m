Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989149481D
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611702; cv=none; b=TmeP0bhDby6bnu30VeYoe/1o/cAVvWv71g32I3AEVdKTCEbB/zZKuJqKlLtqpOQ1eVWMAKx4T1oVQiRDP6f0gB2vktoEBcxhqxrjcnIziq7dqZHYPia2fBE+FzowUP6y3fYsqPRiLj7pvvQHDg0E9BDTwoNM2uPwinFwRHOTkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611702; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXsAnaPBDt1FKAM/W/c3liOGzFaCag4odKrZjTeraZCGUKGrc+pMUJtMob15X1aoFhvLhTChqyIHGEH8pGm/h4V1Sivan52HJAsQJROwQP/kfDVKwINRmNxP4Spi1ZGt1uLfwkVqZkgUC5emwHmQZlLaceX93hiGvGC81eBwUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtbnSs8q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtbnSs8q"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db18e5cb56so16189795ad.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611696; x=1789216496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=YtbnSs8qfPdzgH+oeRaodn+q8Vb2tox19c9H6lxT0EFKc+LY1/TEPedO12k3EV0weq
         ZubHW2aMvu5d9wRdvZ2JZKz7OYJGt9lSYnONx4iIPgTgklB3Zi9nQUeDscBHQNI2nipN
         8PAydIGehlYBeD+FYQjwg6pUJGFz8Zv+UkkQ3/NrLop+gj8ozrTjmwWo2IbPI+M0RoI2
         BN+5/uzNIMcpl8wO3T4RqLVBYURIS6zQbCgT+MIiipkpQV3o9deat8Ivesk3Ege7KHGV
         agTdBI1D8e/AHP9rHdTaJMom7wYS+xvDGlXRUX3Io89bY3cqjDkY4ewjOrVt3ANdSDC6
         BPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611696; x=1789216496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=c+28GbNloh1hP6zKAoSQ23F82LjQptO/tnbmUOOWrdQVOnKSj+U0Pggwfu2/XejwCD
         BlKVF3FZ2BkopjIu+Dpf0hddkpt/fmpDjjao5vLpqM7hLlCREeF6FCSAJIO+GrFn4Qza
         Qpva7n2YHP3NURBrzWMDONU17PdFuygntoqm1B/gEG62OmXKrnhv8ZZ8jlG+6Q3EMtlq
         E3pm27weBES2AArRm62/uKPYqGAqsX188/5PiyegRk3TZovrmW+LZrlYrD8xYA//XE7A
         H8VlKQdQiz+kEZKul9zKv7jr/wnu4lZIdRndmg7v2uvne3eDudKPFHeaU+EXFplBnD9+
         HX9A==
X-Forwarded-Encrypted: i=1; AKwUvBw2vZfQR6WFgautlh/2Pa6D2SMzQbNQftu4SIwczrjzWeSwS/UE0qZcEBfeCwZ3xeBInE875nGo1CCmMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n5JJsaX+fYrghgHX55PGzqUHxbhiq++XwMKabumOXrGvsOxmTs
	QLBB4yEEF4tZjLyRFdZnWd28Cnn82K3Po33r1cflXCKMjlevDAxdRLjU
X-Gm-Gg: AYBFou0ZkdlGudOf5nLw+7VbDjcT5N+XDYaIgmlc4xGSwFaHfiBkHlg/lGKPO7jrcog
	CqpPLJjUszMkCT34VWcqB8/S3sEmRErwFHlWzBnksT6AadsDGH0tc9GB23kKdU2JsKy45mBtVP+
	m4UxMWDZFSDQHiD+3WJCS0yjoZFGBOzn778o9RDpDRuQexZOO8RYCf/Xa/DdvlNL7v4rEYYIgfd
	fFOwWwS0TjYdYBbLtFzICa3RcMDMz2mVI2ywrFEK5e+ZOB1aHwVyE16TSWrNUUlH9yPr+p8jq4v
	Dc6TXXumlm4OXnQ0KwoNZzcgAEhfsB+Am03yQSzH3OnyWqIIX6O0v+GvjmSAQf/3XAvzKimm1L3
	bvEkjC5W3TpCkqJo8aUTQUAR/rZcP9hil943KOK4d+mt1RRzkawTz5B6EsnHqoj1mVP1HSpn5i9
	BA3XOwNDu03D2cqf6QiB8j0CTGCBgwCpn5DRmVoo0PR4rFZdkYXyxZaQ3VfpYosEjKDCE3zSHld
	Cd4EMCKaUfxC4STgTAKx+NCVby5OlBC
X-Received: by 2002:a17:90b:5905:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-39b262133ccmr17366120a91.18.1788611696373;
        Sat, 05 Sep 2026 05:34:56 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:34:55 -0700 (PDT)
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
Subject: [PATCH v6 1/4] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:34:47 -0300
Message-ID: <20260905123450.5620-1-breno3011alves@gmail.com>
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

