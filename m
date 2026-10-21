Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585915;
	b=pfGyRcArSixYinJxYm/TlyK9fR4joWrhssclpTEU+W5jeMuKV87IM7TEOhQDjzZb8AtJ
	 iKyq/5LCe8m4F25DNB/TjmXfkzzZ2IWZ3LDiTq4/gwUt9bSzG9pNXnlthFY6/XQkdhhL4
	 +PEeObGr39asXIWo45Dkdxhd/9jXYw2JKT3vYfXWTYsWdTW4aFPpS1jkmKwZDAm0M9OUp
	 ejIVwTKzoOphJM93FjSxEu1rGzQTOX3n96NHrJPzF9aYPkZLV4aeOv1sz4S+wwF7zwLG3
	 aDWQZ3BvAVhAoWZZCkN0MO0S77/fSCBAelCX5lJ7iyi4vDPjNJVcn70QcS4oeXa34lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WCe2h/c6J0K15hd2wKQCLcyUixtVEx4iPn4ngkUBYj0=;
	b=5nrw26IU3gcs3baSDBUazHZCjzyrycUGrr9doZDlJKX5Qe/5Z1unv6GLVAq3OogIJG6b
	 upfeRllsGqSu7T/fmj1qooy3+sJUK0jFf4gU+J9LJ584Zdhrlppw4ZRJxWGDRrcRRhBBa
	 vpuRds+3S+jc3PANQxFprNxxIAWlVdhcpa2VOWaZa3WDI1cCWPaTBGGu73VlFmhpJZKQT
	 OtmYzbQq5HaGSbynCYzDX6M/PVMdHa9c/DhSwxlGrqHAYiaCCsz+FSbZIOrPsiaI7siFC
	 daHiA9zBbPdYzqv67w+j4ggWl/lkgo3vadia6BwVfBC94MmgaOKBpX7RxplonYRrumQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DMfIYGgB;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9DB606A32F
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 12:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E9DB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DMfIYGgB
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso195904a91.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585914; x=1793190714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCe2h/c6J0K15hd2wKQCLcyUixtVEx4iPn4ngkUBYj0=;
        b=DMfIYGgB9fbpKyyVc6Mtp7dPhRk82hptsfy89WqLYIEnWeyqCgU+tsajJpsR3hXbYD
         csD7yG4DJM2J4ygwJiFVBrV2icf7o6MO/f1mCNcxeLhGSWYlWt3yA14hl1UK/pXcNV00
         7SdlNVyap1qx/D8oZwnrLodLrs7jVs8YOAsSw3SbutZg7BOTjrbCr3d4OflEPDGaF7WT
         yvzIG2HqRHkgkGw+tfoLck8zV6aCJBYw2BVb7LOKi8IsooIv52weIuDt7rEult1Jt39K
         IsUrD2pgNzyFSLIpjSbCCcexvn7rMZnxv+TBpNrdwjb1/VV6klzew0P9N4gNt2LT5dFg
         09Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585914; x=1793190714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCe2h/c6J0K15hd2wKQCLcyUixtVEx4iPn4ngkUBYj0=;
        b=gXnZjBxTd9FqvrlfzHqAQGR87UpiYlAah0scyhxV9/vpb2Mql+7j2hE3Ptmji1A3fp
         h1kiohTLioRj8GEbqCZNcSexo3QaCzvYJIiEGHS30pFBfTxNcyfKgd2ORmBcqlUkHH0P
         NtYuf02HlfBGq13ZsYBVSGCorKjVR16mIrppqR2FWlJbvdP3QgGalsadSETivf9cyzH+
         MPEa3GAA+kracmGoj7Eanl3KQZW5Md8Q7uLFIag2wEDqW6KEoyAU23Vc54O6TKzCbJ2v
         7Zu4PbUEIHInDp7gw16PSDerBvlz/xsLI8Y6z3RhtQZdAzI94x6fU8m3aoNd+tK+ilLA
         6vdw==
X-Gm-Message-State: AFq9FYJzb7WJ7VEvdZD8vb1Ka7r6C5o4FjHZcOLWzjOGRLjx3kkRn+gr
	o2b932sQi+qFErglY1P2iWszEubu7581GviQFUA/Kk14IMKPKlxyiHYuNmFda0RVFGU0Zw==
