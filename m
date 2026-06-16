Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC8344044
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609908; cv=none; b=uPNOQXR+Z9vKYfT8ZVy4bk2Ssa0vWJF6twrKYh3wogFvJLhxe9gXrruYPyk1/kU+aky7o0JDl0e8jw0l+0K0+gbWcmxp5JwsaYv6LKp9FlUOKx7IP9mZH443xJWvqIotdcUdn/7BKC5XruyOpNfrLtfHSJdG03+43PABVdhNFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609908; c=relaxed/simple;
	bh=aJ+xE83sWQ7/0k4Jyr9wSfU3pKXJIwnUlMM3fEZoqWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ph7kuCMtzIwOHybYBwM559Q5To7XJvVihvbvNWmEGdQpibPuEpS8KanW1SnzjTMQEVqka23ZzAnsQPC1zXVMmXq/Qzh98LdRqdEHpUv4K/JWrzmIKeZL0hoc6N9MuZTBfAV0xshcyJaKakqg1mbyYcXlszVUqIUJwEVwYa1VZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNVNVdcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNVNVdcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1112B1F000E9
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781609907;
	bh=aJ+xE83sWQ7/0k4Jyr9wSfU3pKXJIwnUlMM3fEZoqWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YNVNVdcpEtWnYlBOPBB0mRw/WJlRvk4aI3+YtmDr5CgYTe3nFm7emWXV255TttRAs
	 pxe9fjCsvsdiXFaiAyIs8/dT9oyhjn/84dbmSYbMikvyCU6ODpRhPtrfVcds0vHlKo
	 iLG/bGW/C6pNUlL5mNtNPF+Rw/uuN3Hsj3DSCd7n3F5z/jRX4Lbh2hJeybB+ZMgDw6
	 omkoWEoZ5jM/JvVS1QsGlwnzHErEj17lP/CzETY3+oKiRvihPlKRneW3aK+Xkll0Eq
	 YBRAAA36Cf9wtbvZAn0zEoceZC299xY0stU1+2FCee+sVzJlajl5oix61IUjmwT8O2
	 MGYB7s+TvDX0w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-396775c2720so36056901fa.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 04:38:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YxtQm9qf551AO7OzIP1GLNQ214pVJbtdbE/4OWiKVccKJKzs4RL
	bB8HNzvIDfPaaQJXwEeIZ4DXHqLyq7/EXeHyNgdj8TuEtpkizCAi3vGol0R/M7ZoXM9YN9uuyz7
	n6nniP99KojrKqe9gt/irehj/KEN3P4o=
X-Received: by 2002:a05:6512:ba8:b0:5aa:7ad2:f4d5 with SMTP id
 2adb3069b0e04-5ad30dd58bbmr3723976e87.38.1781609905838; Tue, 16 Jun 2026
 04:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com> <20260616050912.1531241-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20260616050912.1531241-2-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 16 Jun 2026 13:38:11 +0200
X-Gmail-Original-Message-ID: <CAD++jL=xV9BiY2j0oCjL5Bi1EtLk6FvJTW8vnOWKw=uexQ6VGg@mail.gmail.com>
X-Gm-Features: AVVi8CdktNujyP9XezHrLMeN5s12BhnebrS3d-xMGTyzwWXEMRTcm2SXtl8KxKQ
Message-ID: <CAD++jL=xV9BiY2j0oCjL5Bi1EtLk6FvJTW8vnOWKw=uexQ6VGg@mail.gmail.com>
Subject: Re: [PATCH 2/6] Input: mms114 - prefer GPL over GPL v2 for module license
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Bryam Vargas <hexlabsecurity@proton.me>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 7:09=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> As explained in commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE
> "GPL" vs. "GPL v2" bogosity"), "GPL" and "GPL v2" have identical
> semantics in the module loader, but "GPL" is preferred to avoid
> unnecessary confusion and maintain consistency across the kernel.
>
> Change MODULE_LICENSE("GPL v2") to MODULE_LICENSE("GPL").
>
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
