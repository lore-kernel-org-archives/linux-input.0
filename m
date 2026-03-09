Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DFE393DD0
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054069; cv=none; b=rfctyl5u7cZDZxfZdZm8x89w/VmEbYSCcC/Kyzd6bh1JlktlkwGZPaeMePKgafUXhfqEy0pPWOg5USAup6S4J3xpDWhSVc170bccWUuh4et6k7NDR3mD5HexE7kngDmNrQDn59Awzti/7zGk4FmZWqoVJnPVbTFeE3gAogZLJw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054069; c=relaxed/simple;
	bh=gKhrwmRy1/But6o5WM7jY3uT6q9+gXw34J3KmZB341Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZylz3PUU8exBMdHdsYVVyERLlvrJtu2ru+/++ViAPl3I+viSkju/t8CQFb5flPJEF0EYZyPC/IB6zVB2gBYAQImCuRrDHKzQdn/loPSQKuFP2VAAhr1+jJNeaG3AAIASm6o+GLy7jSZeLuKNHP+aUyrP/7/WNCWRjwHWqQko+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abhr5uNJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abhr5uNJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-359832fc558so6368486a91.0
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773054065; x=1773658865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qS9+QDrPf/of251vEjU1bJ/OgJ+OlOTQdnd6J3ZiR4=;
        b=abhr5uNJzayz7t//5uTPlWM/kqh0SKBgDUJtUNtbtO0J/aLDKd07ZbeNQK1FLiRqI4
         WHOo2yH59tuLUUY+f3CR3siCoPEPmu6geN2e4sxct3or44j37yC7+RenWGS3fKE769Mh
         OsdO32MX3fSaYL/4JfY3GDQGANpScgi64ACCA3bURJ/Bb8pstnvunli/7M45344WDPTG
         IJAnw69pU7VGFOiICzqSqreYy28UN6+o3Ux+slQ6WNQRfF261wi9rBa0ng8FeMsd6sqk
         HbwdIMCOmdivj7dGiGr1bzFEvKlkUZjJzRhfsrHU+5KeZ/JwrOSdKaHnKAQjrzN28bBy
         087A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054065; x=1773658865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qS9+QDrPf/of251vEjU1bJ/OgJ+OlOTQdnd6J3ZiR4=;
        b=UiE00Oz5y1aUhbxtBiL20tDQiQeXqfoeExKy56rM8R8Pq/JrDuXWZZJbvPay+r/gT+
         WpLf8p/sjoRCkuLPnaaqxLCXXwR6D+x7+oEg/p57QA5wKEMAOYcGsmFVyP1dgvaC1rr/
         PQpaHenQE/ANj4HpiM6f4iO/yEpIACU9tj8ztC/V9eepP62ZiSiKvgiGQ0HIVg3yRhYD
         Dv1JRlkFfgEDhrlPQYiHfganoxqyesTN0er49weiRHI4hOkuSXlyK2Y8p5o4slDF5Jzi
         5ib30u22KZOY2cSY54EUpL27f8YBZGqwcNnYxB/I+HcnBv2YJU42SK6y8kbwOqVD+8vJ
         YIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1dpxvV8Q6urj7bH82/qSxnLCy48LLSB2lzfJq5QL8XEh8xLJ5eAIW38ykO+MQTX2Qj1t6jA3Hu+5dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcU4YCEaa+XKe1IRdSwWBVBwE2BGusxkQ0fCxhn4k7fUQwlxO
	ypDRMjOCtLDMG0jfNQdTeAWvtkJp+bZeYROVDqqUWPb/M+NZzDftwr5Y
X-Gm-Gg: ATEYQzxPTnWbgRiR77hiGL8u185MX0gN9ZceNjt0M/n88bL0iMvs7V1xTgN5OMWFI9J
	gwhkJYqaleWJOWNMbvIMfNfqshPWVl60oNMQlET1fQBbrTb67iUoXOsKsXuBzzY6DnEignjF0bf
	EbM6RntRsIa30opORJi7+Bj+6ME8kXdWn0yvJNnJtNfHpymx8HMnBfm3tMxtw9lsHE2MQNArvY1
	Xl7AB4KYq8yh7FjFFmDn/+GlqVvRU1Hy/+CyOuY+D1d6IGMLfcIaeq0GMZ5utsa12LL58cWFX6V
	Xxjr6hJtey8EQP+w3jRQY1OX8lzk8I8oTogycEWPTYsariDLrt2SypN2oh9jXUdWP+UxB5L9IOz
	8sTscZDDyEXqJ8/vr2Vz/8NLuLoXT+GsgG+ZhJLLMh5wTNUeZMxYHOFeyljHfo/IXGU1a+AqQ19
	19Ufsmn0uRWUIfbywrsZj9s316vvPrtMS0qIiVMaln6cBT22OimUjRFVqfQw==
X-Received: by 2002:a17:90b:4a50:b0:359:8c89:96d3 with SMTP id 98e67ed59e1d1-359be297579mr10350265a91.15.1773054065108;
        Mon, 09 Mar 2026 04:01:05 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bff279f4sm13268296a91.0.2026.03.09.04.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:01:04 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Michael Welling <mwelling@ieee.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phucduc.bui@gmail.com
Subject: [PATCH 0/2] Input: tsc200x: Improve wakeup source handling
Date: Mon,  9 Mar 2026 18:00:42 +0700
Message-ID: <20260309110045.108209-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The tsc200x driver already uses device_init_wakeup() to read the
"wakeup-source" property from the Device Tree. However, this property
is currently not documented in the DT binding schema.

In addition, the I2C core already handles wakeup initialization and
IRQ wake management automatically when the "wakeup-source" property
is present. Therefore, the manual wakeup IRQ handling currently done
in the driver is redundant for I2C-based devices (TSC2004).

This series makes the following changes:

 1. Document the "wakeup-source" property in the DT bindings.

 2. Delegate wakeup IRQ management to the I2C core when running on
    BUS_I2C, while keeping manual management for BUS_SPI (TSC2005)
    to ensure correct behavior across both interfaces.

Note:
These changes are based on code inspection and the documented behavior
of the I2C core. They have not been tested on physical hardware yet.

bui duc phuc (2):
  dt-bindings: input: touchscreen: ti,tsc2005: Add wakeup-source
  Input: Touchscreen: tsc200x - delegate wakeup IRQ management to I2C
    core

 .../bindings/input/touchscreen/ti,tsc2005.yaml |  7 +++++++
 drivers/input/touchscreen/tsc200x-core.c       | 18 +++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.43.0

