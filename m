Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568959;
	b=Hez1eckaFsM7XWYqed2jPkUf7qNdddL63xWOSFKA1ui9qofzDh06uB+qBkZWpIyPGgHb
	 PN/h8tWw6HZa0ohCrvj3hDrnNqDOo8Qwk6to9zT5dB3vVHGN7NCzR+6hk/rIK9CoJxheh
	 tPLcC14E01j27WIPHMlZxo/wHP4SxBXL+OkK67wWOAuO1hdfG7funlAC1wmR8GSr4nhrP
	 qvSotGprhXFjpYy8refWtKUGRiS/d2l+GlcdMlcHfGua6Dh//vMcPFqU2b0a61xrmt1Hc
	 7cQpN3G945kWJVrlebu9C7PXyrQ4ZW/o/PU4fdHe8ee2fjI6dnJClFVHD43hyYUOkFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sbmw4N9ZOrzNpmY4Wy/XZUtKSoT6XgWpn6TeMukDezE=;
	b=dAITN5BaA3+KnqfSvEDMlt50+4nYNnGdmPthtWQS620nLmcxI9GFlDhUw090/NLT0t/o
	 H/IyjYXOmXlufWhpuWm08cTDBAWtbGv1jeJ3YXLB+TkXMUU6xsgMPaQyup0QkCY/o5yrJ
	 b3D2Ig1rmCl/SUFrqQt5vLRZdgBVlFWeMlUDY8p628qpWc5H6QyhH/d7gcBnSHgIQfM7y
	 Jxn9cKe+wfQEpp3qJujSkFlz4jOs06qkqGHrF+t2PupC0KAMGutpWfY521/yNVMGy7sI7
	 nme0yBU5b0nje/VToeEeNuXT5nl3iePjlaJaRNkTquHhZB/GBAnP+nY4baWCRu84nyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q20VRQ8q;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671C606A32E
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9671C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q20VRQ8q
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a8cc11ac42so584994c88.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 03:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794568959; x=1795173759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sbmw4N9ZOrzNpmY4Wy/XZUtKSoT6XgWpn6TeMukDezE=;
        b=Q20VRQ8qOgV9X9HGOrJuLcb2+2cJ40HCMkaUTGcg22VvSeVL4A+RbdWBKM5axJ36QE
         HbVSgfTLgsh99hqCGQGMHTK0AfM+1rkYAxMPyq1fHKJB3FWsovdxHkODcw++LVfs2CbA
         eVmmSSDrbcOCs4y0Dmih82RXdGhd/1RjmAc5RHhgMmF9cZhWF2e312quE0GEKdJMENfw
         pKdpVgL4g7/JWTNNRfp1fw2XTDiNsaV4iqSG/8SM8o/ujuHZgbbUAANY9W/Gvc6kKnCW
         sjSeLv1Dw/ewMi2yB+se+bLS3mhq3A1piFPL0twvdLVjbaiGGq93phQGu0AXDWBdE9MM
         eK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568959; x=1795173759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbmw4N9ZOrzNpmY4Wy/XZUtKSoT6XgWpn6TeMukDezE=;
        b=fqtzSVAyVSUu/pT2Z20fd3sOcD7qb+guSFWnPuEfXaEe8Sh57cC1xScZfONVXf+khe
         KhnYHiamxBScGzxbv/89NQVgC7jlNzkVhgpxtHhbfyi211zTea2IXBKy75cSricd6xqx
         Rp68auSJHDsYIY8E2sxXimT5L+zOr80WXtdEt+PRB7Zvmia49V6SmZlgkeoUMKicSzKB
         AdFpFRQsF3PPze/uHawBqke0I+wmRp5SYYNsd7SMA0lqpUpTbMpLz46Fa/YR5XiYlTep
         hm3mjLpWZDIYroxWuBKa5ojZq39PLm3PqkjsnRUPv0nzat6a+C7zmFhOBNuQTxxdM/32
         gUvQ==
X-Gm-Message-State: APuU4Z81swYKu0zb8lxX5cTwnYCj5xTrdUq4xyvx9oyES3Nw0JMMUKbE
	XetXLdVmtY4ObcvZ6UPIPOfra0BBweXnx+asUSMLk4LWw6UXY9jy5Qys
