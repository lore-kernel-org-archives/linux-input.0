Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185622;
	b=Pg7B9aKu++459C2xb7vV43ekqokmLtkk8/drvziOFa2qrXg8DEMo2+3Ckgqz3Gd97Egm
	 Qiwl8Ag4pF0LZFLWFlL3n/t21iSaBIJI4y2ZeCfBcKoc3g1qYOG5mpfw7CiXVNvG7HWPr
	 SK1dTuBH1pXQRVOGTAJG4lVi+//vXnGDOCTkjkYMLZmgAJDmtJJUBheEGexjMoAuxMotB
	 LTSSh7qJjrL5yLe3rKVgkIlLn7a0HQOfexVg7fzsDbF2sRxSM6uSfo/AwdDkCl8kOkD5y
	 2nGijO/0qNy/4zDkRF0HvkgPRdydO7cPVO1TOVDPh5cx6Ht6dndf4QXsyyTs9rQUg0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185622;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P9LDLNCB5t+kwgP7wUKvPaKDbXLjGj1S4WxN5boBzXw=;
	b=qRk/zrCxEXaTXE3VN6G4iwbEgGCINk373vxmIbUpZWe3Ve7olhJ9ubOhs/ESF/EdSzBB
	 5Ozc1ivtKX2zjIUgDJW3TCaQ3WCt/AWtGqOqvd0BoycjfMnk8idyPvZys7zSFZuSYajpa
	 096kq6iWdxyJbr2U9ULMOOCbwUIPhTo3FCcVnXGHnEAV38ljQ3PYHjB2Lgk5UJ8IY7z2h
	 hqjzNEplGfmFNaFZcTYQsDvFhxrU0kKV16m1YD4WFVJjEiVAq+6jMdl8FzRrLTN2Mkg4E
	 OOL6TYE7Y9D/OFHb32Ay0Juu2tgJpVEWAxxxxKAi0TKFUOkKBVprx5DzXQb+RTlbMSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C6TwMIc/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E9606A31A;
	Wed, 28 Oct 2026 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6TwMIc/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086DC1F01825;
	Wed, 28 Oct 2026 11:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793185622;
	bh=P9LDLNCB5t+kwgP7wUKvPaKDbXLjGj1S4WxN5boBzXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C6TwMIc/JDKleZQDR8HnI3FQaQHUZdd9qp/ekF0tDsEpURnLjcz/F0m0TnqVuLQTs
	 O0HIYXZIW3yJf7IbLgBCoeyX+1RtNAUiOoOLgYbZvncsIbxCDP8abPRJO/CCGGQwwY
	 3I5ijDvIeUiBTxaG6II189ErftHl8SYB6qZfIF/BOReGRsPqCbu6CziddyCntPESwv
	 crHgU1Y+GRsRPi8tz8bV+7h5Dhz4TRf+oUf/sx8f2J8prXKdCW54NbTQToQht6DI3j
	 vphD2hIU/ramvbyyjtjbrR6ts2OrwsA/BRiesnL7FfuUQ66PcqiVCiL8isekG8xY7g
	 ga9NPBpimTetw==
Date: Wed, 28 Oct 2026 12:06:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, Enrico Cic <enrico@privacyrequired.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/3] dt-bindings: input: Add compatibility for Awinic
 AW86224
Message-ID: <20261028-invisible-malachite-agouti-99fcf6@quoll>
References: <cover.1793135056.git.soyer@irl.hu>
 <353fe3fa68e74c46b88df51b303a7d23235d5ea7.1793135056.git.soyer@irl.hu>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <353fe3fa68e74c46b88df51b303a7d23235d5ea7.1793135056.git.soyer@irl.hu>

On Tue, Oct 27, 2026 at 11:01:23PM +0100, Gergo Koteles wrote:
> Add the AW86224 haptic driver to the binding documentation for the
> AW86927 and AW86938, as this binding needs the same properties.
> 
> They are not compatible though, because the chip identification works
> differently compared to the 86927/86938
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> index bd74b81488f6..655633527c01 100644
> --- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> +++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> @@ -12,11 +12,9 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - const: awinic,aw86224
>        - const: awinic,aw86927
> -      - items:
> -          - enum:
> -              - awinic,aw86938
> -          - const: awinic,aw86927
> +      - const: awinic,aw86938

I do not understand why you are changing this and commit msg is not
explaining that. You only say that new device is not compatible, but how
is that relevant for existing binding? Anyway, separate commits with
separate reasoning.

Best regards,
Krzysztof

