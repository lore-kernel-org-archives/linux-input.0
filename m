Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E934D93C
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058040; cv=none; b=Fzw3XbcE49iT0sYkEaTdL2ku9sO6aQU5h4z9DHy/7OYDHVrkSkkVn1nyK6xdrGyz+nkFNRG29UZymR11OjLR50b7Yf+uVxdRG31pjwz/XxpdH1hGDiFz+T2TmMZrrsm1xhOninjyDKdCJwFDQg0eEjOdB5DHNW/Xl6C5xan/T8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058040; c=relaxed/simple;
	bh=7JbPPMC9KEMGlful8kZbuXTUQyPP8BqdUCabjv3tsqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+q9zL4aurFrmSz+lM74pDfypsT1MH524IuSPvtv7P774g3WXrpCDM86CHSh6qDff7ndnyojU92CzKWjuIRS/Qrg7I9LeZvvtH6ScEqW7S83SkigVyc7GIytcFo8yUxVYrvuyRr4X+c4onbjmqGTSarxTSABYczDV6IPrHMcTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWD8gNSl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWD8gNSl"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so4167435e9.0
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2026 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791058037; x=1791662837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1zvj0uCRg+B5aiBl/n8A7h6RRgbM/5lvnwXxsY+iJY=;
        b=VWD8gNSlyz6iAoxaQdCnMqlK0cfEKUdF8i+ApIJ0beBxkzY76aTI5kaPqIWeQPt6cl
         9jp5KKtNcyHYpQGHJbWWNQWh3EYXMg1G6A74FNCJ6PDuLOtLvXmnAYesFqabe/1KeQRD
         wi+dL8L6lgsXS5T8QQSp570+/MrTvRgBUYEHEYRWZ4KEcXep4Nj1liFOLZoh40m70Nkt
         4RgCMOhXRDmWPdVnjTZfi8zXWYCigfcpPbt9FiqsfD6A/tmHTnjHxuTYM91GQ3TDuusg
         GMq9RVJZWzr5cFeHdAwhsNUzSwnZzk6DxojnlekQb0hcd9rmxsfTWNeV9BojAZfcj0vS
         joAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791058037; x=1791662837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H1zvj0uCRg+B5aiBl/n8A7h6RRgbM/5lvnwXxsY+iJY=;
        b=HHgQ/zX6pwF/5vq9GMmCO3aA5Y43YhduISSK2V4JEsVZX3ErgbTnF9fleGnVli9leJ
         xcgZ18Y3kwTTiRE0PZehyLvLg1nEUgoLGZWuQBhrlOTNBKm/IIqW5G6I8+QVT8rNdkRp
         n3mmdqj5f2oYaK++U6JLePflWrkk8YDHSRTMGeMFLrZazFZU0S/XnhppMZJNW2r7R4uB
         CUyKnoXpM9h9TaAtsJqjwYwhg9pv0hSGMVD8FXlIa+5xnwdSPtE1a8cvdDlykbQVCN5g
         M49wy5iz3UJ+y3K9rgiwccjogBQ1XZcvetAjz732CdUgF5gxgeAFtlzHqUq5fCzKI6+i
         DC0g==
X-Forwarded-Encrypted: i=1; AKwUvBz3bceeSO7oFLxzgNBwDsCLOM5Sm7n9FiNgp+VdGmGgRtWClVXHY4X9k4afmDcXndEAPOsvdIxrKqaqIA==@vger.kernel.org
X-Gm-Message-State: AFuF++nBBzjc9/0xfJreBd9cJwzYPNiiQRmW09DiOvGEClkiMzjyU71z
	4ZZ0guWc8ywZTnnbsNxl9OucEBBE3XVxqE2AZnE0i/Y6lVwd2GfwIgAFZGTgSdVO/t9JWEaP
X-Gm-Gg: AYBFou3c9VUze48wtlFtSaJOkxWhyFQWoeJbK3zK7tSRyB5qpYXEdqjyqBGxMFQO2EE
	5p80UviLCEHMXY1Zgn9fnVZK8X0aQ58QxinKX0krgLJA+XVc5HMdSfC6iub9H2+62DZL6yHI2sv
	lMCN0B+ZfNdxsCqIOhvwPQiAhJY5jGEnnI5V3qWbZ23D03OKLVAgVI3hA1b98ZSwnUHRFc6pZuX
	Q2OllEYxuyTT7e2QkIOzZOZrHr2N+X0l50F+muHgSU5lGXi580+hY/x2WPvLuyZ97J9CsLCkPZN
	UR8x7aHTwdOFhVs3pqSHtBMeXsOFAAkK/AFJT9gaEQ65V/fEMWm9l2oZSylJKdMMguqW2n6oM8O
	QGP2+RR32/byUqg15cIAgXmzZoZh1V1Dyk6lxBAoLhWp2VSOAyBd1UIT/TmrPrac958w9ObwMvJ
	ZfsyXxsf4u3HRCAIVYsqOSD4Ot0AUiIG6WXTQH0L//p45ttZI2Lhj5SdwRRkrrZqaONwTbCmf2z
	NZLrgq1gSsQTiAZPhfTRvbg3Kse+rMrem9t5rvjFybAL5/5SBo6rBWCN9/uBJ8NpNk7lUY8lSI4
	39850Q==
X-Received: by 2002:a05:600c:a41:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4a1680b9df0mr46578785e9.2.1791058036797;
        Sat, 03 Oct 2026 13:07:16 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027f2a4c4sm209114545e9.2.2026.10.03.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 13:07:15 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] the Topping M62's vendor controls, on the component framework
Date: Sun,  4 Oct 2026 01:07:13 +0500
Message-ID: <20261003200713.50742-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003184217.34671-1-mikhail.v.gavrilov@gmail.com>
References: <20261003184217.34671-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A correction to the Tested section: "other firmware" is wrong. The
card keeps its operating mode in the high byte of bcdDevice -- 01xx
Mobile, 02xx Live Streaming, 03xx Pro Audio -- so the second card's
1.45 is Mobile Mode, against Pro Audio Mode (3.27) on the first.

That also covers the one item the letter lists as not re-run for v8,
Mobile Mode without a UCM profile. The second card ran in Mobile Mode
throughout: its nine controls were created, it bound again in each of
the fifty reload cycles, its own knob reported to its own card after
the second suspend while the first card's knob left it alone before
and after, and its cable pull ended in a clean rebind.

Two items from the "Not tested" list have been run since, on the
first card, each time with all three of its snd-usb-audio interfaces
unbound and the control interface bound again:

  - with the HID driver left bound: the component bound again on the
    new card at once, all nineteen controls were back, and the
    headphone volume was as before the unbind;
  - with hid-topping unloaded first and loaded after the card had
    registered: both components bound at the load, and the nine
    controls appeared on the registered card. They start from the
    driver's defaults, the headphone volume at 0: the restorers act
    when the card appears, before these controls exist, so "alsactl
    restore" has to be run again, and it brings the saved values
    back.

No WARNING, BUG, KASAN, UBSAN, lockdep report or call trace in the
kernel log over these runs.

-- 
Thanks,
Mikhail.
