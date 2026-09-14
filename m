Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC626368968
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401914; cv=none; b=mI7GnFmSnGnBUWeD/dy+8wp69fZyjns0UID9yTak5Ns6Pzd2tDoJsD1/IlBcaHO4jcS95u1A0URgARXycK6NTOybnQw83Izl0Lho7IjK9qWxM0Z4GrsDzoPTLHpbKG38yMXKGlzjY11jxs9FmUSanzcyBfi34APoHllbydljRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401914; c=relaxed/simple;
	bh=ETiqRMut5auMzx5FzHBv2OM0cVxV0ZHY4LQQE7zDbc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QKHT+ig6wZhgF0SYUbbr7uF6lxaTtfFygvJ+z01GsFbbiM1LSaTivrRwn9fD7tNDISmg+lO05/lznDI6JIixPTwCiFauXIZIVQkF4/tFbPK5324xt74N7CYr4402mCMUEzECFgteNTVQHg2y042UnVj5AOgoMtDtNYTP39l9dgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrkuZ+1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrkuZ+1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C21F000FF;
	Mon, 14 Sep 2026 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789401913;
	bh=eYW0si/W2g/JvUAS7aQAlIGaQdeGbEGA+mbkq/iMMig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OrkuZ+1PEhlu4wrQ8MzUbUvOJLoA00AqeOYXR39WDLQfY0I/+YUkJuR5OBRbJDy0a
	 yg7jWmnTBaUNMxRrOxvHWtZl2EiP7c5FpymdONhlk9c63BFxzlJfcXpbRcvr9uM0Hr
	 tlhsGZJBvE8A1Q+myoeTudDK2LPBADwyoxEAvcKMgniWpzKV7/ans1dZR6jDVhJRDN
	 JvC0styfoukZSXXYLUgF7c/Se8Urfsa1vQ8tZ9wrs/otmeQ+A5XEaXqO2UEw1pGqxd
	 kghUGFDw5HoiJHuw39ZIzvNQIK0FMiojAls+laDmlglrd7h677wYTPOMGJ1kxyyOza
	 PvTRHe3/qKCXg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Ririn Ume <ume@ririn.moe>
Cc: Nikhil Chatterjee <nikhilc1527@gmail.com>, linux-input@vger.kernel.org
In-Reply-To: <20260910110900.142615-1-ume@ririn.moe>
References: <20260910110900.142615-1-ume@ririn.moe>
Subject: Re: [PATCH] HID: bpf: Accept 123-byte pen descriptor in Huion
 Frego M quirk
Message-Id: <178940191230.402349.11307545987777903454.b4-ty@b4>
Date: Mon, 14 Sep 2026 18:05:12 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 10 Sep 2026 11:09:00 +0000, Ririn Ume wrote:
> The L610 pen descriptor is also seen 2 bytes shorter (123 bytes) than
> the 125 bytes the quirk expects, so probe() rejects the device and the
> fixup is never applied; the second side button stays reported as
> Secondary Tip Switch.
> 
> The anchor bytes checked (offsets 0-3, 16-17) are the same in both
> variants, so accept either length. The fixup still rewrites the usage
> only after every anchor matches, leaving other layouts untouched.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.4/bpf), thanks!

[1/1] HID: bpf: Accept 123-byte pen descriptor in Huion Frego M quirk
      https://git.kernel.org/hid/hid/c/73712e5e815f

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

