Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656934405F
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831269; cv=none; b=PxKQ8tjWSxaN52nvuFR6baHGHrRwUJtLRa0Fpcyn5EM2A2jbL4dBH6UQjuLc/1D8g3UFoMqvJIJrZBn9YygeD/e1QcQwtfki8/I/Bjt2PPURR1XoiFIaFLXPMtKJUsLG0CjZP5UbQE3yW/FR/VzLplsj+fJ1SHDYKjXXUafSsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831269; c=relaxed/simple;
	bh=igQC/jHG4y7VEiFOv9JesrmP+mSN3/bEbYL/Phfc/RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3pY/xs3Im3w/wh793MN9BNhr5oSOEHFuobwrRlAIJVQf1rMsQFQtE/yCMdKfJDnFjp8aQEd1aBfu9F/xKs9RKzYZfbejK/KccyEmFUago1GDu8VAn3apZb2bMiDhtGr6vtNkVVmigcWhEQZSxqnanqHmgpR573uimIoIbkdKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RxHM0CCq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RxHM0CCq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4362507f0feso3681178f8f.0
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770831264; x=1771436064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfmoIHB6Dt2sNt6BObzzbr2Nkzxl+C468xBQRKTJnQ4=;
        b=RxHM0CCqPI2NkCQOcOBjwaTZZCujAl7Q+0nkhGvBEiSwFtPgC8vEC+BdcelLjclrIy
         xwZW1A/liwPNjGXgE37GmdYquL0Xq1N9ZfWOWamwz+ExLocobjJoCwk2NBJhSvQyTv3A
         1mx3v1PjgZWfNFWjzKYoon948a7Tcf+3lVtoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831264; x=1771436064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfmoIHB6Dt2sNt6BObzzbr2Nkzxl+C468xBQRKTJnQ4=;
        b=Frj9YTqNmcI3DO8eNfozv44kW2sXPvgfiJ6p5eTKvLUAA7WFznnXqW9bGtnVLjRC2Y
         B9kGGe9Hf5LbCrz26EDI4Dav7YioEBBbl3kXtRKAMOfDlm/J+OXc+CsYdEWvjM1jL2X6
         j2/UQc2dFFoOHYuiodlX+m95lv8oicfKvGYbJDG68T4m7pgqPV8tGeuarfRzPIt2n3ft
         paIjvxbJYs/kq7eB54K16/y4URPc9yxLHR+mAsSDI3nSW+h4Qfzy9dMFyuNjxfVz/S+3
         TxumogkmDwms9OVg+2/EYV9A0ZPFQx79FPE0ViHdhE4kTgLBgEp87BdkOemd1TgidJM7
         qJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1NcMD48BTlBfxNFIep47wvv6n1MeVB9mgk815DjtSLsL7jbLnoA0sHD7clY9wKGZCB5q6fMRD+rj5LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxeG4bt/ik50Pvdbyi06xD2oOnEhkGCR5mNPHyynxwjIK9ALM
	c2/EDvKtrI5X8OnU/3lTLG3r+Tr/lJ7T0SgepGNj/UPu2nYWzGQAniSFcZJ2wpPBsQ==
X-Gm-Gg: AZuq6aK8Vgu6PrZHsONwwyTn1z9e2RFhia6h8bm7Hu/kkJ1Q9t4VM+KD1mXidG53mAF
	GgJfBauNjku3LCC6UJJwKaZmKfzf02mtpVzl9unpPdp9R1e9hEiqzgaEO5YQluchXE46EPFazW7
	4rUGjMyKG2PkFz3DfNE6IrSH0CU9uJ1YNp00Fx4DCwFwI6vU9CK2Zw9NYTWZQCsorhRAXXfqPgW
	+MkepvMV8/GZ36OslxqMBO978dh4PyGDaMKt9MCljUcvH92QZpyBLrXfnVBuOrKjSrPbJ6Adupo
	9CiJ6KltUZH0Qh0UkklWSo8F+312FXbyj+ny7tXuByHy9bqj7D0PwRxTiTGGnaB/TsW4+SAJPm+
	U9Lpvhq4FFU9ld+gAlj2C97LKwxm8VXZGtuSbxeUFEWZDNaCZO1cUYKjFhMO9p6teeevIVgHFHY
	zBcKqjpUS2fp2wDs93L7JBRS9oZLc=
X-Received: by 2002:a05:6000:2dc2:b0:437:6758:ce83 with SMTP id ffacd0b85a97d-4378aa127b1mr372199f8f.21.1770831264536;
        Wed, 11 Feb 2026 09:34:24 -0800 (PST)
Received: from balto-ws ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d50f24sm5885498f8f.14.2026.02.11.09.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:34:24 -0800 (PST)
From: Fabio Baltieri <fabiobaltieri@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] Input: cros_ec_keyb - add function key support
Date: Wed, 11 Feb 2026 17:34:19 +0000
Message-ID: <20260211173421.1206478-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v6:
  - Fixed a bug where normal key were sending the wrong MSC scancode
  - Added setkeycode handling so fn functionality is recomputed in
    runtime when the keymap is changed

Changes from v5:
  - minor renames/cosmetic changes
  - dropped the *_key_status array, tracking using the idev->key bitmask

Changes from v4:
  - just a comment tweak

Changes from v3:
  - implemented fn layer runtime detection
  - tweaked cros_ec_keyb_fn_code to return back the correct position
    code

Changes from v2:
  - renamed the dt property to use-fn-map, dropped the example
  - added few function comments
  - added a helper for obtaining the fn code
  - reordered, dt patch first

Changes from v1:
  - change struct to short types
  - refactored the fn key handling in its own function
  - changed props to use the google, prefix
  - reworked the properties to use an overlay map rather than a
    dedicated one

Fabio Baltieri (2):
  Input: export input_default_setkeycode
  Input: cros_ec_keyb - add function key support

 drivers/input/input.c                 |   9 +-
 drivers/input/keyboard/cros_ec_keyb.c | 191 +++++++++++++++++++++++---
 include/linux/input.h                 |   4 +
 3 files changed, 185 insertions(+), 19 deletions(-)

-- 
2.53.0.239.g8d8fc8a987-goog

