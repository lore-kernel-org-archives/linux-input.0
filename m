Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671668;
	b=Vt1oNz33cLxATFl9//xx5PBTjfeg8UxwvLFZ1/oXHBH2mguUOkqMZMDQGcHdNTNEhEYT
	 aaRMuWlrN10576ChviubgSpAEFmioBAzrS32yMu+lohn98XKQ2kCdGbM0QOMJkDzfsdRZ
	 PobOVZh5QkZGX+2KXZEyigqSmZZeCzwrcZyzdGO73RhXwtr/Caq68KTHZ62OzT+sW9XQF
	 VX4o50Ma6kSgGWh8Xb4RJwBevj5TsfVhQnsrh9iSk/lVi79AyFdy+BKVra3m2aBE6Wph6
	 jdh/hbN/geR0PM9bPofeys3Y3vopDV4WP4vABasvwCOHwdmAgnlbbCjT+EBtQiD3Fvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671668;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bwHOQTJQeV7B3NmJTLbFBlniH4YO+jWdF1Fi2dFZaZ8=;
	b=vKKmjX574mgjWTZ5rou6mz9j9cMIfvXcV5o7c2CVVxqcEp4+IYnVw/X3jQuIg1Ct1O2p
	 NYpu3PtWv0KY5j5nob6bS3NhhrBU9tlttvTqL9rAfy9/q8MuEspN5CnzeUIXGxZ+hOkCQ
	 5uwCCYpqHt1qy4l8ka5U8LZUOFvu6OOHceG5qgYnc6RZF+luPbGfGo1KDartQuQA4tPhP
	 h4neGePSTmX8SdYsFtkx255ymsmbosLbSfmnm84e3gbLO18swcWNtYgrJRvIUtd9W2/fn
	 9TA22LB1uqcHJ2FTwdUwPHXMzOtGgBNWjSyynbwCt1rKQy3C8oDC95f2p1JvusmRvlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o3kwZcw7;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC4606A336;
	Tue,  3 Nov 2026 02:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CEC4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o3kwZcw7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bwHOQTJQeV7B3NmJTLbFBlniH4YO+jWdF1Fi2dFZaZ8=; b=o3kwZcw7uwx8xryMF8q5LYBYO1
	vzW9vX5RjiBpS7fnDiIZd0+XcxSqsLWLzmAjRyIdItO5cXx4yKsbdLFuk2d+km1wyL5BFoaHEz8lD
	GIYltlJt5TTbm+06lfkLdZpCR50Z3rRoGcgHI6YfFieII9eYoHoEp4ufU+Q2D0qucbu84h2sOwGAP
	lRIMKhAXH0TvXS7Sj+GZZJJd9D4WLPzmhaKzVvWlnP9kTvYHR3T3BZba/mhjDJjg8VHH3dsTnjiDh
	6kHLpjjMXrxl1LlRkPgRSAaYW8IEwZUDwp1G3nmj8qWNWd0PJjgz0v2ooXB0fmeHRofxV6E6x4XRT
	9nix7eZw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO3wB-00000000qyY-2q9E;
	Tue, 03 Nov 2026 02:07:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] HID: correct typos in hid-lenovo-go-s ABI doc.
Date: Mon,  2 Nov 2026 18:07:47 -0800
Message-ID: <20261103020747.2510497-1-rdunlap@infradead.org>
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

Fix spellos/typos as reported by codespell:

sysfs-driver-hid-lenovo-go-s:185: intertial ==> inertial
sysfs-driver-hid-lenovo-go-s:185: measurment ==> measurement

Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v2: add Rev-by: from Derek;
    rebase & resend;
    add linux-doc & Jon;

Cc: Derek J. Clark <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jkosina@suse.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260911.orig/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
+++ linux-next-20260911/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
@@ -182,7 +182,7 @@ Description:	This displays the available
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/imu/manufacturer
 Date:		April 2026
 Contact:	linux-input@vger.kernel.org
-Description:	This displays the manufacturer of the intertial measurment unit.
+Description:	This displays the manufacturer of the inertial measurement unit.
 
 		Values are Bosch or ST.
 
