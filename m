Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.208
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972398;
	b=lufzrZlsX/lNrNTYcICk6WVuVbZQmmyX941NZn0+TPsBu2zbcm5IpshkGwsw+tXe5Xv2
	 zSV0ovLhOHgGi4A5rAXys5v8829F6O5iHlTHWqUL+gwsF9dewIB66HjC31JmU38uj+wgq
	 ciQ6cLcfeAVWnPoPTbVTulZX4nwRJQKoJgNE/GAvSwIABFazzGxzh/LphqDRVaCucCtrJ
	 uS9gC6vIKMQFg4eDs/+wgxn1GehZWO2L4OgLPNixIS9b69T6aqWhzyryYCzFjAw/YVAJo
	 oPUwigNVBTeviaCDRDnpiv1J3rWfjDUrQU26LYi69diae5FuAJKoj1H+iJWH2yLWSVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972398;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kOShCq2U4JEXiRarVFOrZYdD4vx45blyVPCctjn43nk=;
	b=DKUiDIRP/3lrVSd/dRXW3dyxFXhijahcusxulP3somXnxW2PvMNreJJE9fD5FQ/5WLuV
	 +0Nq9hySs4dyKSvlG634SvyQwW/owpupyZNgtL2EFdr+FhH+lBWdwtmRQvlYg/JKyHVJL
	 2QFigX1kqxl+kUb4zqrljm4CA2PWhxoldsghT3v09R75xIqhmTwsP5+VRLn3imXhMURPp
	 bvQ4ycH2NYO3EC4xsoWRqsnb/dN5M9d3zIv0CBSL1UYDhgrLRm9o3FIzLMsGbnwsslj70
	 Ku8+gp/9hy1dqOcNfAqSUXbRj0feJLmvSsc7YNd/l4kVsaNZz023f9KyLRNq9+mfBZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VB0ui4T4;
	arc=none smtp.remote-ip=91.218.175.208
Received: from mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383560A5BE9
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 23:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3383560A5BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VB0ui4T4
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nn6GkR6sKN00vvch3hLPYNcxKz8wsGc6g8V7oTwW2ns=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792972396; v=1; x=1793577196;
 b=VB0ui4T4N8GnBrQqNo+cdnUJoDVPGr1N9abN5+a61ZiRK43CsmRGqoPyKN6I9F/xEfyi0+uk
 9hCHWSd1+JbQ1sRHFNek+bhZDgRTSGArN/Rs9PcQzMzHJE7gFramnOwMgRJ63oUXEzfrvmVQwTe
 KoGrzl8rENnRhx2rf/Ezh5NU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a9d5c2c34b647df5;
	Sun, 25 Oct 2026 23:53:16 +0000
X-Mizu-Trace-ID: a9d5c2c34b647df5
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v11 18/18] MAINTAINERS: add maintainer for the ASUS HID driver
Date: Sun, 25 Oct 2026 23:52:31 +0000
Message-ID: <20261025235232.129945-19-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025235232.129945-1-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
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

I already maintain the ASUS drivers in platform/x86, know these
devices well, have contributed in reviewing and bugfixing and have a
lot more work pending so I volunteer on helping making this driver
better: give hid-asus.c a dedicated entry and list me as its maintainer.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a69da715c58..1a3cca5c5f5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4135,6 +4135,12 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/asus-ec-sensors.c
 
+ASUS HID DRIVER
+M:	Denis Benato <denis.benato@linux.dev>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-asus.c
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 M:	Luke D. Jones <luke@ljones.dev>
-- 
2.47.3

