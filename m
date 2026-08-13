Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0B1F3D56;
	Thu, 13 Aug 2026 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590863; cv=none; b=YK4eUdddjTVsD4BHVutu7HI9iEKszRYPuJyzvprRLfoViroaUQKjcLTuNJHZYhjd09P+JyefgKRGXXXZd4/nr6+Y7HNNCojz0uENBOhtXJcqxf0dHW96zD2PCnAObm8+BPZxAggbGDaPCDlvElZEf4sq49dGZppYjZbub9oKC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590863; c=relaxed/simple;
	bh=xP2zXTYbMfRjX3pacD+Hiftur8QodXZQjlo4zfIV7+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwHVQf/Vn/H7MnxOGjJ/Q6Qfk94r5skWN2NTz53D1Y9jbpPfEFP/NyaXR5MKnVQC9VfO/uiuHJmK9H9AOWo/L3iLPzRwLye0D3f+Kb+ab3mkxiuUKIf+pkuatED26PU0tSWniX4mMw7n5DLFci22BtWmEIslC39xVEIW1XWaxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc6rFx7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc6rFx7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AA81F000E9;
	Thu, 13 Aug 2026 03:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786590861;
	bh=uGflFkaSRSLwt8cjOUfrI2G3kHK8o37reSjG+m13zz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bc6rFx7eALcIR6jfdK6CeFY10ziltAnQqytO+w7w+88p4DezqUye503z1W7/FUmWR
	 kuEVQWkE/T6Ga7aE26jvkUl7Z6dzrsLeaozLXvv87RAdogJN+SkNfHHCZHp/J21Upf
	 VuN/A1MtU0s6fZfE8ivUHU56gjmqzCf4hFpxStZNRl0vsxOgqzTheBJMWmmUYJoekn
	 UK1CKNGavgUko45SRCwSDdMGN/16Dakcd5yc2a9KXWjBN3jbMfBS2V/kCOTlwZ/Mw5
	 59CMakHhVfW49MOPuLlyXLCK6T7EwCG10cDrfD67ePgumDvBKiPhvXLBwkR57yP0sE
	 WXjy1CjxXcpTQ==
Date: Thu, 13 Aug 2026 03:14:17 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] platform/chrome: of_hw_prober: Add delay for hana
 trackpads
Message-ID: <an02idvk4GtZIMfn@google.com>
References: <20260811122011.3539250-1-wenst@chromium.org>
 <20260811122011.3539250-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811122011.3539250-8-wenst@chromium.org>

On Tue, Aug 11, 2026 at 08:20:07PM +0800, Chen-Yu Tsai wrote:
> Up until now, the MT8173 elm/hana device tree has set the dedicated
> regulator supplying the trackpad as always-on, simply because the Elan
> driver was missing proper delays. As a result the delay for the
> Synaptics trackpad was also omitted, as it was not strictly required
> under such a model and delayed the availability of the trackpad to the
> user.
> 
> The Elan driver recently gained proper delays after power-up, with
> adaptive skipping of the delay if the regulator was originally
> on. The I2C HID driver and I2C OF component prober library gained
> similar adaptive delay skipping. The device tree will be fixed to have
> the regulator not be always on, and proper post-power-on delay time
> added to the I2C HID device.
> 
> Also add the post-power-on delay to the ChromeOS OF component prober,
> so that if the regulator is off at the time of probing, the prober knows
> to wait for the hardware to initialize.

> [...]

This looks harmless even without the aforementioned patches.

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
      commit: 81c1c0cb68a13d14dd1bbffcf4c49e26f9a6478c

Thanks!
