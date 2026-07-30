Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ABD3E1D0B
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405260; cv=none; b=b25xSHlNvQ+Z/h/5b+Mx2JWlDnF7OhhI4+SNDN6AKyU6k0eMJ8+vq+zQGiYN8iAF91UD29KVWQ0XJ42B7Jr1A8hrMPGqKd2SxO0y02qYwHFfzzk0qEPD1sxmDSI8KDBzwHwMCHei4cprB7IW/GvfKaniGFpnJYBhKpfTbz2vWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405260; c=relaxed/simple;
	bh=SyXBv7/gzzYpIOH0YkvCFMD9mKpgamoLuYhXSvNFezQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOVALfIk2M98WsaQPL9xeheyfW2pj4ACNMTTpGRIL/aMg2lFxb7tWEATMCeIWMKGJ8VEd174b0ES2q8T/RSoMGQS/LxPck7yAseQopM4Sxj3JDVRI5VJiqhqR0BPIupiZKEbHfNXBFE5LKtjlI891LWe4Br3UApVfGmQ9JMMuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naC5WQxK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naC5WQxK"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso1775737f8f.3
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785405257; x=1786010057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l78GKe/xjwh8eB4dHVPC59DhJ6LSazdWHc18VdN1fjQ=;
        b=naC5WQxKFyVzuGqkeco9QOd0MBWeh2F63c2qMCaw69lIa8/UehZNa+tLSK6WN7YSy2
         K/Zt7QJ4SAScFHyFi0GJCa0/CWRqPitY/rCYP+1bPG7RRf2MYa5m+lfrE1U/fmTHklxG
         UESXvV9IA+wEaSl9Ewd7003bkxDBIbQIw6Xfu0Yn6LA0cgkErVYOhaL/NSiD2+sbo0Bm
         30aJAqSU32oQBTotYDy09AiwvHVO5iSCXPXbPyoD6z9okH8y5NPEMI3KiX5eFb5m3WFe
         HXq54obMmleo3fNp/SDl1WCpIy15zN9QPhQSW4UmLgvN6b7V9/1yf/d5UMVdWZ2JXA3i
         jJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405257; x=1786010057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l78GKe/xjwh8eB4dHVPC59DhJ6LSazdWHc18VdN1fjQ=;
        b=YLhbgUGy5a4IEPCjeyv1B5+Wq/Kdk9T+EMLdLp6q54I0pEfP1nHCo020W+Qy163HMX
         M247BcW2fpIuUGn1aNSFFJnAVbif5LArBCsSGtQBVpadLu250EB1YM4hMimZX1HtdM+J
         EC+oQzkc5KchqRfFXANlxoS0shw+e0iCbVP/hyxWGbNheWjDfEPeBmCiZcrLFTA7xemx
         5JZhYOfMWIQFZOrDvMGnJsVdQPVPKF92Jqvl7OnBIVt+rGzUl3Nkbu7iqAlsS/LsMvmB
         X+f3TjAaPBxJk6sUJWtX0m4XolSMbRn8HrU9wHmfRjVYfWI7KwxUcSyrhChi8Bq9Sp+Z
         I7JQ==
X-Gm-Message-State: AOJu0YxbDB1vV58JQzOUSFQEBVDNHxWVl4nwQE/PlMOtKbaBWkmaEsUQ
	b/L/RAEOKluDimpRI7QU2F80Fp2ohQ/VpRtZ2XSJQ1tqmumnRbdLnBoS
