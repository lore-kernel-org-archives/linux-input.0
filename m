Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652978;
	b=vEtVwIcC1nj8oIr5vhqj/8uLk+zowZcFEvBXDloT/pJdExMfHfFhU4WqZFxhrOOePuoL
	 Dskc2/xXlYQt/KA21W+ukLmlFpz+N61we9DPE9NOTnZbkYO5zO5sPEwl8snxaYKEEUkNe
	 sKAPA/cnOAdQfBKzD2shVYgiJEw24xVeYXYOXRmEQNdRQ243XUhz/gmLjKMqWAr6RR2Mg
	 9RZ9wTYkKi5FJA1d9cRVR3TuL3Y4I1A8gbmBuWPECsBhU+zcTxVOYx4B5Ja5Ng04r6/ha
	 yvkmx2zM6OEh3++iufdigAyk+6+9RFxAdFFU6zROwUdS7WiF/KmvN5lcOKgRRNXRxjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y8vRmEfoyjBwhFBdczVPnT1IHPEuzg+vfDA5yLIzw3o=;
	b=MxC+MuOHJblGnO/eM9Y7oEnQSiuzQC7NGtmQwfzZmH7Uz/V0Rs5iMDTH3F4bsIOvST4Q
	 BD9ycgbMxEdLWhlmH8xz0FIBlSZw72ldy6kfoGBwLiRASenuKaUSHLYNlDsMQ2EL/EY+s
	 mNwPl31Gn+r9jJth2Yo5AmHMjNIyuWWXEuBaiVf3PDue54BAj5Fg4WXsilRlccsw81u4d
	 v44iMvZyBV3IDlR/R87Tghn9f6maPuW7sPxMMATJJjvkc05+ymbP4GzVN1wh2ggkiGciT
	 7Vf6eJOy9ZDrRVSksHlwde+SHPLsqel9uefu7Sp+s183dZ8r9CldbfpzaBuHDEfngLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="NpeQI/zS";
	arc=none smtp.remote-ip=74.125.228.8
Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819D606A31E
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0819D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NpeQI/zS
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd3da0e82daso291513a12.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652977; x=1793257777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8vRmEfoyjBwhFBdczVPnT1IHPEuzg+vfDA5yLIzw3o=;
        b=NpeQI/zSvEQxTUCHDlatv9wagKFyhbSq4iYaKIW5O5xnPR1b1UJnU2mVcSBRe/NycW
         USkvqDpY1Nr2gjg62c98xwoqTZxA2BgDDiHRX9I3lWk/7rtBKJThc4mLd9INLBQWvvVw
         yDF1CMrUm2PDdmhbK0usfcbOAaPfJ2/ICjM8Q0dPigwy5PRFAgnxiJyIbx/Zp/B+FPzm
         VF3d7gPwUZ2IJE1XmdAv9oRuFFHsJWDcKOIBPxO7gIwycmkIii8GcsErzdqCP8lbfItc
         pJcPIFIF3nKIL8hfzBqmSelulYlneGMOpOprXwsSOe7v32PJkPMxn4O/qsKAVx4SNkE6
         i35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652977; x=1793257777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8vRmEfoyjBwhFBdczVPnT1IHPEuzg+vfDA5yLIzw3o=;
        b=kyKFJIP/+sVvJR/pB+PaGRzg6ni4oWC6k/6D4TAofyxqgMosHHUjrMvN0cFAQgYFsk
         SYrNAV9v1fqa39QqMmrHHxBOw0p24KVZbqLIuJghAWAOIpA/kaGGI/vpaZKJk+MVloCF
         qc9Gv0aEkIBVxspnWCBRKdzCVgFIoDJRE28jPhw3PIAeOyFW+3B9gzl/AwJuLgKSXSZ1
         jVF+c76O+hY9iHRg7JDL86Anwl6TvsrLdAaHUGgJpE4m3w0JaXB/oVKbFlIKDRDOVFNe
         huZeOyxIXE1fSEVrFlwS2RK3KtFVu9IvYC3RPJWQCunl7vWgBCG1G4ckjTr8+LVrl7Xx
         2whA==
X-Gm-Message-State: AFq9FYJfozxEILVQBKOhl3bOmWWYR0lSg+K/EoQLTs/VYYPnIzML05aw
	ffLufPHlIbhZyN2/Qjkvqt8hTEZrW/CKwG/g9mUl3cPHV6LMPflaTcWLO2QNodeeTrUgZA==
X-Gm-Gg: AYBFou0dhj7Hoo9NRPEyvZVcpDlmpdjfgmrQDFRpX8MAY4EXFZr52UYypULinGpinB7
	myJwuD4+5D4wnExWS5xfhCQEXjtrSaj/c5X8p4eYQimeej4PmgU4+2FC6ENLEC8iFCIYmfOS1rZ
	IGjDHBWnoyEwSDmF6YApSd+UuW2cB5iiNG20Y9eTqVr5m/mMSIVm6YoJHWmh0nWmzZsKURaHhpp
	/o9oUYOiPWHVrIrCqD2b/9PBOp/xHh+G84D0sdOb17cr7Q5+9qaR2ZLZW9GxV+sh16bY655N1sp
	S8lyESeKxV2Xnlv2lHYnHPoAhI2jFiq7PDJHugA+sbw1HjleIpVLybpwwncpTsA0bmOAyQCjMY5
	JfbAJ/+p/kafUgmllPgmKheqeXkNXHzjkhpt5ckgLmIz7RtwN3IUdbVSzxbhFDpcaw6AV2/IbfK
	8csG9Gq9Z6qhpo6BdDD+JMmIGd6pGU00aoXwOi/sNsI8ErK0bGbEE9ustnhSl+g9Jf26Pr7rUAn
	dXEV4B+ggG6XJ6d/V+pZSpcQVfAvGeuVrPLrx1w1ZzHdDCcWpglM1+CvqV1dtSFBcCsdItU1w==
X-Received: by 2002:a05:6a00:1883:b0:8a0:73d7:aa7f with SMTP id d2e1a72fcca58-8a089e90a35mr3761029b3a.41.1792652977248;
        Thu, 22 Oct 2026 00:09:37 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:09:36 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 RESEND 0/6] USB: add usb_make_subpath() to replace strlcat() in input drivers
Date: Thu, 22 Oct 2026 15:09:23 +0800
Message-ID: <20261022070929.20820-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021123146.17202-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
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
This is a resend of v2 to include the USB maintainers and mailing list
that I missed in the original posting.

Original v2:
https://lore.kernel.org/r/20261021123146.17202-1-shlomojune6@gmail.com/

No changes to the patches since v2

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
