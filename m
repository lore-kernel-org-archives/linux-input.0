Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244663;
	b=VwCAl6iLHbmUl1+QXugpPxZKyR+osovqGmlb+hoQ5hnPNaHD8oiolEMu4wunVkY5wN91
	 QS7YFvIA6Cdsb5rvDUXy+I67J1rDp21F4U9lgvbylljESWHx5aNkyzuj2i+XIGiPHBIkc
	 Zjz9Jk+P5f37j0LsAm9FpCSHNBdHZtZbOXCpBCPaWQvHTwsTHHN1H5JsMxHlCktdnJf54
	 vZ31ij8zN0o6GyNfctAbig1fiUiNYg0cwodwxB1rrGkQUY/reGiKvAt2h3dgxCaVD1pFc
	 eenQ3+FWdsWMHwDyDQXuOGgiQvKFIYSFuB7D8QrBpBBDNZ5oOStOTX7XqKrDce3Imsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N6WTQTQRbYXwQiY0GfL/+h0zie0u4l23EdajHTFVMJI=;
	b=wBGLnFRCJXu+X/zP6gPNHhH9LOWI+ITaSp1dzezrnaw1WV8Ir2e6QUSfQvX4ztOAfMPC
	 YSBCff/zEF6B1Ow79uY2wecJaDJe2YADAkXSOYNyXZGSKUSA8ff15WE5CPhyH1NWvM33v
	 yDGSRgxnrLbHFHgbEPAQgrKF8aRlkWMBqyhYh3r/EZs/Ko5XytrKNwBai7gp5pBcbrKJg
	 HUV8m3JjneaCejoieJO6TsnVL88MQfSTPX8HrHSo8LYXuFwZrrHJoUd2FHe7j45A4Nnyq
	 xacE6Fi3JdLppwGZ6euPTkTWq8rHD3GqA5UiI2trq3IY7hU1GFot4CFKp8zCztpxwwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=md6UCzoF;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C108606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 17:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C108606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=md6UCzoF
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4697404c2bso152957766b.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 09:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244662; x=1794849462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6WTQTQRbYXwQiY0GfL/+h0zie0u4l23EdajHTFVMJI=;
        b=md6UCzoFKluPISx1fQJzYzVoPNKc/a1LxqOY5Ra9wrIkO+MRkniUEbG3XCJMuvtEvR
         naWUNT4qH04Ifpd7y1SrROqHqYf+ThpVtx+efqADXW1Tx8OkyHTXF1KedfwkctoBYN75
         61hesQqh9C9zxO0pSmwZev+D36ehhXVGjUmUCHNA8hyMeXTwFz6vrgutT31OSb/X+gRM
         slu3SwUIq39mwWMxxdzMgyQpAl3byIuFx77tZ56nSQGMjO4Xys2Jgs0vq50i0oatFRlH
         dmfMARUsITrOMySt0IyYex3RLnzc7arAoxEby/99QK6Y4eWGJfrapP9KcfWydGWf7aGJ
         Vtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244662; x=1794849462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6WTQTQRbYXwQiY0GfL/+h0zie0u4l23EdajHTFVMJI=;
        b=JSS22i+xvcmhjmhPk9WEABb1vcvNTx47S09X3+73jveQOaVihqMlQTEg5D5ipVo/bN
         dvFhlN8snMunxGKWQNqQsEATlTvbIMz/iuw1wlUQQyWkSEfZrEhwDN+JhxwUOlc/8wqL
         ePHsjcXPt7GNoPAq+coDFjxwG+MME5RPIFgMtnOHgvQuQM1ErvhEfJEL1CQYxGnZep+R
         MbJtGWbI+Qk7WIDvck2ObFEvdn8kTBTWvPmwfVuPkRl+V9FkKUFh67j0q2I9FuDG4auW
         DYTWrbXp/IMGTZaBe3NhzWX28KD9Xa4Qfs/OzxKQpbi8S2AQScPhqnwb0ylCXJ6yr911
         mojw==
X-Forwarded-Encrypted: i=1; AL+hErF9Rnep1WFPrrthiKhLMtq83UW3681+9HfhOVBbGrPq0myPx4cygTTzBIT31uSsVQIMG+m3fvhUDkH1mA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8LSoiIMOJyuvm0O3KyDPy8wHT+TISYhMTxM3l08LeCmbIh5Ygh
	AYIDkIYH41SQlgEg/YR4uSF0opBvrpXf6NjTJGqh0n0iYUG7PnBKyhOF
