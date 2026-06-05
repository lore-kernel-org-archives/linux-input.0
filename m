Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096C426EB9
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643401; cv=none; b=gfKy3/lVw1j6KrgSnkpwg0uuZDfBWpobxbis+3yczd/bMAJJTrkD9NvHcfYjHRKSE2PLPV7lNRX1ZUrYP1i8sU3nc1sXKn4vffBDl50RqJxYnmT5kPoldhbrxkiZhQ82WQB2IU3xzKNfuFabbz5a/htn/0C/B2SHGUw9PwqHcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643401; c=relaxed/simple;
	bh=cli46i4g+ZWhHfmQnyctvXCYw7h17mfnw626tvQL2Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPH/QAN7cRpCc8m0j+KIpxqbVDKJbWXBjX0JxrNEmu+ZrPTclfWurD0z4Z9iuxGpXXvSkT5OewJt6fyq7kU64AElMIAtKOut/M62Xlh8wDl4zYW7jV3g8ramfezjGzcdy51SRW+K4a8LCoY2+x7mX0oopMxevJ+rI8BUWtnVLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOQSVOA+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOQSVOA+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef5146b56so1689896f8f.0
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643398; x=1781248198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWQkWARQy+nWOamGOOMfZhOPV4ti0QdK7fq4o+3I26Y=;
        b=AOQSVOA+0VS2n82UCRIZq99iRTn/IhIt+I8e+EQn1dO0oldKe0uUSJYDczg4UkGEQA
         VEqBUCzKM6rmlqxW+SBN5v9L6GmtwH8NR5+SQWINfwCTb211duRtMBeAtf7CT37bK0/h
         rAHFSy8gJUmrv+d0b/Uq/Qp3jltKX7sQX1ZYDGK7yLRJ0cOl91A6Zn15sPtOo0fcC+yl
         Tlu6tpPSlY/EaEfowef9ROe+g9xyaT/amyl+CAYnI23zRZxsBLccDWHns7c79kekRq8L
         9ZzlreWgXwPda8iHp/1eBGsFZIGacqqt8X9ZYO1Rw2hNh4B9CCdssPvAiC95on0lrbms
         jo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643398; x=1781248198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWQkWARQy+nWOamGOOMfZhOPV4ti0QdK7fq4o+3I26Y=;
        b=VB2AqNLNaZsNkoj1I1HnmCE8KeXxlNEHYy/7JiJ5P7mxTrsXK+IuEkDQFfbFg7IK/b
         5JEXvRL5CIJ6JPXsA3eyAKqhrWzyZFG2/OQl656BOPPYXFRjaNvcpuHs58mT48IX8eKO
         gYHavtxaKUTeSb3p8hVImFRMH4zgzsbGBp7CTM1jEUau/FZK41fWYWS8G2bEYH8e8tCo
         ufCLb6OifW0xtBzgyVEBD1PO97VpGNZf1wuiYoiEz/FDFov7JC1pPMxYfO+iir0zHB7D
         oHdwexQSXpg4TKFR+YK8M9VJLfMX+/jk6Das6J3THP/9/rxPV5RbBIIggiqwMXaRJOMA
         PThw==
X-Forwarded-Encrypted: i=1; AFNElJ+rCxTnGPavRLmNRswIK/B20A8PJdYkmBPYnCHZXFtaAmEO3c36P4nn+ygAMLeVahUM+BES1MCx76Mfbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNLA/er9+9J445wbMtSvBL31YhSc5JZiTFBDK/TKZlUfQcqFU
	feWUbh9L5HjaPbz5NlqfL8yjfE0jo0RyLp0DcdZTJ2jIE0lxaTG5T5g4
X-Gm-Gg: Acq92OF2QyJlad2A6zTxCBxwa3e3JFPBqKULXAniBy38Wk04QJHh8d8swd+r7pF+Mv1
	ygNY57Hf89Dfl0P2iHkHofr3801F2ThE6H9T0WJlg6I16uHYUO2quskLEjVH8OOQg66oSdiIhZX
	XZydmug3oO022nfQfSgw1KCUodrStQ16nYP44TjbBQGs/xZwmR7etsv7jbgQUhGbMCePFir9GpO
	CSYc0iGT6i36E5osIalSoy8ozbY+0s1GWe6cIxEaES97df1oAcT7vyP4uWBcDy7WMo97jmSbq12
	ANQMyRchvKmnimGc4hPdqTxXAax4Y1ad2j4j7GF9OWybwJ1gEXO7C146bhwRBJP8UyTKlWsfu9W
	dsBqdTrLYvhqo1v4ro/+X5AWAmS3Dgg1qy/HDPr66lQXiUYZflQCwpWtgPcXD9OUqHcgz/RebIc
	y3+ynIUc1GxV0DPTLvuoqzqjnN5VTktpMsoC65XADwyJBDltBtoSExKZRYi2DIM0UzMBWW6eAA+
	NXPFkKZoJe/C7b+Bs6DYQ==
X-Received: by 2002:a05:6000:4802:b0:45e:f3b2:1228 with SMTP id ffacd0b85a97d-46032b611d3mr2196291f8f.3.1780643398206;
        Fri, 05 Jun 2026 00:09:58 -0700 (PDT)
Received: from localhost.localdomain (72.92.4.85.dynamic.cust.swisscom.net. [85.4.92.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm25132882f8f.5.2026.06.05.00.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:09:57 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	=?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Luca Weiss <luca@lucaweiss.eu>,
	Sven Peter <sven@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 1/7] arm64: defconfig: Enable Allwinner LRADC input driver
Date: Fri,  5 Jun 2026 09:09:15 +0200
Message-ID: <20260605070923.3045073-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
References: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Allwinner LRADC input driver as module to support buttons on Baijie
HelperBoard A133.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v4:
- no changes
v3:
- new patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 96ce783f24e7..faf6d86d0555 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -479,6 +479,7 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_GPIO_POLLED=m
 CONFIG_KEYBOARD_SNVS_PWRKEY=m
 CONFIG_KEYBOARD_IMX_SC_KEY=m
+CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_KEYBOARD_MTK_PMIC=m
 CONFIG_MOUSE_ELAN_I2C=m
-- 
2.54.0

