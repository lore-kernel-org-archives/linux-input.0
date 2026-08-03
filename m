Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34E361DDC
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728279; cv=none; b=UjARkO7M17ERxJer9mHuOhW3yMA6So0rPVkEeUZGIEHm674zNz0UCMA5SOICiMHH2kKkTce2ZQK0Q4fh5qSoj4T2mnhQMQHX1bkNN0u9KAUIs/fcnxdK1ns7cLUs8YbdD0y7P+lAKe99GJFAJOz/gq9QbZ7HNOSXau9c4ORtBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728279; c=relaxed/simple;
	bh=3kJ62rXINY4asL6Hx9/+1kOA+4Koy+GW8WaWXMRufps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBlNY/yYi8DNJSaDf9G2pF3uO97EXj1nMP1FFFCgZVx4j3nndFJMhjh0fokIxFrf4OZwWIbmjHJtobqXF/AWV8bQpFakj5aLNlK4kQ1MQMt3VsRq27Y+ehdbGN1hYZa5VbMrPTiGwhl0AWEhvwyeuyeUuwWaxtUnQtqVCKq25wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clw7VOMq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clw7VOMq"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90004d2f7b7so32377856d6.1
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 20:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785728277; x=1786333077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IWZjKROXd+TbmXeZiVJROjtuTyAG639iOHSKl662uNg=;
        b=clw7VOMqPu+TI6Wa61n/3VgIW3fBABm+UE6G7hAZKV1fj69aGblNGW0sIjXg9yYRbO
         VtWIpAB5EWXuhR2l+Ng7y1BRlgwq1dl5wmYrvJWJhFrzMnxflM8mAJprMWWor24CEbNU
         kKnummIJJ8GCot6nKaDWubt3iKfaOFtUDBr+yIE6yjw7+P09kYc31e5UFCR0XM051s6J
         bsNcq+aSkvhTBuKDYKqv7Am64j9527fgkiotS3Uq6IZX75AN4Psx6a+TLQgKNgQYZ/OS
         gb3PCmN8MaHiiWktfCldIrnfGLWDTARi0/NxsVV9EQNSD0AKHuSUXnyY4A0mSxt73xbD
         wmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785728277; x=1786333077;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IWZjKROXd+TbmXeZiVJROjtuTyAG639iOHSKl662uNg=;
        b=ogSThOPZGCctz4VGuunOlDvwyW8ZRhH7mHBZwjDgJkesI1J7KDbOQvLtZq7PU0BLTs
         WQHCU7vU/1XSxolMxyzqgOD56K86FSij4bmA4ZPCAiS2tYpEbWzrlloV9SNiOlyefQGM
         ZPfn25nWz7jM6Oy/gRIICmka8Qq/dXDgUCqnFnLX5ko0XWkhjQ5rcrdaw+HDF5+wyka9
         fJr8BrtBIDe879u1z8kGjh2fNJhIdMdJCqOFLHOP9yNSH7bx0M3tAZpCMXWunAA/hY6w
         iWT5IcLQvsdoew0boVDtWMAof9G6x5MFaIh5exNrsxPYque6qX/kWfLNCrjKDfvQx3xf
         YmRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrqdEmGHuzstkE9/eIZ6USSAiQMlRanG1Hij9s7msq6FNmstPobrOCd6tUSWUQTlD4au0PWPOM6my6bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsq7sHsq88ROfqUD4vFpK6SPu2a/PfS5UlodyGcosYJAFzw1y
	2Sa/FGFx5Jnt2CzrVBBYLzWtFfqlpMs/23+272FvkNoOZsbprxhxWSia
