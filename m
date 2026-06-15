Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCC428494
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542279; cv=none; b=sEk1iw0Hrd5q7xp5oRmCSuDrowUeMDKcE7CBD1Sn1GUUDlOXfLSs6k1DkEoncRlMIYI3ufCwJ2POHOZ9MBPtZ89lB3gUBOTgC6HIRZ49AN/2q1bEOuV8JtI4vbhJqfuMpBdEI9kyIxtkKpT7oFhIn8JhzyT0PWFcazzebg8xVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542279; c=relaxed/simple;
	bh=stD665AcG5hcsIyTcVt9is1zVm0cbebXV4YbGVpYpgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9u7jWmjxTeJ67bPTp2sXhnuVldNZ7IJZoimXLNleJdcjrOQgg++Zvj9F/6ZH87GcrQX59xqDk8Nr258TRTZQCYo6YNsVKw2zoLPtHiykZ0kN95z90d8PK/BJAPTAM803frpUsElCWHo0cMqUY6n7UDFBaK4IxeOFBdA64Mnks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FtJRDl3f; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FtJRDl3f"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781542266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lt4FVl6F5XsmnC8Rh2yPJ66cSHPxT0rIY9Vvos8+g4k=;
	b=FtJRDl3fkky+43C1hz7oOyR5vq3eTlr64ngMtFsKzTCoFlN5EBJ3y5qN/dx/Bt5BVXGkX1
	i1I+rYLvNR2idULYfvYIwpL0qr+rSgcjy5tjQTUk7JoqS29jlzhzTXOqA4aFEd4ZvYGJyN
	06qrw9WNo/zf/RG08Kw+P/saqSlTfAU=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	"Connor Belli" <connorbelli2003@gmail.com>
Subject: [PATCH v4 0/5] HID: asus: security fixes and more hardware support
Date: Mon, 15 Jun 2026 16:50:53 +0000
Message-ID: <20260615165058.3845-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

I have added support for controlling the (way too bright) XG mobile
LEDs in hid-asus and added the i2c version of already supported
hardware that was probed only when it's a USB: these are two separate
features changes and are the only two that are not fixes for
pre-existing issue (see below).

Auto-review bot has spotted a bunch of pre-existing problems alongside
problems in my own code therefore at this point I am going to fix the
more problems I can and including those fixes and improvements in this
patchset.

For v4 I decided to follow Antheas' suggestion of reusing the existing
workqueue and by making it more generic I solved a good bunch of issues.

Link: https://lore.kernel.org/all/20260612124830.984592-1-denis.benato@linux.dev/
Link: https://lore.kernel.org/all/30258f28-4036-4e99-9494-031212544dc2@linux.dev/

Best regards,
Denis Benato

Link v2: https://lore.kernel.org/all/20260612142326.1704858-1-denis.benato@linux.dev/
Link v3: https://lore.kernel.org/all/20260613153029.2559774-1-denis.benato@linux.dev/

Changelog:
  - v1
    - Initial submission (as separate patches)
  - v2
    - HID: asus: add i2c entry for FA808UM and other TUFs
      - Joined to the patchset
    - HID: asus: add support for xgm led
      - Use the correct callback set_brightness_blocking
      - Stop hardcoding the cled name
    - HID: asus: prevent wrong pointer cast
      - Added
    - HID: asus: mitigate possible use-after-free
      - Added
  - v3
    - HID: asus: add support for xgm led
      - check devm_kasprintf result
    - HID: asus: prevent a late KEY_FN_ESC to trigger a use-after-free
      - Added
    - HID: asus: avoid sleeping calls in atomic context
      - Added
    - HID: asus: cleanup keyboard listener on failure: avoid use-after-free
      - Added
  - v4
    - HID: asus: refactor the two workqueues and init sequence
      - Added to replace previous patches in a clearer way
    - HID: asus: add support for xgm led
      - Simplify cled interface allocation and registration

Denis Benato (5):
  HID: asus: refactor the two workqueues and init sequence
  HID: asus: remove unnecessary OOM message
  HID: asus: fix a off-by-one issue making a check stricter that it
    needs to be
  HID: asus: add support for xgm led
  HID: asus: add i2c entry for FA808UM and other TUFs

 drivers/hid/hid-asus.c | 483 +++++++++++++++++++++++++++++++----------
 1 file changed, 373 insertions(+), 110 deletions(-)

-- 
2.47.3

