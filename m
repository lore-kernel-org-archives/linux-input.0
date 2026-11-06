Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975105;
	b=CfSFqn/hIX0weU6lqV2dA30dvoUSwaiHkxl767uKbI5FlEixQg1a4gHsIMOrK6MdgHP6
	 6mMcniesoav6ltsl5dVRsiNzdkgCWOXpNaWxbklJBFHwZjH+zrKJjoTzFgjdUQ2r1BLmo
	 xhIthz9L0y0ahvNypgyrNpVkMhG72Ck1ftZZB2JEcXklxvNv6lPfGGqMN4iXo30VuinKa
	 VGZDQhyFdRHOZ+MV9Mkryi1ljxLIyIFJELRzV+iEN2RPVwaU8Yl0+43JOArohcWWlKEU+
	 TxWSEOz9z1MuNce8V604DGINRjmTslyqzsIpLWaavvEepQfQDgYqiXHz1655izGT4yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975105;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLGnmizI0rQhqsNKClm0H53LdDa4BKTqazSRRlghGiU=;
	b=I9nCHzITdFDJRW9jigkliz0VYVx8SuFFHCyOAV5z+SEt33EQ3cJ7PYdNq9RlRzp5BgVD
	 gupdKewHZNUY+lQl+6hPKaUgua+fR13xM66TRBFn4d/nqqvV+UxKfWHNjNPH4t3tvA08n
	 M0t13SLS9IBaGa0dlAAqM5Z5VyOz9TH8sRPL8aAlquS2Qz+XLH8creF32CJ/BYLzL2BaC
	 qNS0CVEYI3SI7di8fnx9aIgbxvBqcAHCJ0rUvKTXQJhdu+pUjt4RgSSR3JDThXdMLpP7k
	 0645IBlDmJIoFNZ7/QHhUaP+TFHXKeEFbhVfA2OLuQX/fVhuhTItBQRvxlvv0HQnIsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rTzlJtCv;
	arc=none smtp.remote-ip=95.215.58.62
Received: from mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A31606D802
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A31606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rTzlJtCv
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v/vwC0I5TFCZ5/5X6X4jA8IEXevOgfqLa3VQQEnVcIo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793975102; v=1; x=1794579902;
 b=rTzlJtCv+qe+VLfIiaOj5R4dHTiVOE7htP+J0YBJp3f0OHDGdNJW1qbdNL3tKF6A7HWJsFZt
 5+vF5pz35ReHdd1vuyYu3VfhctlJJjvAwOVRQUq23aqgNHJbk0pcR5DEf+mI12SgcVy1mmV18M3
 D+4NQAl4GCjiQ9TxIbit0vRA=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d76064137ab0c518;
	Fri, 06 Nov 2026 14:25:02 +0000
X-Mizu-Trace-ID: d76064137ab0c518
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v14 18/18] MAINTAINERS: add maintainer for the ASUS HID driver
Date: Fri,  6 Nov 2026 14:23:34 +0000
Message-ID: <20261106142334.1881-19-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106142334.1881-1-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
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