X-Gm-Gg: AYBFou34kJnZa1nJEDz7YtHN4U+qZlfiU0u21cyJyCMXyYTDzqOIH6dfaQOvAbV4I2Z
	+5sx6JZw4BkWeU/ZlQU5xWs5TBEf6XvNH5UBsjpW05jOHO+kZlP9maTeaPbj/ls24iskSVlQcvl
	tI2R0fGrpe5MLJ87kxhYQEGXcyhXWklNesvsVCR/Md9E6xUqnC9CRZ9MRQC69x0DNdB5n1j1ZTC
	OHe6cdlV4MekIkRbGOCRG2bv8Ts+vskl11JacH1TiiQAFLkURjSXW0s+Z/V+uGrt6UeZQYZ70gl
	L+tKwZHIvsMpPvw8TyM0KWjFFkKOszrLWW5oSGeKrz8ongn8xAOiml4gXDguyAwqEvhos9QM6AH
	KaqCkIgpltFp48peqXZQQZjp2LacvS2ZBYQ1g2T0r/VfW+XyH6x4GwKO3rPLKofMUqJ4L6JmOQ8
	qKQZsvjrkgG9NgIO5XSHmH9fEzwOszB7K3Dhefd8cWncl01v+yDWFZ9MFgX1uUTBSQNVYS2PrEC
	N52InExP+TvlI5bdhhlNdAhKLLRcOUiK328AR9cLGL2oafJPHJ335M4Zx2XLq/nyJO/ZCRtHD5R
	vK2QrCMfNLFQ3FT/1/nO2YB7y5X9d92d9Eu0mUu0YR6CFmp2wdL7sYpCo7YPn0W+dP0fJOLG74P
	rCw==
X-Received: by 2002:a17:907:3f1a:b0:c46:7fa4:922b with SMTP id a640c23a62f3a-c504953a0f4mr2383066b.33.1794244661472;
        Mon, 09 Nov 2026 09:17:41 -0800 (PST)
Received: from torstein-desktop.internal ([2a01:799:3a1:9700:9811:d134:cbdf:c22b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c4d6a4af091sm191633866b.50.2026.11.09.09.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:17:40 -0800 (PST)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] HID: lg-g15: G15 v2 contrast and game-mode LEDs
Date: Mon,  9 Nov 2026 18:17:25 +0100
Message-ID: <20261109171727.2812614-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series adds two LEDs for the Logitech G15 v2 to hid-lg-g15.

Patch 1 exposes the GamePanel LCD contrast as a g15::lcd_contrast LED.

Patch 2 binds the G15 v2's keyboard device (046D:C226), which is
currently handled by hid-generic, and exposes the Super-key-lock
("Game Mode") state as a read-only g15::game_mode LED. Normal key input
on that device is left to hid-input, with the same
HID_QUIRK_INPUT_PER_APP setup hid-generic uses.

Tested on a Logitech G15 v2, together with lcdproc (g15 driver, hidraw
mode) driving the LCD: the LCD output, the contrast LED and the L1-L5
keys all keep working, and the c226 input devices have the same names
as under hid-generic. Also tested across a suspend/resume cycle.

Changes in v2:
- Drop the framebuffer patch; userspace (lcdproc, libg15) drives the
  LCD through hidraw instead.
- Drop the remove-path patch: hid-core holds driver_input_lock during
  remove(), so raw_event cannot reschedule the work.
- Contrast LED: clamp the brightness before indexing contrast_values[],
  and restore the contrast on resume under g15->mutex.
- Game-mode LED: set HID_QUIRK_INPUT_PER_APP like hid-generic, read the
  initial lock state before registering the LED, and guard the cached
  state with a spinlock so a resume-time GET_REPORT cannot overwrite a
  newer input report.

Torstein Eide (2):
  HID: lg-g15: add LCD contrast LED
  HID: lg-g15: report Super-key-lock state on G15 v2's keyboard
    interface

 drivers/hid/hid-ids.h    |   1 +
 drivers/hid/hid-lg-g15.c | 347 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 343 insertions(+), 5 deletions(-)


base-commit: 2c2fe95ab19b09bef7391e3e5cdf8146d09792b6
-- 
2.53.0

