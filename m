Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562575;
	b=XWOxJXwTRF0JhIcl/vaU9XpY0RJ+MK0gayekYQQeflOnJsEqYjgGwDg0Bq72EObm7rQc
	 S12595LhrV8ZAhN7OVXTmaSpbvE25BQhovLsHrjsy98pBVfuELVbsJfoGoeF8dF3LsDtv
	 RiegQePHLr1VfEZIIw0OUQiK3LvnAWA+Dfv3fHoejHj+8LgUE+TiTtDScdiF7xrHRUkv8
	 vyyCM41UDVwERlkS/fdPT8xzaZdAhko5f9SjhRpzVNC1QZNRwiHFewEEDfakktrfep8Lf
	 9q3wUE8lYah7P3Y9uZfrYJaikFeqdn7FD9D+DZ5tAnC74AQU0ps/bkmuPsouook35xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562575;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lglUH/RWXos+BDAnRUkd1kMSmZezdcAJOc0+6EXX0TA=;
	b=u2JaEPR9N9U+DoumL9WJs65uaXGhberkpjLc/QityaiRtMnwBf5Z+klz2sUA9vSvJahg
	 pJ9e32gNOdVdPdHFHKVPSZ2NJyVJ29Vx4XEKpNKA2SI3NO67oDyZ6KwncfFjRfbkK5SIm
	 bWEhm1y51m60Vb8HmGk1n6g17w5LreFa6qbLzmkyBDr5aILbX9nk1xwAnWztjOi/MA6DD
	 aya9HylyAKeUuB3NfTQzhxx0bYee6k4/LpgX70y7NlQG7oIQT0DZoZdTXgtgE9H4S04Hm
	 0WSjm/BlimBQ1ZtSsL7jbgUOlgHg2tIUdj2H5AcOvPTbx6az4h/1z3TGWtBDsIt0xsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=mqmdEJb8;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79892606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 06:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79892606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=mqmdEJb8
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D3960240104
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 08:02:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792562571;
	bh=lglUH/RWXos+BDAnRUkd1kMSmZezdcAJOc0+6EXX0TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=mqmdEJb8QIPTxo423FpEAYBljceYcvAFMwrsqomhcuLbDOD3/PX1+DOHiN4J9aEGI
	 yOG+I7zKk56zprmd+jYqUxBZbS+5QGx/+VC2t0PXkmio8Eu3Xj69gbahsdP0yRfXFU
	 8wZqSPjbc6iCxCe5uqsU79WO0X9zvmtZfQS99eTQO8LKmv53a7VEoQxhgkzncHYpQ4
	 Zn/2vmtBUtGFUCGjITws9e3Iw8Syw5JiTc312xr1zsNftXRgJ0HbgLDniM9xhqFdRv
	 UskKNWXfUlIMc6O9eAyxa4hTJtxvQ7MfFegV4UdIE+9Jk3pYwsyNjjpWuV8kdR8aXP
	 oW/ly+lSbW71w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j8dx62sHqz6v18;
	Wed, 21 Oct 2026 08:02:50 +0200 (CEST)
From: =?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v4 0/7] HID: asus: ASUS Zenbook Duo keyboard support
Date: Wed, 21 Oct 2026 06:02:51 +0000
Message-ID: <20261021060243.855484-1-rebecca.mara@posteo.de>
In-Reply-To: <20261020092423.36380-1-p.pisati@gmail.com>
References: <20261020092423.36380-1-p.pisati@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 11:24:10AM +0200, Paolo Pisati wrote:
> - Drop the delayed handshake re-send: Rebecca measured that the
>   keyboard stays in hotkey mode without it.

Thank you for carrying this, and for the credit.

I tested v4 on the UX8407AA the same way as v3: applied on top of
e16927855d82 (hid.git for-7.4/asus), the resulting hid-asus.c matches
the index line of 7/7, built unmodified as an out-of-tree module
against a 7.0.11-based distribution kernel, with my userspace
workaround stopped.

- Docked (USB, 0b05:1cd7), with the module loaded and then three dock
  cycles: the five keyboard interfaces bind to hid-asus and the
  touchpad stays with hid-multitouch. The descriptor fixup is applied
  to the hotkey interface. The keyboard backlight key and Fn+F
  (balanced <-> performance) work. An evdev reader sees
  KEY_BRIGHTNESSDOWN/UP, KEY_VOLUMEDOWN/UP, KEY_MUTE and KEY_MICMUTE.
- Bluetooth (0b05:1cd8): the keyboard binds to hid-asus and the
  touchpad to hid-multitouch; backlight and Fn+F work. When the
  keyboard switches between USB and Bluetooth, the backlight goes off
  for about a second and comes back at the same level.
- 7/7: the input devices keep their names, "Primax Electronics Ltd.
  ASUS Zenbook Duo Keyboard" over USB and "ASUS Zenbook Duo Keyboard"
  over Bluetooth, the same as with hid-generic.

For the whole series:

Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA

Thanks,
Rebecca
