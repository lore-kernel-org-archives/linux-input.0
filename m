Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6283E49EF;
	Thu, 27 Aug 2026 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830207; cv=none; b=PbVbcxTGg9sZLT5SF+F3v5BlY+MykY9s9J14fgglANj2Pq5X0WS06KCNRgtD3H0GLle4LBGGVflqDUhQ25IYBkAN4/C4QK7oUfFu/1ZSq85u/D5SjjLi88NiJFiM18k1WwXCZQMsGjo3B4b4sOBtmtiu1nxgBJvlL6vkvtYq5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830207; c=relaxed/simple;
	bh=Ltd04Tp11jaczYj9Z3bptj40Ufge+Ujb83+F/zReS7Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Wicyl78+uiroKTBg5IYyDViUOKDOXKJYwvxkijPHvAZKDj5hHj3ZmPqppallbOXTnx7yB3GKslaYj7R1C6FjE2cScmZFBEWC85FRTiUyLeQWH6vt8l3iFjweUgTYj67NyykZ7crfGam20Q28XlwzwTuskNcw37Erfg7JNT2pNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ITtooFrw; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ITtooFrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NdlWtn7RhMPXbLXNfq/H5zVLJOCgx5THX1L6YT/apfY=;
  b=ITtooFrwXXxJb5T6i8zdiJDwq/9LT8UFIV+SiIK8kW2/KZXCA/3fth5O
   RiNQZMIR2X5WaPVMapL9H5WW2+KFc8BBvTDRS51nP82tqKod1kDMu0HfL
   jDrVItPokYiYp/kpet4Nw+ZweniaO/vp5O9y5k3jzPtDGzvuw6SOlxYg4
   g=;
X-CSE-ConnectionGUID: c44e6LymSu2elag5f+2Slg==
X-CSE-MsgGUID: 1ilguNujREWSBp3neebU0w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,246,1779141600"; 
   d="scan'208";a="291799574"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 13:29:54 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org,
	cocci@inria.fr,
	corbet@lwn.net,
	hadess@hadess.net,
	jikos@kernel.org,
	lains@riseup.net,
	linux-doc@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolas.palix@imag.fr,
	skhan@linuxfoundation.org
Subject: [PATCH] HID: fix semantic patch and improve its performance
Date: Thu, 27 Aug 2026 13:29:49 +0200
Message-Id: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "expression" with "identifier" in the declaration of hdev.
This is necessary because hdev is used as the name of a function
parameter.

Move the two uses of @p2 to the relevant function names.

Convert <... ...>, meaning that the contained pattern is optional,
to use ..., when any, and exists.  This requires that the function
contain calls to hid_hw_start, etc, which reduces the set of files
that are considered for matching against this pattern.

Reported-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 scripts/coccinelle/hid/ff_race.cocci |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
index 479f5d1e3..e861de00c 100644
--- a/scripts/coccinelle/hid/ff_race.cocci
+++ b/scripts/coccinelle/hid/ff_race.cocci
@@ -7,18 +7,19 @@
 
 virtual report
 
-@r@
+@r exists@
 identifier probe_fn;
-expression hdev, flags;
+identifier hdev;
+expression flags;
 position p1, p2;
 @@
 
 probe_fn(struct hid_device *hdev, ...) {
-  <...
+  ... when any
   hid_hw_start@p1(hdev, flags)
   ...
-  \(input_ff_create\|input_ff_create_memless\)@p2(...)
-  ...>
+  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
+  ... when any
 }
 
 @script:python depends on report@

