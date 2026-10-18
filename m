Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA34DE72A;
	Sun, 18 Oct 2026 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359812; cv=none; b=su20MwyFj6matb0QNn58cLcvx3Ry05yFIr4MUZ5eR8hdW05fXY5rfwrD7lhj6S93Ai+wGv+G9ZWMxvtMPn4BqVwuI3Xslj1Hj6CX4PaOuOMe1l0T5Z4hnhz3BFg4T1ag44Awz8CYX7ybJ3ocb1XuUjFTMgGnNukpcjuXc1CS+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359812; c=relaxed/simple;
	bh=CKmMBP+Iiyl3NMSzjUE9in6Sd3cWri0MchnEzkS2ohU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgZzzcBv4cGJ5mU5KG2MPzDNYr2nhC6qTgG+VWJXI11QTypvJW/a3jp7ANUzU0MjTlwynO5JlnSdIuBBlRGxzbYWul3NUwUUNxcxb5LDMDaiy5HYF0DglLHe48Ym1aSDRhxFv9fFasD9gqshufTEbnbc1y8peCganLzHfp/QkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXzcMMMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXzcMMMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460061F000C4;
	Sun, 18 Oct 2026 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792359811;
	bh=CwAZRqep0Rd/T38v2mnhngdWbyW6rIM0+7tGymfYlNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IXzcMMMWeDuaX53FijgKtoheN9iKXxKh5AbvoNGET59ppVkzK2nx2dv+7n5mEJaip
	 CiTqAu1o9TV5fUG9Fv0h9NjbSBgzbBYgtu4b6WqU3cBZLpW5xeORfKJgLqKXxghoEW
	 gNS0O5fOBF2gOWzsTsAJLzON59Ba0okmsoqBCqZk5DWjJEdO7lb0epDnCwUapduEnx
	 D2owoJwNXsYrD2c8vLw9nvHIDRqnRgaeXZugn+6Fg1gryLNrhLUAtBhsWlpsHZNRaE
	 At9Kr9juxVUR9GGcZRxpcU9zk1R6H+GxPfLZtVd7Nx39OTt47uaSlI+QaVuWvodOun
	 jexWLK3DzwlZw==
Date: Sun, 18 Oct 2026 14:43:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
Cc: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Luke Jones <luke@ljones.dev>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Rebecca Mara =?iso-8859-1?Q?M=FCller?= <rebecca.mara@posteo.de>
Subject: Re: [PATCH v3 6/7] HID: asus: add prod-id, quirk for Zenbook Duo
 keyboard
Message-ID: <20261018214326.GC4068315@ax162>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-7-p.pisati@gmail.com>
 <42cfc8c8-869f-41e2-a58c-0d6c5ce4a6ba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42cfc8c8-869f-41e2-a58c-0d6c5ce4a6ba@linux.dev>

On Sun, Oct 18, 2026 at 06:57:16PM +0200, Denis Benato wrote:
> 
> On 10/13/26 12:40, Paolo Pisati wrote:
> > From: Luke Jones <luke@ljones.dev>
> 
> A piece of mail header opening a commit? Never seen this.
> 
> I'd say remove this: that this comes from Luke can be deducted
> in the Signed-off-by.
> 
> My question is why has this not been accepted before? Did I miss
> this while we transitioned maintainer? If so apologies.

This is standard git send-email behavior to signify that Luke should be
the author in git when this patch is applied via 'git am' but Paolo is
the one sending it. If Luke originally authored this patch, then he
should proabably be the author in git history, especially since the
signoff chain would make no sense otherwise.

-- 
Cheers,
Nathan
