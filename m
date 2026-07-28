Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C92F3DA7D0
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223559; cv=none; b=ubwt7RMEvZWkc3LOoqFbNhoDpOvtamqXN5TnDInJAO+II+9i7Mm3uLPV/qApXzA+up61NNWcrtnXVISdQf6f3h+Js8A7fE+86R4yQxQe+lGGrNWQOCHbHpHke64xXjDzPJgnMZIRRW4YqZsw7y8ac0HPQWZFxD/uehdLHjDuImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223559; c=relaxed/simple;
	bh=6/KDwlm5ghMlZoZDr+8u5LRQ6G5KIkP2c8ShBPpCI34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRMGajgRGtPSD/EnND3ZisF3nD8CNFYipeHPRYZ53sArBhEdOhBFmCnH1OlVO5ktoysHmxT+rSmVHL6gPwtXJd5jh0d99Tf0jIukm9gy2I1Gxx/D8bugi8Ip24k/XTkANldbxVt/k36BB2ubBQLNByJX4oU3yRT4tOUELr7X+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLk2XQk8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLk2XQk8"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92edb12cdf2so226868885a.3
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785223557; x=1785828357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8REJpVmdZHTajWXPY+els9sTJ1vLLgIwaTgLYZy06Ew=;
        b=RLk2XQk8Yz52IJxVjSPxJI8dtJwgeceabtgD4w2gZpoOU1X36vQsDyvX8uGQEqVDhr
         BGzzVtXqYBYoEwN4+ncBxPByy5IqZ4nOlej4ed54of98ImeCLcMJq26hly186ACWfi5Y
         MfJWQ58G+mpv9bwEfmL0RH2pBdrBS6apaOcJB6pgFVLXEYjZSWIBaYAKTzZbDusnFtUu
         IOVFE8cO9BAeed71IIk/2e0921K6BNNmjt33QD1Gfy6TOClat3xxLWXmn6VleEDX0Wa+
         84MAoecY/l3cE7DA0bNz3f/zP08vY5G4/VihsMtHZMtNDaOSqWphPI+e0X5e4YMJhAnr
         wIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785223557; x=1785828357;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8REJpVmdZHTajWXPY+els9sTJ1vLLgIwaTgLYZy06Ew=;
        b=MwmUqoQMLm08PWJbqnMFuik1ZIH1XY0awrGJqyfuG8KJCT9k7rwlttx27krzNmWt3j
         wt6hTWFhXiWZrYu0QoK+MVIvS/774BvVqXGPXQGyN/U1sSEwzTqZ0PrA9A5X5rOr8jxh
         F+WWxnc2w7DInUWCYumsx/+T1ZNuXVyOO4psAw1GAQDT+Y60/5lP2a8NVrvFCsj6zBeB
         thnp7bV2nXbT7FXJHkiMH0W42m0dMUuQnizbmGTj6L6Hr264BXBAXnEOw0DexI3Ux8Qw
         3g1zQMPgUnBqE+WFE5dbAQo5Y+ep3rTtYLuptdTaKiHBrKJdMFaFc9zkGACsTu9MDfjR
         VDLg==
X-Forwarded-Encrypted: i=1; AHgh+RpjaU6bPP8Kavoqa9y4H9zUp7KZUo+yrnDppxQRog0w4n0/E7f25WxK6rpV6m6CaW7UZx4ctcaVzA7nSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycZMs1QhgYRaG8SwaOSJTrLzz//UPBI1SDIcLqz5+ezZ7pVaFq
	MU2tlw6pLxzTeytySvbGJr1niDvKKBSkubo//7gxrxMZN2VL2PMvYs5r
X-Gm-Gg: AR+sD120aJjQBJ0qr1uq4Vh8LP8Yr2L3Z9Qxg9XpbmPg3W7WpbpgHBeDwmah0fAyZIU
	eDekgQjpRUOEticf7cqSg/fcJ+QGkcB4K1T7RzN/Mb/Ww6//Jx8ZqJ+qRfAmjdO7RhvHk6QdBxK
	1eN6P/e38dalOfwbCgSZKwcaPJXKHVoLMWpWFWELKHiTuV4viNs8AJxvdG2zgpeCE3SZzrgDTCL
	tgX05SJzu9wF5FKRlEPb/QPZwNThZcpHJ1WJeShf2mtrC/tp3QWnsNfJ0RPOrYM7QSssdkD/aOG
	oG6WKx5jHdM6SsArdT2BphL/LCkDvlF20r+g0e1zzwcmdRjm8QwkcSNXvoI3GwRNH3aXVwJmvKm
	L7YSj9sGloderL6d4WKhbubShpSPaRqokEkVGgR9bvwYB4FISZR1u8mGhSRVSiBmzL0ttN10+z7
	UMyHo88z5Lpv0TQzJ0cZutOYk=
X-Received: by 2002:a05:620a:1729:b0:930:e918:c737 with SMTP id af79cd13be357-93302719a1amr103406085a.62.1785223556768;
        Tue, 28 Jul 2026 00:25:56 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de635f7asm795939185a.29.2026.07.28.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:25:55 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: pepemontfort@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: reject devices that bind without an input device
Date: Tue, 28 Jul 2026 03:25:40 -0400
Message-ID: <20260728072554.47069-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715195853.1302765-1-pepemontfort@gmail.com>
References: <20260715195853.1302765-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026, Jose Villaseñor Montfort wrote:
> Move the msc->input check ahead of the early return so it covers every
> bind path. Legitimate devices register an input during hid_hw_start()
> and are unaffected.

The second half of that turns out not to hold on real hardware. A USB
Magic Trackpad 2 exposes four HID interfaces, and only the first two
register an input; interfaces 2 and 3 are vendor-defined, hiddev/hidraw
only. With this patch applied (stacked on the pending battery series,
kernel 7.1.5), plugging in a Magic Trackpad 2 over USB rejects both of
them:

  magicmouse 0003:05AC:0265.001F: magicmouse input not registered
  magicmouse 0003:05AC:0265.0020: magicmouse input not registered

I confirmed with a temporary printk in probe that interfaces 2/3 reach
the moved check with msc->input == NULL and hdev->claimed == 0x6
(hiddev|hidraw, no input), while interfaces 0/1 probe with an input and
claimed == 0x7 and keep working, battery included.

The rejected interfaces then end up bound to nothing -- hid-generic
declines them because a specific driver matches the ID -- so their
hidraw nodes disappear, and every cable plug logs two -ENOMEM probe
failures for a healthy device. Nothing user-facing breaks (touch and
battery live on interfaces 0/1), but the driver has claimed those
interfaces ever since 0b91b4e4dae6, and silently unbinding them with an
error doesn't seem right for a stable-tagged fix.

Bluetooth is unaffected: that path already required an input before the
early return, and a Magic Trackpad 2 + Magic Keyboard over BT show no
change with this patch.

> I went with fixing the probe path (rejecting a bind without an input)
> rather than adding per-callback "if (!msc->input) return 0;" guards,
> since a single check at probe covers both ->raw_event and ->event and
> addresses the root asymmetry. Happy to switch to per-callback guards if
> reviewers prefer that.

Given the above I think the per-callback guard is the better shape after
all: it keeps the legitimate input-less USB interfaces bound exactly as
today, while still closing the NULL deref in ->raw_event/->event -- and
those interfaces demonstrate that a bind with msc->input == NULL is a
state real devices reach, not only spoofed ones. Happy to re-test a v2
on the same hardware over both USB and Bluetooth.
