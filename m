Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138504;
	b=Qrq0hsgSeksd6wjhEuPO8lYUq1/3XC7dUZNFc49gdTTFuWcYN8pN5DP4iuEr1BCemcP5
	 I4y4bGKPvgNVz3tvH6GZkX92SQVroe7eEhPDI4b3+xYSxl65HId+hQRWUprLb+Ridijqx
	 Ou3nAZCbDBAuD9gtyWlxO/+FvmHxcxuirXjaeOUC9dQhSPyxHGRf2yVUa6dc1MjG8RMog
	 24jBQiZDPJDw4TwL9lwZqCwzOU/pNqGvIw1qq028vzL38ePRmXvjBEhO7URUxn04FgzRY
	 JtrCx1MZ/seCuFRkEGVcNydFIlHXJxG/NLc6VDjgfeC0lwwYc9NulUYGaXArCcV6OnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138504;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mime-Autoconverted;
	bh=dOidzRaZztl5Ekhg11I0NkNl9u9xypPjQvEu9Osqbq0=;
	b=5V5om5Xp76j8ClbSx0jJqA0u85mB2KyxhGYrVFm+WMDIVwT7IPcH6EoNpXL8LEY6LL0r
	 0XrYWcVoQVcrUWjx5f5EAiqY9mB3nKI3j+ll0IRsUYjV/CVexURdVrZ/hg/1cYYp36nCr
	 3FakevkypFkTrNSVU82kJeszDC7wo2IeE6whVnWbGjFo3M6h/OuTjgMQ7fi1GzG1539I7
	 yI8RL1pXGkEcyyifXc8JxPyp73GExwyd86qR6bTccVJqLrHAzpOypIDuvnYMix34/wUCS
	 Seapzb5QmAFy9d3Zf/JulN8ixNRxi1UohMTSYz0uiq6d4epaEqiC8Z5ZzF3jz0/uPVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8BD8B606A320;
	Tue, 27 Oct 2026 22:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD8B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68114.dsl.pool.telekom.hu [::ffff:81.182.129.20])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 00000000000807E2.000000006AE11F3E.0002F670; Tue, 27 Oct 2026 23:01:34 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,
  Konrad Dybcio <konradybcio@kernel.org>,
  Arnd Bergmann <arnd@arndb.de>, Gergo Koteles <soyer@irl.hu>,
  Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
  Enrico Cic <enrico@privacyrequired.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
  phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/3] AW86224 haptic driver
Date: Tue, 27 Oct 2026 23:01:22 +0100
Message-ID: <cover.1793135056.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Hi,

This series enables the haptics of the Motorola Edge 30.

The first patch adds the binding documentation for the AW86224, which is 
compatible with the AW86927 haptic driver.

The second one contains the driver. The AW86224 differs from the AW86927 
in many respects, so writing a new driver seemed the simpler approach.

The third one enables it in the sm7325-motorola-dubai-common DTS.

Gergo Koteles (3):
  dt-bindings: input: Add compatibility for Awinic AW86224
  Input: aw86224 - add driver for Awinic AW86224
  arm64: dts: qcom: sm7325-motorola-dubai: Add vibrator support

 .../bindings/input/awinic,aw86927.yaml        |   6 +-
 .../qcom/sm7325-motorola-dubai-common.dtsi    |  11 +
 drivers/input/misc/Kconfig                    |  12 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/aw86224.c                  | 582 ++++++++++++++++++
 5 files changed, 608 insertions(+), 4 deletions(-)
 create mode 100644 drivers/input/misc/aw86224.c

-- 
2.56.0

