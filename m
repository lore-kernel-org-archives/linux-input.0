Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AC379EDA
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411818; cv=none; b=a+Q+AELJlg5eJPs09GJtVm21el/e/1nksAHoKgJMtGQWLCb7tgAGpJtBXaCEkuCavfYSYffwzcR9WGw+087i/uAW6isWnu6dqsx0vORrqWlga/Ey/XMm/vfkSk2liqMlWsc9T2Tp1PiFo7CTxqYuP1xlS3fuQgMv3X9FdaGaGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411818; c=relaxed/simple;
	bh=o2glR0HHqR0WEABSYUab9f3puWpFplzNf7xndkCI/0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfL0+VRJ+qUy/5yU+LQRFYRK7HUusG7uk2B4Q5IsuQX9M0zyxQgLUXrmIlw3VCM7gKIuuV9WeDw0tXd2kTwH71j8iUlPVhvKljfwMwotC0KxisAhR7YqMady9Q24LzEpS3+3sNuW2YXGQ0L9DJlkDYrk8dXCCCOWMbJMVtq/Uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKSdsx4/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKSdsx4/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495590ba856so549655e9.2
        for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411815; x=1785016615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ix301uMLUVdMn58C2UIAphmLJhOXCWVoJrX02MWxSZA=;
        b=JKSdsx4/MgULp/4uvVEMDlllpZlYlEnk+Uwj5u0UmLK3x/toEaoUlexRhLR3Fu4Ajr
         z7kCnE28qZQ5t6QVsI91+1wzH2xqkDw6qjCKNwC22AB1RDNXoY4vuojDQa1yCQhkDmRM
         3Ky7YUYYT/DU5jCFABQ72dEUEaqbMf39JBlrBCZpEvdMuKdinWWEXuP7NayBBAvAoxXO
         DW932m3lTOXlTPjSIw6xkatqAg52NBPEjEsYaggbDo+/wU/GzLGF0Fjlc1+UowIS7Isy
         HlgUi4a7qgnepn7G4w9eMAd1FzIBI+78x7LIxHCwnqmEcicZeSSBgnmPwIQUpsL1f2pI
         9Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411815; x=1785016615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ix301uMLUVdMn58C2UIAphmLJhOXCWVoJrX02MWxSZA=;
        b=gEIw9t1FcUtvzo98rO20/UHOMTBR7hNwVePFDagriJ5CMpHzyOa/RZ18zPQD22Km6r
         4kYWeo1b0p1y8pV1Bv9vu1j+E7k11OXYkYXr0AGp3dqsEWwOQXEOXjORMtBABw1N3l/1
         lEPaLf3pXKDDB0S6WHR62up0OfpjWZhn0TEIHva2xomx4ASTUK/jM/rJU5hOKcg8sDY0
         saEePtbKOV8yQ8Koc2nrsV5dcqgZDTrDJfEDWzAWCjdAauKbK8YVH3uNvnfHXsg/W/gO
         FfNGt8DHuqkNP4Dx3Hfbib7sVWZBj7c75vsORaUYMayaFYRdwKE3vM6in3JR0L6XdJqo
         5d1A==
X-Forwarded-Encrypted: i=1; AHgh+Rqvl7BzUbr/mlKP0NHGvBu+5gThHbfWTxLbglYpyD7VqFsq+d3gM+C44UHVjrjRm0UdHBM6X8aqncLrKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUDc4+UY7Ul1Sdn6lMJKouepqhkzzlTV+mB5KUCvUsvMbaSbI
	wxqdZAHKYakGcOAodgl3p9+erK9N4u5vcv08b63LTEVmBHNezh6FBOB1
X-Gm-Gg: AfdE7ckhpeGDFGMNOPMYTF2xJyDuivAPed5yipd9BFEny6ykLP/WEk+rJ++3bJpg/3i
	NKGRw+gl/ovRjZ2W8NDZUMxs9R4Kfgz3WGpAZ8vZU4rXT2p4z2iyz4zoo7NgpsFEog2+igYi6g6
	9jg7O6fNFcaUzyVML8i6cAqpKJAqeVB5EmOCEYnRBhsFZYo9sFTBBHTcfPOF0x59vmgCjJBAze3
	WdLQPhUGYFa7MS1wAwOskJaOeQBtn2q904B2EgDQ1l0+v3xPQfZu3kItUBvnLtHL4uT5tsV2asL
	kxo5baU4zjynELsHncedEYt9vam7XGoFcAjxJd0uBYWSa/aLaQkuxHw2GXPo9eBi0nclPcVR25J
	ZRvIppq9MUnUu26Y0COFjGJInCxJd51MnT2LKVsBVMUO/1k6VCRdc6BznUI1TTxM9uFys0cfuW5
	7mbLKgiYZHq3BLTn3MJDhO1Zh0uxoBF5P+XEobUnEu5Kt7
X-Received: by 2002:a05:600c:4e86:b0:495:3b8a:5e17 with SMTP id 5b1f17b1804b1-4954a3e41d5mr90987515e9.16.1784411815010;
        Sat, 18 Jul 2026 14:56:55 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4954c0a81f7sm101199835e9.1.2026.07.18.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:56:54 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v2 1/3] ARM: dts: ti: am335x-guardian: Drop unused isink-en property
Date: Sat, 18 Jul 2026 21:56:30 +0000
Message-ID: <20260718215632.3295049-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718215632.3295049-1-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'isink-en' property is not read by any driver, so remove it from the
TPS65217 backlight node.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
index 6ce3a2d029ee..d595e79d6b05 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
@@ -320,9 +320,6 @@ backlight {
 		isel = <1>;  /* 1 - ISET1, 2 ISET2 */
 		fdim = <500>; /* TPS65217_BL_FDIM_500HZ */
 		default-brightness = <50>;
-		/* 1(on) - enable current sink, while initialization */
-		/* 0(off) - disable current sink, while initialization */
-		isink-en = <1>;
 	};
 
 	regulators {
-- 
2.43.0

