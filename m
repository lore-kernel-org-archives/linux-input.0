Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5243C5848;
	Tue, 12 May 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601228; cv=none; b=VP6P4DFpIFLAP+ZZ/1gn4+6rbqMWnimcPBQ518wVs5PPx5PhWsqY7TuEK0Nf7UiCcpmvSvoR7OAVI7Lutqs5afLo/U9xli0hvtIclEQZjVJdI5VqPUoxh/Lf2D+sMKIQPl4fKQgHer4MFBXlPKrIqXRhzDoFKUybfInZyDfHI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601228; c=relaxed/simple;
	bh=EwTpDEtSdJkx8d0/daCuqXASYQKHVBQaEek5Bp6KQ0M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uAwC8FBez9A3uoLmBNx8zlpRjUeqPRMQA5tmwWT8JGEN3L7VIiH5vVC/bij/yvFImykRZY2qZvZPrQVHnGsvlJ4KFmD0v9Yg/7E4p8FCYQTMO9FLRh/wSZ+MYqxK39kw8kYSer0r5pBJx19+L0809jLaopNabi/xOq2wEOAsPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgykbTIq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgykbTIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A389C2BCB0;
	Tue, 12 May 2026 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601227;
	bh=EwTpDEtSdJkx8d0/daCuqXASYQKHVBQaEek5Bp6KQ0M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rgykbTIqUBavIAzKd/aqb01djxAeQY1Jbif7sBf5yZniYJi6bqIDscwsFH7hDyY/L
	 upKM0O47ENHfVdRDd7biMMK52K6D2Wddrf/h6q0GrLi0dzBNi6QSbHc4+3kkWrLL/Z
	 UCphqsXSK8l6JjvrmTpzM9eJGPjJqjgoQSswaiRTC/fjqfKtXcIwkS4NCqlD2xqbDx
	 hmVclZh99gT+YTPB3BA3Ib/vX030yfWRwiF2ZYza6dqICrdK7XQnK+QjAHUCopP5gS
	 VYgp2WvQmUq1SxywdgJwMSxxa1Is8E2kJlk83Lg6p2WbtK/DwTUSUeYKxOzofx511C
	 y5W5uO3h7oCgQ==
Date: Tue, 12 May 2026 17:53:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Damiano Gragnaniello <damianogragnaniello@gmail.com>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] HID: magicmouse: add battery reporting for Magic
 Trackpad v1
In-Reply-To: <20260416143323.418078-1-damianogragnaniello@gmail.com>
Message-ID: <6r098297-s472-4qq8-pr31-snn052604pr3@xreary.bet>
References: <20260415155548.927385-1-damianogragnaniello@gmail.com> <20260416143323.418078-1-damianogragnaniello@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 16 Apr 2026, Damiano Gragnaniello wrote:

[ ... snip ... ]
>  
> -	/* If there is only one "firm" touch, set touch to its
> -	 * tracking ID.
> -	 */
[ ... snip ... ]
> -		/* If some button was pressed before, keep it held
> -		 * down.  Otherwise, if there's exactly one firm
> -		 * touch, use that to override the mouse's guess.
> -		 */
[ ... snip ... ]
> -	/* If requested, emulate a scroll wheel by detecting small
> -	 * vertical touch motions.
> -	 */
> -	if (emulate_scroll_wheel && (input->id.product !=
> -			USB_DEVICE_ID_APPLE_MAGICTRACKPAD2)) {
[ ... snip ... ]
> -			/* Reset acceleration after half a second. */
[ ... snip ... ]
> -	/* Generate the input events for this touch. */
[ ... snip ... ]
> -		/* Expect four bytes of prefix, and N*9 bytes of touch data. */
[ ... snip ... ]
> -		/* The following bits provide a device specific timestamp. They
> -		 * are unused here.
> -		 *
> -		 * ts = data[1] >> 6 | data[2] << 2 | data[3] << 10;
> -		 */
[ ... snip ... ]
> -		/* Expect twelve bytes of prefix and N*9 bytes of touch data. */
[ ... snip ... ]

Why are you removing all those comments? (and quite some more).

I don't think your patch changes any of this.

Thanks,

-- 
Jiri Kosina
SUSE Labs