X-Gm-Gg: AYBFou27DCEjdw5yT0PZV0heYeOuUpwRhBxiyJVwuL2zqGMNpn86hCCFY8AB+MeVEda
	bEgmdhbW2gKaOYG+BX8yEKtZvl9wtI3We5qtw+tP4wCmuVUWczuwsbyBadoGP/gnbpWYw4eeYdS
	s7yVZO6aLvNEIQ9UxA/3E3X4kLVIfCy4vS8L/o+EKUsKTuZmIPKYuPTUyvzHU5aJctVYAQsPdNJ
	7IluOQ5apB/qJPu3pw60deJxrIyZE+k385BW1EbNgFNrkDFsvfhrkv1usdUaYaB+1wCiB+H/UNG
	4Sg9B34D7ALSS1xjTtuegUgBF8VX5UgOykCL/HpKZ3qpZKKWYesAphY3GESmfkT1XVIQZFQtA00
	sJiaBzukDDeyoaW1SJr/cxnoQ/0RUvSrZlvBgLwyPGKic80mDELTD6LBR+478g98Qh0SMzy/m2W
	bquqDoaYDPI4iHs+lyv/3OpTwPTnv3uIIdheB/m5bnzafQVEpQl5tbi2llHB7LUZpl9V2+AOsCW
	yYrf2TvWfvTj3wyvQQI+7S1hYkgeNFrNmD8wbf/hOOSTiATVV8kVnIzYr/CVeckot/IBvKPPXho
	7pDh5goN7cNcSUQ5V/O2u8UWq/Q=
X-Received: by 2002:a05:7022:3a8b:b0:182:94d7:f76a with SMTP id a92af1059eb24-1b5031562c3mr2330168c88.43.1794568958594;
        Fri, 13 Nov 2026 03:22:38 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d990sm8374244c88.4.2026.11.13.03.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:22:37 -0800 (PST)
From: Yuan Yao <yaoyuan0329os@gmail.com>
X-Google-Original-From: Yuan Yao <yaoyuan@linux.alibaba.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vishnu Sankar <vishnuocv@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Yao <yaoyuan0329os@gmail.com>,
	Yuan Yao <yaoyuan@linux.alibaba.com>,
	=?UTF-8?q?Jingle=20Wu=20=E5=90=B3=E9=87=91=E5=9C=8B?= <jingle.wu@emc.com.tw>
Subject: [PATCH v2 0/1] Input/trackpoint: Add new JYT_NDT device variant id 7
Date: Fri, 13 Nov 2026 19:22:01 +0800
Message-ID: <20261113112202.10304-1-yaoyuan@linux.alibaba.com>
X-Mailer: git-send-email 2.56.0
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

The new trackpoint variant id 7 is found on Lenovo Thinkpad X14
Gen1 laptop(Product Name: 21XMA006CD), it belongs to JYT_NDT with
confirmation from Vishnu Sankar in Lenovo. Now it's incorrectly
probed as Generic or Logitech PS/2 mouse.

Add the variant id 7 to match the TP_READ_ID command return
value, probe the device as trackpoint correctly.

I tested the sensitivity/middle button lock/rate/resolution
setting, the trackpoint works well in daily usage and when
resume form system sleeping, no issue is found in my last
weeks usage.

BEFORE:
input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input63

AFTER:
psmouse serio1: trackpoint: JYT_NDT TrackPoint firmware: 0xa1, buttons: 3/3
input: TPPS/2 JYT_NDT TrackPoint as /devices/platform/i8042/serio1/input/input8

The patch is rebased to 7.4-rc1.

Changes from v1:

1. Change to correct vendor name JYT_NDT, with many thanks to
Dmitry Torokhov, Jingle Wu, Vishnu Sankar for helping on identify
the real vendor of this device.

v1: https://lore.kernel.org/all/20261102130836.11863-1-yaoyuan0329os@gmail.com/

Yuan Yao (1):
  Input: trackpoint - Add new TP JYT_NDT device variant id 7

 drivers/input/mouse/trackpoint.c | 2 ++
 drivers/input/mouse/trackpoint.h | 1 +
 2 files changed, 3 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--
2.56.0
