Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7E1A5B9E
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708611; cv=none; b=jmKDkz2yJZDDyjNQ9MAucJBTzVETtr1Ls9NwA+rsoeEFF2jt3ZsneQpKT7bly3Au7C/oj3DgIUC5Xgg6GY7RWgnx4yeEQrKkD/9fcnR1TsnuFepcFYsgU5L3EZ3vVdEphULhtw+0Mm2sSXaq7NE7yYEAXzyJT9W3Ue0BlvBx2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708611; c=relaxed/simple;
	bh=qzyT0dzNYNRzCgv3FFeDbY8FMLcOkX1xXai2XHOpIog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HV8NhpL066HEI+ZxYx23gvMbALtthAMYh2YvNOESUnYc9Yhlaq5lpSOSV2mm1rmNNG2Sc0uy3x2hpMBomq3E/Im4ydI1PY3VaOquayX9p8Ju3hcHdwswwqGbznNrsyosBScHefg/Jh12qqyKn5qUNWFS7IoaMXlTbuXIlSjWBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anCgHfDA; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anCgHfDA"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-662bb8b1f93so1715522d50.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708608; x=1782313408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOnNk1sZYLOxT2mttvm70Wp3djDGUiIpBw1iucl4JHk=;
        b=anCgHfDAclc2V4UxZki+xwFGDlx3HUXFyn5hz00iJ7OaLfXWU4Kq/8+jRbJwSKbQqE
         4ys1TLKCA2+eIq5qt1k3c45lPnrHAx3eUMAtu26K7GZe6afVpGSEPckK93H8q7Hns0AS
         85ggMzH9hcpV5RIzTE2oytvriekTid5DTSac4Wtm8Bm61obF3Qe6ZtytvbwN0I8pjc4q
         C7i2rD8eR5rplF8TSCz1o0PV+LTY65Y8o8QTQn69Gw6Xl3tdh2LQd6KdQCtwewGbaXH+
         8xlrtJtZbYBzMmuJXiNaQsDfyLl2fgjUDy4pRbqPy1lheeipN43iIkjx+8UOGnU/rpA1
         Lb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708608; x=1782313408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOnNk1sZYLOxT2mttvm70Wp3djDGUiIpBw1iucl4JHk=;
        b=QIFA7JuR6gDQy/OAqhQf02/Y91vzZQbOn3iyKskAC/LP0qJLQEo6KkIvDVEs76FXAW
         zf45zt+1LJ2D/FWQQ7YPVIhGvpD08wsVWA/E/+IrtgWVmaltWgfeeuzLzYpxH5Fi6fo3
         2O7EvwMCWXBy/dbLT7tj1G6AdXSIS9FHHik6htYKIcINpKJ92MgPEEaf0PAj0p/HQuu/
         GDXUp023IwIH6VI39kbEO9I5be+22kCnGxUgd/6Mqr3k32jtW8juGFZvezEr6e7MyArW
         lxCCDFwrMXWOiCcjumynOXDYgJiu+EHpZJOWr1ir3Mq5As17EIHzJrds186c4hgZDOdb
         6R+g==
X-Forwarded-Encrypted: i=1; AFNElJ9Am1vmoGHZ0ycrwi9OVs4OaRTbDIIpGKNSIVB0/ia5VqmWd00EE/4IE0YFCEmAaHDdTZZl/5MZeISdHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHJGA4nC0tx2LDUwReS0AAHRcw+ee4Nw8LlKQHuH/YHgtzExP
	khAxbGkPUZ6OMLFwivz5/OO2TzI23dJznH0WfFsRNyGlOeuJ05u4sMly
