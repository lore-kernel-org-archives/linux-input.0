Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C93ACA59
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247720; cv=none; b=mlcMF/EQGuURO/Db5ipXpiEvl3ZeO5ixBAXDAVcU4zraRy5JX69EvNaVTYJdCeJi4adNvn+zdgQyJLD14dwX6WX5W9rwV92QOROFGCEx8tD8yLttnCrarB9hh/TWU+72EeeJCBlxGE3lDVoGJq736VnRx/2xqZ4e8xWfgwbRUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247720; c=relaxed/simple;
	bh=7BGgOMqfp64HcLM4LgYBtFJU9OxxhoCE6bY2vD84luI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WixjLP6rSdJlguc5XdOLPnJ2DtBXP6KD5cJ6O6HEQUTlchrGj/ZzyepHUOU0LZMrpP45sS1s41E47jjB729qa4vDIOz20rQeEReBwWznBfdWpNdPiroqwZymOQtLxHd8Tr/ZcsXr++ka16taWJGsvt8bcBAvk7a3UXCFYGVwLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN3vUgK8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN3vUgK8"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-462bb734793so203234f8f.1
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247717; x=1782852517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+McTmOMLIPUuLLM47k3fHqRzuLTPsVSB+P6EOYjRpc=;
        b=AN3vUgK8b7ANbm0PxEd/GyjCIDGx99Zw1fAGYnU59KerdPm1tI7QVLLCkShdZ3hH4q
         nDrynTjctef+/G9wNuOW++uPOKtRev8kfeftpAG84la49fFUolRnkNAzL4pXtF8xuYS7
         lSUknrQo+HkkqHDE+kGFykB58S7mkajeVY8RGy2qByWO7jHwTxMPg/++/ewkzlOEsMfI
         Y/TRgbLSm9MghR3uwtRN3jC5WVD67mEmc6146V4yd0p2wsYJSsipZyd6id+bWlZkUkr3
         t9bqlb9Kpe/+ILLYa6SAqbTQ5hWOAUMtQ3upSIa5Lg7frgUgMW5i/rj++uBLcx6C5umk
         LESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247717; x=1782852517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L+McTmOMLIPUuLLM47k3fHqRzuLTPsVSB+P6EOYjRpc=;
        b=hdj57P5/gKCNpJGxI+Mr31yhThwwZlPvNq/oDTyp42nypMwJCBUYQ5c5l3e66MBuRP
         FNVgPeP7SnSX/uKFZ/MauKHkP1l5t8R44buLb+a5UAkZxI/8KRvit1tUroxzg2jbXmZU
         ACx1kECNNuLLF+k6kFHBBdGoOr9k6h5RZT9RAteDY+gRin4CM54EncP7CJI7EdNpxLv3
         TNoiivRwH9HcA8fvtW9f/mTNI5FO1Kv4ytVlzHt3T1soMFgMjEZfY0qON650bw8q+y35
         ZG1/kzZcoTM65+yUTqS7Iry2jCPEvPzaQ6nUJUpDzIi6D5dyTsGF2Ok9CocHjKyECasV
         t42w==
X-Forwarded-Encrypted: i=1; AHgh+RpPcU+aS4MkR3bGRVbkd6ABv7vN1NrtjDu5WxnfD7lxEr+OA/d31Y8QOohFnikHabMewcwugM1bzWqgKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ioooNo+n5qsjLYyGcxYzPtJZuhCDt+b9Nvo5+fDnc5P+IsRM
	ieUL0XyUv8zSr2qZu6X6tDYZlJaXQd773laOtqIo40J0uVo1p+ZrIgnh
X-Gm-Gg: AfdE7ckPvK9FI69PPOydf+M/wdDcQMVi3ISzrPMsS/gcusKrFXXcYR/WVbY6tiXkfmY
	TgO32O1BEe3TpPd/Fz5gsTTSA5TfvMtdL/BTth7nFsj1fMkE5p1fVWpiph27g77A62k8lbnvHpu
	Tg+v/U8ZL/lZ5HHx19CuaJJylly61UoV0sQZgnRu+RDBESVya8ROeEHj0LO+HD6raFDgwCqltL+
	tLxpqVG5OWWuPdYNXEq7cgbQwRfT4AQSkrIk+et6czgtFBobgItQKvbLZvXwbC//EPhucToML05
	PSGn4VjSJmhQbRnUY4Z81a/9LcpAIZO/dKExksY4+K43xD4JOQAANIWZJoF7AnB/yeWbNWosvwT
	OQkttNUjQ1rjVt1s30fVbZNx+Y3D/qzL4gidcz3hbfHOGfsVRy/uKzuEVjp09AJTOrrx+/Uvac9
	e+Hzjn6fcs6sAZDT7Sn/mr6EePKXgFaoyeeO28aHmy5Q==
X-Received: by 2002:a05:6000:40e1:b0:460:3233:beee with SMTP id ffacd0b85a97d-4666358161amr26055694f8f.42.1782247717200;
        Tue, 23 Jun 2026 13:48:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1e840f80sm351996f8f.6.2026.06.23.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:48:36 -0700 (PDT)
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
Subject: [PATCH v5 1/6] arm64: defconfig: Enable Allwinner LRADC input driver
Date: Tue, 23 Jun 2026 22:48:13 +0200
Message-ID: <20260623204824.691832-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
References: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Allwinner LRADC input driver as module to support buttons on Baijie
HelperBoard A133.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v4-v5:
- no changes
v3:
- new patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 654a102cb5bc..c267f0906460 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -527,6 +527,7 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_GPIO_POLLED=m
 CONFIG_KEYBOARD_SNVS_PWRKEY=m
 CONFIG_KEYBOARD_IMX_SC_KEY=m
+CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_KEYBOARD_MTK_PMIC=m
 CONFIG_MOUSE_ELAN_I2C=m
-- 
2.54.0

