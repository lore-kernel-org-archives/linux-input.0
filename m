Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645091;
	b=X2J47+bGTeonXy2ZKqta6OkxAdelahPydN4IYM9Zdqc1uwH6j2CZJcJhNuhPdqjk/mrP
	 P+EHba18efWKTv261G+FpoQk1/z8cXAgF2aI6EdaWkGoA946ROHd1kucAZ4Ac3Ntn3k3c
	 2wBsXVa3DxOWWEizg1MZrVGV4vXnB7jtZunnfPK+RIJirXPihNAcLbmT6bF2xT3wLSK31
	 0WIizzdjrDyhnHXlIB77vr7sLoYxU8ZHn0PZ61WM4UO3368i4r4A7mxa/tivaCRCQ23yN
	 FsS74GKvZkoSDAYG3Dmkb0HJ8iBbrRa/2d821Nc41sUVvOZ1kzhTDWLfPI7wXZF0/6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AkD/EULkjYCTOVN6ONVEcYCDVTXRZ/wAEijqIncHQyo=;
	b=n1GZJJAps6uBM3m5mnCL82HvY+z9AW1hHuMkcLKl0r6Gn7VoEyl8Ui3pSwvMyBYyMhQf
	 h6CjiUgFpkRN3k7aiqn12Me2OpyqjguXbeOnAiR/xwfOXK0uFBJq8mI8AaZQv+l7fsLAz
	 TuxXLtN8nz1pj2bUwu8h2FKmlHKtxEuewqmMQy93QhhL1CZfHfeudVeI8rF/OYYhK+ERx
	 Ic8Zb16pjVDlJS70xDrYTmR088uxh5ycufs3WTjjfs5R4A6aHMYUu9d7tEsPMDmrNrBD6
	 USwTQUZMOa7NI6WhjsIowknf2uHsD0nI4ehMUvwHmQ8RRw9f0Kt3drzb9Z7G9Xyll5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EtI0OK/n";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539EF606A691
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 22:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 539EF606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EtI0OK/n
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38692f62b22so7637003eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795645090; x=1796249890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkD/EULkjYCTOVN6ONVEcYCDVTXRZ/wAEijqIncHQyo=;
        b=EtI0OK/n6MC4BVKd3pAxgf03MybUyrEr/pFVhAvp+iXntfUDeaRqHxKpVaXFVHcGwC
         iLd4TDiqO9K2xRY0HvB79J3Ioam3j2ErwGhwdFBb2v2tdlUYK0Lsp7ONeo6Yf3A+GWqJ
         yUIACEFFlbyETHReWI2yAt3TjbRHcFEKmOzAFsuiTEFWvTbeZGyBYRwxoLTCVvDyr9Ig
         Fv7l1CLYjd03F8L3YdmLoBuXrxqbPP+hN4JnLCvOBLjxwHw2AOq5XdDsLxxA8dA2k+EM
         RNzjz6pVDloaKsrMUUxfbNRAYTw9LYv7STFicpVJsI2EBu37+Qghxv4fAkP3gd0hXMY6
         zNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645090; x=1796249890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AkD/EULkjYCTOVN6ONVEcYCDVTXRZ/wAEijqIncHQyo=;
        b=hdQI+yz6SCufPSmVxnmZKDByRzhT7/GIB69QRjaXTXdCqA4FWJ4v5NZY3CG+ToIdNZ
         QKpIQ+BXzw+mPThiP60Ygpyi8nnvz1jTU4608N3uypZvflR9HCvDceXUC1H3G8a+Da4/
         Ic/ken/iE52rrEjn2xWqKggpz7CTVx8W6vn3cb5c/nyBpDI76rrldDtVdAPUk2YhFFy2
         eH3kdnve8JoyCwGtspje4QfnpUVuodo4zbyH2nbTNakY42Jhd22FvBRSGQsEH3BECarU
         XewnscUeJtoVOnHUt0PtPD5gnKuy8iXH9tf5QTYu5LUxhSrDCuaaCMKN/SPKDJ853ThP
         pmdw==
X-Forwarded-Encrypted: i=1; AL+hErHfzlWRCjboKS/oT9i9VNck90aGS03wUI5KfMANh0ALN92w6Vqy3jRdd+aKDDlJv/LCMYi4HhRefAJj6A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/px6F1kMyfgmhPaQhPlr1X8wouavNpc2Q9XumZKpx5I0nETENy
	fR04f66DClWv5vxlh3sCHdl5+M2tAlZUkXz+VdAOa2XF564vFIU7Hg8F
