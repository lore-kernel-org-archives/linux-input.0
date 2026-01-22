Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC73994C9
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110580; cv=none; b=f8tVu911z/lirC+1NahgNReyWsyJXJqzu9N7auwdtCN+O4CyJ+a8DJNXkxoG+jmkqrie+yrQtDUkbPg4A5tuXIY061N7T3GxhB6yeIJ2lID4r+vCRzpKt1Me6GUiTyDK2jn0+KXzNB16p7cLURDzE9sfff2g8Z9M/c/VhVYnKO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110580; c=relaxed/simple;
	bh=6bcOzK12X2n239i0z2HYrans52sIg6wjGl8x+aSjd6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckoZjlqCs9MxzUcatoGha55PwR8QxCzLQXJsZE8qlAzosftf/hurxw2+DxBa6z1jN8cFp8lec6hU9T2Scsuu63AbwvUK4TkUGrzKkf0DApRoH7dcBa3H7jnhsonE/zowW+oWKvx2mDHOaC3/q1FCMaEcFaaFEpXBhD12gLNQfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfdMYZjG; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfdMYZjG"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so15431285e9.2
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110560; x=1769715360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwi4ZRaqC0fLP1GDcRU6oR980s6aWRwXFTKbG3IWwZ0=;
        b=XfdMYZjG8R3OOWYd0TwAsNMqvuEnUG6PTMHnSDc9fWYqJWgmGuQ+8l8zcV9QXm6Ee7
         rvvEaAa15aNufjEjStqtQ1a7wsPzwegI8rcpCBpYMwBe1uC0YW6P5wXJSUkEzd2WcyzE
         XO7JwKfBxlKt3B21pRIG9g9o8VPuQqAGxLcZWNjS2/yjDOZlaXjcqzbHm/vB8TI2lEnI
         bXgKMImoRSi+n2nJ+pB64w6InsrUEc+SK7mjA7T4njUhVuG56PyJduPi99t+VbYXXxD1
         zbOxKgAi1Qx5ApjjhEl62RpXcoOpMStuhBGh6fTVTIOYoDzgaDecjwbF5MOF/nBOULgq
         bafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110560; x=1769715360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwi4ZRaqC0fLP1GDcRU6oR980s6aWRwXFTKbG3IWwZ0=;
        b=ZiG3d/zzSFsHDltEth68iW9siCj1lj/9cBtg+8MsrfglZFMo1PzQ7UkfoohtSMnPjh
         CxUzCHY6uj+6LHJmEp3ueRXBGHdOSu8U58zy7DDg5r3EXAX6UtdU9Y5/T/Qa/OMgiqmR
         yWMqAEmgDIH0CGbk31AZ+yvHnw5S2ceAcn0psImuI0PbDqaa9HJMR9j9q7dG1dkB1TrI
         9+KXK5wUTitExL8NmTFhC59WaL1SAfxfTD/s93Dkm1apvuKL1ZszUsWslnwOf4YnKYl2
         N4Fb4kw65H93Z/La0GEDBEv5/uQHQAxGz9UIx/gxkTHrdz/IfazT+Ig58Z0QwtdXypEf
         xcGw==
X-Gm-Message-State: AOJu0YyDaKW0SWz3x7GMpZzyWBiSNUeA6jkEA+vHruVS0MFjwaYk5Mm4
	V43bz9s4d09Tki9ZvjHuGCRBpZM3VwaMtdp5gl7MMVKN2fdnhG06K3nM
X-Gm-Gg: AZuq6aILz/42baml41Rbn8oJgsy909QbIt/uLiOvHUO5uaEGXwfwkKx73q3Lw+5e51o
	8POsvpq6nUSwleATgNUz1YyDAbx9WSwzQ4igH6cLK0uqeDjxtA1SnPKBzMULeGevaYwjL53WtiU
	ZnP6QlSfTiEy9h9bPns3vqwuIDTVDkgLQppiBT8uhHS37+fwSYg1CBt44ae3pRyLrAYlgdoJhjC
	Ep7WyYb/knBuDjV8616xc+R1V74fKgLR1I3WiFgsWbck+COax0qrqes0nayQUCOWNoGktdU06Ty
	CM3tyPX4z7v3JxhA4KXYPp4jGYw9p8XdkTVur9wtRa6h+0XENuCqnwkjaHIc7Ehw/LTCsAqUocV
	zHrMRUDJP+Ldvs3hMEXIL0RJnypeXOwhTnM1w7VlgkekdS4mDiqvt9uGSq/2gENDkHch/bAOtSh
	t2
X-Received: by 2002:a05:600c:3f0f:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-4804c9c0ba8mr11723685e9.29.1769110560378;
        Thu, 22 Jan 2026 11:36:00 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745e6sm843027f8f.33.2026.01.22.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:35:59 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] dt-bindings: input: touchscreen: tsc2007: document '#io-channel-cells'
Date: Thu, 22 Jan 2026 21:35:48 +0200
Message-ID: <20260122193549.29858-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tsc2007 can be used not only as resistive touchscreen controller but
also as a ADC IIO sensor. The second use case requires '#io-channel-cells'
property, hence add it.

Svyatoslav Ryhel (1):
  dt-bindings: input: touchscreen: tsc2007: document '#io-channel-cells'

 .../devicetree/bindings/input/touchscreen/ti,tsc2007.yaml      | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.51.0

