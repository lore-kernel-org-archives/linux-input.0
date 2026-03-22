Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB71684A4
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 03:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774149381; cv=none; b=Uv3FFlyKrmZ5ayaPk1nFuWphvWeroT7+T8Hwgg20SmhBoxD1WdVRQ6oWhJHDJ+5upg/mzpQAQSqmUaJxIKc5bOR/eG8gxYwa2XE5rRFFZKuPjPZADDxMthp5Bdae3eAAfPKspdvNFQfxbg4L4zMrhtO7Ucl3x5a5xU8dhWO0zx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774149381; c=relaxed/simple;
	bh=H6PgkDANZTVCiCYueGZ4VDqAHVuGoTAHrFT/u1/OncQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuiQpZRoXqnWFKd2LP5ruO4NGK2bDd2G655hpmf3wWnbiBc16SWJRPJDYySRuio374x4X+zxBNgZiEGOKxjbt7yaQH0RSAAXr5fE4TCuH94cKNezNvedr+P6VbQIHF6EhUcUg3ot5SMulKH0NpNr9JyqbCEHEG+4qu+xEO4PwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4rrDt4d; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4rrDt4d"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c1092cc08cso4774717eec.1
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 20:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774149378; x=1774754178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9nXD/mD+l1Mz7junnW36Q+i6fhLMe8N062hMZ4dDb8=;
        b=N4rrDt4dOSXWbvg0XySheKsLaqK+2klkVVZTOE2aZZiLrRjo1MsvX91cUsCYDsH8YO
         c8PirdRzdNkxVxg03xxGymC2ugOMhdh8GG3lZtTG7cKwlm802RWChexpH0woPjaWNAV4
         CIdPRIwXuHyH6maBoh+OMFEPAMuRwPhQbn0AeAjiujlffUHqccMMLyhJaYbFgtsVi2q2
         q6sfHdgb2H2pUGt3D8kbh8dCOKVb5eCWLEIhsvbSv7+NAFgluULMhkrnX24jgGLmt+ab
         B136k3evBr2FQcNAg+ZtReT6Rk3ur5eAKAYKt3moSzEuc7ktypvDxoP248OMzBTZK/bw
         aegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774149378; x=1774754178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9nXD/mD+l1Mz7junnW36Q+i6fhLMe8N062hMZ4dDb8=;
        b=VQNr/w1QNXehii53d/DpYqqM+KBZcGQVMbTOEvwLIwRBNTPoLUwH6c4/D729fD/hHW
         ED1otEYggrfDLL2Bul1rlYQTfzUrmlyw5aUw5PT/u8KoSHwctJSVLEJOaVLLIwftcDMZ
         T4KWVqp32tR++RQlXguQnFWtVLmyY/jE9/BFQGlfSEdKG2FbYHpnO7sGijifZ4d0DfzS
         FzwOTQVNbYn6F4OFYDafGe2KgaMJ/3GLKpy69bLQIt0uFOGSuYzpDCvF+9rgp1YMdsFy
         XLhGhcCK/GI/4hXwgnTZ1LR9loWv5cxyWulPRvMK2056pr0RlfJ9i5K+jhKC8/poBPVg
         YSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+8TmuxpBYnnbjeAZ4NbV4zYzY3BLVCT7Q/rEz7BmxejF+6U5TnXHtsyp1lPqja2AOe0pyax0wNAFrBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UMh1wezSNVRzQlGq3RPns03VR4Ak9wt0JqBPHjV49WYNwZsU
	Vay1H4z6kn2QYFrhuN640hzdD68ka0MgJtasma91G/+BHsuU5zxV0cv6FLzuKA==
X-Gm-Gg: ATEYQzw7eBSghj/UMpjE0qW2L2Eb5gEuyv2Z+38BjnAzKG+CbbU6FyBQtoobQ4KIS0c
	aGRggC8SBfLnYyH+w09lixXLSQMTgjMqjRB3bsurnF5UkAe1XqJr5KuzWvdlPoWq4NI4KLXBy/f
	VkpqnXNnHQLp2KXHAS0v667+H1Jd25Ifr+nO3Rnh6WEFIC6lyidYT6y+hYANB6qLsy4UYHca7eq
	cVefHKUyPOKGpu+sEsZHuuyRZv58emy4bCL891q/h6/zZX4A4pwx06enhQQMWcVZyW7mqAnG17f
	IhevxpV5RFoWtGGXhxiVUHGe7LjptnN/P/bUHavl6608BU8JoMt1K3y8JUm+PI9O7UiAZ18aCtH
	+XY20nIJR/8BYDVaLa9AtGXMgQRGhOrYmLewZqlf8dmdAtQ9fCj410GQrC34fflrIvpB7eimQBC
	tjrihAwRmm5IRzKzhV0ZdaFEFF1R8aRXBz8+gQC1r8BA/4JeqkOyI2pcYh/20uA3itbkNAv4HLi
	C54
X-Received: by 2002:a05:7300:2382:b0:2c0:d04c:a6a7 with SMTP id 5a478bee46e88-2c1097c0a34mr3899512eec.28.1774149378073;
        Sat, 21 Mar 2026 20:16:18 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31bef1sm11220460eec.26.2026.03.21.20.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 20:16:17 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add OneXPlayer Configuration HID Driver
Date: Sun, 22 Mar 2026 03:16:11 +0000
Message-ID: <20260322031615.1524307-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds an HID driver for OneXPlayer HID configuration devices. There are
currently 2 generations of OneXPlayer HID protocol. The first generation
(OneXPlayer F1 series) only provides an RGB control interface over HID.
The Second generation (X1 mini series, G1 series, AOKZOE A1X) also
includes a hardware level button mapping interface, as well as a
"takeover" mode that was added by the ODM for debugging the button map.
This takeover mode can be useful for exposing the M1 and M2 accessory
buttons as unique inputs with some userspace tools that can consume it.

Signed-off-by: Derel J. Clark <derekjohn.clark@gmail.com>

Derek J. Clark (4):
  HID: hid-oxp: Add OneXPlayer configuration driver
  HID: hid-oxp: Add Second Generation RGB Control
  HID: hid-oxp: Add Second Generation Takeover Mode
  HID: hid-oxp: Add Button Mapping Interface

 MAINTAINERS           |    6 +
 drivers/hid/Kconfig   |   12 +
 drivers/hid/Makefile  |    1 +
 drivers/hid/hid-ids.h |    6 +
 drivers/hid/hid-oxp.c | 1340 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1365 insertions(+)
 create mode 100644 drivers/hid/hid-oxp.c

-- 
2.53.0

