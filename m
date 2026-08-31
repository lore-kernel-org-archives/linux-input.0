Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD846D08B
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189745; cv=none; b=I6s1F//8DlxfbZ/Y+qMULD3YcxSCC28tdIBYAQagpvsuwSo+sq/7SZxOt89ACNN3YDs/wBgQQnnHFUb7g7bXY2RX4q02SmBMSW4pvYvFt6MJEaF51E2wDIvlAAYCK4zekDdSoHu3txYBD4697n+bVk1aTmBWWGmjo8cg3YX1g1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189745; c=relaxed/simple;
	bh=a7QmT6D6ZzTDIpRpEEw8yAEqutSch+PYx1h132MhJHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iwt0KvXvJdnSOb+K41fqcKJE67U64QFPgIYQEw4OVe/NAHS4A893FQIQeFk1VAxZ+v5l3824Ri/7QLfhFetLEc7uvpb0ncyMLHH/tHw+QrA7thIXd/LPOVOyEGZOdldlyUCtFsRAFEXyQ1isxFlEhkj/2Y4dafSOfoe99YXVtic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjRUNgT6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjRUNgT6"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de0093c42so3339384f8f.3
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189743; x=1788794543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAabvW/LFOQnUFGSsqKGiAJ7IJMbUXTCA25C9OFUDGo=;
        b=cjRUNgT6hqSgSQAIwljHckZ5jpp0orCXSXgTlzO5D9jCW7aiEz3cZwF/h8UxsyaECM
         ArsWJjWIL2tSb7lN7Pv28Xb0i47sz50rDl8oXsSSNOM97XoJQZ7aEPsIEOvagbMOaDZ1
         Yv7Cmgqk4XoIKE7oqsNUvGSfaeLpGVRZprHJFSwlk/UtBhZRgWr1yqbuSAWbutPedTWH
         dApZChhOX03OvVLr4sgwbxN98ZLgWQT2TMmGeMDwv7uQmHovWXWvZG0FSBKBhIA9umrh
         25mgtPwjJj9qChd3JylVj/isOCpfMdiokvEi/2TEyML4vgxkd500p0dxjxUuC0RMJPjj
         xX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189743; x=1788794543;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xAabvW/LFOQnUFGSsqKGiAJ7IJMbUXTCA25C9OFUDGo=;
        b=iNOLjFJGTPvrbWNwcs+yOTPtxhii1Tx7ZSLJON68bbmomxeI9eEIW2m79+tucYKDbx
         mgclrp6NaBNnGF/jbWtFl5FDG/zMDmxN9RcU8qsDFFEJG61i5SROKhRB5GJ9CUXuA+zu
         OCm5Pf3IidFsnnzYnxgvLr+koHfKBf+o/au13lq7cLYNuC+Rq38HSi8BIxhjKnarj6BH
         REe9QIAuqWTM18uegH6q8qFIOotRCUYTebHGi4vQ0Od0JJX8YyttJ58wezp1a0R/qjeN
         HtKPm4pJC54Du8WMKetpU2o8g+ARogEYm/cqSIB+3qJWj0dcVIoKASMpYn09Xb+ER/+H
         YN0w==
X-Gm-Message-State: AFuF++k0rXsw4LHMfAJH1C9TiucF2A0LcjQ+0fu+eNyrfrA6jyUrqGXD
	hzxI+Lrty2sg9F+pKc1O+6DuKt7+sKq4GF17vS713EoFv2DsSQZdesE200vLxU8TN7M=
X-Gm-Gg: AYBFou24KjjvxVdb2KkGbufmUna9Z8pTjYyQhKHr60DzlYYzuq0Q8cR2/jmlffzqKjb
	C6u20WWcZVd0FrfMpy4X+m3fiZnedajU1+9YhUF1jClqIcRKXVhUlVfb9jVWn2f5vMFgfbDoOV2
	efkcMdFzy7/xvZk2LgkgXwixGYH402KAx+Cxjem8k+mgdSrSJ8zbgcYRxvJiCAzX0E+9p42as/W
	ksEiJSgBFToYiNsPzonXh5qHabKsBDjCCMwzsgNVo0eu5IHGy2HPq1UpWXtqwi8fuZWK+yt1h2m
	PF0TzlpZyxjtNOiDzVmyUNS+60qEg20wROMCv2o45jxT1H4C46/VkmVlks7FzNHL3T1HBUePIA+
	iJucZptH5ddnvE/qGzjmvEf3har9CPeX3hvWOgqFbpIqxTI6wLEv60vbVy3xtRNkh3cc/3YZciM
	efWSAxwP2wbAg1OzfrtbndAzmNbfJUnvDr6MwrMTZWosGKpppZpk7n9K7jGEYY7jeB+yTq4Cc5s
	zLkf3PPSU3YD64Jl7VF6lm/
X-Received: by 2002:a5d:5d12:0:b0:484:3313:fd87 with SMTP id ffacd0b85a97d-484331400a9mr27452685f8f.28.1788189742553;
        Mon, 31 Aug 2026 08:22:22 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm17342585f8f.19.2026.08.31.08.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:22:14 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 0/2] Input: evdev/uinput errno alignment
Date: Mon, 31 Aug 2026 12:21:54 -0300
Message-ID: <20260831152156.166514-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Two small fixes so ioctl failures match what helpers and uapi docs
already document.

Patch 1 propagates the return value of input_ff_effect_from_user()
from EVIOCSFF instead of always mapping failures to -EFAULT (wrong
size becomes -EINVAL).

Patch 2 returns -EINVAL for UI_ABS_SETUP when the axis code is out of
range (was -ERANGE) and rejects ABS_MT_SLOT with a non-zero minimum.

Base: v7.3-rc1

Tested: built bzImage with CONFIG_INPUT_UINPUT=y and CONFIG_INPUT_EVDEV=y;
QEMU initramfs smoke:

  - UI_ABS_SETUP with code > ABS_MAX → EINVAL
  - UI_ABS_SETUP ABS_MT_SLOT with min != 0 → EINVAL
  - EVIOCSFF with wrong size → EINVAL

Thanks,
Iván

Iván Ezequiel Rodriguez (2):
  Input: evdev: propagate EVIOCSFF copy errors correctly
  Input: uinput: align UI_ABS_SETUP validation with uapi docs

 drivers/input/evdev.c       | 5 +++--
 drivers/input/misc/uinput.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0
