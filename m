Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1C361978
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583907; cv=none; b=HlvtTuRHQVPNiuFLsRXBUupH2KvYBoepAXyRQH3ZJBgYV8Y6ugf+2BAAG6GzGYrZ0PZkZiaIEaihbgXzvLcvzWL1zWIpXEMIu7jIgeMMQFlLTnj/wn6jFJYQ57U5YASz+qJ7w6kNCHTHngS4MEwyFNHErd7OPLeecNAL4r7z98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583907; c=relaxed/simple;
	bh=BTkHktqj+sFaz0Dsq/Unb3DCk69QjF+NOzpynqJERv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlUj+8axNApvqXJakTxgVzAUks4XyeBLWJRg5Ine4SmccXuBnwJiUxZWuH6YuV9cToBsvKfvxy/farFaT+ysSBagUq10QyPdaxzm9snQD7y5dt8ZIcfOxMiek6qjhfp0eFCJjFihW4s5D/HZPwNBXMYgpObpl6m3yZD4Iqe5uRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAH9hkhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAH9hkhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533471F00ACA
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583906;
	bh=RUx3Y2smE+pdSW44cfPQb7+KTnUQGNkmHi+FG0UMvPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KAH9hkhKsey5/jmdcEiaEGIEQGCZGnp50zEPZZO6D1Vk1oWfMtxuKjk/wWyCOUQEH
	 Cu+XzdPjRPFiC5urPBz6oSq/yKIB/CIzKb/eZlDoQrvJshW7rVfI/K/oftOiyRPOmf
	 N6OyxMbqETjne9bxr6b9bmrQKsquFgTmLjw67JI0rjtLLxSWlrnF8ecMcZrlT2rz84
	 hEsvTOohxXIK3+mX08xi6PtwAEUyK0dpZx648lgI1gx/v5f+H52uD4tdoAanGHXPNB
	 ZRSKCIVNswM+ZntWNwZMG8+WoKryvJHQnYQP3XgXrB4YfG8/V04nazbvXkIMg2xr7N
	 VfCH0kmCJ9Z3g==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1677c91969so435874966b.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 08:05:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpuXpFGVHnP8/gLyVeKcYNPBO7faLuwUXSBsKnhB0IDGVT/xfTvmOqccJEcrxKURxuTYFNqlAWPaL4dCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mHMVeAsksZlBxwMt/wtzVhAildOQN3Sn/cmBfNWY4KPPaCeSEF
	RXe/6FB0vdCPUr7QBv0Apcn1V0BtksgOpXFFEd7nybSpDOjfbjs2lx0RunWc3jlChXicbY182tR
	g1+prAY3EPttuv9C1lCbIPaNSK4zIfcGRLIKFFnFtJQ==
X-Received: by 2002:a17:907:72cc:b0:c1f:8145:820c with SMTP id
 a640c23a62f3a-c2492579d7cmr2078800366b.2.1787583905085; Mon, 24 Aug 2026
 08:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoF-jIn9gk9kJ7Pz@decadent.org.uk>
In-Reply-To: <aoF-jIn9gk9kJ7Pz@decadent.org.uk>
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 24 Aug 2026 17:04:53 +0200
X-Gmail-Original-Message-ID: <CAO-hwJJPoemycG8b8tKOuwMBWHnZgYSykvjUswz164XLxLA4kg@mail.gmail.com>
X-Gm-Features: AcwNN1UXsKh9ieKcw7NzvI_UQcPYs1JldLWY7XPzQEjUbd4o_MxG1mFQwiDjGGk
Message-ID: <CAO-hwJJPoemycG8b8tKOuwMBWHnZgYSykvjUswz164XLxLA4kg@mail.gmail.com>
Subject: Re: [PATCH] HID: core: demote warning to debug level
To: Ben Hutchings <benh@debian.org>
Cc: Jiri Kosina <jikos@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>, 1141407@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 11:19=E2=80=AFAM Ben Hutchings <benh@debian.org> wr=
ote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> The log level for short  messages was changed from debug to warning,
> flooding syslog on systems with devices that regularly send
> short reports, in my case an UPS:
>
>     $ dmesg |grep -c 'Event data for report .* was too short'
>     35
>
> Demote it back to debug level.
>
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus=
 memset()")
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> [bwh: Re-sending this fix which was applied and then lost in a mis-
>  merge.  Add a second Fixes trailer so this should reach all stable
>  branches that have the warning.]
> Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
> This was originally posted at
> <https://lore.kernel.org/linux-input/20260523105545.68079-1-technoboy85@g=
mail.com/>
> and applied to the hid tree as commit d0ff08d946c8, but then it was
> lost in merge commit aa776949fb77 "Merge branch 'for-7.2/wiimote' into
> for-linus".

Sorry, but, NACK.

See the discussion with Lee ATM on the LKML[0]

That intermediate "fix" was wrong and got merged while I was working
on a proper solution, which is now upstream.

Cheers,
Benjamin

[0] https://lore.kernel.org/linux-input/aoxcpDR8jnuUA1nF@beelink/T/#t

>
> Ben.
>
>  drivers/hid/hid-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cf123347a2af..605530ec2e9c 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2079,8 +2079,8 @@ int hid_report_raw_event(struct hid_device *hid, en=
um hid_report_type type, u8 *
>                 rsize =3D max_buffer_size;
>
>         if (bsize < rsize) {
> -               hid_warn_ratelimited(hid, "Event data for report %d was t=
oo short (%d vs %zu)\n",
> -                                    report->id, rsize, bsize);
> +               hid_dbg_ratelimited(hid, "Event data for report %d was to=
o short (%d vs %zu)\n",
> +                                   report->id, rsize, bsize);
>                 return -EINVAL;
>         }
>
