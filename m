Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E33313E29;
	Sat, 27 Jun 2026 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782596339; cv=none; b=cbY0j7+nhMC1yocCvZ/Qzbg9lzWEFgzKDDHwY8Ti++vZI7jkveQfdoVvZBviR2+tMztgBdOVlwYT8zwk1GHxcq95wfi5KmklkH3HsXpVPtd6TMoriWJFc9Z437QO4Aro03EOishWg57wycjpnFQLI+WMXO0ypTXYT5H4mY43zyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782596339; c=relaxed/simple;
	bh=TMYBMZ7b60V9pA1xG/2ua5+4oeFPX30HOydULRWxRnU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noxTGzebg3uM/cYWBZy8UpKu05Y62u43F3qO+lz0fhCsXL4hr5K2xTpcWovqmiJ1RHNOHrlopA9dgzYzcPKbENAR64VTOZDQuBcSIKg/bWzw17QdKLXdV8ns0lo6n8ljnYp6DkiS/1F15/psFw/7tHFGrbqngkHukN/HxWt359w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NMpGRd8b; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NMpGRd8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1782596332; x=1782855532;
	bh=TMYBMZ7b60V9pA1xG/2ua5+4oeFPX30HOydULRWxRnU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NMpGRd8bTcMgO0cujZ9waQZnQoV5+RGgQgwotnypYh9ZTmq+ybCPsymPPjN4up51c
	 0NMAY3mclCFp0HvveWVB44mA5DZKGHlIi94+pF1ljBX5PZ/3t+a9CfGI+5KbmRpq8n
	 ZMdPtfXhPnNIA5j+eZ3PEpGmGAMYGQdCsgPjbG1WBvnWNtqPELZNZjGJP1YlqWxpGM
	 Uja2IAFlNpz4DxWepDE3bYPbCXc1HcOmtUAnBVPl+jDVqAo2TBvNZxFbV25tGfxizB
	 BZvsPqANcaGF6CUB2Ib2NzqjUb/ncK4o/NgIp0Z+8LebEbtk484V5NkCt9rhIHL6wK
	 htzqOkJ3A4hhw==
Date: Sat, 27 Jun 2026 21:38:49 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH] Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer
Message-ID: <20260627213845.34644-1-hexlabsecurity@proton.me>
In-Reply-To: <aj4LoEHHCMqUnyy2@google.com>
References: <20260613-b4-disp-6721686c-v1-1-4d5bb84ee520@proton.me> <aj4LoEHHCMqUnyy2@google.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 85ee5445d484aa3a31a2484472e6a4e6d1e4304a
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks for picking this up and keeping the authorship on 03.

> there are more changes needed in F54. I incorporated it in the series I
> just posted, would appreviate if you could review it.

Went through all ten. It holds together. A few things worth flagging:

Backport ordering is the one to act on. 03 leans on 02's control flow: its
report_size > max_report_size guard lands in the worker tail that 02 folds
into the single out: write. And 03's Fixes: c762cc68b6a1 (Nov 2016) postdat=
es
02's Fixes: 3a762dbd5347 (Jul 2016), so any stable tree old enough to want =
03
still carries the abort:/error: form 02 reworks; cherry-picking 03 alone
conflicts on that hunk, and 06 touches the same tail. Keeping 02 -> 03 -> 0=
6
together for stable (or a dependency note on 03) keeps AUTOSEL from taking =
03
on its own.

01 is correct but instance-complete: a device honestly reporting a large F5=
5
num_tx still oversizes report_size until 03 lands. Maybe a line in its comm=
it
log pointing at 03.

One aside, not for this series: F54_FIFO_OFFSET is 16-bit but report_size
reaches 2 * 255 * 255 =3D 130050, so past 65535 the start offset wraps and =
the
device reads from the wrong place. It stays in bounds (report_data + i trac=
ks
the same product), so it's correctness, not safety; maybe a later guard.

Otherwise it's straightforward. For the series:

Reviewed-by: Bryam Vargas <hexlabsecurity@proton.me>

03 is the one I sent, so drop it there. On the memory-safety patches I ran =
an
in-kernel A/B under KASAN: the unpatched arm overruns the plane (07), deliv=
ers
the stale frame (06), or overruns report_data (03's class); the patched arm=
 is
clean. So for 05, 06 and 07:

Tested-by: Bryam Vargas <hexlabsecurity@proton.me>

Thanks,
Bryam

