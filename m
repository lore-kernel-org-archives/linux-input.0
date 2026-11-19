Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125046;
	b=4evwxNDck2f84fGBOMGkSDCEQ7RVesXFg82hYI66y4LWzZPUA2SweIYhQ/SqUxHJ1MYm
	 0TDviFw/ZAyAFi7pw6b/eTSdUU2eo7jnj6A6ScJm3Ni3Uy9HgNVZkzLI6tJIYpLqFYWSB
	 z9EMN6hhQleDUsuYvLQW/4MU/d222CNFI7gd9d1N4N/+uXeiZuLrlKpL4DmjvRDGJjGIk
	 GWHrCH5eJKjFb2N3QFcpnCv8VT5X2DvGkrQMpwVnRCCeQobBKVTpYVvWNmgU6E4tkvlh5
	 OyDMRaKFcciNZIUS+fL7ShL2ryrV7Tllu5z4aLRdelisFaPj9N98mTl1fXLx7lybvOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125046;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=NKLt1NClIBj1ugn8xKsmxJCnbyETMn/KSJJZjZIID3I=;
	b=2Zy91Qqg4VWCAgdwbaZ4Lu3FrzBSGsaHvV3KEfmtObiDqIdiIFl2IYfHot+50pnAGkC/
	 V704Oe67i/0DXJDPcpgsCJOT+EVRn21gX87CwX+UVNRD8kG8OKEzzkeSSZuhqhUfI9a9Q
	 YkRKVUXhpByILDKcRFga0JNRJ4siasxFbXQ+uD7xFOHaUca6C2GdtXIs8+yL3cOg8GqEH
	 iwWAX6jCfT/P3cZ5knZAXET/ea5T+VQbW+QdKSPMjxyVUk3b5HIBwYC/o33TPW+kVct19
	 O5fAW4QlIPLnjodGomA07EpbGaz7UsXKxO/Af3oUfkcGh2b+C2L5L284GpMgdxeuy4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2kmPfdW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC9606A324
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2kmPfdW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F721F000C0;
	Thu, 19 Nov 2026 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795125045;
	bh=NKLt1NClIBj1ugn8xKsmxJCnbyETMn/KSJJZjZIID3I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=T2kmPfdWwv2MaPMF3L+1eaU6X9EDsgNDHgZOi0302ZbXBO7+5QYXKXSXTkUyWAlgq
	 N4s8/BZoNL2gguaRSABrZ4VD1GMASpq3/N8TtBdTBhkkyyDDUJwbVwrKbeFlCUE0XB
	 g/9fnoLMNfQSvkeGlTfvLE3YJF94UL0HycZEHc2cO0Sacu/3cQL4SW6Te6mmHc4iC3
	 wDhMLuMiy8wPyZkVafwCCatFq43GAc6iJOoynByUEJ7XsHg8GLZhOuTleepe875+HV
	 vSVYZxGiNCtE2Q/4Uf5/R6QsrHy8sv+adukHRMbLLTHyWfIPfgBvgLvxjhyHcLZE2O
	 ROxsSRf95CsAQ==
Date: Thu, 19 Nov 2026 22:50:43 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sang-Hoon Choi <csh0052@gmail.com>
cc: "Daniel J. Ogorchock" <djogorchock@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Changyul Lee <lcy8047@gmail.com>
Subject: Re: [PATCH] HID: nintendo: release the player ID when LED setup
 fails
In-Reply-To: <179001656825.91284.1468613120745540918.idr-bug-07@gmail.com>
Message-ID: <5qs0ps50-5pq2-5497-2p76-2198438so996@xreary.bet>
References: <179001656825.91284.1468613120745540918.idr-bug-07@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 22 Sep 2026, Sang-Hoon Choi wrote:

> joycon_leds_create() allocates a player ID before allocating the LED
> names and registering the LEDs. If one of those later steps fails,
> nintendo_hid_probe() jumps to err_io_stop and skips the ID cleanup.
> The failed probe leaves the allocated ID in nintendo_player_id_allocator.
> 
> Use err_ida for this failure, as the power supply and input setup error
> paths already do. If the ID allocation itself failed, player_id is
> U32_MAX and ida_free() leaves the allocator untouched.
> 
> Fixes: 5307de63d71d ("HID: nintendo: use ida for LED player id")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
> ---
> Found during source review at mainline
> 5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchanged
> at f0100363d8c374bd8e9ea7c9ba02744f0b802ca4.
> 
> The modified hid-nintendo.o compiled with x86 allmodconfig and W=1.
> I have not tested this on a controller or injected LED setup failures.
> 
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 43e0f2aae..bec0e7652 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2784,7 +2784,7 @@ static int nintendo_hid_probe(struct hid_device *hdev,
>  	ret = joycon_leds_create(ctlr);
>  	if (ret) {
>  		hid_err(hdev, "Failed to create leds; ret=%d\n", ret);
> -		goto err_io_stop;
> +		goto err_ida;
>  	}
>  

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

