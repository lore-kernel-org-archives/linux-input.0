Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466241;
	b=4jloJLvkeyUbkqfSA+2ojyLpRLe7rfIEmY9oTiX9mlQV3vPYSGNWb5D849xLSvPV1E+l
	 AAnkui1OjzioXtHp/YWkgZtEsp8Hs9TaadOlLpRJcc+ocwo+q0Mdv5p7/cB3zpTuSp9mz
	 RnApAvDKeLelSS5bFUSBKJSuNucsD+0/vtbtELBKR1+hyU6WsmmC7yOx1JyRAUiZk417p
	 kspa64yK/TufUQj6I2hcg1Wt9WpLixHEF/EX5ZZmx6/TpLILdfYqjHMjYRrom90yLtJVm
	 FhSzx5KHDfM8J/xbcdJmO3NDEwWpQ32YeVjnC2frMGoFl2muZQxrTC9cXvy1BIMuKrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UQ104XrltwOzDQ8IcCi3Ok5RkLXXXhJmwNsMcy2ddH8=;
	b=iZjRR4lLcU03p5OGC7lt8CDwV35DRFCfmQhjnWyprrKX3vcD1rIk0T2PYPqrg2uN2tJA
	 r5+cH/JGnkvaUlg4YXoodnbUAwhDyLqj/Ti8p2vsl5FFwwfVWZts+qyiWiyQOK5N9SXLr
	 ctanM9HdyYSp2LvctIM4xgSWByVDxDTDK/hqoi37Ju215QhWiQvSBL6PIuvncQ3TRHCxj
	 Jnka5jSzVFTBSotc1nD8E1ZldcIOQO4oysb6AnnRqbP6oltkyb5wr5b9sbFr5slfWPx+w
	 fJHZ16Y4q35YRIqxuNXivWmLQJBzC6QUZnP3YSUQ/sy5Xm0nPfozkQYcVtx64FD9q5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+kJtLGF;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50280606AE61
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50280606AE61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+kJtLGF
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so322826a91.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466241; x=1795071041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQ104XrltwOzDQ8IcCi3Ok5RkLXXXhJmwNsMcy2ddH8=;
        b=N+kJtLGFASRGuahSux7Ypn94XBqaQfBt7x3p0iF0GNp3TDjNDeTJ8prQVSu9U8gFcP
         hlYxSbRXx68RnRcWwVG62mYXATTWyEhA25gQiWCIdjKvya7iLVH7GMPwISFXw/RwMRLg
         fh07Q9IhoovKjhk3QfbcovvP55djwpBIo7Mfn/cLYeKeGi0Pr7N8Ot3VEAv9Y2mk6zPq
         SX39mUH53To5ACHKMAXINsCDWFFxWCDb5zz78Stq/veL24gHJr5sBammaFm6wMPQfdTi
         mnM4s+sH+zw2UhavXX24lv6W+QR8G7zjJVVEyyNYEtD9mB6elnGo191616otDMecOWua
         XHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466241; x=1795071041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQ104XrltwOzDQ8IcCi3Ok5RkLXXXhJmwNsMcy2ddH8=;
        b=ie7sYmlWD5768ra0O5U9MXT7w2ZffrubbO5xzdN1KYgDuyHy43fFAp01Iyb+WxkRjk
         9Js9TUEPod9MKzocIONmXf1zBp+E2Hvpx3tkpUfhKUltLo/UYNxuZIx/wWqq0qrmZGwK
         XTJgWqvhAfT7HSa0lKfE+Ki1C55Nc54ah70tNpIDOrt5EJqL/czj8KtC8HioyTa3MQOh
         JueIkQVLFh3E469yx0C4bcznGRyyUD+gN6giN0c7Q0VDWkJZHWIrnjQAsz4kC3fjb/jM
         yRrxnAS7Pcr9zbekKK1M0tIME/eNieocX9hHY/JRrbI2If8frIaYYOMkFsjxMeZE2K1+
         yT8A==
X-Forwarded-Encrypted: i=1; AL+hErHOMB1Tv2dcQ8BqX+HJ1Inhj7h1X79WTdZW7cHbBN+8pt/9E93hGGIHCzmoRcWJa6/YtFOwmKpRwgVSxQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Cnvzj0nVDQptmqwIIjjHP+VsCc3FoHSz3TbPIzeP6KI4B27Sx
	sTriIIzJyKtHrj8SSaIxwHPbIzcwj3aCpMNSlOBQ4S4B0fbAQIdkGy2b
X-Gm-Gg: AYBFou0RFlDBpkZ6+UfMBMAqoNKfhmQ8ExiSt2seTk9eIHt4KK6oHn3UfieaOsBLsYx
	IyxPH513S5ZvXT2eOpx2cOpXbzv+qdFQGmqCN9750TBdLIMyGQJgFLcBrxqFzq1cVtfFuuj609E
	C63fxnnEB//n458lNa54+8sx/agFjanagOQFNpNp4CvC6XE4kADGwRsJTYbmBrKO3WvHz62FLCP
	YB773ZuHU80lkRw//uaTzQX5wDyvQY+XVvq/vpV2FOBPFwowS3egI5p9cq2dSTwm4KcrTBq3E9M
	lB+3feQMPaDPUJMRCz5N1s7CewUU6rS2Lq0sev9K0O7cbef8iy9aZVvb1bUtgjstM5zXEhPNuCW
	bvY8ivSUWamrGBZkij8OA1mRZCQZAoyB9veiowF12uo0yDlUjzXfF5TjzPTMUH+B6dP0eyodeuE
	bRtQO7WG9H51JqixpzQTQB+gZ9RLQAw1ZpBzc++0K9CNJacw10j7y3nMf3V4H8feZx9jGj3m3LI
	de7fJnZfmqzcEzYUALzlXjzqPNitPV7LI0VcxYex8WE4LhI+2bgV1nh9eSwp5P0l+wcBd5Rk+jw
	f03QZf728vY5tl4rTZ4kMGEIoTN3Idr6K3Lpce1P7eFuk28zWcItuOIr89/L4Iis+DTnNfWix+I
	ovcYytg4aTHGj5qq+iGEFrjBlCfkzwNVQwsw+kQ==
X-Received: by 2002:a17:90b:4b84:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3b197cca4b8mr1069474a91.29.1794466240511;
        Wed, 11 Nov 2026 22:50:40 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:39 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-input@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Input: tsc2007 - drop platform data support and cleanups
Date: Wed, 11 Nov 2026 22:50:32 -0800
Message-ID: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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

Now that all in-tree boards using tsc2007 (including SuperH ecovec24)
have been converted to generic device properties, this series drops
legacy platform data support and its header file, removes redundant
memory barriers, fixes minor coding style issues, skips registering a
non-functional input device when no interrupt is wired (when the chip is
used purely as an IIO ADC), and uses IRQF_NO_AUTOEN when requesting the
threaded interrupt.

Thanks.

Dmitry Torokhov (5):
  Input: tsc2007 - drop platform data support
  Input: tsc2007 - remove unneeded memory barriers
  Input: tsc2007 - fix minor coding style issues
  Input: tsc2007 - do not register input device without IRQ
  Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt

 arch/sh/boards/mach-ecovec24/setup.c     |   1 -
 drivers/input/touchscreen/tsc2007.h      |   5 +-
 drivers/input/touchscreen/tsc2007_core.c | 183 ++++++++---------------
 include/linux/platform_data/tsc2007.h    |  23 ---
 4 files changed, 60 insertions(+), 152 deletions(-)
 delete mode 100644 include/linux/platform_data/tsc2007.h

-- 
2.56.0.567.gdb80ae8cd5-goog

