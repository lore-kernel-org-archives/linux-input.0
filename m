Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10A3B14C9
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514515; cv=none; b=gZQYEVhRcgOq8qunGa7CRMJqgajm0gNqfwrPAGGY6owiUjleyxJAMsQjPBFk6zObpqdPqS60gg1+ki1K20q1bPRE2/HzNlOroALfJb29TiWgaUe1EwIxoXsFZmb30IeNmpyEkj0upCJ2sK/27EmGX9i+TOk4ALnV4vCK7YcK98Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514515; c=relaxed/simple;
	bh=9eE802/mdqD1szWpDk9wP2FgV9BPvfuFoeY4cWiDP5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0YF+HffB7B8lOFUvbyBxAmbaFi1SKNUStLikpfB0YuDOVch1z8izPg/DpP7D+cqZI2e+HG8PAgwB3J/nTcUkqsjj5B2f/YMLIxFllUS9ujca/9duICk06QS5KHulPJSLs+gg956fEJDqP317AjbpASbGh96EuLA3DdeCeeCnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOY+oGGE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOY+oGGE"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so2613411e87.1
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514509; x=1788119309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1N+xmknAerLXLrkm4c+ef9Ke+sN2GRf6fH6nUtDpvs=;
        b=DOY+oGGEXF8SsybJR6bRaJAp2XarMA6NAw+VUKcjM7lDXcp7Gy7AXQ75f+Of+XO88D
         oLVvbJBadzUmnkwRwS9rv0btOgFV6zvi6jZanfdhKdxYd0VWgbNLRvBSAZvx/3ETMsBS
         uf5Ju9IvMduSqDApORjvvoC2jkhDD4kki2qI98dZf78hrTacfBOgNva/QnjQUwkSHD9n
         QrUdjIg6imFNYuDS74esg/9JQNtR3UqHWrKhCxmuWLxecLn/E+munGiBSC/scMzC3SBN
         CDruIbRJ8WTGo9UL24Pi6XXtp7HzEb9uVL4iJgU/vLViuF5oHQzUmtVhY4xJRhtbZ9BL
         1zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514509; x=1788119309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v1N+xmknAerLXLrkm4c+ef9Ke+sN2GRf6fH6nUtDpvs=;
        b=Kwu0w4OmcB0LGmeZ8FIeVMCRpAppP8Xv4VkvT1yKxTiZsO/L1G+FP4ddYOo1uXJfzx
         k6MUuom3+SaeKGLpwgKY6GBdpne5NOfr0KfKUwP5+B410/P3HDnzOVXQUMp8Nvikz1AN
         6vQjLjz3iOs4e9am5+DLboeE1O/nvqMPUYazGXEclAjDlmZ59a33XL//MwA/sqlXi0Py
         G9dajOvpWQPREk6iG8ygLqQ5Tt+dgibCkfJffqrWVtrL5gxkl4Vki9GHfua9d3cebzdE
         oPBy1mHBBVcvTu+KzTRDeKZOkkDR2w1BJwaoW94c/mmGQHeoUcAEZGVM7nfzDtDqyv4n
         2jqg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6HfHb5u6B0Vd26EKhcZjZWI9Cw3iR/Xh6IOCcyfxzF9t2gYV+ng7wKijxpqUc3OWJjJ4KvAzNlOnjGQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kOP8JIDWS9TcG60Rq0sdqIrapqTkf5kEd+WNtuJoDoXgqMOHRA
	LQRVGV89HdDLIhdPRbfe0qvV0iZP0pMrX/lPCNTdkpJVc8pJZaPPd0wc
