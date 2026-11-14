Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794652177;
	b=JXQBYQAQzel0O8vRPxWytwpAN+9P+NWU8Vs0UDkxHHrZ3ld8FL/icDAqKH3JCHoRVp++
	 UvP5KA+4Q56yKo4Db1e2DXRxXn2EQIdnBYbkBvmQR1DSTnb+BkaLN2w2sVzzpUpKHHXlt
	 qYQnOL91f4ojl2vthFwpIb6JLt22paqNSGvODf1MojQYxnuT/mD9IckMrj03e+vdPRvkO
	 /OVQafArRzPJjOJlxfMPPYZQwPhxUGaU5+MDarBUQWv8+HdVTi5wUAHhhPW+5QdtReeWj
	 YMRPV1DaeTgegqIsWsK2rFXjDdfWF9QmLsV9PKQJjZyDZTp1mPwP71Z2fCj/664BXzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794652177;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=uErNLi/2OCf74YqDJoADHzHPm15XqcJZ+OFir4+WK/E=;
	b=f11+CJvHjYx5RQMxdJmjvQwaPqISJqccKAdZpZqSPWkjC57QVJZR7XzA5Ev9OYVk041m
	 fyoP4eYpBGx2/r2bO2UNoMFmi8XGgwwe8Jk1+U4qIbPiMls5CK22htuBsiIdoH0llBxZi
	 YwwmkXj+/PjH90AjxK75+xTF+ilV7Y5WaOz2+nxsiNeT0hpS1GRp35Dl64CIVAO2Bo+lS
	 i8J0H8VwOv9N7Gzf1PvjVgvG2wJIRsifYZzP5mig8zdJxwK58WAr+X3dh9hx3FhAice/o
	 HflK1IoDzZi4mjk4ESwKGKlXX4OX+SSsjmDZaIhH/1IU7iFaYBspVt+LPs8LW1hx9iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7vsuyjR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB3D606A32D;
	Sat, 14 Nov 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7vsuyjR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088281F000C5;
	Sat, 14 Nov 2026 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794652176;
	bh=uErNLi/2OCf74YqDJoADHzHPm15XqcJZ+OFir4+WK/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d7vsuyjR1VDuLpCZaVnAcs97CnN378lybAxntYArVAIWpBO/G0QY4MowNay3RH1sJ
	 I/+m4hpMxB6GpMKWDbzb8qtrLlBu3YtDeZvzwuhnMB/yA78hJusU853lj73XvqfQKc
	 EvGzykvrbS4lq/1O6DTLRc08TU7xDNFp/dLuKD+MFITdLvet4hGZDl9JAlBCEPF0xx
	 ij3wqSqFhhR6i0TtGjKrrnP3Z3PpGxrdb9mdx3i2B+5EYxPu0H1yqZC4/aKDGWNr5j
	 ij+bUDu6z74RwEA9jfNDdUvkLcIIa5ya1qlqC26lt0K0Us0aKw8Yg+9nBBNq8D2ZIO
	 OPqicXdnFAsTg==
Message-ID: <ea4068bc-be71-4487-b286-68f0ba9f4334@kernel.org>
Date: Sat, 14 Nov 2026 11:29:29 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/configs: drop CONFIG_INPUT_CM109 from
 ppc6xx_defconfig
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "Alfred E . Heggestad" <aeh@db.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Oliver Neukum <oneukum@suse.com>, Thomas Reitmayr <treitmayr@devbase.at>,
 Shaun Jackman <sjackman@gmail.com>,
 Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
 Florian Euchner <florian.euchner@gmail.com>, Johan Hovold
 <johan@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Xue Lei <Xue.Lei@windriver.com>, linux-input@vger.kernel.org,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
 <20261112001642.243554-2-dmitry.torokhov@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261112001642.243554-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/11/2026 à 01:16, Dmitry Torokhov a écrit :
> The cm109 driver is obsolete and being removed. Drop its module
> selection from ppc6xx_defconfig.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/configs/ppc6xx_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index 29acc77573d6..4ba35b9377d7 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -537,7 +537,6 @@ CONFIG_INPUT_PCSPKR=m
>   CONFIG_INPUT_ATI_REMOTE2=m
>   CONFIG_INPUT_KEYSPAN_REMOTE=m
>   CONFIG_INPUT_POWERMATE=m
> -CONFIG_INPUT_CM109=m
>   CONFIG_INPUT_UINPUT=m
>   CONFIG_SERIO_RAW=m
>   CONFIG_GAMEPORT_NS558=m

