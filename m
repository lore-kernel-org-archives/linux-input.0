Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E32D8376
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757860; cv=none; b=DURfyeN/X06ZKOi/K9T9p1I5BQ3gVPC00iFPbIsfxbSbJVsvgXsXqVzPaDZA5iDDtmYLc/TXZ0OIFFn14lex4maaEavIPc5FVcEq/lGIdpGxbJJTwe90Kd9EUTR1jsZl4SG62fPq0tY5/Xn/j0zflWpoeExI28xRzezHzJdshHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757860; c=relaxed/simple;
	bh=RUhZ687WiXbhHP2A7uEREv91fU3FDbersCArglngaxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ou7zz9AUTod/UISfYB/QReIQvvtZmy86vrLkE9dLBndGK/inqdHGIweQQZg+M6MQWpMg3BWs7z3rpj8f6JZAMABbK6Fcq1k02DlfLqaQxHRVQ3/cMzSAKyuRpT/wT/PEJjKdsoBfD1uPuc5l323hZYkH71K43gvMZoC840u2os8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=icjRwqbP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="icjRwqbP"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-533797e72e8so7382501cf.2
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791757857; x=1792362657; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RUhZ687WiXbhHP2A7uEREv91fU3FDbersCArglngaxQ=;
        b=icjRwqbPlBojkQofC5EzCPZGf8XxvgLLPHDYu0na0R4+WiQEnSci8sH3DkIpNwjkE6
         fIDyR/aY1oeIpKyVdowLEWOC7bP0KC/5lh/uZ8BUs+HGS9qIriwmvf7GHQxh6WfAGzai
         4TZ3bLoykATY7OM/pU6FJkVFm7SoCHlbdL5bw4dqfWXRPuYeJUhWGH6xk2Ry0ETGFwjZ
         TCYEnEqAj+1pzkM+Myp8xEfZRTtOVYm7CacWLAsO+tk9NGxDV3gKTWl1NQ58fU5y6dtY
         EZ0bDZdAXUyiMd2qHv41E1faJ36kaIsuD4s8OY2GjLGEfjsE64soX57mI0bBXCTufxt9
         8wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791757857; x=1792362657;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUhZ687WiXbhHP2A7uEREv91fU3FDbersCArglngaxQ=;
        b=H1warbKVOqNdP/k1h10UACb9XiItcQ82G2zewSCX/n0zZPUoOKAkjkBqX40DU36eJ1
         Jr/1LgtLVrGjuIU7dqFJcfA3l/fhz/gHHBEthujgQRdYnOCbKE37txt4App6bbBhLcX6
         gvqmuI/WQv5raFKOqlyFtvkKjWM9Iesj122k+JxQ4dw8e4WXAuUzE7EOE1BtydxkFAET
         2RYIiQT7xfzQ1hORQL6ZpzS2nnksBlueroUtaG3DstMjeT5C/quU1j2Yv/6XxBjKSICe
         PWWT5+BgTR5iL15NMU0xkAfToAMZCE82ykd3Lkq9MZtmZCztWVnyMqpdj+ZeXTM9V3VO
         lBcw==
X-Gm-Message-State: AFq9FYJtGwWfgtulWEIP7yLHJBrDDbw9DCGkqN7C5WZIBvH9qCPT6dok
	zLpEIto0PW7+I8+4qHKB9LDcdAPr2q5K7rihNDfOTV5iMjYJZtd1YhptqEkcJYqRpPY=
