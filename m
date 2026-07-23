Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C2F45D1AC
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820209; cv=none; b=SOAi+9AgzS1IroTvL6WUxg266/9xvtFXyY9Wyt+BlUFejESfzd/esduY/hxQJ4fYC1/1Iay4vMpAcMw97ua0Iqm2bT+LI6ghVL+mPQRzqeV1bbuLZ1wqEYQHUkxV7KBNUezaS6e7BUTOSuqE/L3ExnGC5Uq5Vsd8/xJNJJKaomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820209; c=relaxed/simple;
	bh=Cj7/0hUPeXgZVqg8KWSZTNJ8vTFAgPSshjlYFrf0LIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otdQlixwmKvriCWHD4lO3vCsXKm63TMg5wQkJcQRFw5vLTjOKzKM3qpHW8MuYvuNJxlMVmyeVsnHOmj4GyDJedlEgwIelXlPtkWoKHvpWOsvr7yNatZjWiXBVX9GdM+P+YzksRg4D2Rwd6XJnA1dl6oIRbo9uNwqhZ25lAqT7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=SMexMpPl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="SMexMpPl"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15d47266baso97816866b.3
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1784820203; x=1785425003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CuP0OeJhTGW30HNXb6Y1WIZT6ga8TxkRxs5cbmmgrFo=;
        b=SMexMpPlDeGtfU0hF7w5CSLGOHogSCgE/P+egylArJA7+WVcbNUn+ZaVRN8sv8RpKp
         4FwQlyoGbnOcJG0MD9Vx95RNsQVisBw34ahA8dzYoKVdj4vMYTzOcZTNy3/tXruFmxCQ
         xNvjFhUoY91LkxLObZM6ZiqG9oKSDsD0qr05I9I6qzykDnLDG4CI3IJYU66AMSTYvMtx
         sbRA2YJXJrMTE8wKIX0VR1VlGeHm7e/Yu9IIRPMGcfg1gMo5MSiYvcVF7lY1ZJofPc9h
         qjNnA64lVxBL3lrejJt4ziqvmmYiP0UPjxyEZ4g8gQsQ+CSOajIO1tJRcFylhH7Bcw06
         WwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820203; x=1785425003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CuP0OeJhTGW30HNXb6Y1WIZT6ga8TxkRxs5cbmmgrFo=;
        b=gKREcihVfO5HyXlNT+/YfV0fPFT6qgT83UDhAYCRdOr5Pu19KiFfSxAa7jPi+3QGgt
         V3erVV25WMWcm/MbudgqA0Lc/SFeihUaSiJZA94Jxe6EWdi4sJuiV7xQTvouqhNgrSfp
         HXe2hjiwCt47SAcRYDJFueozXrwcrSCu0GUUKBB857AS0e6Xl/vuTfSKXczMog4UlwGy
         CA+aLAvFueJlAblMHyaTnFaYPBZLYNt+hX+JEVvEw9Rr2KEQarJMfCR2guxbuR+TTIuj
         VnP8rVWwwjME6sqpHMaibBKpchaUmKPgTHwFdlOeJ+0YmD5HGxCJlcbUZKXRAq3WAZxR
         FXfg==
X-Gm-Message-State: AOJu0Yxw8t6eypeRfKgRKXYluaPrGgfziTdED3anQeZlTil6zzsQ7n1v
	KpkfmYazlG6R3y6nGvVAd8h4u0DcAN3A+cFobg58fOSqSyToumkADtsv4UkzbcoV6g==
X-Gm-Gg: AR+sD11u2Jz0LC4VVLHB0ug04p4o4Wqi5aGW3VyiNeN5mzEsRsg8cYINZv8RZxQ3KWJ
	EIU5M4kVmxE76VCegNif8DFMuu/ui5P6pk5gP7WyG7sNVkdA3rd+ezGBKxUnn5U6M5G4GgLAbDK
	b6eb8AoI4c1sWfFS3z15xheZFC+9Ri89f+ljwPezT/5LRovl0+WglXxLaU32yuKBWtOa2pm86uE
	8qQsAyxN3nE93sgvncWbgIEElZEGS8EY2GDvePJf6EG2gJslrcUy9g6G5b52mXKA1FTHDQjtS7o
	3yZ50Aq+VfxGtvEtydATumQMvmN7d0JUDNT/wvDQ4EE9QZNfMbk1gxlkLor6QdEDnfjgwa3HZDX
	Ts1MZ6lEPMH6qyACXW4ybt9FK9nGTrbtnK90daKxSbp9D19HtcFx2X3RmgQ7HWY5ATuuWKgMVr6
	doBLoh3scw63CtXg2gCmT30OLYqFs+VMS6YifjYrEbHcuQ/25OAKz4wyMs3awmPxLV9eofCtaYO
	Sw9GdjWHYR5WBWpnsfWUU3/UpJSvM0yslEQQsWzKQ==
X-Received: by 2002:a17:907:9451:b0:c16:2e4f:a372 with SMTP id a640c23a62f3a-c1c5074a65emr161638966b.13.1784820202713;
        Thu, 23 Jul 2026 08:23:22 -0700 (PDT)
Received: from localhost.localdomain (2a06.4004.215b.0000.2aa0.6bff.feb3.5b8c.static6.kviknet.net. [2a06:4004:215b:0:2aa0:6bff:feb3:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebb385sm250749666b.52.2026.07.23.08.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:23:22 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH v3 0/3] Input: ilitek_ts: add stylus support for 0x0c reports
Date: Thu, 23 Jul 2026 17:22:41 +0200
Message-ID: <20260723152244.11252-1-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709182602.7308-1-kristian@mide.dk>
References: <20260709182602.7308-1-kristian@mide.dk>
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

Changes in v3:
- return success after ratelimited unexpected-report logging so the IRQ
  handler does not emit a second unratelimited error
- use input_set_capability() for pen key capabilities

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
 1 file changed, 144 insertions(+), 5 deletions(-)

-- 
2.54.0
