Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276077;
	b=klb65+5JpAWqHD1ov7yknhZCG3SSZGkWL7fuQTSXJB2vFYXpKs6/rgeQhJpUOhmjv4Va
	 7W08YIDAXOePHCVuJmMuX26Kkrf09RNLeKEY0TxaXlbB7EIzlBb+s0ckdL2qMNWI18htS
	 E5U8859adOhLan1dnsd7fdxDrhX5WVi1p+QqEkjy80pheY6yFXitjZLaGMxplTaOt5tn6
	 HH4rQJItHw3EYI4JhRovG+aW1Plu4VBTcXK3r5uUBOBJR+Nwm/KJd0NJduxG6rrSWsnUZ
	 FfzBDiNn3wWloNYiN0Kpj5B2cShbAOyIaD/5Ho7ZRxLKckh9xv8Phwey+Jbr3GiFRIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276077;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLGnmizI0rQhqsNKClm0H53LdDa4BKTqazSRRlghGiU=;
	b=ZyAnqh9GcwzM3vb+RDCwA1KS9GU+hWOGxrlAXQ7NrtRIoJp+r/7CeWjrcu5SE8JIRUz5
	 Obhf5HvFrNfvYRXcJ7lsisyDgMr0ep9EqOvG2mACw1ZH566tiVeHmMIjGnxLnJOzSfmhn
	 nXZWI7aT5Hj7C1Z1/pxo3uUVnicfQkGuIZyP5MgLGNtKALymibwrGdTRGqz7QkUBnJtjk
	 oMIvT/6n7VGHARjAE3d45Qyu3bl2vFT2VLImsV+9dVGKTtkFkFLxcaBGRmgiXQ4ue6x6G
	 7IWydJyt7cO4zwJKOnBPeUmuHhugppYKF4G/+QA7Di0ou0BoPdz0DDE7kFYYbbMcigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Yuk/2jJa";
	arc=none smtp.remote-ip=91.218.175.222
Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C709606D3CD
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C709606D3CD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Yuk/2jJa
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v/vwC0I5TFCZ5/5X6X4jA8IEXevOgfqLa3VQQEnVcIo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794276074; v=1; x=1794880874;
 b=Yuk/2jJaO5YqSvN6a820LJKZzFYPC9fVykaBrOukHqGSSQBi6KhcPZERsKyzjPaE/ehYpJK1
 ov/GvNPFJKom7YoYAcfA682iL/dmnIfdjOs87XVLAhjaoiDjLCmQ600G07G554pr0I5RF9+0GwL
 xcStzvbRoyTehP0Mg7HsztIE=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4e56b48cd3244b6a;
	Tue, 10 Nov 2026 02:01:14 +0000
X-Mizu-Trace-ID: 4e56b48cd3244b6a
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
Subject: [PATCH v15 18/18] MAINTAINERS: add maintainer for the ASUS HID driver
Date: Tue, 10 Nov 2026 02:00:36 +0000
Message-ID: <20261110020036.112884-19-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110020036.112884-1-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
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
better: give hid-asus.c and its sysfs ABI file a dedicated entry
and list me as its maintainer.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a69da715c58..3dbf491046b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4135,6 +4135,13 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/asus-ec-sensors.c
 
+ASUS HID DRIVER
+M:	Denis Benato <denis.benato@linux.dev>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-hid-asus
+F:	drivers/hid/hid-asus.c
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 M:	Luke D. Jones <luke@ljones.dev>
-- 
2.47.3

