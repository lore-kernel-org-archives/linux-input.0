Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124206;
	b=nWdDhsjI3kBwGAZ6q/BpSKR9AlahGLqXpVPaBA/Efl7vXCr3FqBs5mzYhxAvsS6r+5Kg
	 xTrnKK4gtw4UFnq/GolATMj7EWIzGa6YnpUe314MKMmyOQxR/75bGgbkvjk7KsxkRNuW8
	 DWX5jymKMt5pVN6XyaIlM02yVxPkjj7/2R1hnB3DuDrAbSi9nom3CAcTGOUi+Xs1xFfoR
	 3bruxt55oB34YdnAthEAfCTYCW/OOfKOeDGByDKoc+2B54Rypd49heN+J15gGsnRrMq/l
	 LmwOh2S22uNdgID6dBOiyWJJCndn0QJc1oem5CvD3ZueTSbHWEBJJilajJKvUV82cNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124206;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=LML88oLR/JHS1tEWSCvh0L02QsPi7WMgIFrwWVKms/M=;
	b=KY3ArKph8LLOGacZUSc/QDnJeOWGKGYahVE7zfFgjmjeizeo/su9CFatkuOzPY88qi4W
	 Z23Z+2W+z2oOdKMFIVlI504bm0A8eDPImCuh4KiQH+7KhXoonC/sHKnQwrECP35q2X4gL
	 rJwDmItuLe63NCJtAbp7oY8kvQ/Ks1mGdf9HxC946jtJrKo9uoFQJlhbmRQbqIPR9rflF
	 knkPbjtevX0PeMrbbW2JXjFjDrEvcbxGT9HDVwHWtlKtk1VCE+kjUPw1lRxSUciNAAoDW
	 JwfaHLZEp+DZRWgt4HM1qsE0z/Hui3E78w50/tGcWo3h8k4vWa3p7SWpR2ZYnt9ZmSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O/TgTy+s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD9606A324;
	Thu, 19 Nov 2026 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/TgTy+s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDFC1F000CA;
	Thu, 19 Nov 2026 21:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124206;
	bh=LML88oLR/JHS1tEWSCvh0L02QsPi7WMgIFrwWVKms/M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=O/TgTy+sLb1MSXnkpbF0WehAIrZR/vY7UOJEHvHD5p0QO8fdODWxouMv2mzEQSyiW
	 lNUVvMwCYR4R13NMdQR/0BXYNtJzyges6Vg+8rthsGRY9630gqarqIdywRLMhqQQag
	 cujl1vNX9cLs8Qh9cSL+zER2pvFOMBKOqlUp6gGb71/R2CFZDu4i7wlueGTJ0o3WiY
	 kQ+5wtmGBFjrYI8Lyo6KON+RPWUT/UszrF28D2QBPZUorbX4frCaTQK47msynr7QnK
	 py6IgYLUl30n77eQ24+joDBTNbcjUXeV1Umm/XzLZCUtTaafKX48JecML6gQP2U5jq
	 Ew/G02yAO5low==
Date: Thu, 19 Nov 2026 22:36:43 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: David Cemin <dcemin@nvidia.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-tegra@vger.kernel.org
Subject: Re: [PATCH] HID: asus: map Consumer brightness usages on I2C
 keyboards
In-Reply-To: <20261020220919.611287-1-dcemin@nvidia.com>
Message-ID: <99s8sr4o-0498-824o-n90p-2rs7o0r40s87@xreary.bet>
References: <20261020220919.611287-1-dcemin@nvidia.com>
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

On Tue, 20 Oct 2026, David Cemin wrote:

> Several ASUS laptops carry their keyboard on an I2C-HID device with ID
> 0B05:4B42, the same ID as the Zenbook A16 (UX3607OA), so they bind to
> hid-asus with I2C_KEYBOARD_QUIRKS since
> commit 206107536018 ("HID: asus: support the Zenbook A16 (UX3607OA) keyboard").
> 
> Unlike the A16, which reports its brightness hotkeys on the ASUS vendor
> page, these keyboards report them as the standard Consumer usages
> Display Brightness Decrement (0x70) and Display Brightness Increment
> (0x6f) on report 3. I2C_KEYBOARD_QUIRKS includes QUIRK_NO_CONSUMER_USAGES,
> whose input mapping ignores every Consumer usage except mute and volume,
> so the brightness keys never produce input events. The keys work when
> the keyboard happens to be bound to hid-generic, which maps those usages
> by default, and stop working as soon as hid-asus claims the device.
> 
> Let the two display brightness usages through the filter so hid-input
> maps them to KEY_BRIGHTNESSUP and KEY_BRIGHTNESSDOWN. Keyboards that do
> not report them are unaffected.
> 
> Tested on two ASUS laptop models with this keyboard: with the keyboard
> bound to hid-asus, the brightness keys now adjust the panel brightness.
> 
> Signed-off-by: David Cemin <dcemin@nvidia.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

