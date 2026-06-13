Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70137204A
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364645; cv=none; b=mJx20hHVZbcdwbk+zl+1Efb7gqinSwRWPmYjQXjjcPsaMJZgeWsrZEphcYctHQlgBzAbGTHKo+m5nOvYT3kGmciHcyhrD8HmSO/+2gTgza/NCU2WcS6grvvQvkVu40fObztQbize05zhhgkwteXWYAQXRA3Yxw2N2P55pyHKoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364645; c=relaxed/simple;
	bh=vAmtKZfUhXB4sPxF9FbGExv5iktRTDVBdazj4J1AvRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTv/BcVzuXlc/sMpaBYAFFQ0smkBKNGvoP3NUDsRUvOZK1lJbIGqo7MuelB/hJviWpV97e3tNssdJY0m0eyNNNoxWXnemavkb3zmFGX14S5bPazbc7v8FHObwjRSE1MVTyfyl+SjhYIqjwc/au7KbVhGfdD/IL0aosyPCF54SWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZNVYqsDi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZNVYqsDi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781364633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=36LFikKWnYCc9HirdUYug8kyng2xCErhHBZdoeIjjiE=;
	b=ZNVYqsDiTXUu41uaD6+raNt4mwt6paYaXpVbsbyzQ0hy1yPXF4ja/ATj0FK5rFWTOG2ejp
	2oVTfd0sqn6slH+JQt6thcJ9h7qtZ8FOs7KXYFGRws8uZENGVAxb4Wq5WSsdAqrgbbdCTB
	JjrM1xT3rmp+Snva6BZoxtpqNICG05M=
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
Subject: [PATCH v3 0/8] HID: asus: security fixes and more hardware support
Date: Sat, 13 Jun 2026 15:30:21 +0000
Message-ID: <20260613153029.2559774-1-denis.benato@linux.dev>
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

Link: https://lore.kernel.org/all/20260612124830.984592-1-denis.benato@linux.dev/
Link: https://lore.kernel.org/all/30258f28-4036-4e99-9494-031212544dc2@linux.dev/

Best regards,
Denis Benato

Link v2: https://lore.kernel.org/all/20260612142326.1704858-1-denis.benato@linux.dev/

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

Denis Benato (8):
  HID: asus: mitigate possible use-after-free
  HID: asus: prevent wrong pointer cast
  HID: asus: add support for xgm led
  HID: asus: cleanup keyboard listener on failure: avoid use-after-free
  HID: asus: avoid sleeping calls in atomic context
  HID: asus: prevent a late KEY_FN_ESC to trigger a use-after-free
  HID: asus: add i2c entry for FA808UM and other TUFs
  HID: asus: remove unnecessary OOM message

 drivers/hid/hid-asus.c | 183 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 165 insertions(+), 18 deletions(-)

-- 
2.47.3

