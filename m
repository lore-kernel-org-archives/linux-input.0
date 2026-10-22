Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660766;
	b=lH4jYVOaAerRgv1bvfrXMZGri+kD3wqgbnzgB1TuQ6GpSY/H5UO0WvcpofD1ppO1m/hx
	 3p3d2sTiFJVX7eMANMNg11M4EiPirBFHTYqhQnBAG0gnWyBiNhz8yiXpXTO/gPMQtFaKo
	 /t8sGrh497ewWy60ZpjFUS0xJQhucjuJ/+vBezSjAn3FDMH+ll0aHENRk7ywa/EWgbVOs
	 ODIWanAfnlg6uwT/FtWhpRrqkXEwfUNdCoKIvnmoggebe1y/acA44VGZr6UEYU5T0miuH
	 yHofPsVK7gNSxeN04W5quKArkCUirpBf/eBPzGuqKspGYOMVd+yJgKmxpQjKBfm0WZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=x8jM4tAINOfg6rs5A/OqB01VfXYqFURFLCrahQ+gFPg=;
	b=FTHHYj59FXrRtA8By78iZPBq6ba18ZCgR+u/pB8mlOgdtO07q+ygeohDXDwZ+imwTYbx
	 BG+twTNukYRxDlHcIXhWq8pnv/G3+MrfQpEnKsoF4I9Dah9iigoHH6S2JhULDdOorJWIG
	 rdySe2EIoXfaDtvIP1km3HVkQMenCweydMZdQVr1gbbwwGWEsRt5Ed47Y4AzJBACKAR6c
	 p9xl6l3bZTy/v7LHzbKMCLZ1I01zXV0iLxyQj4niubzMWc6FOw7bJJ33qgdykiLOBZro6
	 apeOw1dtQL0riNFp2mEc5pjENfF+k+nE9mB62ORWv1Sl2DSQxCmPkuUzvCAfgZolnmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=XdFZXixA;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5F606A31D
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 09:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C5F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=XdFZXixA
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c45551fa84eso238908266b.3
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1792660758; x=1793265558; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x8jM4tAINOfg6rs5A/OqB01VfXYqFURFLCrahQ+gFPg=;
        b=XdFZXixAP3+1xIqY19/pqmBDJ0RWMabLR5crxFylDucQM0LfrtTJ3IvNWyXLNulwAW
         LWjaTt/NwVpCvEV/Cld+WAICdUHyvhfhunyyn6CSy6hhnyrPR9cY2Lpoj7HMFzJbjUJH
         pItVH3nhGL6vFiJRC1ESOPfvzgIepgzPk5zS/SPOC4H8xov/KpBmnt7WgoHe5nwbRp7d
         oQSRfk240nnZbeSIIeRNz3gQzgqk98dudyxpvENRsSVkwJyYi2DIgKCRrZAqPBN5s1VE
         amgTaHVi6B1dBaPFMUmsXTJKshCrGbHc9hWOC+GQqEAMllqXJ3/dI5qYPcANx0Q8qUOD
         YN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660758; x=1793265558;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x8jM4tAINOfg6rs5A/OqB01VfXYqFURFLCrahQ+gFPg=;
        b=IQbkFwkZ0zxQD3X2yilk3waj7v69EmMtKiZgkkegsgX69KdW21lk93M2s7uwS/IkMd
         r+fWMnIsI3coTa+UAhzS0fAGRcGw9kO7c4p4DW5PYTv7zs9AloJRSgVFVXJ6R7d8+G3S
         26H+8BsQVdDiIl8tCItZP18wznvbg43FW6si+yM5m0QuZjtSN7S6hgGgNR/X+tEEDhCJ
         zw0hBQA9Bc1emH4umtJQaz+Bm84R5Z6MWHbGMzK5gifD9TckAbeRPiR0pMHpAjQ6NjYG
         y1Q8h6MN7IPsi1UiZzvYya7bm27XLVzOx1XtR+MRSMv1ibewP88//lACeeITF+fKFNSp
         4xJg==
X-Gm-Message-State: AFq9FYLMYUUtKVNIVO0FXj2P/YeiJ6tvbjFhuSjBKk5PV0ODNti+adgQ
	x8WLAqmd7gCrUmlhgqHiOogV3s7WVBBOU+sgFMrF2EFmN5dDNKbvugRtX7n+t1wl6d4=
