Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C21DE4EF
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780204201; cv=none; b=J5q84O6kMycuno2Lrw7I9j2/HAmN5yJ/Ow+393babh84YzhT9+bsyM2vwiEy+S8jj8AaGT7Q76iIfW4RiDfKudGzN6e83Wdff4t3HY+BdLf4otYpwoSwM1IgDc1AZ9D+fNnB495jTW6bvEMKPIzTkyMdXkBz8z3S/Vq7lFfx2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780204201; c=relaxed/simple;
	bh=7bR7rqL/zSf+brPmiMYKuSXmbLZKtghFr4tAb0VxLBM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cBgbdWSTYsisGqrhZg/LpL3TSA7cFLprhZJoxyg9//A3mmmoDty9JmEJrOEhLqbxZA48yrPh1D+3hET0MWBk+3tO/Yw5gYok1/WQpFzRN+GbmH8N2ngIS74lojNliuVDr2FXalNjzQA74aFruvshN6C6RpCbaiu2DSh9s4QXLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8xTR/bm; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8xTR/bm"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137dd51129bso530782c88.1
        for <linux-input@vger.kernel.org>; Sat, 30 May 2026 22:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780204198; x=1780808998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IYCo3kKHlefZAl1IT6QlJ3rLTf4/OyBQiIoN/0s9Ts=;
        b=q8xTR/bm7gp/7QK1VoLFdMsBE6mXwGEdCEjzfIOIPWAPT3NuEBNGXu9UzcTfWJ/pnI
         +3dKa5/6b1/iUFFC9+Fp9aIknWlrd9EK5UeowpjA2dpB2X/OrpmhXjTic8lpn40TIpBR
         6Kb/AKUj8bZ7jbKsFkw69FgtWZN3IyeC/Ki6VVVI7r1KQ5y/jMtacb6yTVNp2Z6nv8w4
         Qhia07y+mvIhlEGvZ679CyT1SDSbwdBUFVhPvqdoC4/xMIDgBBbMLjhX3nDbpTxRsMcW
         TJTu2JUhRa6TG5rmLqGWnarjD/2K/0TWpXExeNn5WgCprZyaXKt89sg1IKNlpE0vNndJ
         Z5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780204198; x=1780808998;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3IYCo3kKHlefZAl1IT6QlJ3rLTf4/OyBQiIoN/0s9Ts=;
        b=lmHZh2BvAdbBS2LNOHlGIOBF1Pqxe38VYIwtEMdMtF2Tw3dSrM8Oee3IjpyypOsY3R
         Jc/joYe5MvBPqRZtPg1Btg5gD0egVZB6+iJATTI6ol0YsV9n5c40lEREUrIdw6G+SUVM
         iDfCLFp1kW6OGCg4snx5aX4zvl2FAYQLEBqHBIXJ3TmjOuKMLphK3WuK2UvNclWr8LHT
         QVwiR/Ud1t9xb9IMEdKdG/UluGjGjLaCG2dZEjuYXSmHN2KM377pzi/Q56euNwYe25+u
         ARDbvYNmrzWvapEE+avCEQhGsY90hemC1bYS4uQuE6T/3WiXmjxWusstEBx0UW/Am0+a
         4asw==
X-Forwarded-Encrypted: i=1; AFNElJ87cHDhMlk5Wy2B9pNgz5kBPqH12k5BVdNQvOSoMwOrq+us59t/1ayC8dD64WPqkzdcoUMqIZVWPU8JpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XyZAOiFAb8zyZNQwA9AAwaOpxedSJdXESWurGY1mkWmLiT/d
	T6Z9B3MZ5tTxsusoewTDD5S6o/QpSOapxdHlsIURHrd9uHu279hUGrEGdQLDgA==
