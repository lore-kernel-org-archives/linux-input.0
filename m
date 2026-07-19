Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056E245008
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468282; cv=none; b=t/vTRRwOuw4n6t3ewEnDqwwVa070AQA4LeG31QHbJH+an4B/Qh+gz6OguFbQUKXIh6vbaqQPtRc5k63Niy0a5BX5I9VieoyzchttEUFxlIOYGXrw7G6xsFLjDmieRyo3V0gi8kZ+xdtAo4NV48zogFHApIU1ZL0PV+Gb/ucGnHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468282; c=relaxed/simple;
	bh=V7cQtYXT1oLCrxYl9d+RloU5vz4sOIsuAqfNBNM2KV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYFPa3T9qRUO2+qwGLCCioj930i1k1o2iCTbFm0xH/VG/wQoSwrgIeA6YTosrKk2jX9XWNCXKtWGRsqcasvcLKkuj4OjL4ZXkHOhYbIFLaNfQoXK39PKpEFYTRzEE6y0TMG024Le19ortAswBoGr4V+YXwUCL3O5QnJXxZkHwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTMzCwCt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTMzCwCt"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49558ce01afso3795655e9.1
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784468279; x=1785073079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8M2tiw5eOuKti96JSxIGvzIRa/bxVJzwY8EbOmcsNo=;
        b=eTMzCwCtgF9/h2/FlyExr5UYUbp5NnPMkR485TxUTkdS7FdGYY4A8O/bTQ31EKJWF+
         JziCB/7Jk2JDYa5Ya1E01kL8l3FHaydlPuguW8VO4oikLGmr9omdhJWqUyo7+xol7rpJ
         9Bu9KjNmkNAw7l7duQinyIA/hXrnUQ1r4imwYMVCnnpOojMlPTqioh2YFZMAFAjio0Ga
         f4SjWMQ3g8Y4dB77P2Sfmxw+50xqTee/OfGcdrxPEKGvqpaAdoFv+ZbDxsf0yxtnG6EE
         PSTM/Gq3w2bVsWNLVfugksnNVlgBtzTbp3TX5NkZY+eTRJOZyC3EdxoIShxGThTJCJuB
         zgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784468279; x=1785073079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8M2tiw5eOuKti96JSxIGvzIRa/bxVJzwY8EbOmcsNo=;
        b=rW0FkYgTy+G6fxqZ2XBPPDhabwddlWR0awE7enlSqR4/mF90MhnE5TI/RUeXi/Gek6
         coOkE9c/m+FHCIHs467yZNMVdSzmwA1IfT30AjZEgltex/RkrZH+EXLgS7yNT/QO1Z0E
         aj+9CAFjyrRUjbxtVsGFqkQW+sI8AiJ1NkZj7wWg5iNaUJCbDe3H6hpVlo65oJtZ2z0D
         d1/w6CttDt53qs7RSmJ1KLcc+cfRFAiQOxISY+EunXRu412TyAaDsgwfJHXZZ7jTrkJr
         3mjszygoptqs090/pEY0kKmxEU59YMGWMMXKr5qe1xF4cWBjkXtp5Yikh+kXjQrtsTQD
         aTiw==
X-Forwarded-Encrypted: i=1; AHgh+Roj6OKrc6hezuwYxrnnErluUdT5usCR6BTQqJT9I5vcHV3kI7tBRcpa2bqk585QkrKk7pV9JBvkWxQW5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlg/+9FXyObGuCUjl+Bijlw88d0JtsrMxwehvGzzp2n5NX+mN
	HNsfcpeRJ6KrCFw7+VfF+lnKSsckYElHfIemzTnBRRz71bE1bI8A8R3+
X-Gm-Gg: AfdE7clfB4it1+0IOl/nl8eSuZVuJaR5VI/v3vqlwe+4R9qRa+IEfBa7JkkpG/H/xsD
	70px82DM1l+AMf8o/yVZAgq/+Ebu4a0xMt+IDnsbFy1tP/qC4B3Q5XXTD5GcivVNZoLC8Jcf4H8
	Gx7Pig3PkwWoI2Bc85TfEUL3SvS7hefgNc615IMGgOFO6EtzwIuFH9AhLYVbPPf7qz6sm4oS6hq
	vvqWdngYMpW4Mp2HHVvAKRdDtEEFDMwCYf/dPDmSnwu5PSpn17EDh7EWgLuQvc7IP7IYSOkF9fh
	3dxLnCbUDHgzpIObTIIwB/dpKz9Xpau5jKPxUzBhV1yGRIa5C0RwhsM91uZyvb+1kZPcJJYlp8Y
	Dwa1zE3TdbMz65kwZWwYnlVsgAUavZ0Qdr1MUTLrcsJDKZZ1GyFeoUQbOuEpL1XTJ8Do0TXavRh
	9LZ3WsdBmSNXiFe14hCG0+xm4p4dAaOdIadT72vyuD4yxL
X-Received: by 2002:a05:600c:48aa:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-4954a516183mr75623815e9.28.1784468278420;
        Sun, 19 Jul 2026 06:37:58 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63edda9bsm21807179f8f.31.2026.07.19.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:37:57 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v2 0/2] dt-bindings: input: Convert TI Keypad Controller to DT schema
Date: Sun, 19 Jul 2026 13:37:28 +0000
Message-ID: <20260719133730.3551691-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch converts the TI Keypad Controller binding to DT schema.
The second patch updates the OMAP4 and OMAP5 device trees, which is
needed because the schema requires the matrix properties.

Changes in v2:
- Added 'interrupts', 'keypad,num-rows', 'keypad,num-columns' and
  'linux,keymap' to the required list.
- Dropped the '|' from the description.
- Added the DTS patch, so the OMAP4 and OMAP5 boards still pass
  dtbs_check with the required properties in place.

v1:
https://lore.kernel.org/all/20260708123252.1768355-1-egbostina@gmail.com/

Eduard Bostina (2):
  dt-bindings: input: Convert TI Keypad Controller to DT schema
  ARM: dts: ti: omap: Disable keypad and enable it on the boards that
    use it

 .../devicetree/bindings/input/omap-keypad.txt | 28 ---------
 .../bindings/input/ti,omap4-keypad.yaml       | 63 +++++++++++++++++++
 .../omap/motorola-mapphone-mz607-mz617.dtsi   |  2 +
 .../dts/ti/omap/omap4-droid-bionic-xt875.dts  |  2 +
 .../boot/dts/ti/omap/omap4-droid4-xt894.dts   |  2 +
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts  |  2 +
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi       |  1 +
 arch/arm/boot/dts/ti/omap/omap4-sdp.dts       |  2 +
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi       |  1 +
 9 files changed, 75 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/omap-keypad.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.43.0

