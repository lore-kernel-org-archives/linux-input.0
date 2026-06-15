Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA44389E13
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548946; cv=none; b=VC2u4tdugsO8NCzDlAzFEYFhhfsA0z3fBOyHhHtI8NVT5nBvLf1rgCARyBE0cEHRFBBBsJ6wSxAGMXlOnOs4HYIWbxj+CZRTYAddvf5Y7tKusShY7zvVPRGEBR7pwE+HeW5US4Nag7XnUsoXJ/TmqQ4+GbngKR77p045yi8KdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548946; c=relaxed/simple;
	bh=I/BO+Hj0qGkLSlWe/ohEnlox8MBgF61jYUvcs28cNG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hA+GdXycAI+6erTVQ7hP03TDGxjaI0VOz4rBj17xiQphaX5U9Y5V9Udgk03jEUrgzO7ImiH5HbFl83Xdxs+qcwcpks5q6M7BzaVVSJ3UCt0Dx4akGRAgRopLrMLYzpe6H2in7IP7Ow9jJjqSYdjGNcRF5KeLHxCcaWpuc0AAFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IBSSsKhj; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IBSSsKhj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781548933; x=1781808133;
	bh=I/BO+Hj0qGkLSlWe/ohEnlox8MBgF61jYUvcs28cNG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IBSSsKhj1yyyxbPSk7XLkIeLDz80hpMadZz/n0giAtKUuG/AtP6Y7vLL6czTl7vmt
	 XApQw3Q1y/oRvf3wo/gU8o60BXTk/Qx0NCMA1qfJcCjYVmU5jtZVlTZP+IsrwBrODE
	 o8lhyIx3ZLfAF2soacMD3xW/X5eIB4sFfVR8PUCWYZsDeR0nHNOCBiUFwHWndnTeGC
	 Q7tPyidDh0bYISmmooEi4m94Uhvdie8/RMdJArHMc+xrZt9NzFY0+n/EPZJpR5ZqkU
	 /WVXZt2HlUvxhFJJgWHmmmX6AHnJ3mE+pKMyBeaYvnBLGVqov0L1NG3FY64ferWq+w
	 gYjWOVIGeO0bw==
Date: Mon, 15 Jun 2026 18:42:10 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: goodix - clamp the device-reported contact count
Message-ID: <20260615184204.26707-1-hexlabsecurity@proton.me>
In-Reply-To: <ai8WppWIAsSKXwFk@google.com>
References: <20260612-b4-disp-6844625d-v1-1-df0aed080c9d@proton.me> <6f529998-2b4f-441e-88be-fbc4eb33461c@kernel.org> <ai8WppWIAsSKXwFk@google.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 015c4a268d4c00687fa4fe4c4dd36dcd7c358dba
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 02:02:27PM -0700, Dmitry Torokhov wrote:
> Should we drop the report if is has bogus data in it?

We already do, for the per-interrupt count. goodix_ts_read_input_report()
drops a report whose reported touch count is out of range:

=09touch_num =3D data[0] & 0x0f;
=09if (touch_num > ts->max_touch_num)
=09=09return -EPROTO;

The only gap this patch closes is that ts->max_touch_num itself could be
larger than what point_data[] holds: it was taken straight from the 4-bit
config nibble (0..15), while the buffer is sized for GOODIX_MAX_CONTACTS
(10) -- 2 + 9*10 =3D 92 bytes. A config advertising 11..15 made that -EPROT=
O
check accept an out-of-range touch_num and overflow the stack buffer.

Clamping max_touch_num to GOODIX_MAX_CONTACTS at config-read time makes
that existing per-report drop a safe bound: a report claiming more than 10
contacts is now dropped with -EPROTO, and 10 is exactly point_data[]'s
capacity, so no legitimate report is lost (the driver maximum is 10, and
the other max_touch_num assignments already use GOODIX_MAX_CONTACTS).

If you'd rather flag a bogus config than silently clamp it, I'm happy to
add a dev_warn_ratelimited() in a v2 -- just say the word.

Thanks,
Bryam