X-Gm-Gg: AZFdTZescKUMKtmihFXq2l6tTj3m+kPY/WMShz10XmvQZooQRt3gIIKNiIISbiMMfEr
	BJ2XixioAG+FapqQTaYWNqLY68Bgg302phW8ouxfCcAKdQVfAlySdiXAYjxCjNTioKve4wa5sDt
	c700svrvsPduA24smFJh7SOlNkc8S/6BaYBZbpIiJuFUfyhKJWm2glzWxHSpD+jQ6hKTIjFaAuK
	5jWBeBaPMrORyMs2FPAUkYCStlfaA2uxriiJUHEDlMs2nKoyIf/Gir3fNCsKRRItq6zkT0SnsRL
	csn06AdS62e8zrXSEFtpSNfkNUyEeTqDJgBXP6LIpzy4E/g9A79zseydbfDhNU/r/6L78r5igvp
	+AuIBY3hYdBO04308ZlA0WcsP3hhNVdCYh23qF927JQv/RpDIA5gL6EYjTl6kuBiFPUFvgCngLv
	TLcvtUEgSbCdGKbI0nNRr8vgdXC5L7EyrPUL32kAArP+835ilccqngo+RfxZ2OpOcup6DWfy99W
	X9kQ+CUWjbaTncaDkSyBHeTq/WZkBDsdBLlBQhcRKvZF6iVtxZe7WuaA9dhAXg3AZniat6iS5eZ
	x2vBv3vTKSj/coaW+dJT
X-Received: by 2002:a05:7301:6407:b0:386:2300:db04 with SMTP id 5a478bee46e88-38623101ee2mr19243959eec.22.1795645090140;
        Wed, 25 Nov 2026 14:18:10 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm69581357eec.5.2026.11.25.14.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:18:09 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 3/3] docs: python: abi_parser: Detect a symbol repeated on one file
Date: Wed, 25 Nov 2026 22:17:58 +0000
Message-ID: <20261125221758.2535044-4-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125221758.2535044-1-takano32@gmail.com>
References: <20261125221758.2535044-1-takano32@gmail.com>
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

check_issues() warns when a symbol shows up on more than one file, but
it never looks at a symbol that two entries on the same file claim:
"if len(files) == 1: continue" skips that case.

The parser stores every entry under a key of its own, so a repeated
symbol on one file is visible as two entries with the same file.
Compare at that level and warn, and keep the cross-file case
informational, because two drivers may expose an attribute with the
same name for different devices, as sysfs-driver-hid-lenovo-go and
sysfs-driver-hid-lenovo-go-s do.

Verification: get_abi.py --dir Documentation/ABI validate used to
print four warnings for the cross-file case and nothing for the
repeated one.  It now prints four informational messages for the
former and two warnings for the latter, at sysfs-driver-mlxreg-io
lines 348 and 744 and at sysfs-driver-hid-lenovo-go lines 389 and
566.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
Changes in v2:
- The documents are fixed before the checker is added, so the tree
  does not gain warnings in the middle of the series.
- The internal MCU protocol_version entry points at the top-level
  attribute; v1 gave it the prefix of the removable controller's
  group, which made it name the same file as that entry.
- The checker keeps its warning for an entry without a file, counts
  lines rather than occurrences, and drops an unused loop key.

 tools/lib/python/abi/abi_parser.py | 48 ++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/tools/lib/python/abi/abi_parser.py b/tools/lib/python/abi/abi_parser.py
index d7bb20ef3acc..8b51659fb6ca 100644
--- a/tools/lib/python/abi/abi_parser.py
+++ b/tools/lib/python/abi/abi_parser.py
@@ -554,28 +554,44 @@ class AbiParser:
     def check_issues(self):
         """Warn about duplicated ABI entries."""
 
-        for what, v in self.what_symbols.items():
-            files = v.get("file")
-            if not files:
+        # Two entries on the same file that claim the same symbol are a
+        # copy-and-paste mistake.  The parser gives every entry a key of its
+        # own, so such a pair shows up as two entries here.
+        per_file = {}
+        for v in self.data.values():
+            if v.get("type") == "File":
+                continue
+
+            file_ref = v.get("file")
+            if not file_ref:
                 # Should never happen if the parser works properly
-                self.log.warning("%s doesn't have a file associated", what)
+                self.log.warning("%s doesn't have a file associated",
+                                 v.get("what"))
                 continue
 
-            if len(files) == 1:
+            fname = file_ref[0][0]
+            for what in v.get("what", []):
+                per_file.setdefault((fname, what), set()).add(v.get("line_no"))
+
+        for (fname, what), lines in sorted(per_file.items()):
+            if len(lines) < 2:
                 continue
 
-            f = []
-            for fname, lines in sorted(files.items()):
-                if not lines:
-                    f.append(f"{fname}")
-                elif len(lines) == 1:
-                    f.append(f"{fname}:{lines[0]}")
-                else:
-                    m = fname + "lines "
-                    m += ", ".join(str(x) for x in lines)
-                    f.append(m)
+            self.log.warning("%s is defined %d times at %s: lines %s",
+                             what, len(lines), fname,
+                             ", ".join(str(x) for x in sorted(lines)))
+
+        # The same symbol on more than one file is normal: two drivers may
+        # expose an attribute with the same name for different devices, as
+        # sysfs-driver-hid-lenovo-go and sysfs-driver-hid-lenovo-go-s do.
+        # Report it, but do not call it a problem.
+        for what, v in self.what_symbols.items():
+            files = v.get("file")
+            if not files or len(files) < 2:
+                continue
 
-            self.log.warning("%s is defined %d times: %s", what, len(f), "; ".join(f))
+            self.log.info("%s is documented on %d files: %s", what,
+                          len(files), "; ".join(sorted(files)))
 
     def search_symbols(self, expr):
         """ Searches for ABI symbols."""
-- 
2.53.0

