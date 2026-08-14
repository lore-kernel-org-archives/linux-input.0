Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAF471439;
	Fri, 14 Aug 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713349; cv=none; b=r6ojMkJMhn78mmsqAcQkIlEiG34DXPAJs+cv0buNPikapK3KjSG+uSiaGSlNs6/paAjDmIbXcfaVdTCCb3QbBb1hmeILhx/ecD/oGnu8iahDB6oFmckE7Oz4gQPqlvPWf1H7ZFCkBQA0QGYOG6GPiZq3f/9eTQgr4QaNcTgBSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713349; c=relaxed/simple;
	bh=DLQjGp6ePudgegpMmul1mgvALW+Zp8PqWA9ZdQG3Cg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sQUG0TyI3avO0ZXnYnE53D/3GfAzdx/gMagQ0PDXUkVLlZqffeMbfk0RN7YrRkGgs5inEfrJAP9f6eQVHAxTjuib7QgyShXk7oI/nLyDM8dLkgrBI4HyALuiz/EMCfylsZiSSlWHgLz21QVSv9lRHfeLlA5E5rpU0KH5ylXon9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA3ss6Iz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA3ss6Iz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC51F000E9;
	Fri, 14 Aug 2026 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713348;
	bh=tnWkX7Xygyah7vamKyV/iQW6qqaGOMQM8sLoDGCSIdA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oA3ss6Iz93LrdgScvNqXePFKhWKP0CoBKXL8PgNLHoEkiDxyrlqoQN4Qv+wquuCQy
	 x2uYSrjKn6k+cP1zSfwlfyhbblFKLo8itEOhQNjo7monbZqC/JkEchwLiipYKWsejJ
	 4MYzpN3FjcG9ondW8oeRdkRQGO1tCL24skgJD63SOacU22I/JGp4yb6vp/uZjiDhBJ
	 LH5kIyAQE8GSY/Z1P9+Tg4kIikTnjFzvcdFUUvYKuH4PYGKUGZViC6I7iqRj65QmhY
	 PwAnIXSAB4jAKQwlKtPK7KvsB1uUYwaKjo0i0Ws3RUdauTR3cz3galrmOk9QbH4VGw
	 NsyUZwHD0VyPA==
Date: Fri, 14 Aug 2026 15:15:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: haptic: don't write an uninitialized value to
 unhandled usages
In-Reply-To: <20260808190417.87415-1-kmehltretter@gmail.com>
Message-ID: <o7o32nns-60qp-ps00-5885-48414rqo08r5@xreary.bet>
References: <20260808190417.87415-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Aug 2026, Karl Mehltretter wrote:

> fill_effect_buf() initializes value only for the four haptic usages
> handled by its switch, but writes it to field->value[] for every usage.
> An unhandled usage can therefore receive either an uninitialized value
> or one left over from the previous usage. hid_output_report() then
> serializes that value into the effect's report buffer.
> 
> Skip unhandled usages instead. This also matches switch_mode(), which
> only updates fields it recognizes.
> 
> Found with Clang's -Wconditional-uninitialized.
> 
> Fixes: 344ff3584957 ("HID: haptic: initialize haptic device")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/hid/hid-haptic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index deadab28cdbef..66d90f0f78a3b 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -187,7 +187,7 @@ static void fill_effect_buf(struct hid_haptic_device *haptic,
>  				value = waveform_ordinal;
>  				break;
>  			default:
> -				break;
> +				continue;
>  			}
>  

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

