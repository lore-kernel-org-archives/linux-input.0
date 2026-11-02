Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624927;
	b=MsVR+3V4gyH2rHUgfOV3Zm4Pa5qTjWApjRFU0uxpaegvfelamlX6aDQ1FBs/qEEGu3uD
	 YPq6kj1S28uWxqEaaTEL9qNGRcF2zjXtbuk0TW6utTruijsdn/MW1OdbebMMETACuzqX7
	 H9g4u1Q6XLLa1ss/pkIsHTs/SLXqHCJESdylvG4ykv/rg9zRZ33oKU66hA677MoMaetKp
	 11ihOuPEWn3njnfSfsk9GWafJ2gcimeEyCI6ElzZaCoxD7Tj9Iotd/6lOOyZLM5cUHB5E
	 fwmOEJmqrwoYbHBS42ssYejdrP4AGPGfYuWkHf8aFkhC0i9n+2Q58rK50cjY2R1nk3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=U9QbGtzeNGJqzyzCb4IjDhpDG3gtmR1xtKLnaooRWwg=;
	b=iScdBGp0CYpmR79LSKMBvFf+HrF0ABTg7A8DE3wNQw96Km/VV9iLZ4Y92FhblCFvQKw2
	 CRaR3yndav3RDbSWKKq9/AOGmK0eIppMDiYKtuvFy2+cm858U6ahvCsOd3CndYuUZpuMS
	 Y6Q6oEp0JPSw09OK6DQIkg5GAAx7V2lA1tjDhaaIeGGjNTShbkekWCuApIw6a40dnzSPo
	 qDewluuBDvp8MFEI12Bc/icKZj9UYwEaQRVYLrgTJYw7twZ78P6TZ06GdwSEsx0CFeR1a
	 rNoaCeG+HhJF0AAgwBNL6oSaco7+hGQ3vF1EhtSdG76Q2kMRbpy7U8vDG2KzUmDW8PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="j/697NcG";
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0523606A324
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 13:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0523606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j/697NcG
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35b2c599f43so4910034eec.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 05:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793624926; x=1794229726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U9QbGtzeNGJqzyzCb4IjDhpDG3gtmR1xtKLnaooRWwg=;
        b=j/697NcGRQDxkvUj7OWJYXmLtHTaGypmTBLd7YgbPvcb2Nt/eY4r3D21B9ZFw0VIx5
         w5Uf1IwS2Sdvl7Pk3BKbnX1YWzrBKK6NKfxCPjgztnKtAf0LMsM3dcJm9Yg7elRPB9XJ
         8lEiTVl1JDqZ/sGA792TXSQqrq6N+gBYhbzdHhAQrBSQUYFGseSf2UdW6hc4kghhjFul
         XzoSg4a9Q/PJwWEB70/08It9ze12d+i2M5AAkwGAYAeTBSrOcgAwVYjEX7cxipP3ppO0
         CkSrEkQjWwGm1E7VbVbcqFPB+U1DwD3y4fRqvXkFRoMbZLUrAS+RNDGFh1Om08rD/pbE
         9Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624926; x=1794229726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9QbGtzeNGJqzyzCb4IjDhpDG3gtmR1xtKLnaooRWwg=;
        b=gACgLld8eAmi58dbgJr8GRV5h3uXPj50M2+R0J5XGtiEotvzggwgvJSuWg4lCIZdwm
         j+JfK7noMe3kkJo2LdDoW9HCe7qjhwux6t+MKp962iuOJryj9UWLB/MbS8704UZlaQmF
         Y/69SSUHENpRPfozf5t8n3ZRreJXhpq+f9xTKb/uYcCm22lCyj7pBjfUWdtKNOHFdyQM
         TNtLgtZ9j4B0BnYkMdOHdho8va/bGkLKReHk2xqoY4d/P2IvCom5nZHSfFUFl+kJmJQ6
         bQC2CZ32bMdAMej/GTbk5CX8HfFxwLIf6pXD0hQmKRSJgOgwwpIkXCOEtYJeSyStzsTm
         EejA==
X-Gm-Message-State: AFq9FYJ4dDxpXGIbGQsuGz2k4FMPX41N2SIvz2wqrdnBfh85I8+uA+LB
	J+Ir919EusD8YZ5EjFBmYGbq2R7aFIXu9iWhPAW7PhITepYxaoml4rYN
X-Gm-Gg: AYBFou2X7nf88KnwVDEze0N3gH99ZutFd6681pV7Ihf+xssN4WPRzK8TmPsRJQn43A9
	ZKt1K9DPnfAoalNsju0jBUuKXeEmcNeAS7mG2+ZFU5GmUoQ2DHKD/5FMJi48GbXLnPLtjOcox7O
	SWe6RWrIHB/flor6yAaF9ZWSjAe3yQpScV1bLQySveuPt04cLvm8ACzLsCEG5pF4w5NtATLXW92
	OsR6gWoJvLL0GfSl9tuA0U3SCg+4tgs8UQf70879cAYgPFPSjXrVnO41SGmCfruhE+SB9bVVxMd
	0F87v9FfkSkYtHsOx0rbfDPMGymFMWPoTK2wLXSqs6djIKGlDj9NU3A1a7FIh9+z42qNq2Rn5N4
	7OuBaYDe/JYoL1J/fAbBS0TT35//QwPu3smYO0KYwLcWD2YXvohDC22FpDpEQF2lwNVDNXdulxm
	/yMxhHbD1EtHC5tFzHyZDZsgRer9dMDgcyDlWaj3fTspBBa1E1Kuc7R17qpiHCijVUwL7ynyC7L
	Ei+symF5W9+SSYAVxYtlP2oIB+HS6EKW1zLnejEGUouLLGXHDMTPLxzn8MqHNrGVzq7zzz3VZwd
	93ClRarCre+JJRoKb9TsU9AFz+4=
X-Received: by 2002:a05:7300:d0b0:b0:369:9eea:cd25 with SMTP id 5a478bee46e88-36a4235f6ddmr15378035eec.7.1793624925608;
        Mon, 02 Nov 2026 05:08:45 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm50979337eec.16.2026.11.02.05.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:08:43 -0800 (PST)
From: Yuan Yao <yaoyuan0329os@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vishnu Sankar <vishnuocv@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Yao <yaoyuan0329os@gmail.com>
Subject: [PATCH 0/1] Input/trackpoint: Add new ELAN trackpoint device variant id 7
Date: Mon,  2 Nov 2026 21:08:35 +0800
Message-ID: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
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

The new ELAN trackpoint variant id 7 is found on thinkpad
X14 Gen1 laptop(Product Name: 21XMA006CD), it's now
incorrectly probed as Generic or Logitech PS/2 mouse but not
trackpoint.

Add ELAN variant id 7 to match the TP_READ_ID command return
value, probe the device as trackpoint correctly.

I tested the sensitivity/middle button lock/rate/resolution
setting, the trackpoint works well in daily usage and when
resume form system sleeping, no issue is found in my last
weeks usage.


BEFORE:
input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input63

AFTER:
psmouse serio1: trackpoint: Elan_variant7 TrackPoint firmware: 0xa1, buttons: 3/3
input: TPPS/2 Elan_variant7 TrackPoint as /devices/platform/i8042/serio1/input/input65

The patch is rebased to 7.4-rc1.

Yuan Yao (1):
  Input: trackpoint - Add new ELAN trackpoint device variant id 7

 drivers/input/mouse/trackpoint.c | 2 ++
 drivers/input/mouse/trackpoint.h | 1 +
 2 files changed, 3 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--
2.56.0