X-Gm-Gg: AYBFou3NvB+ywehdp+XtjS0wCtPPze4vgZOIPeUHzCw0P/w/ihX5bxu8/r0ANDfaNnx
	tK+FFwLiJzBAE+0qOn9sVh6BxkRd6PeochjxYa0BKIDinCUr5iURY7xmEAKhEzE4ipvq63LsBGU
	GR60xxPEqdHDAG1YKl3WDnPmqCU1HWIs89HGH7AgwAdr3WwfxHO/Hfv77d+gEGz1YKdnIduVEGv
	2xyBL1uosc2V+ZGccqUEDlgStr+/L9OBu5f4WwxUYOdgc9430//MPVZCRKC0QNbgAXLMpbmEumo
	tYA3ng0ZQjvn6bydFmoJ8REVumPYPH4cgkf+qd7QxzzDL1hQKBIpHDaTmewEkK7CjXAYJv7Ec2G
	cPxl4dwtGcwshfDZbxanuyOp8BPqTAOMEFk+G9wT9tYE8tpGD5ItlDvftn4cQBOPVbNdITTwMnC
	NYVvyxcmeRNXAkEdl4rWk6YDCpOh6FgTzKgFw5aagiHy8h2sGjsRVxj5hLqIl8NSIHph+KN3nPZ
	/B+gIM+LsDZ86CLPv4F98AMS38T12/2oySwBlC26CR8vo2Me/ZD6s2rI5k4
X-Received: by 2002:a05:622a:22c6:10b0:535:db6c:139e with SMTP id d75a77b69052e-535db6c1fb3mr1848091cf.64.1791757857443;
        Sun, 11 Oct 2026 15:30:57 -0700 (PDT)
Received: from boomzilla.local (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7324c9sm67778241cf.12.2026.10.11.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 15:30:56 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 0/2] Input: discard pre-registration events and test state seeding
Date: Sun, 11 Oct 2026 18:30:51 -0400
Message-ID:
 <179175785190.2.15570576039664484922.input-plain-reply@voidship.net>
In-Reply-To: <assT056aFmzMHmON@google.com>
References:
 <20261010180031.7-1-kabel@voidship.net> <assT056aFmzMHmON@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Resending in plain text; the mailing lists rejected my previous reply
because it contained HTML.

Hi Dmitry,

The observed problem is the initial switch event being delivered later and
undoing a subsequent Bluetooth soft-block. It does not depend on the event
timestamp.

hotkey_init() seeds SW_RFKILL_ALL=1 before registering the input device,
without calling input_sync(). That updates the switch state, but also
leaves the event queued across registration.

In the unpatched hardware trace:

At 74.486 seconds, Bluetooth is explicitly soft-blocked.
At 80.300 seconds, Xorg injects LED updates followed by SYN_REPORT. There
is already one event queued.
That flush delivers the old SW_RFKILL_ALL=1 to rfkill_event(), which
schedules a global unblock and turns Bluetooth back on.

rfkill_start() already reads the initial switch state when the handler
attaches; this later delivery produces an additional action after userspace
has changed the soft-block state.

Regarding the missing input_sync(): from reading the initialization path,
simply adding it alongside the seed would be ignored because EV_SYN is not
enabled on this device until input_register_device().

I targeted registration because input_event() documents pre-registration
seeding as updating initial state without delivering those events to
handlers. The patch retains that state while discarding the pending events.
The timestamp reset addresses a separate stale-timestamp case covered by
the tests.

Thanks very much,

Karlos


On Sun, Oct 11, 2026 at 12:45 AM Dmitry Torokhov <dmitry.torokhov@gmail.com>
wrote:

> Hi Karlos,
>
> On Sat, Oct 10, 2026 at 02:00:29PM -0400, Karlos Abel wrote:
> > This series prevents input handlers from receiving buffered
> initialization
> > events after device registration. On a ThinkPad T14 Gen 6, a later LED
> > update flushed a stale SW_RFKILL_ALL event seeded by thinkpad_acpi.
> > The fix drops the pending events and their timestamp before handlers
> > attach, while retaining the seeded switch and absolute-axis state.
>
> Could you explain why these seeded events give you trouble? Is it
> because thinkpad_acpi() forgets to send input_sync() and so the
> timestamp is stale/wrong?
>
> Thanks.
>
> --
> Dmitry
>
