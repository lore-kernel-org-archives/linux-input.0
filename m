Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DC30E84D;
	Wed,  4 Mar 2026 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609112; cv=none; b=GYTFV1nHPw73ZRo5XH/QySPJlUoBMRiyUOvr31X3TXjftxSKhoAvSYXxsUosOPwtpngOrQ6iVtmGFWKru9CQrYv6jTJul74+XctA1+Qn/VSPm6mgmpZyO+6mlmUf80BFJ4TvI3yr8+dgLdxgXfMfoQQeSxnP1019PWjVx+vU/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609112; c=relaxed/simple;
	bh=uhNL0dEuNiSzO6s/3EZ4lgIA8e4DQDPaP2KcDBGeCa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5fiO5NvUUn0qEJuoNTgzw08NdHDJ62PO8OH60T9x8erAxF8lQ98zg2ibY6jNerAycKYbhi0bFJf0d/jbcCNUb6QzUCmieHqrw8iuv9dbj9ryrY5T3DR1BZ6OaLnighH4bXFRkiD3tFWKVc5MCvwH7IfmjDzZs3iqQlzF6ZNQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwU5faIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwU5faIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F95CC19423;
	Wed,  4 Mar 2026 07:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609112;
	bh=uhNL0dEuNiSzO6s/3EZ4lgIA8e4DQDPaP2KcDBGeCa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwU5faIFVIQbLpfeyGrzSxJ2cPKpeycARd/kjHDUFIVDDepU0vy5TwMdjbr+pTDG5
	 JwPEDgzV1LJ4ZVqowT7RtcIWrYppdkgi8CMMlSMMLQ68ImNbsg9O656IOrnGg6e+7O
	 XnYRp80s82ZhPRi0d5/CLVX6vp7VHYvGdT+1AISrEloUv4toXrgJQXv8E6xwCwDoy2
	 LJ0yHQKlRfH4mVmsJu1v08nJHXuWvCwfyr5vkOH/pHvRsDS3+n9+G/Wu/mq0UiBKP2
	 S7m/LdUqISIkKVdl49BegZmTTz1YuvPf1L5Om4mUJ+n+gYI13uqyP1UxqfDLYBhjZ1
	 06TBk4MucVOOQ==
Date: Wed, 4 Mar 2026 08:24:45 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: leo vriska <leo@60228.dev>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: quirks: add quirk to always keep device open
Message-ID: <aafeCVaf6ebaxqAQ@beelink>
References: <20260304033245.445671-1-leo@60228.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304033245.445671-1-leo@60228.dev>

On Mar 03 2026, leo vriska wrote:
> Some devices expect the host to open the device shortly after it is
> connected. If this does not occur, they may freeze or disconnect. A
> quirk allows these devices to function properly without userspace hacks.
> 
> The existing hid-axff driver solves this problem for some generic
> controllers. This implementation is modelled after that driver, which
> still needs to exist for force feedback on the controllers that use it.

It seems 2/2 is dealing with a USB device. So why not simply make use of
HID_QUIRK_ALWAYS_POLL?

Cheers,
Benjamin

> 
> Signed-off-by: leo vriska <leo@60228.dev>
> ---
>  drivers/hid/hid-generic.c | 23 ++++++++++++++++++++++-
>  include/linux/hid.h       |  2 ++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> index c2de916747de..0595e653b7e7 100644
> --- a/drivers/hid/hid-generic.c
> +++ b/drivers/hid/hid-generic.c
> @@ -67,7 +67,27 @@ static int hid_generic_probe(struct hid_device *hdev,
>  	if (ret)
>  		return ret;
>  
> -	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	if (hdev->quirks & HID_QUIRK_KEEP_OPEN) {
> +		ret = hid_hw_open(hdev);
> +		if (ret) {
> +			hid_hw_stop(hdev);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void hid_generic_remove(struct hid_device *hdev)
> +{
> +	if (hdev->quirks & HID_QUIRK_KEEP_OPEN)
> +		hid_hw_close(hdev);
> +
> +	hid_hw_stop(hdev);
>  }
>  
>  static int hid_generic_reset_resume(struct hid_device *hdev)
> @@ -89,6 +109,7 @@ static struct hid_driver hid_generic = {
>  	.id_table = hid_table,
>  	.match = hid_generic_match,
>  	.probe = hid_generic_probe,
> +	.remove = hid_generic_remove,
>  	.reset_resume = hid_generic_reset_resume,
>  };
>  module_hid_driver(hid_generic);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 2990b9f94cb5..9d0ab7c217f3 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -388,6 +388,7 @@ struct hid_item {
>   * | @HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE:
>   * | @HID_QUIRK_IGNORE_SPECIAL_DRIVER
>   * | @HID_QUIRK_POWER_ON_AFTER_BACKLIGHT
> + * | @HID_QUIRK_KEEP_OPEN:
>   * | @HID_QUIRK_FULLSPEED_INTERVAL:
>   * | @HID_QUIRK_NO_INIT_REPORTS:
>   * | @HID_QUIRK_NO_IGNORE:
> @@ -416,6 +417,7 @@ struct hid_item {
>  #define HID_QUIRK_NOINVERT			BIT(21)
>  #define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
>  #define HID_QUIRK_POWER_ON_AFTER_BACKLIGHT	BIT(23)
> +#define HID_QUIRK_KEEP_OPEN			BIT(24)
>  #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
>  #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
>  #define HID_QUIRK_NO_IGNORE			BIT(30)
> -- 
> 2.53.0
> 
