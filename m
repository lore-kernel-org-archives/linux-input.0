Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD081E47C5;
	Tue, 12 May 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602433; cv=none; b=YSik1+N6iigJXm4en9G8TCtHk7Bavuet475AZZQSFUxuTScyPQCAXtuN8cctjtlJ0aBn61gECQUZv5gaggiaJkOL2j2AIkSyRA9UL4o3xHJwYzq3M3oic9HrfKuQ8oQkDKYRqsaA/UkS5mmO7OnYNNr1iUilAcSZ1jjNdRIzTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602433; c=relaxed/simple;
	bh=Vm59EjF83J5QJXJ+9riKbDWcz6XEbTFFjvMkXT4zM/w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ItkntsKUtHp1d5s03HxVMGo5WZDjhDisqrlRymRbj70hwL+glBj1pWZBQ8As/9LuQNAQdICVU4dFX+Bm6p43UeUfKz/RSI3BbCiPOp9ClYp3HbacNrpON+NvwSqU0RSM9zehxtswheQ1ryRIOpvDxai8+VQN5hPLtECFi3tpGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhFj6192; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhFj6192"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA86DC2BCF5;
	Tue, 12 May 2026 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602433;
	bh=Vm59EjF83J5QJXJ+9riKbDWcz6XEbTFFjvMkXT4zM/w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WhFj6192lPpYZpSiLC7QLyC3CFqdek6XSSPuWR3y7B1PJHyK86Szdj2A0F9/4vYc1
	 b/NkbYTWQ6keWpGV4SvqBOpgYHmcXs5onnu9heR2RJ2v2VwEWP3e+kZqDgDMkp283N
	 DAnRVN0Rnk18kISSEOrpBUm28Ei7TQzXfeOUKBvpaW/HBpaot5rGAkqoZ+dkWy2Goj
	 9NGxaSdFyqDisyGEf0vhhN3wunT+pZ49sSZ89J+6KkDmf5UKBou7AU8ATG+Fn7wrvj
	 zf3Iy7eMOLnRKjy9BZbmhd2cGbXmQbQF0UQoFVSIuIwv9rJtfdVR59DfsNCe2i9YHy
	 6MlnKfCQc1N5A==
Date: Tue, 12 May 2026 18:13:50 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-2?Q?Tomasz_Paku=B3a?= <tomasz.pakula.oficjalny@gmail.com>
cc: bentiss@kernel.org, oleg@makarenk.ooo, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: pidff: Fix integer overflow in pidff_rescale
In-Reply-To: <20260510122352.1161826-1-tomasz.pakula.oficjalny@gmail.com>
Message-ID: <8o17n5p4-n1sp-4914-27s3-14o076n41q66@xreary.bet>
References: <20260510122352.1161826-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 10 May 2026, Tomasz Paku=B3a wrote:

> Rescaling values close to the max (U16_MAX) temporarily creates values
> that exceed the s32 range. This caused value overflow in case when, for
> example, a periodic effect phase was higer than 180 degrees. In turn,
> rescale function could return values outised of the logical range of the
> HID field.
>=20
> Fix by using 64 bit signed integer to store the value during calculation
> but still return only 32 bit integer.
>=20
> Closes: https://github.com/JacKeTUs/universal-pidff/issues/116
> Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Tomasz Paku=B3a <tomasz.pakula.oficjalny@gmail.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

