Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795315722;
	b=2bnVfWKSfXto9ID733saMCLWO5PlvV3kO1BlVEGDukTm7yM09H/dsZPPYd/Yequzc8ad
	 C2k773TXE9njFjuqrPT2Ej5GbbpLKts+q+PUraT7t+TYsjgGOk7e0zXEIInO2pn3YFig6
	 Khne3sc87C/K0Ddodo7I/xBQy+HqxlEfNoz1gubokrqBpHZLiaaxTQvOF7ObWthvW1zgj
	 N03EYUavQe3pELmOjIo3bZJL3zCX9/wLv4pFKfdU0fWHV+s1J2O16qC8FCsqYToRy92E9
	 Dvyjl8ci/MdmgY/mNPLksgSmHAMw1No8gc6w6iMphUN4NmJmTejckfflONnhPwfbK/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795315722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=yOipYhHuZqMstdAIaVGJeVvfGnYpJyJlLJYOZzJsGs4=;
	b=MglSJtG3ieYpFlfBiXPt516Bua5waHyXVW7JWi7SdVDd/GpOXYOZaNXxtbKFcXG8csV+
	 8ertQTyZwIWE98I5yEUBX+2p+0SfxPm9hYPhbqqf6EFT1ujXU8S3ksdyN8KYQOsYBLb4X
	 bIzzWttZiE8rbjY2CwP2gyhzGIg7yjqKxObw7ktKZA3QQSAMsuVPYklG/n7CGizyqT2f1
	 nlZfpU+SveLiF9gMimkVj9SgPajNzijf5EpZhoWCA/8dlgTPhX8T7d1RWrn6kH5y0OHLA
	 akI4eXTUNAExgXJ8P+HCwxsNJ0qIxZDUwXSbxLV3Jrcjj83mXVvRtss2JIWBE9c4aSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QltfMwLf;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A313606A320
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 02:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A313606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QltfMwLf
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2717480c88.1
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 18:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795315720; x=1795920520; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yOipYhHuZqMstdAIaVGJeVvfGnYpJyJlLJYOZzJsGs4=;
        b=QltfMwLfZdn7tH/22ZU/RbfBA8TAAyW7z1jyl4LyH4pf2vMAu5V9gP3f7DcIms059V
         CQbJPdsyPp2j7LVbnaSZZ896K2TanBu/kmp8IWM43LuAldG/+vhWSRDpqc5PgX3/DqP8
         IrBE+v61BmyFPp8THD5kzjD7y28yVlcP4l94VMW9G/0wlrcKhLXCvEtEgVykIE1uoVTR
         +UhoppKwH58Q7f8xBIOisYJcAvdzSsViKIpug4T3r5BoWMkPIdMaEnrJOLgGkqLqwOtK
         XpTiz78ix+HHZ5ED8HficmPbmWVO+YD2X6/sl19xAg6v+vbRBc16kUHeSvt2/Ap4kgJW
         4o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795315720; x=1795920520;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yOipYhHuZqMstdAIaVGJeVvfGnYpJyJlLJYOZzJsGs4=;
        b=VQmDsIVY4eWeO309SsOSNeScuAg9PyVnT2/H1FBeEiVwx2IsVT5CTadDfzO/OTjizh
         ll8A4dcwulHURxxyi4QnDfBTXv9c+KbNxmCjNi+rlgNvz9ZZXPUQ6cmAAc+faOdwdcA+
         l5ZTYDQhk57t/UzTfc71qzKoouuZR6+NM3hU8qnrUV3wPv2rMnwNs+EmdolFBFPbjF1W
         2vtuxkJuMtWBh5Nj6oHde1SnvtLDqSzgCcm4tpOwLhZR6mxNBc1l3O+MLi4V81IfINNc
         9WJkGM2WwP0SkadBuh+WfNtQm0bPqbZtHTT+jg35ObjMJkT40w9plDFFO2tbzkcpT7fo
         E/VQ==
X-Forwarded-Encrypted: i=1; AL+hErHVYmfEFL95EkWJbTYSyvYQVfGUFXNxBpFSSm1Pt9IYOgppubRSOjiRtR9+C8wa3IhPGvrX+jh3dvFqfA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9XLDqyPTiiGpiHcJqPL1y/tx3AwFQtU304w0m6pDaO4lyB2uaS
	GSyBpZ6oTsIYrsi1y7Se6kvLB5wpcVDRTkEJeTkbxqnBszubIpoRhzZ0