X-Gm-Gg: AYBFou3rjWEUAuwp+L+g7XF3HaT0a5Jcg8g5YXQ2jG9Hs5krU40ZWnSYzsJiA2AY4R4
	j/gS8wmlhqqndBM/iOy9Pvdg4yYOepJMRoTbmH0jJ/Gq0cY+PBo2Bn0eMm3MSRc6c8POZELqj2j
	OKvUnEwdtsYd4zPQ4303pPrjx7q/JV54osuDw2xV5LzFFy3mO1m7HBnAL1PbZdlPc8EZWrddBNm
	WMmy8YVvxLPdQqeB/yJpXIcj4tnh/CRj3ZwJxJFXh5aaqKlQzEVUDG874HtydDLcEi800q9hH0L
	fDwyu+rKeFc4LJlffkHe+9wdXZelQPd7+4NondeZo9Gkj5TFgU2OkcpsEovXm7v7zImp8W4oXb5
	spZNPGzlri8aaiMibltcO4OP22vza8chuvXPnVCJdJrfQ5t79o1iKYGT7dps2u2A+2syPeIs+fd
	Iv+XsVoMH2JNO414tuzNOqiPf49mqCFnzPg43ljNhaK6oVYDmeYvo033m3WL7fuXectCJFsQO3+
	70J/tn3c8TcI2IyStrCR1jXSSialAr9xXZ9RpyEMuH7LG2UZwc2KqbWLGlVvSecooF5gJj3X3X8
	0/eAp6+ZmONKmcfqjS8=
X-Received: by 2002:a17:90b:4e87:b0:3a8:7242:e8d3 with SMTP id 98e67ed59e1d1-3ad86dcaf42mr1503660a91.7.1792585913894;
        Wed, 21 Oct 2026 05:31:53 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:31:53 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 0/6] USB: add usb_make_subpath() to replace strlcat() in input drivers
Date: Wed, 21 Oct 2026 20:31:40 +0800
Message-ID: <20261021123146.17202-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several USB input drivers build their physical device paths by calling
usb_make_path() and then appending "/input0" or "/input1" with strlcat().

In preparation for removing the deprecated strlcat() API [1], introduce
usb_make_subpath() and convert these callers to use it.

Patch 1 adds the helper in include/linux/usb.h. Patches 2-6 convert the
joystick, misc, mouse, tablet and touchscreen drivers, respectively.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>

---

Changes in v2:
  - Add usb_make_subpath() as the first patch in the series.
  - Use the helper instead of open-coding strnlen() and strscpy() in
    each input driver.
  - Link to v1: https://lore.kernel.org/all/20261016170411.51025-1-shlomojune6@gmail.com/

---

Shihuang Liu (6):
  USB: add usb_make_subpath() for formatted device subpaths
  Input: joystick - use usb_make_subpath()
  Input: misc - use usb_make_subpath()
  Input: mouse - use usb_make_subpath()
  Input: tablet - use usb_make_subpath()
  Input: touchscreen - use usb_make_subpath()

 drivers/input/joystick/pxrc.c              |  3 +--
 drivers/input/joystick/xpad.c              |  3 +--
 drivers/input/misc/ati_remote2.c           |  3 +--
 drivers/input/misc/cm109.c                 |  3 +--
 drivers/input/misc/ims-pcu.c               |  6 ++---
 drivers/input/misc/keyspan_remote.c        |  3 +--
 drivers/input/misc/powermate.c             |  3 +--
 drivers/input/misc/yealink.c               |  3 +--
 drivers/input/mouse/appletouch.c           |  3 +--
 drivers/input/mouse/bcm5974.c              |  3 +--
 drivers/input/mouse/synaptics_usb.c        |  3 +--
 drivers/input/tablet/acecad.c              |  3 +--
 drivers/input/tablet/aiptek.c              |  6 ++---
 drivers/input/tablet/hanwang.c             |  3 +--
 drivers/input/tablet/kbtab.c               |  3 +--
 drivers/input/tablet/pegasus_notetaker.c   |  3 +--
 drivers/input/touchscreen/sur40.c          |  3 +--
 drivers/input/touchscreen/usbtouchscreen.c |  3 +--
 include/linux/usb.h                        | 29 ++++++++++++++++++++++
 19 files changed, 49 insertions(+), 40 deletions(-)

-- 
2.43.0
