Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118878;
	b=Ae6BYZw7JYapkPK3bsBbA05/kBjWLLCK2Rc5yOiVD9d0IQT2dQbhjS55X1KPOapXoZg7
	 CJR3QOxTo1jcD7ZZCjLFoCeU2nmigkuYhyYvTD8OoidIW97LuptQ0Cbv+efVKPqU9EF0W
	 ymty0N6dkDRy6+veYJwDhe4LyQ6YsYLkb+kQcDuHIuYMd/pz6BEf9iyauExlCnOfZ64Pq
	 pFPT8jpG/K9afTIsIScVWFY4sPfoVAtrXd/z0Cd34UCEVSNkbswK8ndCbe5zij+EmXEPG
	 nQDg3umlBkBIW0cl0mCRgiA9m2cV9zuxcfMdEzkXfLc1XhkKY2qFaelB6JMDGfvuW9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q/JKV97sCmcIGpDMr5vMhTnfZ34mZbmaoLGVAAqLDYw=;
	b=q5Rr7t+HgXJQsYP8uI06Wu7sQrPFbuiVyzMFoUjx42g4IY9limSEWvz5Efq8bIW/v6bf
	 RBI9qSlqED7iPL7yO509Mpp77zv7w846hTa+JsNNbGnAGAPYAf+Qmhe6OE+PKCjWRQXce
	 yS2nxuASUL7SN5Jjeo+Gj6Qpo+TjH6p9aRpNl33fgeeZSBDSXw/E90SuPr2t6n5j2wedE
	 oCqUw8KDYiZ2KouWLyPyxcG4yrEv9i0jGDaQimCK/ScwsNQDQJfvFcruPsR8ImkxqLDZC
	 u4gJcL4T/vxU0Em8F9H3CbF5+MSdNLs+Gev+7a1b5xYp3j2bFbTan4FfVQVid+yRVIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AwDhRhvV;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D29606A31D
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 16:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1D29606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AwDhRhvV
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b19e291cc6so114927eaf.2
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118877; x=1793723677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/JKV97sCmcIGpDMr5vMhTnfZ34mZbmaoLGVAAqLDYw=;
        b=AwDhRhvV5x5ruErCYDk68Kmrv5BlFrgSGxdnMXhpubhcZGNxfXEm8SWpmivemxIors
         iNuvQKiFhUUANF+ea301Ro0AwM9B1+1mqBl5nBvokfPMHqrv3XDcosWuaycDuphQlduD
         Q5ugg8oIGYj/HSnnbnReplGxRZDbnCg8kiGOW7hcHzYJbZ7EGwed08Hd+cPXkyaa5hQ9
         khGGFa2F8CE71eXNoms8081rmEPBgWZcb0NoyrTZmtzJunAHiAqposarLZAsqiXocQck
         rKApQ7hO4BrNMwC7nPBkfHLL2imz0mV00hjLyYXKiDK6CNrERBohWEjpvoSF4WydgKB6
         3r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118877; x=1793723677;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q/JKV97sCmcIGpDMr5vMhTnfZ34mZbmaoLGVAAqLDYw=;
        b=mjwRq98wSpfjCK7YBUOmprIffxCAoJabIbIVrXSEQLZT5O5xQerGOMKGmBkzb+FBxu
         ualdtXemI8RtXnk0hGaXAE10sALpKRrTmWP0iA67i9QzRajYVY0gOd0sOhy9m+E4UrEQ
         DKUYr/kBQL22BMe9Lh/dk2eOz/Vzolf/3i2lgk8Ly9T4vJon+Aq4HMJLQf+hs6uTGh06
         LKDy6L1bh2/kIJKCrlsEOP+yvQFMR5LUsoFK/rjaJA2V/RHiohSu5xPulzrds3a153C1
         ps0kH1oS2DOQJtOZvn9XBk2bGsNRGHS+V21qAWK09Yz+oUCoqqRv+1BjKFRnSZIbewzI
         UXAA==
X-Gm-Message-State: AFq9FYJgKbOLSwMsTepCFSDEdp9uKJMMyxY2X35DhfkUhIgk6IYAFXLy
	P/215LGUXPGUDHyhR1ycVjywX+LGaAa1A1Mcy+Syib7oJwEuZsfFlQ3Y
