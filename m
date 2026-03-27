Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F32E8B81;
	Fri, 27 Mar 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614373; cv=none; b=r4uCcDoCRLCW9kmXiNwtfBBEDuZJG1EJiVu4IgdQJZW8XCroxvn9lscJDtBFE8QOrB1S6HhVYoCsQess8krt0oxa04AQ6uMvioSpP/GcO639MIado04dqwLUfF0IDXCnq8coilAHbGfvJP7y9g5zN4OPYYRYw9XodtezBtD4Nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614373; c=relaxed/simple;
	bh=zysPZg2APRXgK4mS/g32kzwEz+T2OZD2wnZAnRmkkg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=biSljJqkjUwPn3xiFD0FFV9iWAsML5nnObm7X6y9RPDYPWOdVDuo8WrYi7NxKYfT0/iKTShelwqMiQ0POtJFJ1QNAU/NHKNR+Nlt2H7xU0zRp9Q1p7ghaxoRE7T2n/pVbOl1FGK+Xzu9FxZ0fG8eiC1BZ1TTSN7GnvpLrxM2nDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKFkcPcl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKFkcPcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E254BC19423;
	Fri, 27 Mar 2026 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774614373;
	bh=zysPZg2APRXgK4mS/g32kzwEz+T2OZD2wnZAnRmkkg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JKFkcPcldU4T6ZLRifRrfQmNfEw1dydydkBLpzjA31npAcQ5oRYBW2Yi2mOxo1XpK
	 b1xsYAYLfWbsujmqap8zPOPCKW4wMP3iBRVHgbyJUcZvz6C6wFr+De2vgZD7wMruQp
	 +glNVSM/CAGW5fER/S9JrxIDASh/mcqQrJK4EIwxn1xuBXU/r/v7ekPEegPl4+MhXC
	 oxld2sppFJ7kDdSJS574wR0ZRfj6SeINyB/Ty+Qt/ix55MeEXdTjO9u35CKFVKyuEI
	 uKAZ8xMSrblcqyuMXivOWQy8I2g1PkNlFBYnAjVfsD/qAUXgc8lE5PqYFcof2dY1HM
	 jUFZrC6K7LSsg==
Date: Fri, 27 Mar 2026 13:26:10 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Maximilian Pezzullo <maximilianpezzullo@gmail.com>, 
    Basavaraj Natikar <basavaraj.natikar@amd.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Casey Croy <ccroy@bugzilla.kernel.org>
Subject: Re: [PATCH] HID: amd_sfh: don't log error when device discovery
 fails with -EOPNOTSUPP
In-Reply-To: <20260304-amd-sfh-suppress-eopnotsupp-err-v1-1-20214ca6a2f7@gmail.com>
Message-ID: <2430n591-so34-25p2-0n99-7opsn9nrons5@xreary.bet>
References: <20260304-amd-sfh-suppress-eopnotsupp-err-v1-1-20214ca6a2f7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Mar 2026, Maximilian Pezzullo via B4 Relay wrote:

> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> When sensor discovery fails on systems without AMD SFH sensors, the
> code already emits a warning via dev_warn() in amd_sfh_hid_client_init().
> The subsequent dev_err() in sfh_init_work() for the same -EOPNOTSUPP
> return value is redundant and causes unnecessary alarm.
> 
> Suppress the dev_err() for -EOPNOTSUPP to avoid confusing users who
> have no AMD SFH sensors.
> 
> Fixes: 2105e8e00da4 ("HID: amd_sfh: Improve boot time when SFH is available")
> Reported-by: Casey Croy <ccroy@bugzilla.kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221099
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Basavaraj Natikar, could we please get your Ack on this? Thanks.

> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index 1d9f955573aa..4b81cebdc335 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -413,7 +413,8 @@ static void sfh_init_work(struct work_struct *work)
>  	rc = amd_sfh_hid_client_init(mp2);
>  	if (rc) {
>  		amd_sfh_clear_intr(mp2);
> -		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
> +		if (rc != -EOPNOTSUPP)
> +			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
>  		return;
>  	}
>  
> 

-- 
Jiri Kosina
SUSE Labs

