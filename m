Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927D153BE9
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881804; cv=none; b=Z/nOMk2JGe4787PJnwMU0FCI1kmZ5RCVYt0oKv6mWu4DBafu1Bdx87JW2oYrWJFLo2F34IlLmeid+HHWX0fW9sfHA6k+e9UthPFxzRW9lPvKxmxLCEGihmknBwEcuvWrRyqDfYvcnu5ZHUaKwWMZkfIbQVTpG6Iil2/XzqO7bJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881804; c=relaxed/simple;
	bh=/htQH9DJG1Tjryd+VTe/FSKuO+YVYEmZUb+BfCxAoRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJmhkncI68MATOqiQWdj6JU24xBCfEJ1Rm2pBMAyTY0PfRNu4gnz8y+4I5FgHaoBbtHMBeJAMIDC4xTblGzmBigsCpu8q2OhqejTQA2IuwRJbnyyI+i0u2oDIlwAfx3fR9zFoP0QUyJlEBQbABRlzADjq6T6U8gn1tlnky4oFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fee8Rudf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fee8Rudf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600241F000E9;
	Fri, 28 Aug 2026 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881803;
	bh=jm1/UwY7FYIbpLcVGsCGplGnmjVoYk1eQ4WD8JwbNA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fee8RudfOhyjyjib0nMrZYIwdMBxg/1Noim5XObh1y++15IT6wCOKyOnF1HAs/MWa
	 bBOT6XIS6dT4aOfKSjKM+CqceEcGxp6nSOj8z9u3tGm0Ean9T+jc9bzoYBs1xGNoIm
	 6n1DylyMwocg8khil5nyxkaweMu8HM2GUaLLJKE2ewEV/8HVXXW2WxXHA4lqo52+c7
	 LWiNeuRdHjRkzHiUiifY8VKjMi68Oe0IzKohY17yTolSQJWlv2h1wVSlJao8gUZ1Hu
	 aYwF4viZpMfvYDhn3RQBqUV+omn2BBnC3I1UTPw/8jIwHf884ZzJ9hdD+WHzNBVdC+
	 09EqQs4WwpvAw==
Date: Thu, 27 Aug 2026 18:50:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Vicki Pfau <vi@endrift.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v4 07/12] Input: xbox_gip - Add security implementation
 from xone
Message-ID: <20260828015001.GA1949@quark>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-8-vi@endrift.com>
 <20260824214933.GA399653@google.com>
 <e554318e-77ab-496f-ab85-c2c5d7273eed@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e554318e-77ab-496f-ab85-c2c5d7273eed@endrift.com>

On Thu, Aug 27, 2026 at 06:40:01PM -0700, Vicki Pfau wrote:
> > 
> > There's no need to use crypto_shash.  Just call the SHA-256 and
> > HMAC-SHA256 functions (<crypto/sha2.h>) directly.
> 
> This code was originally written by someone else more familiar with
> these functions than me, but it looks like shash_transcript gets
> finalized repeatedly without being reset. See
> gip_security_get_transcript, which exports the state, finalizes it,
> then rolls back the state before finalizing it. I don't think this can
> be done with the basic sha2 functions.

What do you mean?  In the library the context is just a plain struct, so
you can just make a copy of it if needed.  Like this:

static void gip_security_get_transcript(const struct sha256_ctx *ctx,
                                        u8 transcript[GIP_SECURITY_TRANSCRIPT_LEN])
{
        struct sha256_ctx tmp = *ctx;

        sha256_final(&tmp, transcript);
}

- Eric