X-Gm-Gg: AYBFou13hYKTlBo5MZxNr0v22aPDHVbfk4MN7bfQLcAPLfnLUTPz2/BTnQqPATe1OH3
	SWZPvhsWjaSC4FIA1jt2HKPXYYJjdY5xIDodzHsrJ73K77XBA9Y6UB9IZO2R25P2jk75UTeu9zV
	JJm8SvQhVoPSA+YFxGSmwCXyxYI/16qNGUNsPWGDDr1Y7DhXeUeyKOOv74co96fvDUTONAnmUjJ
	DdIaZ7cb8/FQ2e5XSWKirZR6itN9xypewUt71G6kRkCcS3VafsQkL4oIMtYpqsVP41vLX64lqyB
	eRkklUZsX9+VExdfPXE0G6B0oVU5rad/50ER+4TEoAj7E/p+W8B2YecK2gQ4rMxfuBDBWFupSjF
	5Xw0sK2D+w6aK6hhHGUCX/SBjQMD02Sq5giZKuguD9zHPvA7fGafp8EDO/uraRUXpnEE21idYhx
	Zx3wBS7kXHiRyNHWtspCIDviRywMVBkIMbbaAGKlaA81gnvHMDuml+do3dHpXHR/gmCz9u/yGD8
	BQyKgvC4LYEp1GdgFRBBxruYumjHXKQiGnkFSbnCnVOuWoK5X5MN9yLQ7QGtLnXbDBb6FLpNkxj
	pZvpgQuRnYg=
X-Received: by 2002:a05:6871:e805:b0:48f:e3f5:c41a with SMTP id 586e51a60fabf-4a8bb61b399mr19617fac.59.1793118876737;
        Tue, 27 Oct 2026 09:34:36 -0700 (PDT)
Received: from fedora (fixed-189-203-106-166.totalplay.net. [189.203.106.166])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b77ac132sm496503fac.6.2026.10.27.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:34:36 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Miguel=20Castellanos=20Valladolid?= <josstamy@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Miguel=20Castellanos=20Valladolid?= <josstamy@gmail.com>
Subject: intel_ish_ipc: ISH loader "cmd 2 failed 10" on HP OmniBook X Flip 14-fm0xxx (Lunar Lake), no sensors
Date: Tue, 27 Oct 2026 10:34:00 -0600
Message-ID: <20261027163400.20055-1-josstamy@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On an HP OmniBook X Flip Laptop 14-fm0xxx (Lunar Lake, ISH 8086:a845) the ISH
never starts under Linux, so there is no accelerometer, hinge sensor or
auto-rotation. The 2-in-1 keyboard/touchpad disable at 180 degrees works, but
that is handled outside the ISH.

Kernel: 7.2.12 (Fedora 44), linux-firmware 20261019, BIOS Insyde F.20
(04/27/2026, latest available from the vendor).

DMI:
  sys_vendor     = HP
  product_name   = HP OmniBook X Flip Laptop 14-fm0xxx
  product_family = 103C_5335M8 HP OmniBook X
  product_sku    = B5UJ1UA#ABA

dmesg:
  intel_ish_ipc 0000:00:12.0: ISH loader: load firmware: intel/ish/ish_lnlm.bin
  intel_ish_ipc 0000:00:12.0: ISH loader: cmd 2 failed 10   (three times)

From drivers/hid/intel-ish-hid/ishtp/loader.h, command 2 is LOADER_CMD_START,
so the query and fragment transfer steps succeed and the bootloader refuses to
start the image. I have not been able to confirm what status 10 means.

The vendor-specific lookup finds nothing for this machine. The CRC32 values
are vendor(HP)=12128606, family=604fc7b4, name=e4cc03e5, sku=dc6e7f5f, and
none of the ish_lnlm_* names built from them exist, so the generic
ish_lnlm.bin is loaded. linux-firmware does carry an HP file,
intel/ish/ish_lnlm_12128606_f9751b71.bin (5.8.200.7720_1029), but its second
CRC matches neither this product name nor this SKU.

A complete power-off (not a reboot) and a BIOS check did not change anything.

Questions:
 1. Does status 10 mean the bootloader rejected the image (signature or
    platform mismatch), and is the generic firmware expected to work on
    OEM-customised ISH platforms at all?
 2. Is there a known HP firmware for this SKU/family, or is HP expected to
    submit one to linux-firmware?

I can provide more logs or test patches on this hardware.

Thanks,
José Miguel Castellanos Valladolid
