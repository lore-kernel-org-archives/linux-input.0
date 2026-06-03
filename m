Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662493B1029;
	Wed,  3 Jun 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483443; cv=none; b=tEAbFh7aP2vxejbb+NJTelWoH70GLGrgQlBlIkN5kEGQDoKNsxbJVAqEHm9pKr+IOD9scUFyzgULYF+d1uOxZLEgiULDyT0szs6fQuN/5j4NabhoOTU1WfnnzVKUDr3tQ5GFl4osmxvoCwxZ3Px3X8Ya5gdZd3NowTUuPXvvB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483443; c=relaxed/simple;
	bh=BhIKTQ4OQ9RChf0q3imRx5L1bGzhInW1zKj/r7sEOZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5bm120ZAKUllpHpzlhY38xb0RbNkruIHEozoOVLXNVyN8P/gxtyxkqeoE+OUhV3u73Oa16bMsj+B9ypN1ktBmYT4OubQo65Za1Ov/4ccCEwFNxI8qMrvGQlEtNCOf2zM+aVrHy7CNJH/H5BBCYKG1n5oYOvwv2Bx4HFPGFEycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2blfiW/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2blfiW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780483442; x=1812019442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BhIKTQ4OQ9RChf0q3imRx5L1bGzhInW1zKj/r7sEOZo=;
  b=e2blfiW/W6Y2WCf96OViqobqeWib0ZzDojS/X0TsWXJZeABxX42rBQV0
   LB5jIXE0Lakni9BbxXnfBCjvnwRp/VtkB2mNtgJS3tT8wJDC28016IuXd
   6tZXfOqswJiSpqzbl0hGAmoLe6hLvj2XzM/fADnVyQCWeEk4kTVx2bbls
   545eXf1UPzxjTOQzuSYPARBdkcieolsT1vDk3oA6CtYJeF2bGMwjR4iHB
   Xwqfh+5V5sB57mp1jogtlZALeWvcyMA+KHJUScWpqsd1CBwcYrZbW8qcW
   qBskPwclz81ntaNQlwfiMEg8F0Kx+axftYdh/aPE3raBCRcW2YnzagRVz
   w==;
X-CSE-ConnectionGUID: rMEOoUbhSQKtuekea58Rww==
X-CSE-MsgGUID: 9L5r8RWBT1azkAY/8vrgig==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80429109"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="80429109"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:44:00 -0700
X-CSE-ConnectionGUID: dQM4dhm3T3etxy/+iUafXw==
X-CSE-MsgGUID: Kh+79lN5TR2EySDRK3tttA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="241695745"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jun 2026 03:43:57 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2F51E98; Wed, 03 Jun 2026 12:43:56 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	"Daniel J. Ogorchock" <djogorchock@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Tamir Duberstein <tamird@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/2] vsprintf: Add upper case flavour to %p[mM]
Date: Wed,  3 Jun 2026 12:34:02 +0200
Message-ID: <20260603104351.152085-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603104351.152085-1-andriy.shevchenko@linux.intel.com>
References: <20260603104351.152085-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the (ABI aware) code needs an upper case when printing MAC
addresses. Introduce an extension for that into the existing %p[mM].

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst |  3 +++
 lib/tests/printf_kunit.c                  |  2 ++
 lib/vsprintf.c                            | 22 ++++++++++++++++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c0b1b6089307..57e887ff24bc 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -322,6 +322,7 @@ MAC/FDDI addresses
 	%pMF	00-01-02-03-04-05
 	%pm	000102030405
 	%pmR	050403020100
+	%p[mM][FR][U]
 
 For printing 6-byte MAC/FDDI addresses in hex notation. The ``M`` and ``m``
 specifiers result in a printed address with (M) or without (m) byte
@@ -335,6 +336,8 @@ For Bluetooth addresses the ``R`` specifier shall be used after the ``M``
 specifier to use reversed byte order suitable for visual interpretation
 of Bluetooth addresses which are in the little endian order.
 
+When ``U`` is passed, the result is printed in the upper case.
+
 Passed by reference.
 
 IPv4 addresses
diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
index 58e639b01e83..eccf041ebd56 100644
--- a/lib/tests/printf_kunit.c
+++ b/lib/tests/printf_kunit.c
@@ -435,8 +435,10 @@ mac(struct kunit *kunittest)
 
 	test("2d:48:d6:fc:7a:05", "%pM", addr);
 	test("05:7a:fc:d6:48:2d", "%pMR", addr);
+	test("05:7A:FC:D6:48:2D", "%pMRU", addr);
 	test("2d-48-d6-fc-7a-05", "%pMF", addr);
 	test("2d48d6fc7a05", "%pm", addr);
+	test("2D48D6FC7A05", "%pmU", addr);
 	test("057afcd6482d", "%pmR", addr);
 }
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 1389b50266bf..c9b6ec0f0de6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1303,31 +1303,39 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
 	char *p = mac_addr;
 	int i;
-	char separator;
+	char separator = ':';
 	bool reversed = false;
+	bool uc = false;
 
 	if (check_pointer(&buf, end, addr, spec))
 		return buf;
 
 	switch (fmt[1]) {
 	case 'F':
+		uc = fmt[2] == 'U';
 		separator = '-';
 		break;
 
 	case 'R':
+		uc = fmt[2] == 'U';
 		reversed = true;
-		fallthrough;
+		break;
+
+	case 'U':
+		uc = true;
+		break;
 
 	default:
-		separator = ':';
 		break;
 	}
 
 	for (i = 0; i < 6; i++) {
-		if (reversed)
-			p = hex_byte_pack(p, addr[5 - i]);
+		u8 byte = reversed ? addr[5 - i] : addr[i];
+
+		if (uc)
+			p = hex_byte_pack_upper(p, byte);
 		else
-			p = hex_byte_pack(p, addr[i]);
+			p = hex_byte_pack(p, byte);
 
 		if (fmt[0] == 'M' && i != 5)
 			*p++ = separator;
@@ -2410,6 +2418,7 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  * - 'MF' For a 6-byte MAC FDDI address, it prints the address
  *       with a dash-separated hex notation
  * - '[mM]R' For a 6-byte MAC address, Reverse order (Bluetooth)
+ * - '[mM][FR][U]' One of the above in the upper case
  * - 'I' [46] for IPv4/IPv6 addresses printed in the usual way
  *       IPv4 uses dot-separated decimal without leading 0's (1.2.3.4)
  *       IPv6 uses colon separated network-order 16 bit hex with leading 0's
@@ -2544,6 +2553,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
 					/* [mM]R (Reverse order; Bluetooth) */
+					/* [mM][FR][U] (One of the above in the upper case) */
 		return mac_address_string(buf, end, ptr, spec, fmt);
 	case 'I':			/* Formatted IP supported
 					 * 4:	1.2.3.4
-- 
2.50.1

