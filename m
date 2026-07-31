Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8E35C6BD
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476552; cv=none; b=mcJmuadh9po/bEsvsTNKMN+MSzZWQe3kcwW9EjHEpsZuxjteA2F4dIpihGn89l/aO2+TFVLEDShSkUO5QcF2wtilh1EyEX8wvYPD27D7oC8+HxOexmac/WkgC2QqUHQpaQ8p2jveKz8H2ApPZXvYEKVIJNtG64KJGM6yHlSz+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476552; c=relaxed/simple;
	bh=grIx/OkVxWnPtBhheXO3mljvVe0MI7LlAzHhBFURjQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAh+06wpgNrUMPTGJTqUwngkd2ti2/HmCKMzVwpNYLNwljq0t++QqbBwaoNT2eEMa/H2LEl49Z/SnCx7ATR6/R0Zvjc14gtu1XOMLIOMuoB2MFHtLH2gtATTXTFyFdQ1+mebcnx3mxbNscTp+qZjLzvUJO+oqsYgVk4foUSck3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAVHOZ8b; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAVHOZ8b"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so472392f8f.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 22:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785476548; x=1786081348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EzVRN5A4VxKL2AL6Q8Jif/vHDX/nsL6ttUQeuroK6N0=;
        b=JAVHOZ8bEQs+zZ4maFKXAnjhFi52/Fc1s6YJ50+0Z95PH5vWnnpOV54qGeGPaZR0nX
         L3rGK1b8tpOm6f3191yzOcJDb5moEbGKOYSIhleGrDX2bGqJt6tIBjbX3qnrWehsj4EB
         U1Yrx+kTO+5qYw2LpabrRk1vFcSz1hl+8QRp39KdHmTFob4x9ThIqVk7KM9l23R8QB7H
         Ebqk17jcNDz0gf7qho/rUMuyLRE79LvfgozeW1uKsocbJdQFa5aO3UoiCK7hYSD8XJko
         PeVpa+nn53kW4X7kX5hFvPKaQdtNFgmyNEcEa4elN7Fh8to1dmZktz+1iRdovHQs61Rt
         x89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476548; x=1786081348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EzVRN5A4VxKL2AL6Q8Jif/vHDX/nsL6ttUQeuroK6N0=;
        b=U5Ppe6ggdM3IzTpZW6bG2q/90xb4u9EDLq9Dyps2ldzvRxR2PtYlzp4l/db6T3RYz1
         EATSN7AiUfDwLDk6tLY4fDD9Br8lgBW7lGVS6WijJMZ1e+aa2ZcZFJQiAtxmLykLi8il
         g0L79+grHmprWPrs3X3U5xpHicF9kNTeW2s27S4LlRUdE//LZNPDEKG5dC/sefVvwhtc
         pk4ri+UUEd9Ob+k3I2QVkw29OPrr8wahRftIz6QOzqURwVXFcM+gNNbigyLJqCNDvhVI
         P/oM0PEyFg87JMRCkA7/UQglb86x/WG0l2DxyUIZS1Z7oM/1k6h4jcg/UalLQgenDzJ+
         Hv9w==
X-Gm-Message-State: AOJu0YzvWHlfKvYzdpIeSxasZ64cnhGbmi9lzWiW4jlsrUzIwP3rrSkq
	vqxPzxTZay+pnGgiS3iJV2q6t/H171UNLvWnyBCFHJomJpCMTW5zbxzt
X-Gm-Gg: AR+sD12l8xOvOdNkc4eIp4TPqC9mI+Lgv9CvTU1ZFHlOoginpL0Fo09bxPQWueRVGwx
	0LTzxbtu77EkvVheTGE3dxEx+z3mOltkhjtiGgBWsAyJVLDJpWKqOXxMqasaF/fAuQXMX4rIhO8
	/TtxUDc0TVL/0mWMLk3jzOpFIEibW/5lIV2BKKGCG+sY9yZulp4yku7dvVcN91Fd9Nn4jFXDJZy
	Oh1vx2EGpV5Fm0MLUcRXXilzq2xwsvt2WOL4s3lKM1qFQjJ+ddTJ7h5PaJekTGHgh9WW7uUvT6a
	yyuQQG1p8KsEFwSUvd5zRPnfOGfmLmM2WlMjp+hvjOtEO1PDjPC7eV5c1kzJnbCwdi/ShHGD0OM
	2AF8pw3aKxOwNnuaHYrK7FcUtxLPi51LTPrsHGgpI0ZP61lDrue/TJ8KT2bTbXVs1ewXoMK08CL
	KmPDx449OyX+ZnD0QyKrO5S71qq86ne4JDuOOdZJXMX5ihmpOeZ4ucNGXZ/c0urvVM54xQOMcwc
	MmuqhypBC+6o6Xn3k9esIkPTkXPapZx
X-Received: by 2002:a05:6000:24c1:b0:470:2fb1:3dbc with SMTP id ffacd0b85a97d-47fd2b40e32mr1600723f8f.35.1785476548033;
        Thu, 30 Jul 2026 22:42:28 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm412873f8f.33.2026.07.30.22.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:42:27 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v3 4/4] Documentation: input: Document FF_TRIGGER_RUMBLE
Date: Fri, 31 Jul 2026 07:41:59 +0200
Message-ID: <20260731054159.1982164-5-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
References: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
 <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List the new effect type alongside the others so that userspace
developers can find it when querying device capabilities.

Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/Documentation/input/ff.rst b/Documentation/input/ff.rst
--- a/Documentation/input/ff.rst
+++ b/Documentation/input/ff.rst
@@ -85,6 +85,7 @@
 - FF_FRICTION	can simulate friction
 - FF_DAMPER	can simulate damper effects
 - FF_RUMBLE	rumble effects
+- FF_TRIGGER_RUMBLE rumble effects in the triggers
 - FF_INERTIA    can simulate inertia
 - FF_GAIN	gain is adjustable
 - FF_AUTOCENTER	autocenter is adjustable