X-Gm-Gg: AYBFou1afMPs5M0NunYItgACq/pDKBiUogA9f1sYuxURi9kufedJA4uH3/JBFK+xnBY
	0YfNvo5PSpaSkiAfnnkDHkY1DgDO5teejpKPW9BKQyOiGWuEzcZvRnJR0e78GSlGr+IZj3SVyYR
	NI/1vrsLOqFq0Yyfyy9Mk+IFs0i9XJ3vPR5vCbM224B+DX7zSgOJSpvNwKQ8NFUOigdkEG0wGOV
	wI1oDNaV+E1Leyky5QZpBah4DASnUTjUYw8r0ZEoQeBMZxUnjWOsu9JDu//O4PDBAn9P7pFREVo
	S4zreZztBVQgDBeIHg5bqaV7d76hWUVKCbTqxVC6nyTAOWmtKFU5b9GgurMw7uDIjVqt41Xs3uB
	XlSPR9xGmB9MkVJKy15rJR6z0/TiKWZ62EFbguIqQSR9uRpXPBTraKqgx9jDEzMCscboBwEWwm7
	edW0hEzDpF8mkl+LzLagsByjuD5U6H9cTNS10gZMdGmNWdShCraHXpPjpHenOKgE+cGGp0IMpVS
	6WUNtcEOVDUEMagXw6uwaG6F6ahza4YZFbH+tlMSB/V/8Jl35yfSVbw4aeV0Zskhv83LU5+qXTC
	xad6GhpP8dexASFoxwqAnA/1yfXNpbyIQkCFa2C+Pc5adjf+xx6NaCf+nmDp3kV3x5rgrBZIcw6
	SEFosJr0TFqlnO0D3OuAP34Z6+z5Bfng5cigA6ycMVXCWPZkfNwSvsmiK130MOByDDtNXFGaiBo
	ehpgy6fFf3AKpzEg==
X-Received: by 2002:a17:907:1b0e:b0:c3e:f39b:2296 with SMTP id a640c23a62f3a-c4679620f94mr494323166b.31.1792660757898;
        Thu, 22 Oct 2026 02:19:17 -0700 (PDT)
Received: from 2001-1c08-080f-fd00-57f9-c36c-aa93-fd36.cable.dynamic.v6.ziggo.nl (2001-1c08-080f-fd00-6fe5-b143-671a-f202.cable.dynamic.v6.ziggo.nl. [2001:1c08:80f:fd00:6fe5:b143:671a:f202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a50aa01sm85790866b.22.2026.10.22.02.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:19:17 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v3 0/4] AW8695 haptic driver.
Date: Thu, 22 Oct 2026 11:19:14 +0200
Message-Id: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABLV2WoC/32OQW6DMBBFr4K8riMPNjbOqveoKmRgKLMIkDF1W
 0XcvY4jdVGpXb7Rn/f/TURkwijO1U0wJoq0Lhn0UyWGOSxvKGnMLGpVW+XAyvDRWt90c9h2Grp
 pM93IlJCl9s5oQO+sbkV+3xgn+izql9cHM17fc8P+OIo+RJTDernQfq6SO2nJgxP37ExxX/mrr
 EpQwmWAB/P3gARSSWjs5BqTgz48T4F4m9cFT7mliFP9IwOl4B9ZfZf1o2578EaP+Ft2HMc3/bR
 PzD0BAAA=
X-Change-ID: 20260716-aw8695_haptic_fp4_driver-397431e97638
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660757; l=1833;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=CeRNtKXwj6aaH+FnAhN1LCI5wbPc6KwuhA86xbBDykc=;
 b=eNrI3Wlge9SCKhzCcm+PxA35epMAcHqYm/Df48RSkdmGmgrSpp0fkkl+DYQ5Rl98R7KcvsnWB
 kPzCfRn6rVqBYF8l+Vq4D/stBObWcSYlb5RtMptUR7WNU0qh1YZODAr
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Clean-up of the aw8695 haptic driver patchset that was sent in 2022.
Variables dependant on devicetree have been hardcoded, and unnecessary
functions have been removed.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Removed potential race condition in power management.
- Fixed dt-bindings.
- Added MAINTAINERS entry for the aw869* family of haptic drivers.
- Link to v2: https://lore.kernel.org/r/20261001-aw8695_haptic_fp4_driver-v2-0-1bd38b1943de@fairphone.com

Changes in v2:
- Added power management.
- Reformatted DTB schema.
- Removed unnecessary IRQ dev_dbg messages.
- Changed reset pin bias to pull-up.
- Changed error handling to reflect subsystem style guidelines.
- Link to v1: https://lore.kernel.org/r/20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com

---
Griffin Kroah-Hartman (2):
      dt-bindings: input: Add compatibility for Awinic AW8695
      MAINTAINERS: add entry for AWINIC haptic driver family

Luca Weiss (2):
      Input - aw8695: Add driver for AW8695 haptics
      arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695 haptics

 .../devicetree/bindings/input/awinic,aw86927.yaml  |   4 +-
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |  26 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw8695.c                        | 805 +++++++++++++++++++++
 6 files changed, 851 insertions(+), 2 deletions(-)
---
base-commit: ec8bf8280261294a9b9b4520414b42704c7f9f6b
change-id: 20260716-aw8695_haptic_fp4_driver-397431e97638

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