X-Gm-Gg: AR+sD13AMERW/Ylop+rwVkn51jpmxWPZPsjDo8WNNYiKtN5zLtV7C21ATtXbKLCQJPn
	Wsfdr2pIqkCi8chccFoBQ1KVxDk3D7hAtuEFbj4lyhxolsAFqqwLegVsi5JMXlfW3TjCq4srngk
	QTv91hjP8iU9IPc0OPg90MS3CnVddWPiYm8LBrP9Fk1a73bQLoKww/u99ogjRlTLdNoZz3A7974
	jhxB/leeBAsSxwwr2PkjQ5umcTncojCjGRrhBLyg/0eUk852gItKUPnYd5EX/JyyG9fDMWS08nK
	0Zc2N6y0AKtI5sKzNfHdambuVPapdABldVsez2TuRCZQC22dY0+u0j0GmJurIc1ET6iJ3xmLqOH
	6tfvYxlR6Lw0x22gLAY6jXYUSDKZzr617n2WeUTdxxGfSTCNmhiHNplUBGqhCIKajLRhkMmP3iN
	05IyMgXb8J1PkKT5wzkOlgLJO/cl/y2FL+PkzWzKRdyJSQWVcoCW4U85nsgE4E3+4c1z5xliUvC
	0JB530kwg==
X-Received: by 2002:a05:6214:5196:b0:8f7:3902:42b2 with SMTP id 6a1803df08f44-9084965c5f0mr176385206d6.27.1785728277443;
        Sun, 02 Aug 2026 20:37:57 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435b609csm65419786d6.26.2026.08.02.20.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:37:57 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: pepemontfort@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: Re: [PATCH v2] HID: magicmouse: avoid NULL pointer deref when there is no input device
Date: Sun,  2 Aug 2026 23:37:09 -0400
Message-ID: <20260803033711.17170-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728184059.688513-1-pepemontfort@gmail.com>
References: <20260728184059.688513-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026, Jose Villaseñor Montfort wrote:
> Bail out of both callbacks when msc->input is NULL and leave the report
> to the generic HID paths, which is what those interfaces get today.
> Rejecting the bind in magicmouse_probe() instead would unbind interfaces
> that a healthy device legitimately exposes and drop their hidraw nodes.

Apologies for the near-week delay in getting back to you -- I was away on
an anniversary trip and without physical access to the test machine for
part of it, which this needed. Sorry to have left you waiting.

This is the right shape, and thanks for turning the v1 report around so
quickly. Both callbacks return 0, so reports on the input-less interfaces
keep flowing through the generic HID paths exactly as they do today, and
nothing about which interfaces bind changes.

Your ->event analysis holds up on a read of the code: hid_process_event()
calls ->event before the HID_CLAIMED_INPUT test, and with no usage_table
in this driver hid_match_usage() returns 1 for every usage, so the guard
in magicmouse_event() is doing real work rather than being defensive.

Tested on a Magic Trackpad 2 (05ac:0265) on 7.1.5, over both transports.
My tree carries the DOUBLE_REPORT_ID recursion fix [1], so the raw_event
guard went into __magicmouse_raw_event() -- the trivial rebase you
described; it sits above the size check, as in your patch.

Over USB all four HID interfaces bind to magicmouse and keep their nodes:

  0003:05AC:0265.0014  input48  hiddev102,hidraw7
  0003:05AC:0265.0015  input49  hiddev109,hidraw15
  0003:05AC:0265.0016  <none>   hiddev110,hidraw16
  0003:05AC:0265.0017  <none>   hiddev111,hidraw17

Interfaces 2 and 3 bind with msc->input == NULL, as they always have, and
there are no probe failures in dmesg -- the two "magicmouse input not
registered" lines per plug that v1 produced are gone. Pointer motion,
multi-finger gestures and clicks are unchanged, and the battery reads
74% "Charging" while cabled.

Over Bluetooth the trackpad reconnects and behaves the same, battery 74%
"Discharging" after unplugging, and a Magic Keyboard on the same host is
unaffected. No splats or call traces in dmesg on either transport.

Reviewed-by: Alec Hall <signshop.alec@gmail.com>
Tested-by: Alec Hall <signshop.alec@gmail.com>

[1] https://lore.kernel.org/linux-input/20260715053526.574725-1-pepemontfort@gmail.com/
