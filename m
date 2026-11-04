Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756505;
	b=O/hkaJwmok+QZxFY0S21UXfM0et4WqcMRrb44Vb8O2PeDY/Zcs/h9xqmegVvWMSUQdca
	 aDNI7jxhXZ43olCIP9QHb9Uqbl2q/Qg1ifWjO6Yph1oYWnuNlFxrWeVFQmSFbdfgKASHp
	 Ymxnflao6aTgsThRxW5UQFz+QFJX4psnkNZji6uuoz0CQ97eRNo+uQ85Z4i6WoXBWNHx1
	 jb7ylX6zm8wMkKPQ/k40hfl6p+6+W2nwaKbL/A3OOxDa76EHcbXLlMSABoMkajhtJz8a0
	 zXQ1QDynMXL/ekkpNbyM99MW8ZekhmqEwViwjqhCapzgvjqMsx1kwtva6duWLFy27Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756505;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLGnmizI0rQhqsNKClm0H53LdDa4BKTqazSRRlghGiU=;
	b=sZ9bj0ZTIOjG+FkVOMzKoVVZm5wJhTP+D4SxiRcktYgK0oMRU7yiDN22jQM9/XoIh0/w
	 RHHnVgmbO0f7hPR0keCImgcAg21Lkgkq7Aoe586D0vBWkSYn/v/yDI86ufWJbMjKZ+Jnz
	 1RPRY91w+u5EkEpq+kgXzeN0HHktn6PVISmgZeAKoVgwYT0fM8RJC5feeEFlYMHPLuBRv
	 7zAY1gwjxVN4PfkNDgDiyTPegZmcnth+2UNZPi2BxRbQBwold4mQ9UwIGetAiBP57/jdA
	 Ns3WDe5FET6xHsNeGlqj971tmBM5H+1gpvwFWqriy5Ga9ynwKVJjmh1JalZxQS5v6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WodpJemv;
	arc=none smtp.remote-ip=91.218.175.42
Received: from mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E8606D802
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E95E8606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WodpJemv
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v/vwC0I5TFCZ5/5X6X4jA8IEXevOgfqLa3VQQEnVcIo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793756503; v=1; x=1794361303;
 b=WodpJemv48puEWSfIGeXRISpYiPsoddmw7OjGeYMoKu9tDHUg4/CoRjV7Yui2L+6vN9OqMnJ
 k735EfspU3hxTMOmmay0RQks/d5HIXvX+0nnxgsxwKXc1koXV4HApiIfonmlyEof4noPTCjpQKu
 cqv5OkVLANy6tj5OjBWDUAHw=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4feac6e259902a2b;
	Wed, 04 Nov 2026 01:41:43 +0000
X-Mizu-Trace-ID: 4feac6e259902a2b
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
Subject: [PATCH v13 18/18] MAINTAINERS: add maintainer for the ASUS HID driver
Date: Wed,  4 Nov 2026 01:39:35 +0000
Message-ID: <20261104013935.512713-19-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104013935.512713-1-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
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

