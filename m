Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468571;
	b=dpqfJqbQtf7nVHV5NU3CR/XZa0T/ZytNiCtQ5rctAurPQn/tdAypfFRCXvYDhIWdvKN2
	 PI7iUCfZiJ9RdfLJgSaO2k5TvgU8q0pWNnpeF90cy5qcwRIpdoY4kGzw58N7cWFCsvgPg
	 LohS2rxiV+jNbYvFzsLX3Z8L/+9YbUk6VD5VKYYtRr+IWih1zPYdEzFt4INE1VJ3xoDhM
	 nPI03x1pa9rkPJtrq9bJX1y6B6jtmyqijJxlaJlPWD8Pk3oUYBvF8njj0TRDCl9pD0A1X
	 Xay9z4CeUT5uTaPb8Dyur2SI30t/bAWemsypdU6PHMJ6+iim1koylXagaxYUXoLh4Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468571;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLGnmizI0rQhqsNKClm0H53LdDa4BKTqazSRRlghGiU=;
	b=uncWcJzg9zzBEtQFRghWw0OPLN4rW4AWBIOFNrcMDgPyyGMJe9PBu4lVrN2cdNyFR9I8
	 4hqZg8URv3BFBNqh2F2E+y0JPe4P3gm3jRN09Tz5hAdWecboreYHxz+x1eNqoTuc+WacT
	 uOCXiyHWU+aIN5Xm8Bt0sKa9qurZq13RMN0UZbmIDam0z3huezBQqMDatqKh08X5rp+oL
	 Fka5JJyWvzLvTkvz4HJk167+Rs36j/gU6MBW0RQxkUiXhMwwvN+rqgtOnW8rsFVzvuCGa
	 ROlOPRURmTKOWXNWZ8KfTxxqEGqhlayzjOAJJjHfK+cc1Eq/Hw641AdHgPXgO+RegvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n86VbwA3;
	arc=none smtp.remote-ip=95.215.58.118
Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810D606A320
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8810D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n86VbwA3
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v/vwC0I5TFCZ5/5X6X4jA8IEXevOgfqLa3VQQEnVcIo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793468568; v=1; x=1794073368;
 b=n86VbwA3d6t459rBFa2Czer9dgoWgU7asDo6OOFo+ty03cQSk2hLMKhxzzy9wpnmyNf/RKSA
 NZtcrSKl/Mz10IspkudWgCoPOlcEdLYOxFKHzHVaNWqRuktRFSwDMauCdZdYjBZI1qGX98MT9Il
 ied/Lfcra4aEexHG6BSWyinM=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c4da3dbea52248b5;
	Sat, 31 Oct 2026 17:42:48 +0000
X-Mizu-Trace-ID: c4da3dbea52248b5
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
Subject: [PATCH v12 17/17] MAINTAINERS: add maintainer for the ASUS HID driver
Date: Sat, 31 Oct 2026 17:41:30 +0000
Message-ID: <20261031174130.208240-18-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031174130.208240-1-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
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

