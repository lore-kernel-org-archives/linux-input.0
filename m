Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119792;
	b=k/tZUjSYw8P/El7knyom+COLKzUWZM1/ztuMl2vQmovW0721kY4Qnrpga7HS4WSZID95
	 ftD5V8iWZtaJ5et/HxcpluvysqotEiS1KI+1O1sLKI3UpyBvoSfgkzEdj+bp+igJq5vaX
	 Keaju7DevBgGEJmL6LQPzjVHS2DrqByYO4Kc9a69bsqScUWo62v5wxSeuWAsN+YSGgu/m
	 IjZj+rU9M1jAPrNGcd/Ok0dVL37H2dh/hEoIxMe+ERVNe4JiWBuaLK3HMEI8UUjLGUEeC
	 aEl7hE7mUrx6FnO580nzpkGTqfLb4JEnLZHbavg5i3MBnC+srlYc9A+JwIJHRrHebOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119792;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=eL66y0w+JilQBmkgVicVh+XQpgaL6FJvqU23W24G7Hg=;
	b=iYrrVhB71Pw346QDbPvTR0GP+yBN7Dk8P1GbSzqL/zYHKG5eGxu0uEjT081lZbu7NU+E
	 U6EfnpI4/LMGogfLukNOJaQO1gTw5+raFjFyxpcJ7w8QqQMv4LWGG2nA01EA1nRJT7+T9
	 0SkhHtS3y2dNWv6btnGCtalvORJ2hg6+WM+V/aFW0B8jXuJ8CToceBhfP9mra6h6mWBnp
	 4c9zzsUQRRFV6UD7sMzv7N1IKV/YeeBTKgWCa0yOVMLhVulOjXJM3Jn9e375Z15m80asK
	 XU9YHcHVGJdXYV7BKyn/O//DSGfYmJatO36q8W2gOsK9gnyDS7TCu00HMI4cgIzlKdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlzCgi+a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3525E606A337;
	Thu, 19 Nov 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlzCgi+a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F471F000E0;
	Thu, 19 Nov 2026 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119791;
	bh=eL66y0w+JilQBmkgVicVh+XQpgaL6FJvqU23W24G7Hg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=AlzCgi+aMysVMwaD/YqN4Y46Rh2nL3LR7DPQ/z/aZf8Q1TeFngpLd8w3yHg09Dxmg
	 aBZyDKSRBqK8/8mlfqlFg/WEUEaM5Ee4cxFW04aGRPuZGz6i0/YcluuXm8BhMPsL4G
	 JoaZLA2vJTUKW7nyK7HFaecQDgBdgVC2+c8gf84OHdGQ306YYLfUI8U4s2oq4OI+EY
	 y2KJXzkatXo+UB/rY0ThXWEkEf3PNICna8TwQrqAhHVZ0pDSLX+w33LWAw0ym7YOsH
	 SyBNphv7BpU2t0QajWcub5cs0UD/MciRu3V0wFne/L0WWcHgUzwUIaB5exKUqLIdE4
	 XuonERMPcEnVA==
Date: Thu, 19 Nov 2026 21:23:09 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Derek John Clark <derekjohn.clark@gmail.com>
cc: Aditya Dash <mradityadash@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] HID: hid-lenovo-go: fix controller
 configuration
In-Reply-To: <CAFqHKTkStExZHvFKP0Kh8USQaGfx0jXO5QmvY4vNhT0eB6ENSw@mail.gmail.com>
Message-ID: <0110o9ps-299n-qq8r-ro27-qqor7782so77@xreary.bet>
References: <cover.1788222001.git.mradityadash@gmail.com> <CAFqHKTkStExZHvFKP0Kh8USQaGfx0jXO5QmvY4vNhT0eB6ENSw@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 Oct 2026, Derek John Clark wrote:


> For the series:
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

Thanks.

> Jiri,
> Aditya didn't tag stable in Cc for the fixes tags, do you mind adding
> that when you pull?

I don't particularly care about -stable, so if you want the tags there, 
please let me know which ones should be added where (or ideally respin the 
series with the tags added).

-- 
Jiri Kosina
SUSE Labs

