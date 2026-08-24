Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49F37E310
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608176; cv=none; b=Bgmn2VeAt54pYgMh2oc2Yt3iRuLvbEc4lrlEkT7/tVkSDXI2DpYPi0hK+sCOwYK9z5d7hSdsjmLGVDS1foT1KPzm35kKIu/KOfgjc3NIv7ZGvuCu2oHkysWynFyk9luzv/jkNVD+AKhZ0Wb2ykuEcWrk5NHTmbedbwENRa6Jm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608176; c=relaxed/simple;
	bh=861YM281H21RCYW2UQEiz0XRaJ1DOWnGdGaTwjKmjnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFIDlaIthtZ+Zp0iT/NKPZXCR78yUlg/gmdsz1u5SJu4JXlzgcC7ALnb/Yfh563xK8xBRHRMuM1BltDOhW3648K9SCehgVpuRPrNJwrjjBxKCrJUoX59pMjF8oD0oC4WzN0NnyjQ2d5NTOGjomNII5z3DEkJf06Vu2Xd5K89RAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7Cp4kga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7Cp4kga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6571F000E9;
	Mon, 24 Aug 2026 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608175;
	bh=XQOSdNAXref6MdGIlIu1je4q2aqZmvdKWhuBcGFlczo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l7Cp4kgaOo3USD3gpHj/bs30TsAQXU6BEz7sjfk56cScZtNwiV/PsfPRld4lJ+m/b
	 j3ZDThSeDjFfGkbnS/1fMTLJETa0IEpVGIQnas7VFifR3jODeh0XlJcg0wnHvKHWgb
	 kkETe4qlQws1z9YzpBAXcVR4VY3Eupoeyb7Vt2N0Cc7j66hqgVyaiiFUfyomzcSwup
	 VnJGiqKttXb+H+AckXMYjNMxhiBnr0j5MtinokdhMjqQw0arRdv0YT2BJTC8Y9d5PJ
	 mJNn1LScUCMkznuyCTXK+ta/LDDoYt7dkVvwW16f7f7hhwmqCYydHflCm+BFQu56gC
	 EQBSMQoUH9yww==
Date: Mon, 24 Aug 2026 21:49:33 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Vicki Pfau <vi@endrift.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v4 07/12] Input: xbox_gip - Add security implementation
 from xone
Message-ID: <20260824214933.GA399653@google.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-8-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822021140.1149546-8-vi@endrift.com>

On Fri, Aug 21, 2026 at 07:11:31PM -0700, Vicki Pfau wrote:
> +int gip_security_start_handshake(struct gip_security *security)
> +{
> +	struct shash_desc *shash_transcript, *shash_prf;
> +
> +	if (!security->shash_transcript) {
> +		shash_transcript = gip_security_alloc_shash("sha256");
> +		if (IS_ERR(shash_transcript))
> +			return PTR_ERR(shash_transcript);
> +
> +		security->shash_transcript = shash_transcript;
> +	}
> +
> +	if (!security->shash_prf) {
> +		shash_prf = gip_security_alloc_shash("hmac(sha256)");
> +		if (IS_ERR(shash_prf)) {
> +			crypto_free_shash(shash_transcript->tfm);
> +			kfree(shash_transcript);
> +			security->shash_transcript = NULL;
> +			return PTR_ERR(shash_prf);
> +		}
> +
> +		security->shash_prf = shash_prf;
> +	}

There's no need to use crypto_shash.  Just call the SHA-256 and
HMAC-SHA256 functions (<crypto/sha2.h>) directly.

- Eric
