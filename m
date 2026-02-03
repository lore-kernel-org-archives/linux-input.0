Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851A28750C;
	Tue,  3 Feb 2026 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770147875; cv=none; b=tmWhGP02f6Wslx9vrwHta5jiINOG6bkldMY0wwaCO/HiWpHhbAutQDbOmrxKzKcfPB3nKfasiJmMJ96RVbtK2GKwnGwa0UjEFqOwwIns5d0+Dk4qCrd61j5xIa9cgL2HPGAy/QdCyc3qvZcXPN0GM1tXPKqMI9Wh7bT5nN2ATGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770147875; c=relaxed/simple;
	bh=K4bfb34/DBnKRoOm9nx91MrlG7A8GE0he9W9pemyW0s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J0tJi6blJyur28w1bI43vrCBcSpHZgL+UOc3uoQbD9EBt5plYhUqelofxBfhFA28hgyN6kh1okm+cQUJV+wtmF5x6ziEyqkC0heFDT9GjbugZIKdKAueZCEwxwHIm3H1Bav26upHYlhqi9Mi2V6nRhM3JrgM5Mt98V85hVfaGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGbScsZh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGbScsZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4B3C116D0;
	Tue,  3 Feb 2026 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770147875;
	bh=K4bfb34/DBnKRoOm9nx91MrlG7A8GE0he9W9pemyW0s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hGbScsZhgHNP9oLhwfUGDxMnVHR8mu7UJg2qRTHReE9PtyusPBnIS3Wcg4XoL2TIy
	 ptJ9BpyIgu8E1bZak8lVg/eHZNy83db1W02UtbU3AMkS5ZKHo9eQINlxghiOlRWV5Z
	 z0+YF14RjwlfQlDQNFhTFFl/oKoRX1K8xRWII1ifG0KPD1BWLiMsyCBUyJhzv/BHFa
	 u9pc2+hvAd1ba7tyiK7ZPJOO8Y/IyM/Nwzqx0hTcdQlzOvSWkMJhCF8BsBdYwLVB8F
	 Da/EYxaNs+wotLie6hVJMGkFkHIuCrNG6dv29bZVwoDaP0DF3IZ+bASdfLU+jKufeX
	 abekBinZH4tqw==
Date: Tue, 3 Feb 2026 20:44:32 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Denis Benato <denis.benato@linux.dev>
Subject: Re: [PATCH v12 00/11] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
In-Reply-To: <CAGwozwEtW4+ke4p-o0+92Qv-03pkVTMt3UUAJfH_o69376pJog@mail.gmail.com>
Message-ID: <nn9n7868-3po1-1n27-347o-936onrp4p002@xreary.bet>
References: <20260122075044.5070-1-lkml@antheas.dev> <92095q4o-n2o1-p4or-n238-o1ro83616o37@xreary.bet> <CAGwozwEtW4+ke4p-o0+92Qv-03pkVTMt3UUAJfH_o69376pJog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Feb 2026, Antheas Kapenekakis wrote:

> > > This is a two part series which does the following:
> > >   - Clean-up init sequence
> > >   - Unify backlight handling to happen under asus-wmi so that all Aura
> > >     devices have synced brightness controls and the backlight button works
> > >     properly when it is on a USB laptop keyboard instead of one w/ WMI.
> > >
> > > For more context, see cover letter of V1. Since V5, I removed some patches
> > > to make this easier to merge.
> >
> > So I see (because of the conflicts in linux-next :) ) that this is now
> > sitting in kernel/git/pdx86/platform-drivers-x86.git with Ack from
> > Benjamin.
> >
> > Where did this Ack happen? I don't see it neither in my inbox, nor at
> > 20260122075044.5070-1-lkml@antheas.dev
> 
> Mmmm. From my part Benjamin's acks came on V10[1]. I think that series
> was for kernel 6.19 originally.
> 
> I b4 to develop the next version so they were carried.

Ah, I see, thanks.

I guess we'll live with the conflicts between the trees for now then, and 
will make Linus aware of it when sending merge window piles.

-- 
Jiri Kosina
SUSE Labs