X-Gm-Gg: Acq92OHOaQunrJRTAxvb9Q83rVpzWXI/896APf0UHWu4V8fjnSLRh64TXVFjhxb/Doi
	4G/wC2Wwugx04FJL2YIhTAKEg8vBiJy9UnzoytK6KqnYMZcbFoV+CeOIOcVDq4LFySqMfXZgI+9
	UwCUgThAUHHG/yH9XxZjV5l7h2OIaF3eFnf7YUMXPw8WwJXWIC6wU6m48DgJ+HX5itkDIXTzFG3
	CQ6FXDoU64bh8IEDUpvzGcCVhfHPrjPcskVdnF9Xt/B/BgOsOQby7zZYEQhEkwo+j8JNhg+wdGL
	4DMisEqmNR2fXQFlUxZzJq7oy/mwCMTGy6i0hiCITV+UA3eRj2SYmpd+M6QLsvHgtJGgyobTjG4
	ifUUr72ISz4oJkomiBLU8ZMQLxwFHd5mkwP6ltNfl2WtU9c+ePZNVnRY0G16QO1Dd1rvDmevr+y
	O/N+awOPoo+DCnQv4TlM/V7RC+yXQuWLARKxGVTT6ETv152XhMqB/d37FJZpQgrpGBlFeTqjUmM
	92Mk9Op2BTx
X-Received: by 2002:a05:7022:661f:b0:136:36d4:3161 with SMTP id a92af1059eb24-137d401de9amr2635356c88.11.1780204198307;
        Sat, 30 May 2026 22:09:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:aa7b:13a9:ea74:503])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69c0asm4594684c88.11.2026.05.30.22.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 22:09:57 -0700 (PDT)
Date: Sat, 30 May 2026 22:09:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.1-rc5
Message-ID: <ahvBdJ_vd3xuf-Rd@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc5

to receive updates for the input subsystem. You will get:

- updates to Elan I2C touchpad driver to handle a new IC type and to
  validate size of supplied firmware to prevent OOB access

- updates to Xpad controller driver to recognize ASUS ROG RAIKIRI II and
  "Nova 2 Lite" from GameSir controllers as well as a fix to prevent a
  potential OOB access when handling "Share" button

- an update to Synaptics touchpad driver to use RMI mode for touchpad in
  Thinkpad E490

- updates to Atmel MXT driver adding checks to prevent potential OOB
  accesses

- a fix to IMS PCU driver to free correct amount of memory when
  tearing it down

- a fixup to the recent change to Atlas buttons driver

- a small cleanup in fm801-fp for PCI IDs table initialisation.

Changelog:
---------

Dmitriy Zharov (1):
      Input: xpad - add support for ASUS ROG RAIKIRI II

Dmitry Torokhov (4):
      Input: xpad - fix out-of-bounds access for Share button
      Input: elan_i2c - validate firmware size before use
      Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem
      Input: atmel_mxt_ts - check mem_size before calculating config memory size

Greg Kroah-Hartman (1):
      Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size

Jingle Wu 吳金國 (2):
      Input: elan_i2c - add ic type 0x19
      Input: elan_i2c - increase device reset wait timeout after update FW

Nicolás Bazaes (1):
      Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490

Qbeliw Tanaka (1):
      Input: xpad - add "Nova 2 Lite" from GameSir

Rafael J. Wysocki (1):
      Input: atlas - check ACPI_COMPANION() against NULL

Thomas Fourier (1):
      Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_free()

Uwe Kleine-König (The Capable Hub) (1):
      Input: fm801-gp - simplify initialisation of pci_device_id array

Diffstat:
--------

 drivers/input/gameport/fm801-gp.c          |  4 ++--
 drivers/input/joystick/xpad.c              | 14 ++++++++++----
 drivers/input/misc/atlas_btns.c            |  6 +++++-
 drivers/input/misc/ims-pcu.c               |  2 +-
 drivers/input/mouse/elan_i2c_core.c        |  8 ++++++++
 drivers/input/mouse/elan_i2c_i2c.c         |  2 +-
 drivers/input/mouse/synaptics.c            |  1 +
 drivers/input/touchscreen/atmel_mxt_ts.c   | 13 ++++++++++---
 drivers/input/touchscreen/usbtouchscreen.c |  5 +++++
 9 files changed, 43 insertions(+), 12 deletions(-)

Thanks.


-- 
Dmitry
