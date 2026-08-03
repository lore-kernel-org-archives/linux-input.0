Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D53845D5
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734234; cv=none; b=XpK9qgc3BmHRsliQ77PibmjZH5hJZlRdUZGo/81XP51mXAy6bMNUsEqiIrBjl0q1qRU2xZO3NPwfTU0VaFFj6FkNDxNUONx47a+kIdqWLqpiM9+sZA86uX999xeuBodm9cNT/Wg6JXvAsdvCPRd1zYCG3qJaEvFNX1ck1IaYe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734234; c=relaxed/simple;
	bh=KmL2sbnHKLahsnko/p7IL/HAXoGfUFNYPlNNLbso7Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/DX/nFFhJ8GSMMZZHiSFDtim7x8Gq4UcaogCIAixu79tCBmuEh+Y0fQa+fWpDpatWD1W4k+dsrqR9BrRNcBsP+4PVjgC3Bcy6rEN8R7n3t2ZLaQ0NTwEJk5iVFl6HGgqsmAORype3KXB17FhTlwZRC3ZSYPGw1vhC/2S7MXRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=psvhIjBH; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psvhIjBH"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92ed3993c1eso146565885a.1
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 22:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734232; x=1786339032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4k0ugYvWzxtiO//veve6HLDZsW72yaJjTh1QvzWOQdk=;
        b=psvhIjBHdX2GlggxYuOa1Q0S/3N8PkcQnoXVPxr2HwgLno4UNWDVv2odoMKqFrYQfx
         EyeUzYmiZRg7HHDXdyCntEI4lZXxnV7Sf8clmr4OJMirfHf2vtkvYt8WlxIz6IazvlnL
         emDsR6W/l8uaxQomEdvXF07sjoGhhe2C8pJ6SNZIkw+wgtmRBq408Dhx60JdvIHa0oEO
         iD8tjmw+cavSebg9qchyFhB41UhUhngfmIqGRqNLO92BdF8YPdD3f4Jog2EhpP5i9Hqk
         pvqRJ+qMjJVbmEbrXH+DqYBb7xqRgdJi2vgGBTu3jorx2LNdurZ2r0zJdZUqLtEKjuy2
         9vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734232; x=1786339032;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4k0ugYvWzxtiO//veve6HLDZsW72yaJjTh1QvzWOQdk=;
        b=g8UvrGkR2d8jYvgIzGydvmnZDKOXlRmQCsP/ze5S8p26eXOUSmc4oBsl08SfeSYPTM
         lpWG6TaVunbIKSOEArUEjHQZQ8hjdpbTP9LHds7wNEqNI+h12yqowULqIAPLTWUU7wGg
         MutocVKRYJVRp367pkKjZ1OjPVVBCsWxl8xhhj1xnABWBuy7FdcFcOrbKByO04PdlNY1
         FlgKhvideRp0H8RuxiV0pBAFNpLJHO5D3hRIVkeV4B7gZpQ8mlOmNwemATrb6GyTYzuS
         9k2f0eybwDeJYB5w2a8N4dgEurO1R9mVEBOV055lutWAf6je8Xm6u9KQKhPcDQiQ6tQI
         mHUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2tTAbeqwpaTcAAKwYqJ35NSPeVqBNA/29O4A1jrnqNAH9jkn8Kmt4/OKpA5VTWldODHSzOSb5wqz0Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HTEhTZnMFml8woSVuTOTogdoIVkr8uQ6+2RZCeB8SVgfmZ2i
	RiQLkqgXw6UjPgptmx907da7D8o0ZEjnErZQMFY2kqUl4Kd9en03TMq2
X-Gm-Gg: AR+sD10hDGawrxRDqIJiBWARzk8vWe1nMLav2wAo+7T3DMBLJF8yYtXBny9sTj1GoJz
	q8Uh9ZFGYoU1Pdp2HrhpWHjM1QFH6ytbObQuxsY2KtHfkkOEipGY1BSxh+saJMB0Jvmb8YU4/+u
	kTGLP2ExAG7o4bumgXuGhg1qW9MzBeMgtM1wz7CtZ9BZ7+tAmhLKryj8YvZOaEpOpZKAomAKTaV
	mDUlwMfmbuMuFDVFN9IoxFYDU65X3hu4NPUIoqq9yXFyJ06kgHB+5tnFjmd76zqBvFkBJjjT1lh
	SPikd+WxP55Myf/5jYchbtJJycrF8zcP3a7gnjXNicE0LTELwVE5ui851KjhYCEUo5z37GDSNki
	GPMmC5UosfzP1XDOfwmQ22n/sMFyn+CHkejmPhvIns+k8UwZJQ1nQckd0cE4zQcuEKNYLDY1vc/
	Fc/1p3kYGc3OGIXvu+s/SBEsY6Q21pC+f/CAiXOF6X/dFZ+xi/WDrDtUDU6UzQuFlitn5x/6pf6
	0Uf0pR8+w==
X-Received: by 2002:a05:620a:6506:b0:923:45bb:a95c with SMTP id af79cd13be357-934a07395d4mr1649450685a.10.1785734231869;
        Sun, 02 Aug 2026 22:17:11 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1dcee1sm585700185a.38.2026.08.02.22.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:17:11 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pepemontfort@gmail.com,
	Alec Hall <signshop.alec@gmail.com>
Subject: Re: [PATCH 0/3] HID: Apple Magic Keyboard/Trackpad battery over Bluetooth
Date: Mon,  3 Aug 2026 01:17:06 -0400
Message-ID: <20260803051707.53252-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714101235.99447-1-signshop.alec@gmail.com>
References: <20260714101235.99447-1-signshop.alec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Gentle ping on this series, posted three weeks ago. No rush intended -- I
am mostly checking it has not fallen through a crack, and asking whether
anything is wanted from me before it can be looked at.

Some context that has accumulated on the list since, in case it affects
how you would like to sequence things:

Jose Villaseñor Montfort has three fixes in flight touching the same
driver and the generic battery path. I have reviewed and tested all
three on a Magic Keyboard and a Magic Trackpad 2 over both USB and
Bluetooth:

  HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
    https://lore.kernel.org/linux-input/20260715053526.574725-1-pepemontfort@gmail.com/
  HID: magicmouse: avoid NULL pointer deref when there is no input device
    https://lore.kernel.org/linux-input/20260728184059.688513-1-pepemontfort@gmail.com/
  HID: magicmouse: do not keep a stale msc->input if no input is claimed
    https://lore.kernel.org/linux-input/20260729041557.1185819-1-pepemontfort@gmail.com/

Patch 3/3 of this series touches the top of magicmouse_raw_event(), which
the recursion fix splits into a wrapper and an inner function. Whichever
lands first, the other is a one-hunk rebase; I have both applied together
here and can respin this series on top of his at any point -- just say
which order you would prefer, and I will send a v2 rather than leave you
to resolve it.

There is also a generic fix from him for the battery query path:

  HID: input: read battery capacity from its actual report offset
    https://lore.kernel.org/linux-input/20260728201309.776026-1-pepemontfort@gmail.com/

That one is complementary to this series rather than overlapping: it
corrects where hidinput_query_battery_capacity() reads the capacity from,
while this series changes which devices get a solicited fetch at all.
Worth noting it also improves the behaviour of this series -- until the
first battery report is parsed, capacity reads go through that query
path, so on my trackpad the power supply reads the flags byte for about
a minute after a Bluetooth reconnect before settling on the real value.

Happy to send a v2 with any changes you would like. Thanks for your time.

Alec
