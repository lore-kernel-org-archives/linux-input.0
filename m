Received: from a9-39.smtp-out.amazonses.com (a9-39.smtp-out.amazonses.com [54.240.9.39])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB943438015
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154082; cv=none; b=glHuuEEYKO0rqXzDsji18+V6HotJtbZD7nRP51eizSzt2S+UbwM/k0+MJGyLRqkER4E/uqWQi4gVgt5YhvUBbSFDXUigsZm5mXzaRiiaBLLymdO/QAxvCpoDPbqaRmWoOHoHjWV6eL4IPINHUJPEzFu9hnLX9BNgK8bwQGCj9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154082; c=relaxed/simple;
	bh=HUlPAADvidL6hyzJ3tzld68JTISaEtOuMaiBF5qX9jo=;
	h=In-Reply-To:From:To:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=NlFVF5YU19FJmJFJbJ9rB8jfreU3TTJTnV6B9tYU9JbQguxjktm+XYG87MlW+kLN8uQ7jt3TAMn/NmpWKjLIC4tNHP5oyLY2iX+7O++49ZjF+QqdjicVDRdMsPf0D4fbWx5bEVTPgkKCQ16ecOCFJr9VIgsctOqu8XWXws8Toxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=send.bugs.sh; dkim=pass (1024-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=VVC7JtXl; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=BRJYYqox; arc=none smtp.client-ip=54.240.9.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="VVC7JtXl";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BRJYYqox"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=bugs.sh; t=1789154071;
	h=In-Reply-To:From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=HUlPAADvidL6hyzJ3tzld68JTISaEtOuMaiBF5qX9jo=;
	b=VVC7JtXl64j7s0WPReGFInn7iH0holjtt2S8CJAAMIwBP2I9rUiR0UdPziASwtxQ
	oifAPhwrEh6Sm3KZIzW2SX1fR6CW84TxWNwyXoIEQl5Q171Uyi96tzWoE+7suTO7Nh1
	QWpC+3TvS7X94i7gRLr3sDmzTNWkeFpsbnw20QWI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1789154071;
	h=In-Reply-To:From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=HUlPAADvidL6hyzJ3tzld68JTISaEtOuMaiBF5qX9jo=;
	b=BRJYYqoxLhVamIONdagQ3anumE9rDgG2BYmahwolSWnjKM+acz39RSnmKEL2kiiA
	kU/JSxqB9Ig1zxMjx+zkf3MFeU/SKqdGQJMhqtQAXwqz8jph78IouoF8EmMKjGQrFRX
	cLHl+XdxEyaauyKBqi/B6MH3GoNw1BInQZnSVMjY=
X-Forwarded-Encrypted: i=1;
 AKwUvBzA4vzeWQn0iC76LgweKdhAAi+14KLJ3pxGrWf6UKv5J2tV+K4kPrRzWuse7GJbBGqWikusyFGh19hZMw==@vger.kernel.org
X-Gm-Message-State:
 AFuF++ljib69R8k3XZE9V8DyqyMTiyOru+0VRHULO6JPei+kwivfG4lo
 LbkTRsvAESRTCwbTyuFTHasr/aJoWjDzVJHh+gHjN15R/iOclUc9+Mv5PUvig1/krHzE48L7rH7
 P/lOB+wJud9phEbwwFBywN2DYe5InJEVlkU9BVYvz
X-Received: by 2002:a17:903:8c4:b0:2db:2ae9:fab3 with SMTP id
 d9443c01a7336-2dd2a33680fmr105724465ad.11.1789154068854; Fri, 11 Sep 2026
 12:14:28 -0700 (PDT)
In-Reply-To: <2r7082oo-1qoo-4r04-6nnn-r193s5n91rns@xreary.bet>
X-Gmail-Original-Message-ID:
 <CAPpSM+ReEBaJgCAOf=3H6wbKpjbC9SPiYgdMaCnpsWQKiuBQUA@mail.gmail.com>
X-Gm-Features:
 AcwNN1WdIsIOiR1pO_tErYl77QLKrD7_KPBoD3tNcbkSMT3h5J-XGU5GFiLqkU0
From: CO <co@bugs.sh>
To: linux-input@vger.kernel.org
Subject: Re: [BUG] drivers/hid: use-after-free in u2fzero_recv()
Message-ID: <010001a091e48f6b-ae465cb9-05fe-450f-a553-e16211dc3129-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:14:30 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.yL0noGNZdXCKlJHw27bHz8/I7/GZTaYDRe4l4bGvzjPa1Q4S+kzxKgpyYIxfCxOFAjHX6QJhZdsZN1SP8V3NfEiLJ34m58z2/mmJDZ5RtdRTZ06dzneIWyoUkJ1DSaTbU2HlPz+Zb2/NZ41D3j4FLWNy2FyGjUOa4qpft7gzKcs=:1.us-east-1.QSNtDRXSTq9sAuvRl56h5mypgasnQ5yDLNpVzTnziu0=:AmazonSES
X-SES-Outgoing: 2026.09.11-54.240.9.39

On Fri, Sep 11, 2026 at 7:54=E2=80=AFAM Jiri Kosina <jikos@kernel.org> =
wrote:
>
> On Thu, 27 Aug 2026, co wrote:
>
> > We found a bug reachable =
in:
> >
> >     path    drivers/hid
> >     crash   use-after-free in =
u2fzero_recv()
> >     commit  6f232446a629 ("Linux 6.12.77")
> >
> > Config, environment, the sanitizer report and a C reproducer follow.
> >
> > =3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     If you patch the bug based on our artifacts, a tag would be
> >     appreciated:
> >
> > Reported-by: co+b240dc164119a46c@bugs.sh
> >
> >     Everything in this mail is validated by the reproducer below.
> >
> >     We also hold an LLM-generated root-cause analysis and a candidate
> >     patch. The patch passes an A/B test: the same reproducer panics the
> >     unpatched kernel and runs clean on the patched one. Neither has had
> >     human review, so both still require validation before you send or
> >     apply them. Available on:
> >
> >         patch.diff  https://bugs.=
sh/b/b240dc164119a46c/patch.diff
> >         report.md   https://bugs.=
sh/b/b240dc164119a46c/report.md
> >
> >     This is an open science project=
. The code and the full set of PoCs
> >     are not public at this moment, =
as we intend to disclose our findings
> >     in an ethical way.
> >
> >     Happy to test patches. Complaints and suggestions about our work
> >     are welcome at:
> >
>
> Could you please submit this as a proper =
patch [1] so that you can
> properly creditted for the fix?
>
Hi Jiri,

Thanks for your suggestions. We are sorry for the misleading report. We
have updated the report format so that it is correctly stated as a bug
report, not a patch. We will also state that the provided patch is
LLM-agent-generated. We do not want to overwhelm the maintainers with
low-quality patches, so we choose to send the bug report, and we will
spend our time working with other contributors to close these bug
reports. This is mainly because our bug discovery is automated, but
patch verification is hard and cannot be done reliably by an LLM. So we
decided to report the low-severity bugs like syzbot and ask the
community for help.

We could provide the patch in ready-to-send format, =
but we worry about
people sending it on without review, so we trimmed it =
and kept only the
code change.

Feel free to tell us if you have any =
suggestions for our workflow.

Xiang

> Thanks.
>
> [1] =
Documentation/process/submitting-patches.rst
>
> --
> Jiri Kosina
> SUSE Labs
>
>
