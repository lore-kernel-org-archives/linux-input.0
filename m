Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794652154;
	b=hBLLkCrTfZzK3RWcagzn34HtynEIdirXAnu8StxqBw6aRJvPHtytElAaoIZ3EQDbpWJK
	 HCrN4QCJMLDQqVy7XSdxxbP2B6iqECE2v5WqGwFw6hcH6NzLx8vOGwo9q5OJTLq/v9uJq
	 bMT+FRzjqtSC8WhbORcCp+DHxPjLtwrq4WwyHOYGzwz2urS1dPQPM29WE7IvzvlkFV9i+
	 Y0GCjQhkwiHotyxMQuSXG9AvSSf8OUSab3HUkRfGLuudQw681gTuC0/abQQqIBhp+uU56
	 ahSb3XpGM/Wz3gQ8iIwLgnbnb8mHXptxkOiXkio4qRqhMFwUE0DKGI5jDokzohd3Kog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794652154;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dcmfpT9IKALT3AMaYE02cIzt82rWcSY8cPriyi8AD/Y=;
	b=PYsP9qhEIvwlMsiILtvosQGpsWfBS1yvNq44ln58M73O26VU4QjKzeqSBAVc81ARjMU4
	 wols4sdDNaGO22mEaayzvf0FBwR28H2PeQFQPH6hMBa049v/bxxwmjYEnDuNeXrLNFwq4
	 g53DA64e4XD4+RkjMVxRNW0/QJpV+IEz48zggGY0DLqh5iRjnRRSDLsCtqQa7KJVlv6EZ
	 PZEpAKWDMlHfY7S/TpbpkPB7LG5ogdxTNBIXWKpjj4b2ZON3WLoWrz4guQ7jl7chbMbQf
	 gFt+ImhY9gIJywrZhceviXonOXEmfCvKwfQrwXb9L9Mws5yBr06iktixrD6wdf8qNmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP+CwZcV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE554606A889;
	Sat, 14 Nov 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP+CwZcV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18271F000C4;
	Sat, 14 Nov 2026 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794652154;
	bh=dcmfpT9IKALT3AMaYE02cIzt82rWcSY8cPriyi8AD/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oP+CwZcVcFSC3QvevnrIzew+WDs8zC9DmXsnq2G/7H2yeFPN+RyqU+HU4xj5HwjQj
	 vHdMlcxd4eI4x7z75kVK2ljbcLX5dRP+Zo6M3RaTut3u/mSirmLQSvVTq172Nn7bJb
	 9eyl2HFHcPGjBIryaGA2CR++sko1J3Tibq7YUBL6wtT8my3PJ12O4clWPxPHXm54TY
	 61O0Jh2IOAVsjHTJE6DNkMelf4Tg/LTPHJSBlWTmN9ctIQM+muyrA7qMEg8RbcISLw
	 3DoKrxM7nVqnTprQqH5INM54aesKZ5kp8+VXvVyix1hqsAxyiDakU4b7I2z4bbjEZR
	 yLVeoQgcZXtdA==
Message-ID: <39b3b80c-54ca-4fee-9a56-bb2999705e2b@kernel.org>
Date: Sat, 14 Nov 2026 11:29:04 +0100
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
Subject: Re: [PATCH 1/2] powerpc/configs: drop CONFIG_INPUT_YEALINK from
 ppc6xx_defconfig
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henk Vergonet <Henk.Vergonet@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Oliver Neukum <oneukum@suse.com>, Martin Diehl <m-diehl@gmx.de>,
 "Alfred E . Heggestad" <aeh@db.org>, Thomas Reitmayr <treitmayr@devbase.at>,
 Slawomir Stepien <sst@poczta.fm>, Jie Wang <jie.wang@intel.com>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 Randy Dunlap <rdunlap@infradead.org>, usbb2k-api-dev@nongnu.org,
 linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
 <20261111215723.3802209-2-dmitry.torokhov@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261111215723.3802209-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/11/2026 à 22:57, Dmitry Torokhov a écrit :
> The yealink driver is obsolete and being removed. Drop its module
> selection from ppc6xx_defconfig.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> ---
>   arch/powerpc/configs/ppc6xx_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index 8aab229fb909..29acc77573d6 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -537,7 +537,6 @@ CONFIG_INPUT_PCSPKR=m
>   CONFIG_INPUT_ATI_REMOTE2=m
>   CONFIG_INPUT_KEYSPAN_REMOTE=m
>   CONFIG_INPUT_POWERMATE=m
> -CONFIG_INPUT_YEALINK=m
>   CONFIG_INPUT_CM109=m
>   CONFIG_INPUT_UINPUT=m
>   CONFIG_SERIO_RAW=m

