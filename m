Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629619B5B1
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786166548; cv=none; b=Tq8DQB+xCVR1UBxCmWUiN49reJy/g46XbVUTteiWfVNKZHfKqjuV8xSNJlobVNL4qzyCMGu0ah4lO26P5DYYWrRRlLwLuf9k2fLHYiKuycbWHYyZeJgcVl8Ax36oe9x0dcFQU9TGCKIGwxOzKfgADMw7QoTXB46cWbj5phH90kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786166548; c=relaxed/simple;
	bh=EZ0GVbbJNBvsm6tOblM181pFOxOxv149uqL2sYNkvuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HutTTeQUsf9LSuAn3WGA10u3kIeBjaSWrOT6+NXoRh6IyvSH+iuhPsosMajLO4M/x+1RiSBgOWeCxHJFjUK1opS3ayCTVKSgvs4Ki+tr9zV5tfCs31w7zY7hbMrHysddTWO5j09uod83AsoC4yM8cv5oivLbbP9MkoRE4mIQsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOvAfLKN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOvAfLKN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceb096e675so2821565ad.0
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2026 22:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786166545; x=1786771345; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZS2IGGAQfybrsj7QIjhfcUfSryJsCXqoo6POfzwBsM=;
        b=MOvAfLKNPpwAXch6h7RLSHk2ih1bZvz5jCfhfZ6gZfO1hwQsOXCYv/AKaKGRdCVlld
         pZwWvqTIVKLRBdeYj5AnR4++rOOaY/0Wd0lJtkn6lqON6j9njljzRwWIFJ1HPB7wRP4J
         RaWdZ2hkur6taQQPVfJWMsGJUEzZd1E0LS8IM8NP4Pp7aS1+c473hGCO47zezzvwId8m
         G0hSPCpVWlBjkBfJGxHw8hkUhmS4nkUAfVPFspzFKaHbOgsdLGy/zMd+lcu/mpgpd6ak
         Y95jEIuC/5RMgroczPVNqU6RE52BwqBX8vj7U8L4swIWfH8YVKqB7HHzuU+VQO6J0sdS
         MJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786166545; x=1786771345;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DZS2IGGAQfybrsj7QIjhfcUfSryJsCXqoo6POfzwBsM=;
        b=P9dHsXd37spTp0C62IFrv3EBTe4Tai6WedriM+2Yk0PO+9DRmiEGLBxExNg43OuT5a
         rFm6G16OBM3+xSUEoRsL3xlui13TAtfsrTPBuHlIcFGQSBWR7/nWr0tJMRcvKvoDZ/2V
         aKeDShfa7mYfZzsHVcuaZHjX8Jk389PKHre6nE8UOqOx6l4sIlIflKFGEITj1GTo8xWO
         yS350JW1kd9vTLGa9VlYsGev/hiXVWGikfn7yIgj86RGYKJrBeAS80WhLJaHI5U5G8ED
         FBawdm1jYFZF1i6DvATPUcwu1Nr63XptXjS7+HRQ0I6M/hScy5iYxFij7ZD5omnVzsPV
         lNNA==
X-Forwarded-Encrypted: i=1; AHgh+RplnZnoLZAjeVkQXqVHQIiJ1sNgI+1c7Q2GX2N9w9g7MGnnWYaDkNjhqVhOqlMXRnoRYWtefqQPYqZQ+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVY0j0YO/h1ihz3DIrgouxUbZl3blEeAywGjMLFbdCy1jfG1/
	zHFDjDL/SFDDCVFrdNVWvfUFTwyLNgqEAX0h1JEHt8b4QoOgfI4wNZMX
X-Gm-Gg: AR+sD13ZxyJIe/fdb7U7C3fsaTmlDJ3piKfBmQLd7sFlBdrZUvu1VNyfAErvjW0MEsV
	cmralA/MLCSnuCd7KTFw2vWXCDhQfSXOvySmBRGSvGH2VNg0bPdlw1dQXmTNmpX/XBesLh6EeRF
	1DOBQxxsxCBRMkuyKXKsrWOtbxLKm3W+TO3aOvEQAnm23uZKEbKwsblk3uBfICuZNvtxQT+mf+Y
	pgGngmZVAslz/sBewoDeJiKarw3RcMKp75wUQuzVYugPSKHuFELi7o/i9m2tztxAYBZckopaxAI
	BZLMRJ1MUQJGRul5KfO2Z4zbNcLBi/C26DbER2IBgs3VoxYfWsUCZptDJuhAKc7afpa4STwFqim
	q3kh0RXxYfsLCds3MEInKBZlAY9wFpeub6v+UUM4z9Q3YgBFa4CnYvJn6NU/KR8HrWtnD27zJyS
	+HRxu+c41iQmv6KH24kuue3sNZI6Z+AjMrlQOHXKh1CZYqcaw7mfqi8lwNEAxfuGoXw+xTha8QT
	DbWTjI0AT5/EdENT3eRMReCc5r0qA==
X-Received: by 2002:a05:6a20:2d13:b0:3cb:7b9d:9869 with SMTP id adf61e73a8af0-3cbce9de817mr6511479637.35.1786166545030;
        Fri, 07 Aug 2026 22:22:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5f7a:642b:8f3b:d2ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde353sm15947419eec.23.2026.08.07.22.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 22:22:24 -0700 (PDT)
Date: Fri, 7 Aug 2026 22:22:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.2-rc6
Message-ID: <ana9BNQ9VsV9CisL@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc6

to receive updates for the input subsystem. You will get:

- Fixes for information leaks and OOB accesses across several drivers,
  including evdev, focaltech, edt-ft5x06, iforce, and cs40l50-vibra

- Improvements to the synaptics-rmi4 driver to properly handle F54
  worker errors and prevent buffer overflows

- Input validation fixes in the hynitron_cstxxx touchscreen driver to
  prevent issues with invalid finger IDs and touch counts

- Fixes for use-after-free and initialization bugs in the byd mouse
  and psxpad-spi drivers

- New quirks for the atkbd driver to make keyboard work on HONOR and
  Xiaomi laptops

- Support for the ZENAIM LEVERLESS controller in the xpad driver.

Changelog:
---------

Alexandre Hamamdjian (1):
      Input: edt-ft5x06 - ignore contacts with an out-of-range slot id

Bryam Vargas (1):
      Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer

Dmitry Torokhov (6):
      Input: evdev - fix information leak in evdev_pass_values()
      Input: synaptics-rmi4 - fix F55 transmitter electrode count typo
      Input: synaptics-rmi4 - zero report size on F54 work error
      Input: synaptics-rmi4 - block s_input when F54 queue is busy
      Input: synaptics-rmi4 - propagate F54 worker errors to V4L2 queue
      Input: evdev - sanitize event type index when fetching event masks

Donglin Lyu (1):
      Input: atkbd - skip deactivate for HONOR ZQC-P

HyeongJun An (1):
      Input: cs40l50-vibra - validate custom data from user space

Jianing Li (1):
      Input: hynitron_cstxxx - validate touch count and finger IDs

Kyohei Kadota (1):
      Input: xpad - add support for ZENAIM LEVERLESS

Linmao Li (2):
      Input: byd - synchronize timer deletion before freeing private data
      Input: psxpad-spi - set driver data before use

Pengpeng Hou (1):
      Input: iforce - validate input packet lengths

Randy Dunlap (1):
      fixp-arith: convert comments to kernel-doc format

Richard Davies (1):
      Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet

Zhefu Zhang (1):
      Input: atkbd - skip deactivate for Xiaomi Book Pro 14's internal keyboard

Diffstat:
--------

 drivers/input/evdev.c                          | 27 +++++++++-------
 drivers/input/joystick/iforce/iforce-packets.c | 11 ++++++-
 drivers/input/joystick/iforce/iforce-usb.c     |  3 ++
 drivers/input/joystick/psxpad-spi.c            |  1 +
 drivers/input/joystick/xpad.c                  |  2 ++
 drivers/input/keyboard/atkbd.c                 | 20 ++++++++++--
 drivers/input/misc/cs40l50-vibra.c             | 10 ++++--
 drivers/input/mouse/byd.c                      |  2 +-
 drivers/input/mouse/focaltech.c                |  2 +-
 drivers/input/rmi4/rmi_f54.c                   | 43 +++++++++++++++++++-------
 drivers/input/rmi4/rmi_f55.c                   |  4 +--
 drivers/input/touchscreen/edt-ft5x06.c         |  2 ++
 drivers/input/touchscreen/hynitron_cstxxx.c    | 13 ++++++--
 include/linux/fixp-arith.h                     |  4 +--
 14 files changed, 108 insertions(+), 36 deletions(-)

Thanks.


-- 
Dmitry
