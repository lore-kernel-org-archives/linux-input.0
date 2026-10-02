Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7547DFB6;
	Fri,  2 Oct 2026 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932458; cv=none; b=BUoHJZl3oebiXUcv6QHIf8mtBip3p85MqpFAZaKNA5aR1VincNpgnhO+NfZP/8Fc8mLvdh4ibhwuKOs4SMEIaqJke0zGF6KAZjau0v3q88Key9qE9S3wZvv0nWh0qSSdXjxjuRdsk45dasWcr0GAFEdx4GvMSNM+1BpRHCcuxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932458; c=relaxed/simple;
	bh=xje1qa+XqpjCxK7Hf365zVzPjInNKAL7/44wJiFWht8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gauvmuLEsIwRfeZ7dofVMkE2XY0B7W9nRJOtOHhVwGL1CLkyi1bOgsjF2E/Ljg3xCCgNGkaQnBEm9E6ypClBkYX+5HyDsyWyQcHXckPfFdGCAyzwOtalEjho2h9dIzj968f8p2z1P1ze8g3+ejTKXsnUcFR3JKaVwk97czZzr/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MShTwfyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MShTwfyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBEB1F00893;
	Fri,  2 Oct 2026 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932457;
	bh=u4nUaE6X06J6oJaNon/hWE7dB7yD2iszAa0UbIzs5RQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MShTwfyikkFeTUYy4nEPIuJNnB61kC1d3oOfWdN+cwhBu4Y1Lh6/fQvon4SYQ9yHv
	 WgbYtci233c+THa1vVdEt178iWZW+UDesIaTHx4Vcfd6BNO+fSJ17h/0IUX2W26p7a
	 8QaSJf9nUzG9sEu4aSZhDfwx7Cud4oUGWxxAXFrGTPfOkGYmKw6gTabMeB8rsGhZKY
	 HbjnTI9Ca2gKNcaSk8FOZCy9pAK86KFEeudCvcjEeFpcwV1bBhVkrHkubP9pnj6ixU
	 yYuhn8o3wedlb3hohfjMS8LFrAum2VMDKShBCy23x6NoliLkaHgzFk57jW6LBEqbLr
	 F5ZKCocccdS+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 05/12] bpf, tracing: load the vmlinux BTF
 where tracefs and bpffs requests start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: linux-modules@vger.kernel.org, ojeda@kernel.org, bpf@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, gary@garyguo.net, linux-trace-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, sched-ext@lists.linux.dev, linux-perf-users@vger.kernel.org
In-Reply-To: <20261001225214.12351-6-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-6-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:16 +0000
Message-Id: <20261002091416.7DBEB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> With CONFIG_DEBUG_INFO_BTF=3Dm, bpf_get_btf_vmlinux() and
> bpf_find_btf_id() do not load the vmlinux BTF: loading waits for user
> space, and their callers were not written for that.  Besides the bpf()
> system call and /sys/kernel/btf/vmlinux, some tracefs and bpffs requests
> need the BTF.  Load it at the start of those, with
> bpf_load_btf_vmlinux(), and have the code that only uses the BTF if it
> happens to be there peek:
>=20
>  - Reading a tracepoint's btf_ids file (events/*/btf_ids): built-in
>    events use the vmlinux BTF, and module BTF is only registered once
>    that is loaded.  event_btf_ids_read() looks the BTF up under
>    event_mutex, which the trace notifier of the btf_vmlinux module
>    takes, so load it before taking the mutex, on the first read() of
>    the file (not again for the one that returns EOF).
>  - Probe events with BTF arguments ($argN, argument names, $retval,
> [ ... ]
>=20
> With CONFIG_DEBUG_INFO_BTF=3Dy bpf_load_btf_vmlinux() is
> bpf_get_btf_vmlinux() and the BTF is parsed at boot, so nothing changes.
>=20
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D5