X-Gm-Gg: AR+sD13YSMtEFud6utZDrza848/hDzUhBnQpDqfY6i36C3Gic3qH9E0yQrD+6+2U3k4
	jOwEGAeMaz6md/jONRHLN2S8ddn0Hs2Eoe/tvOgCjf0tnqpjshYMgQgqQ+BJvgnPdheRGso3jqt
	OT5bqgw2ekah0ttzZc0SvwMuRzbkUNf8jFn0O5m5PDCUq2CnC9Ui6XivZ9KfZP//mDO2S13qhav
	XbfiOYZAtj/qachZA/GqEyYg7dgMLD1LRQJI4fmeVTuQIVwCLD0W8rUN4AqghCjIlBaaMsFf5+c
	32GX5cOUADDVXaEDEcJlqIyn2/pxw9xMYqEXpA9hJp0QgSJU2c6wslpt3JEE4t+WDo0h/9Alw9y
	ad4eXM5OwJRVRlrBeur90CssvhepPCrtR4Ab49mqO3Nxo/HWA1s3yJumnZ3DHoKqRG5XQ8aqbCL
	tl1hhfQnvVuuZ8kXhojSD1draj2ExUFRX0ET8BqW1t7KAoYCu8AH4QsLUNxtBrnYGasE4otLAky
	3ZqjOq/8mnslMuUAr/4P5V8fDGmVOOAJjZi1bBfmjvOAR3PxZweIy1AaSJf
X-Received: by 2002:a05:6512:3c94:b0:5b2:e5b7:2419 with SMTP id 2adb3069b0e04-5b4841e99d8mr6452510e87.5.1787514508303;
        Sun, 23 Aug 2026 12:48:28 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda2b8bsm1199260e87.26.2026.08.23.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:48:26 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3 0/2] ALSA: usb-audio: the Topping M62's vendor controls
Date: Mon, 24 Aug 2026 00:48:20 +0500
Message-ID: <20260823194822.29430-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
References: <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 answers the automated review of v2. Four of its five findings were
real, and one of them was a bug a user would have met on every boot.

  - The enum refused "Unknown", which is the value it reports until a
    hand has chosen. alsactl stores and restores that value like any
    other, so the refusal failed a restore of the driver's own report
    -- observed here as "Cannot write control ... Invalid argument"
    from alsactl. Writing "Unknown" is now a quiet no-op rather than an
    error, since it is a report and not a choice either way.

  - The hardware is reached under snd_usb_lock_shutdown(), the way the
    rest of this directory reaches it. Without it nothing made the
    teardown wait for a control callback already in flight.

  - Suspend and resume are handled rather than survived: the URB does
    not outlive a system sleep, so notifications stopped for good after
    the first one. The resume path resubmits, subscribes again and asks
    for the state, which also refreshes a cache that may have gone
    stale while the panel was reachable and the driver was not.

  - The claimed interface is released, on the error path and at
    teardown, so unbind and bind again works instead of failing at the
    claim. That needed a release helper beside snd_usb_claim_iface(),
    for the same reason the claim needed one.

  - A mutex spans each write from the comparison to the cache update.
    The review called two writers reaching the device in one order and
    the cache in the other a race, and it is one, though a narrow one.

Nothing else changed since v2; the questions in that cover letter about
the third form of the driver and about a control that can be written
but not read still stand.

Tested on the hardware as before: values arrive by themselves after
probe, a front panel knob still reaches the driver ten minutes later, a
write reaches the analogue stage -- one source recorded at gain 30 and
at gain 60 differs by 29.7 dB against the 30.0 dB the taper table
predicts -- and for 2/2 the audible test, where pointing an output away
from the bus being played silences it and pointing it back returns the
sound. On a KASAN and lockdep kernel, including unplug while a stream
was running, and now also across a suspend and resume cycle; no
reports.

Mikhail Gavrilov (2):
  ALSA: usb-audio: expose the Topping M62's analogue gains as mixer
    controls
  ALSA: usb-audio: let the M62's outputs say what they listen to

 MAINTAINERS               |   6 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-quirks.c  |   2 +
 sound/usb/Makefile        |   1 +
 sound/usb/card.c          |  19 +
 sound/usb/mixer_quirks.c  |   5 +
 sound/usb/mixer_topping.c | 709 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 +
 sound/usb/usbaudio.h      |   4 +
 9 files changed, 756 insertions(+)
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h


base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
-- 
2.55.0