X-Gm-Gg: AR+sD11KT9V+9/ZCd2BogPsgEPxPyfptkhK9PUpZyrs7i9ki/qwwGjvPWUXxL3O6w0p
	alrIhrHVIvZ1RqRj0EBbjgWRkkNqY3UT5JP6hD1SXAFn9joxOYpRej+y12y0Byrap1o+ciJY8s5
	jSFs/8GeLZB8Ojk20HUkTLGNcEzPnJ5ZWca6ZLgullUgC/bHQoxD3IwkNb4fqI1PIThB2ovnpEf
	fchP5xJTkSxY+kRAoambuu7OAvCIGzc2XtipeJu+l+Vz/4XWIPx/33p/VSbTDgSR5hz+ykhOiu8
	gPF89Q+zx+Jj7/ELo94sqZUs4Lq714iOayyV0x9NPlDNh+BeZmLMGlgHSexG4odj2AwTGUyblXq
	hMxH3CmUqD46/Xr4MUklmMyCZ04sdSpBxllDMFpSMjYEBhTt3LtrGEc1XbYsO8Byuwg8hclUoW/
	4s4c9iwurkf4NGzbAKd8ccEsEqqXGqK+r+FEzAWb5vSSOJPyFwTnTxXPhbpAAk1j2OBfx4boCkl
	0/FqMFP8QR7Q/hd8kq1bZAPw1wytYG0
X-Received: by 2002:a05:6000:2584:b0:47f:918b:f9ef with SMTP id ffacd0b85a97d-47fc81f3a34mr2351085f8f.33.1785405257128;
        Thu, 30 Jul 2026 02:54:17 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc8934ba3sm4317500f8f.27.2026.07.30.02.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:54:16 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH 0/3] input: force feedback for trigger rumble motors
Date: Thu, 30 Jul 2026 11:53:14 +0200
Message-ID: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some gamepads carry rumble motors behind their triggers, in addition to
the usual two in the grips: Xbox controllers call them impulse triggers,
and handhelds such as the ASUS ROG Xbox Ally X have them too. The force
feedback API cannot reach those motors, because struct ff_rumble_effect
only carries a strong and a weak magnitude.

The first two patches are Daniel Bomar's, posted in April 2022 and never
merged:

  https://lore.kernel.org/lkml/20220410220449.5071-1-dbdaniel42@gmail.com/

They add trigger_left and trigger_right to struct ff_rumble_effect and
carry them through ff-memless. I have rebased them onto v7.2-rc5 with no
functional change and kept his authorship.

The third patch is new and addresses what I believe was the main gap in
that series: there was no way for userspace to discover whether a device
has trigger motors at all. It adds an FF_TRIGGER_RUMBLE capability bit
that drivers advertise and applications test in the EVIOCGBIT(EV_FF)
bitmap.

On ABI: struct ff_rumble_effect lives in a union sized by the larger
struct ff_periodic_effect, so the two new members add no size. On an
x86_64 build, struct ff_effect stays at 48 bytes and the union at 32,
of which the extended rumble struct uses 8.

Testing. I ran this on an ASUS ROG Xbox Ally X (USB 0b05:1b4c) under
SteamOS, kernel 6.16.12, where the patches apply unchanged. A memless
test device advertising the capability shows bit 0x62 in its
EVIOCGBIT(EV_FF) bitmap, and the four magnitudes arrive at the driver
independently:

  triggers only : strong=    0 weak=    0 trigger_left=65535 trigger_right=65535
  grips only    : strong=65535 weak=65535 trigger_left=    0 trigger_right=    0
  left trigger  : strong=    0 weak=    0 trigger_left=65535 trigger_right=    0
  right trigger : strong=    0 weak=    0 trigger_left=    0 trigger_right=65535

Wired into that handheld's HID driver, this drives the four actuators
separately on real hardware: the triggers buzz while the grips stay
silent, confirmed both by feel and by capturing the USB traffic. That
driver is not in mainline, so its patch is not part of this series; I
will send it to its maintainers separately.

To be explicit about what was and was not tested: on v7.2-rc5 the series
applies cleanly, drivers/input/ff-memless.o builds, and checkpatch.pl
reports no warnings, but I have not booted that kernel. The runtime
testing described above was done on 6.16.12, where the affected code is
identical.

Daniel Bomar (2):
  input: uapi: Add trigger_left and trigger_right to ff_rumble_effect struct
  input: ff-memless: Add trigger left/right in ml_combine_effects

Guillaume Casal (1):
  input: Add FF_TRIGGER_RUMBLE capability bit

 drivers/input/ff-memless.c | 8 +++++++-
 include/uapi/linux/input.h | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)
