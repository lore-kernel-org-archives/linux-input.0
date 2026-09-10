Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756C328B7F
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024066; cv=none; b=ioAHWev9o/8LSjPlgfHClXb9V/w82Xu5eXxzGXEC8jy0XqR8chmXb3pKB0ruXUZlon0UgBCKJKL4gfqLy+R4i+c1UoBZPMhATRUq7QZ8AevQ/W8XdcBrxyDCnXF2F63snWFLEg9YPcVCsz1AH53ta8MpK8ZGHr1X3vYvIbv5ZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024066; c=relaxed/simple;
	bh=7TGmcQ0ut3jQv55/l3p0mRfZ3tCXRLFJyZ/GoBCAVyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iM0SQvQuozwk7kIR8qLEC68cHVha65lx+9q830Hg+dKmD/spRdAfxSfc4dOekXlfC0AO3dFwaC3b6xXmOAML/dEkJ5uTHPSLJM19QgALbVGo/ShUJ2iLReuj6aUi1N3rrCIg3AR4jz+z43crCqe3BTtIxS7UZCtMGmrBJeHfRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtNe3wmN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtNe3wmN"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482e257a23aso4455085f8f.0
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789024061; x=1789628861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3B+mk67NOh14yB8lu79Jka4GJUJbwG6mwKbpmyJ82rg=;
        b=KtNe3wmN3dphauQGw6bTwU6OfYofoixT2zuTabC6+aHghgOZvlKJn1hRieE6REu1/q
         bKmA9GDmmChky3wBLv+be/e/YchqTjFLTOhAOYb6pIqQQKqZQff8u8e8cH5A9wCLdFg7
         QehRIYJiN5ylzL/wT6QSsXQMXOWAR3SNQ0snsJfb1uaoiHJrN6YWpEyiRl/t84dhZbEC
         ENDIYJPoWBjeeQ6dcM//+MqxITSE+I4aNjjsKgJ94aAD/OmxsDPh0KmlmYQxwm6qlJef
         rGaqEexVjkaN4R53mYjWWQfE3YkseFfqzmCK5+1vGRBx6xE0ynGo8MG2eMooGsM6kUMq
         WDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789024061; x=1789628861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3B+mk67NOh14yB8lu79Jka4GJUJbwG6mwKbpmyJ82rg=;
        b=I3Qa5IECmOaHSaCHOdb7QwQ5uA++JfUZD+KKO7A3OzTK99WUDZThkWoaX7dqVAd732
         ZqhqFPPhpB8sWLmeEE3fnFPZsN77UVcMYt6FTRsvcPKjTobHGIkQpGF3PmxHYOMFZIPm
         Qpj1qibIvkmCp3ExMcmTozqyKFY2kSfnXjNWqLxagIniXFAdTU4kTXjlAelEaRbK/68C
         NmboA8IslTWtnPNkJRZry2oDVItLZFcMfFc8sOa6A6kXEWei11x0/iN/ogbeoYp9V47s
         ispBqaQe/DThqpRygG7GUYEEAu9gcsJJtzMJyDxa094xdfawJ5ShoRZGB7AOrvNy7Q02
         Tzhw==
X-Forwarded-Encrypted: i=1; AKwUvBwuaZa6rVJYAEy27KbiyVV0GykJECdCKctPHf3tStYgvKM+ky29eVx+FsEnWTtXU28GXrFgEycTxJc2mg==@vger.kernel.org
X-Gm-Message-State: AFuF++kPsug1pNKhOGnJbZHnk7pK0TvZ5k/mOAt5sivaUcQVkBQZd08/
	Zw5wwmD0C4Cs/GUvVJkgJxcEErmwQzvcrwqzx4L/1JnO4IQQtxJSZYyk
X-Gm-Gg: AYBFou1XZKV8U0WE1LYjczQjzzIJsmXtdeEP39kPdhGG6CmBkeXE5V87FR1b4bUKHUm
	5M+wkDSyKYQ8xXnS7tqhxyzoXjYETZK1raEyUVhNGl/x0yZwrbgpW2wSZAs3akKEZ2n1Czp1jPy
	57MgqE3BRd0z/JEZqHfYbz3dXZWN+8D0315Y0tZegKtIueUEQu+fitUqqG3ij5mTKZ4QVRlCLMV
	+fplOf96uB6UgHgCdobdSio303GyuY/07A+FKPIyp1Ko1O9zFcT44Ubm0RbwoqHtoZivHPwJcHO
	EFbyz7MzINn/jTUbz3xXf4bfCMKQR/50nUTv4yBDW7Mi6aaW1ecOYOT9Fr7jX6fpg5FHO0Epgnw
	PeCy/8tmchThuvCGrCmHEt5/0cnGT10SleBABE8xxM5k1jUYeLt0id0sDybV9UDNZPS0PeZ8RJq
	sIM5rzIvrnS1tUM5MER28wQnEgiBRBulH1LOXh2uFgpc6OUGSkvJ05YKveMG6yrHLLevJLKcqKu
	5U=
X-Received: by 2002:a05:6000:4703:b0:485:93c5:856e with SMTP id ffacd0b85a97d-48593c58629mr30970075f8f.9.1789024061125;
        Thu, 10 Sep 2026 00:07:41 -0700 (PDT)
Received: from Empers0n ([193.23.219.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883959f0sm52244311f8f.10.2026.09.10.00.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:07:40 -0700 (PDT)
From: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vsevolod Nevorotov <sevanevorotov29@gmail.com>
Subject: [PATCH 0/2] Input: add Synaptics TouchComm I2C touchscreen driver and bindings
Date: Thu, 10 Sep 2026 14:07:21 +0700
Message-ID: <20260910070723.347768-1-sevanevorotov29@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds devicetree schema bindings and an input touchscreen
driver for Synaptics TouchComm (TCM) generation-1 touchscreen controllers
connected over I2C, such as the Synaptics S3908 found in the OnePlus 9RT.

The S3908 and compatible generation-1 controllers boot autonomously into
application mode directly out of their embedded flash memory. The driver
implements communication using the Synaptics TouchComm packet protocol,
retrieving device identify information and handling reports through a
threaded interrupt handler.

Features supported:
 - Multi-touch reporting using the input_mt framework (Protocol B)
 - Dynamic touch report layouts and coordinate/pressure decoding
 - Standard touchscreen properties (axis swapping/inversion)
 - Low-power wakeup gestures (double-tap to wake)
 - System suspend / resume with deep sleep transition
 - Regulator and reset GPIO lifecycle management

Vsevolod Nevorotov (2):
  dt-bindings: input: touchscreen: add Synaptics S3908 controller
  Input: synaptics_tcm_i2c - add Synaptics TouchComm I2C touchscreen
    driver

 .../input/touchscreen/syna,s3908.yaml         |   69 ++
 MAINTAINERS                                   |    7 +
 drivers/input/touchscreen/Kconfig             |   15 +
 drivers/input/touchscreen/Makefile            |    1 +
 drivers/input/touchscreen/synaptics_tcm_i2c.c | 1033 +++++++++++++++++
 5 files changed, 1125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
 create mode 100644 drivers/input/touchscreen/synaptics_tcm_i2c.c

-- 
2.55.0

