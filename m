Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB93DAAA0
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031697; cv=none; b=poaMS6BLNwhaBcMsTgY3wn9fLJixS2ThabbnmRZRY6oaC+aptXl58Xu+j3nG94nCzNU8PE2P8IgeGLtmpEeZSQuVfEcCOd/LzBnbROKR9YqqWAmtqrvbEWftPsk+l9GVeplRFtEa6jL6UJo1+RkrvITrTtR7ZbNUHeAAjugzRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031697; c=relaxed/simple;
	bh=NRKScEnPh0zPdlf0AwpfifvXkF3txZwkPfUFOR044BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbqReyXJrkWEyQmRT5W56cW1UdDnbgrYndF+oFRmHr6K6EI6TpuXRzM8An3UFbT0dOv635MODD2qUNsv8J9cd2a9eZMqdYI0aC4ewoZjEJqfwK+aUb9G6viYDRtGznPmVsqVFa/oSv1L6+Vzy/UlIqjmpl0zE+wtWfRAD+pJBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbGJ+MYZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbGJ+MYZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48589798dbbso5608434f8f.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789031693; x=1789636493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4Bwx1DhVI6FUsnbRcI8yiZi82mxSdYhwi0jzDrPMfE=;
        b=pbGJ+MYZqSXeCbCxdZoTfArzHkOBPnHCD/Cogl5BL1zpbOKh1zAAz9C1IoXQFy3f5Z
         g4970VGjUkYlUEu7ItdnWUp5SmoZNzkBCd4IY24aygYPgJ/jzNsmWQXEj7aCyFajNg5G
         +wdLTeTgQshpQcoytCRt+LooPhAmoK90Ir5pHegLYYvANY/2pzbFFJOvG3eqQgwg3LXm
         /g+PMWgYlP5nFvkAQ97Qgllg5by+weJjGWNsUEP0GtuFf0aHVLYhK9XvqJrxAOEibBoC
         1JwMPl8HExV2OO1y83oE5WtfreuFaCrqlPz6C589wqnKlaqUqVfaLFkqfr7XKpbUiElM
         qnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789031693; x=1789636493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4Bwx1DhVI6FUsnbRcI8yiZi82mxSdYhwi0jzDrPMfE=;
        b=NF0D3AaTb3HWiYDSoBx508Jdg6qR86vZ59mAd+ClXJP+1ZtRFwYtyvfUqwWVtof0wP
         dI1V6QIS2pyXk8mGKZ0m/gFcdm88ppk4Iwo4/NnnIJTZY34A55ePQep+qh47//ke0HRm
         hxqP5F3622kKfkntA2F2M2cub/zLVZdcf/yl7hFDszk3dA7Xp/bmaEK8knXw7OCAf8ha
         4t1icef/6VdsncBtXZdMADuObv0KQDh8IjgRenfjnBX1L1pYpAiMc6cUMUGWcokp2VDp
         sCjMcsJ+BAdBIZf9/ObM9tNRL4JV6pR74J46IDa3GGdrLCKQJFAisaREI5fdceq4c/g6
         Krgg==
X-Forwarded-Encrypted: i=1; AKwUvBxzzwzz509P7/NOL9DfBmP/CcU1JKLi5PsCNbzid78oxlLjIPB5WuNBqc55wlvwJeDEcSnl42geiKzvnQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mz05Aw1EcNZqAA9MEfVO5aID0y2PVuLOOyumraJ2FgMliLVtse
	bIWUYNMcmTU/CYmDpj3wFmLmiqnqUCRIlbuLCR3hCmYv6x5j87NEDmZdNPVtF0+8
X-Gm-Gg: AYBFou29aTXlgDXguKLIH3OvQSOS1oeEvi8CSvn+nt04fJtffdJsVxq0Q6JrqMb1Aid
	5Q/AC77stlgXKkXRNx/ROwRhWTkxJH127E1Ck009k5acFtiyvnui1b4Jvlpe/SHaoEt178IMjxw
	djWbNdlA9JY695XCEmCCEEMY8YOHUUEda0uyIo1a+CtevZsJuH3x6u+uFMX6I7kb3jFo15hFwY3
	1ggP+MQHs/IUgGkkepBbSbfrkE3YMbM5pYhjn0pcZHTjMUndw8FHhu9WHqURNOORH/xRWbo8Zcq
	3xI7ZShskXD7DeqIGFDNXHImnj1CHyfgNEPxLKz+4d5WzOKn7ABRFjxe9jZ5Lnwntfek5pmn98x
	/zViwr+qPv0G1MdExLVRt1jo5nI+R9smfoBtnPydUJgE/aCP105V5aMiQRHvmuli6jpTZd1F+68
	kiKYeCQzZXVVLmqiTZYUD+Wbq1+MD3wTS0vdUUSIYL6vd3e0cQwDrfxQL1Ne37JKfJ+dyprucvk
	aJWCXJ2xJhwbg==
X-Received: by 2002:a5d:5848:0:b0:486:e37d:c58d with SMTP id ffacd0b85a97d-486e37dc646mr2555494f8f.22.1789031692803;
        Thu, 10 Sep 2026 02:14:52 -0700 (PDT)
Received: from Empers0n ([193.23.219.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bbb51sm52065435f8f.30.2026.09.10.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:14:52 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Input: add Synaptics TouchComm I2C touchscreen driver and bindings
Date: Thu, 10 Sep 2026 16:14:03 +0700
Message-ID: <20260910091405.354058-1-sevanevorotov29@gmail.com>
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

Changes in v2:
 - Fixed continued-read chunking in syna_recv_message(): accurately track
   stream bytes including the trailing 0x5a padding byte, request full
   64-byte I2C chunks (up to 62 stream bytes), and ensure trailing padding
   is consumed and verified even for 60-byte aligned payloads.
 - Clamped active touch object count in syna_parse_touch_report() to
   ts->max_objects and guarded offset calculations against integer overflow
   and OOB access in syna_get_bits().
 - Made regulator power management idempotent with ts->powered flag to
   prevent unbalanced regulator disable warnings during teardown if
   hardware recovery fails; power down controller and propagate error code
   on recovery failure in syna_resume().
 - Removed touchscreen-size-x / touchscreen-size-y overrides from driver
   and DT binding example, relying on native resolution reported by
   controller firmware.
 - Documented mutex locking contract on syna_exec_command().
 - Added explanatory comments for ABS_MT_PRESSURE and TOUCH_MAJOR/MINOR
   default limits.
 - Sorted TOUCHSCREEN_SYNAPTICS_TCM_I2C alphabetically in Kconfig.
 - Fixed commit title casing and checkpatch warnings.

Vsevolod Nevorotov (2):
  dt-bindings: input: touchscreen: add Synaptics S3908 controller
  Input: synaptics_tcm_i2c - add Synaptics TouchComm I2C touchscreen
    driver

 .../input/touchscreen/syna,s3908.yaml         |   69 ++
 MAINTAINERS                                   |    7 +
 drivers/input/touchscreen/Kconfig             |   15 +
 drivers/input/touchscreen/Makefile            |    1 +
 drivers/input/touchscreen/synaptics_tcm_i2c.c | 1066 +++++++++++++++++
 5 files changed, 1158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
 create mode 100644 drivers/input/touchscreen/synaptics_tcm_i2c.c

-- 
2.55.0

