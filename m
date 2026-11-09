Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208235;
	b=rbeKxJBoZJSNBDG6vTiUHLn3FBKVuqm8kjA9AsAAvapD96jp23ZuwzFB//MCtLP33ekH
	 KfypUYHnhs1KBODI7hI3rOHU7HtiPWMVnoJP6lwb40s6+HEXyHAFx6h37ZC+mwHfV7a7X
	 Djh+7/NvsJWkdkQIDrP880he8EkEgk/PI4b9c4EyMHlkBzsKafhPxLb39Y08VcuOy8IS2
	 r/sB/O4gUymK73v8byoN9IZHe+wtVRPyVT1+1STs3pZbfJBkhRObBy7COriD7zqJ+CyOc
	 TESCLmLJsitsDt1vee/VeDOq03+u+rz7nQEz4iRk//inh5OztwUjoUUuBqoO6WXMtlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208235;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=I3vDrfrHSTXXpn+iUTrYwYMArOS5I1+18oTHiI4evIQ=;
	b=zQk/RJgxFioU1B7GV9sPjqtJJzvt3zbOEsvs+2rmrgIviszkNsS2T2dXQXbLGSNsBcJM
	 xt3MdDGYqte0ziaERsLLqQSHHW+rIz2hUHl9iaATWkeJPhYiM/K7FY+CK1kWlf13QhtrR
	 uJHnJZYm7FPbJWoT0nRmvsxKoIf5Pmh6SSy/ATG6NBoIuQ0UvYW0HEJXN3gUNy+YdA1sO
	 Ny+WasmjwJTpDJ6z9kifnI2+gTB4ZQhbWxQde3u7l7ieynEpsOtESdizxe9u09wBmHMdY
	 K/atkuG7wLawOhbLh5iSZ2MxrytEKDHcDXKd0/ERqNXZteGDwHDCRQojsRKyqwR7Ieg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EetIoBV6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C8E53606A31C;
	Mon,  9 Nov 2026 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EetIoBV6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C58E51F0089F;
	Mon,  9 Nov 2026 07:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794208234;
	bh=I3vDrfrHSTXXpn+iUTrYwYMArOS5I1+18oTHiI4evIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EetIoBV6LRmLhMUnrR814ZowR3ytmIzkrYO48ng98UfEXAXmtHVpCtVvlpB9MNaBd
	 ZOgpWh0jaCFnKtmaUk0yBiRxGAkkiCYBeh3lqU673QorZikiqNf1nMV7I+aa9LE/Hd
	 VodD/SjH7ZqzfYyilmZQGQbY8xPWmyMhheAb6FDoaxeQGkze0ck962Bc4K+Sox2z1B
	 gVehq4HjpwcqychgMtnZ9vFlyCxLoQG3AS20yVaLVihHr8zKbSpca7YactGBR/TXIc
	 ZivMNSjCnARqell5a8De5yNAzUVcvGHuLxxXUAOkLjqCx99vucBN9W4Ad3TK+2gM1o
	 fpZdVV0qALtzg==
Date: Mon, 9 Nov 2026 08:07:15 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Input: apm-power - Rename to apm-power-input
Message-ID: <avFxIyYvPT7W_QvZ@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
References: <20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org>

On Mon, Nov 09, 2026 at 01:25:26AM -0500, Nathan Chancellor wrote:
> When scripts/modules-check.sh is fixed to normalize the module's name
> like name-fix-token does in scripts/Makefile.lib before checking that it
> is unique [1], there is an error due to drivers/input/apm-power.ko and
> drivers/power/supply/apm_power.ko having the same module name.
> 
>   error: the following would cause module name conflict:
>     drivers/input/apm-power.ko
>     drivers/power/supply/apm_power.ko
> 
>   $ modinfo drivers/input/apm-power.ko drivers/power/supply/apm_power.ko | grep name:
>   filename:       drivers/input/apm-power.ko
>   name:           apm_power
>   filename:       drivers/power/supply/apm_power.ko
>   name:           apm_power
> 
> Rename drivers/input/apm-power.c to apm-power-input.c to make the module
> name unique and clear up the error.
> 
> Reported-by: Sasha Levin <sashal@kernel.org>
> Closes: https://lore.kernel.org/20261108225808.1809266-1-sashal@kernel.org/
> Link: https://lore.kernel.org/20261103110411.11698-1-info@daylightlinux.ch/ [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> We would like to take [1] for 7.5 in kbuild-next, so we would appreciate
> an ack to take this directly or a stable branch that we can pull in.
> ---
>  drivers/input/Makefile                           | 2 +-
>  drivers/input/{apm-power.c => apm-power-input.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 

Thanks!

Reviewed-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas
