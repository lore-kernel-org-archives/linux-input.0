Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978084DC541
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621599; cv=none; b=gldW45MpopznkDvQliCbGSeBmeu8E345Q5po97aWBS//ILQnLpVzwuUR04i4zKwnJs2cYj5VRrI2xtWmQQZoIBaHzIGZPJVHYqKQUCcyGmnp11DxFEyyGv8hJ8cuUpC6MNG9Lb26qOs4VTX3spudDBoh2tePHFIm1bA5DCV35Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621599; c=relaxed/simple;
	bh=e7LwMLlt3YJJiCRG69wWP3F8RTsG2YpHYR6vE8zTtDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsEuDgfRWbKDwiH0rUzCWrnqB9Q3lvSCeHrZx4vPK/QmCmBZPn70+eb+JMQ+gPl5q4yw+XtM5i8r+5LecDW5bUU1yfmA1ooyhIG9CQUVnFxfhQMVLpFXqDDx71GD5rQAXlI7c3Wk+W9KVYnQh7m7x1VeSabk0MwcLN2LfIRSE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=r0mPiyo3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="r0mPiyo3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso183491a12.1
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1783621596; x=1784226396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INkPlYJVYmGdtKbwb89VFpcKn4Gp9KScp/ldb6EBeqo=;
        b=r0mPiyo3eGZJ/oooED3FCBE6ybTzg28feEznJKbTxlRQniHUzIQBliD5TQ3p4ZzTD+
         3V/CxHPZDKi1H6GRaBd52Fvp7zP92CSjpEGaQ6ds0+wGRkJZInYxonteuqyKUGpENrUY
         Wx5IknG0oBMA7j6TxTZsiGhgavOlJCw2P4ImHs/tEq3mrLbeCwxG+QlStVamp3rUsiGO
         HdxLeBp4hbnuJ0TbFltzX5sV0jmcsCi8E2BEw/3DcIHK7n+2Fn2hZh7ZKgVPJNQyDfAM
         qH1V+7zrLm/KbCPLYZYJ455KTKYTOIV3hSpQsTNAeiigmGNLsdW7NpyfslDBebqlNbcP
         +Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621596; x=1784226396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=INkPlYJVYmGdtKbwb89VFpcKn4Gp9KScp/ldb6EBeqo=;
        b=efHv+/KEEdGf7iFmW7VUo3iqvrj/D2zbW+wkTGRWaaAuMa+S67/LKsljPdqcC2FVIj
         a9AZEnmPgB3CUhisif4Efd9roPZzZTtmhkua0Ll8ZNwLle58Fhr20v6b9zM8IBOQb8Po
         wxs9FDeCodjIusluWpMz7W2zI2lSkKrXObjZ751T8i0YmtU3jCcX+j1eY2jtdOu0S3J8
         BMOqD8LPMJZtfyjnQWFJXuhHrxrJFxjjIU0BwaCYrn8dcpe/zT1/SfRz20Q42Ocm1Qew
         hlw1l+qq3DSotGi/P7XZUobODpnjdIBXUWltoXNJnJhU0ZFIhfbPAwZE6NIUDaODbo5j
         1ofw==
X-Gm-Message-State: AOJu0YyYhwhLZzLfRaXjPJSAao4IDD4z5XUblYIqdSKkRSu3y1VYygV0
	GwohWeI77FkK/jpGX53n2jTL6ObuFrjpSAy/4IXOXvYJRjFjJjTMNlWMhj0HEAPxJw==
X-Gm-Gg: AfdE7cmQWXFQ32ZIiuhitUtV2wXuMM1ZZOXxKVZHGWdopaXmADT7pz4A85N7NARufKR
	bPozPixahen49cKftlKTGjQbB2U9L9Ffb7vzL5zq93hBBL2FRRegbqKYee8FYBFpn6dz3QdareV
	+d08MjKp6n0kAzdWB/+k0ZRTu2V/VZJAVyI0pheg73uzI8M82Y611BjZzQ+3aWDzCjlDyX5Wab3
	CVkqwIi8a91h3jEYFP7sSzPe9m9Xl5n+8HEBw0OvuXb3rA9bNAZYCH1dZq27sXAswSWN/rUFay9
	GI/wXB1djcrD9GbyBc0tqmOiK7YMRDRA4IdljTi4XSW7/iQa+Ak+7Mb6jJah/QvgPiFLcxnQpnp
	pfYfwSpSxejhkriLNqx1G6qfrWaoxX2+NssUdcvwKgTBg1hbROZMtwx+0KLlQjGkP5ktXRknp9I
	I8kVf4vxAn4ImWDWeZzPMHmMaHdI+0FV3eKvMQUX0qKA435gHq7HvxY2MpW+HWk7re/Qc3WBRxU
	OBQtQpHPj1AB1dOxsCK07nNrKrHD/JL4bYyx0O830Gi3HOf1wsf
X-Received: by 2002:a05:6402:2345:b0:698:1504:e3d9 with SMTP id 4fb4d7f45d1cf-69ab44a23f9mr4027419a12.29.1783621596073;
        Thu, 09 Jul 2026 11:26:36 -0700 (PDT)
Received: from localhost.localdomain (2a06.4004.215b.0000.2aa0.6bff.feb3.5b8c.static6.kviknet.net. [2a06:4004:215b:0:2aa0:6bff:feb3:5b8c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19dbee72sm9934268a12.30.2026.07.09.11.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:26:35 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH v2 0/3] Input: ilitek_ts: add stylus support for 0x0c reports
Date: Thu,  9 Jul 2026 20:25:59 +0200
Message-ID: <20260709182602.7308-1-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626214248.5563-1-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I bought a CHUWI Hi10 Max and was annoyed to find that the built-in
stylus was not usable with the upstream ilitek_ts driver.

This series adds support for the pen report format emitted by the
device, exposing the stylus as a separate input device with hover,
pressure, and side-button support. The pen device is created lazily on
first pen report so touchscreen-only hardware does not advertise stylus
capabilities up front.

The packet format was reverse engineered on this device. In particular,
report ID 0x0c appears to carry pen events, pressure comes from
buf[6..7] shifted right by one, and the side buttons map to two bits in
buf[1].

Changes in v2:
- manage the lazy pen device lifetime explicitly and tear down the IRQ
  before unregistering the pen device
- sync pen axis limits with the DT-adjusted touch axis limits
- reject short I2C transfers in ilitek_i2c_write_and_read()
- split the short-transfer fix from the ratelimited logging change

On the tested CHUWI Hi10 Max this makes the pen usable in GNOME/Krita,
including pressure and side buttons.

Thanks,
Kristian

Kristian Mide (3):
  Input: ilitek_ts: add stylus input support
  Input: ilitek_ts: handle short I2C transfers
  Input: ilitek_ts: ratelimit unexpected report logging

 drivers/input/touchscreen/ilitek_ts_i2c.c | 149 +++++++++++++++++++++-
 1 file changed, 145 insertions(+), 4 deletions(-)

-- 
2.54.0
