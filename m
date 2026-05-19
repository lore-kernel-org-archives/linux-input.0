Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2FD39DBF5
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234494; cv=none; b=pCR/uJRDQBOLan7IfjXjwUH2dWOw4VaSPJRks4B16/V5ZywOaxuMuUuesNqYhfRXDRBuO4dHcnUlNmQxkcFsry9JY/PuDcoNcjI1pFlj7kX6t2Z8fouIa3bRWOPMx9IxgtVnoh25tVmezj25cLJ2MtlMuYpW4knvHcaazcVlj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234494; c=relaxed/simple;
	bh=Ta9WGER8ct7kczazZS/8V2rHje0U8Pio76nEzIUlIkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fuQlQ4wfS+PnPX9m4JJ+VC+A54O74v3uQ5RyQDoHlGrsH0aZ4Qf7VNFlLCm35Q/Cobf3YoynElkpjBGzyDhEY3j4ZzhXO0s0iPoH7QuTyPNBPj2neYPpQsLpF8kcOYiEusYvKULRAfVgsvU/qfaX0wnmCxgUZCD3QGRGueCXLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=jbqunUBG; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jbqunUBG"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8acb856a674so55686496d6.0
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234489; x=1779839289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoCyoqi9IVhXALA90XpIAUY04CE+61QR9mXxpS1jXWk=;
        b=jbqunUBG0NfEwnlT6E++nUj/lAieaM1pmLh8owu3cpFa6+acqz2WPEbpErosjRMLqP
         f2kP1GXVHLUddDVyLrTxs9+MPkW7pqCICztgLgCnJPNKhm+Jo++1eM470QIqBL84yofT
         sdcpJU3++mrIV/HVYLmJs/5de2UIwv37CYDF6RoVvwxHuUlLL7cn3azYzBjUXmIsRBpm
         66WWp9qmoS3aL4vFRfjBD5UdYIndJqkGtEykclnczM2x9CfxSApa2XPMhPodNdAwL9IF
         YWVlY/AR65Zc6ACcPJ8KvxAR6MUO+ZfKJ9shyvnQZo2PXE+TDwOAXetkQxIdfxvQ2aox
         OE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234489; x=1779839289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoCyoqi9IVhXALA90XpIAUY04CE+61QR9mXxpS1jXWk=;
        b=KO3plGEIfR5GWuGLN4FmqaLbp3PD0upu0a8xB1+sxE0l+k/aLPqiSKz9+M7zXrevdO
         tRdJXm5emHQ0Y+Mg1NV52xvJAcMomTf3ShvtvqcPluXXEtaEAAivtqnebNYBKKIjKXr4
         Adhl0YXAS23CrE+MFdklhOnUL6TKhr/1+iPqG0KDaac2pniNX7FOkySVOFFo5llY4TLF
         qstugCM5jmFWGUudSCKIhfV442lVTfxenlNBDWzVfITCf96VO1N2J5SqzaPE7Yz/n22e
         RzYkVVkyIxrWQshwZQHodiLfiliPuKvXDDXX6Ffj/Y/A/p7yNsxbR/PL3B/fR3lp/FoA
         1qNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jZDp1K6kDovZA7n2aabRjV+TfRl0jHzkIGfgloYRPr+zQAjcYFfAQNyosPC8SDBdzxaAac1MER95cXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhnKMdzTe1Ly3xQ41M/+Z2w0Htcx6lvttD7A8UCpTY1OV3pPyZ
	nnglf3c0pEWJo/pOtE7AlveK+xQvf22rS7dkHRp38iXTAvdA0W2w7iFNBG0oiCcgj4h1fmWT1kO
	Siu+JyLOvdg==
X-Gm-Gg: Acq92OGyj3j0dpzyPmN2BXHKFBC6CUzSQMLaunraVCowe6bG+ZVTBz8QqEw35NB9JN3
	tw27wfkDpz6pPu8vEBfYr9D72/Q4NZSygOdGILF3fpfCxpFMsTtpbzrzDzNZrggGF+iTfhYmXx2
	oRrF5dtXn+8ETJFxEBZUmdnKH/OJxE+LYhdAVxwubEmode4o9Bqeh0P0mBQA2MzjLR/mDGjwZ3w
	xxthwQjbwTPB1FX+ivoxcCiDllkuElXJwFAsWYBSOIUWBMODT0R5AiSskdr6mlneAq24pCkjTN5
	IVxqVhseaSkIZzI+J2gamK9CHR4GzxwpXCmx5H83QpnlWZDRFnrjIH6D6+nZ1/TrapgKM44uLe2
	c3vae1X+wqnQYH1Q2wsSUJ3eNjcJ6AMt1rErvjmOsJv/Wg1H4JXgtL7JdZ3b1EdVtqiU9fq38vP
	ZM6kdbAqmOcj5FVaBcoI1AYWPD6lP7XKAOaI6FLEk=
X-Received: by 2002:a05:6214:21c8:b0:8ca:1102:3e3d with SMTP id 6a1803df08f44-8ca11023eebmr290921806d6.13.1779234489091;
        Tue, 19 May 2026 16:48:09 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:08 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 0/6] iio: hid-sensor: standardize scan_type initialization
Date: Tue, 19 May 2026 20:40:42 -0300
Message-ID: <20260519234752.23911-1-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series refactors the HID sensor drivers to standardize the
initialization of the iio_chan_spec scan_type structure using compound
literals.

This change improves code readability and ensures that all fields of
the scan_type structure are properly zero-initialized, allowing the
removal of local helper functions.

Additionally, the channel initialization loops for hid-sensor-accel-3d
and hid-sensor-gyro-3d were cleaned up to iterate directly over the
scan indices, eliminating redundant index-offset logic.

---

Changes in v4:

- Fixed a bug in the sensor_hub_input_get_attribute_info()
call where passing the raw loop index 'ch' broke the HID report
field lookup in hid-sensor-accel-3d. Restored the proper HID
usage ID offset calculation using HID_USAGE_SENSOR_ACCEL_X_AXIS + ch
- Cleaned up the channel initialization loop to iterate
directly over the scan indices in hid-sensor-gyro-3d for consistency

Changes in v3:

- Dropped the global helper function implementation from
hid-sensor-attributes.c following maintainer feedback.
- Shifted to local refactoring inside the drivers using compound
literals and the  macros BYTES_TO_BITS() and BITS_PER_TYPE()
- Refactored the channel initialization loop in hid-sensor-accel-3d to
iterate directly over the scan enums instead of using 0-based
index offsets
- v3 link: https://lore.kernel.org/linux-iio/89a2e6775e3c922a4848a4b4730aab8d32097454.camel@linux.intel.com/T/#t

Changes in v2:

- Modified the helper function to use the BITS_PER_BYTE macro instead of
magic numbers for bit calculations
- Updated the scan_type structure field assignment from '.sign'
to '.format' based on recent subsystem renaming feedback

Natália Salvino André (6):
  iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
  iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
  iio: light: HID: hid-sensor-als: Refactor channel initialization
  iio: light: HID: hid-sensor-prox: Refactor channel initialization
  iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel
    initialization
  iio: pressure: HID: hid-sensor-press: Refactor channel initialization

 drivers/iio/accel/hid-sensor-accel-3d.c       | 27 +++++++------------
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 27 +++++++------------
 drivers/iio/light/hid-sensor-als.c            | 18 +++++--------
 drivers/iio/light/hid-sensor-prox.c           | 19 +++++--------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 +++++---------
 drivers/iio/pressure/hid-sensor-press.c       | 19 +++++--------
 6 files changed, 42 insertions(+), 88 deletions(-)

-- 
2.51.0