X-Gm-Gg: AZFdTZewwzfpuLLS3VZAHqViKmgrrTjGrgaaQCpRLXnxtGuYjhvxnw/SNUhIrMEXfVP
	LjXbT2TV0jp8QdCHXpVo6mSYtmQXIBpkPDlnjwM9cYjRJuM4STXHTN+bnqLEEZmxpD7THszRmDi
	xFppw6RPJVHgcpbyICM23Xsxki55jARRm1DnS5Jq1JgAPbvkMjdqGpGh8JubzZiQelEnvfaRdTQ
	ZqX17C2uIrh/MmB6MdNjHuBifzOnZU2tlnYmippwgNW26ZomgO1rdzsu8ktXe1fQMb9RIkLFX2J
	VL12q3uPvHAB4L5HhVBDUr/pSJfrqMPeKv2DnGpQtGpgR94RUEQ/pU8iE0gMEX6T3Mi8zyWZyQw
	qfMlyqSanxm97wVljkwx1XLBQrFbL/7HW4EFl/9Wh/2k8RLadZxwYxkYlWCoUKUW169nRxwb/x+
	dHCH3x+VEUVsYOEclisFQYcAYtnQjkWFZrX16p+apGUjvHA/F3EyDI+YkODA7xRiCx9CQQj0Zdk
	NQFO5yMrXrAIV4R7q57bW2Qr7VGXJbIKdXgNhgEYW1wYX3Xj2JUtNsDkUwfaNY0yRrzjx5U7FwT
	KqFR6T/z/VMFj/L3/JRYE7iep0Z8tgFC119y+nV3/zpPySD1oyfxKTS/XInalFLRZ0LupQ==
X-Received: by 2002:a05:693c:83ce:20b0:384:8726:fcdf with SMTP id 5a478bee46e88-3856f65b3damr8532637eec.12.1795315720043;
        Sat, 21 Nov 2026 18:48:40 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:8bd:8d0f:cb70:907c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm21722846eec.15.2026.11.21.18.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:48:39 -0800 (PST)
Date: Sat, 21 Nov 2026 18:48:36 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.4-rc3
Message-ID: <awJX_vVgR79DxVuw@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.4-rc3

to receive updates for the input subsystem. You will get:

- A fix in input core to tear down force-feedback devices synchronously
  on unregistration, preventing use-after-free and faults in unloaded
  modules if userspace holds an event node open across driver unbind

- A fix for the da7280 haptic driver to stop advertising FF_GAIN
  capability without implementing gain control, preventing a NULL
  pointer dereference when userspace writes a gain event

- A fix for the goodix touchscreen driver hardening backup reference
  length validation against malformed device configurations to prevent
  invalid memory writes during probe and suspend

- A fix for the max77693-haptic driver to disable the chip bias if
  enabling the motor regulator fails when opening the device

- A fix for the cyapa touchpad driver to release its runtime PM
  reference on interrupted lock acquisition so autosuspend keeps working

- A fix for the Atari mouse driver and m68k IKBD glue to treat mouse
  movement deltas as signed bytes, restoring proper cursor movement
  with unsigned-char kernel builds

- An update to the trackpoint driver adding a new JYT_NDT variant ID
  found on Lenovo ThinkPad X14 Gen 1 laptops so the device is not
  misdetected as a generic PS/2 mouse

- Updates to the xpad driver adding support for Hori Real Arcade Pro 4,
  Hori Taiko Controller DX, Hyperkin Xenon, 8BitDo M30, and GameSir G7
  Pro controllers.

Changelog:
---------

Dmitry Torokhov (1):
      Input: destroy force-feedback device on input unregistration

Haowen Tu (1):
      Input: max77693-haptic - disable bias on failed open

Ivan Verbovoy (1):
      Input: da7280 - do not advertise FF_GAIN

Juan Parrado (2):
      Input: xpad - add support to Hori Real Arcade Pro 4
      Input: xpad.c - add support for Hyperkin Xenon, Hori Taiko Controller DX, and 8BitDo M30

Liu Chao (1):
      Input: goodix - reject a bak_ref length that cannot hold the checksum

Miro Kropacek (1):
      m68k: Fix atari mouse movement

Sergei Kuznetsov (1):
      Input: xpad - add GameSir G7 Pro support

Wentao Liang (1):
      Input: cyapa - fix runtime PM leak in cyapa_update_rt_suspend_scanrate()

Yuan Yao (1):
      Input: trackpoint - add new TP JYT_NDT device variant id 7

Diffstat:
--------

 arch/m68k/atari/atakeyb.c                   |  2 +-
 arch/m68k/include/asm/atarikb.h             |  4 +++-
 drivers/input/ff-core.c                     |  2 +-
 drivers/input/ff-memless.c                  | 23 -----------------------
 drivers/input/input.c                       |  5 ++---
 drivers/input/joystick/xpad.c               |  5 +++++
 drivers/input/misc/da7280.c                 |  1 -
 drivers/input/misc/max77693-haptic.c        |  1 +
 drivers/input/mouse/atarimouse.c            |  6 +++---
 drivers/input/mouse/cyapa.c                 |  4 +++-
 drivers/input/mouse/trackpoint.c            |  2 ++
 drivers/input/mouse/trackpoint.h            |  1 +
 drivers/input/touchscreen/goodix_fwupload.c |  4 +++-
 include/linux/input.h                       |  3 ---
 14 files changed, 25 insertions(+), 38 deletions(-)

Thanks.


-- 
Dmitry