X-Gm-Gg: AfdE7ckSfDX3ZAoo28Uesz9bCoS8ab9V15q8XY19dngioS3Fr761jfetg5/XHA9GPz6
	UFdUWcSF1Bpgi5jsGEevu7FzqJU3nvC/O8pDI5OVw8uuUdiYVQumgoGRwuhsVIWZyFPjJOJ0ZkT
	PeofwiGv9WZy1OWPY7jAjdrsS3cs3Cy8xBqAthaXuMPtZX4uoyNRm9gP9snjk/UakjsBIAICkDP
	r6I8H28r0PQMLPQopD/j+qddlqD/9AqMXR5ltnDtjywvKc0yiVHAHy6/C57bKMg3uiFm+SzAImp
	cxmpeKOhVhnobHe5QKCbkhxfb90rI4Oiay5ZvR6Ccf/I3Lik9CYmimMMa+SoqqLDZRXrOPkNt53
	blyAn8pofPyQ4ZnfA3TACu1qtSzxfA5Uy6WU0Ix0rCpSsse93FTm+ofQX29/Lmso8h4tOpwpkVU
	kYMisKEjErWA==
X-Received: by 2002:a05:690e:480a:b0:660:5a04:9a02 with SMTP id 956f58d0204a3-662cd7a0977mr2345514d50.40.1781708608042;
        Wed, 17 Jun 2026 08:03:28 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:03:27 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/10] Input: cap11xx - Add support for CAP1114
Date: Wed, 17 Jun 2026 23:02:39 +0800
Message-ID: <20260617150318.753148-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support.

Patches 1-4 perform driver cleanup and DT binding tweaks.
Patches 5-6 add reset-gpios support for CAP11xx.
Patches 7-10 add support for CAP1114.

Changes in v4:
- Revert cleanup operation for CAP11XX_REG_SENSOR_DELTA.
- Move the LED unit-address update operation to the CAP1114 support patch.
- Limit the CAP1114 LED unit-address range from 0x0 to 0xa.
- Link to v3:
  https://lore.kernel.org/all/20260615142103.352163-1-jerrysteve1101@gmail.com/

Changes in v3:
- Simplified the logic of the reset pin operation.
- Adjust linux,keycodes configuration for CAP11xx.
- Drop unnecessary CAP11XX_REG_SENSOR_THRESH(8).
- Checks for the presence of microchip,calib-sensitivity and
  microchip,signal-guard properties before processing them.
- Link to v2:
  https://lore.kernel.org/all/20260612072237.1177304-1-jerrysteve1101@gmail.com/

Changes in v2:
- Drop LED property tweaks, keep only reg changes and node regex
  update in DT bindings.
- Split microchip,cap1126 LED reg constraints into a separate patch.
- Replace usleep_range() with msleep() for 500 ms delay during
  reset pin handling.
- Add missing <linux/delay.h> for usleep_range() and msleep().
- Add CAP1114 to unsupported enum for microchip,signal-guard and
  microchip,calib-sensitivity
- Add constraint for linux,keycodes to support CAP1114.
- When reading CAP1114 button status, mask STATUS1 to bits 0-5
  and OR with STATUS2.
- Adjust code style.
- Link to v1:
  https://lore.kernel.org/all/20260606150458.250606-1-jerrysteve1101@gmail.com

Jun Yan (10):
  Input: cap11xx - clean up duplicate log and add probe error logs
  Input: cap11xx - remove unused register macros
  dt-bindings: input: microchip,cap11xx: Update datasheet URL and LED
    reg range
  dt-bindings: input: microchip,cap11xx: Add microchip,cap1126 LED reg
    constraints
  dt-bindings: input: microchip,cap11xx: Add reset-gpios property
  Input: cap11xx - add reset gpio support
  Input: cap11xx - refactor code for better CAP1114 support.
  Input: cap11xx - guard unsupported DT properties before parsing
  dt-bindings: input: microchip,cap11xx: Add CAP1114 support
  Input: cap11xx - add support for CAP1114

 .../bindings/input/microchip,cap11xx.yaml     |  90 +++++-
 drivers/input/keyboard/cap11xx.c              | 274 +++++++++++-------
 2 files changed, 254 insertions(+), 110 deletions(-)

--
2.54.0

