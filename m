Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9E3E024B;
	Wed, 30 Sep 2026 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800580; cv=none; b=r+N8slp2xveNua0HljuWqrmAnbaxjKce9jvvYB+h6+YYL399eiCoHFHj7kKkyKywuUkAoli9NvHnj6SorWa83oaU89vihmltibJaLElfTRdh5SesYLnNTljGoGb76+mAozH7yJG7JjSe9beiqjIOlZf4jFFvvFVYWh1l+1AqjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800580; c=relaxed/simple;
	bh=tNlIwn1LrJp3ghtDRtGrFyiIHufjQqCG5nlvEpAP99U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwTzKIz/Z5RW3s/4lb5OdF255fj1zVyay7U9pR0fe6ICSGlss5sxZo7/tjFwuEyoFjmVJVc9rtU4f7Ja7x5EsbLy5GkZ+ClD/K3JbZ9PFyAwnTMPMZxROlOX3ixxKitQ40p+olYU2W97x9bDk9wzQs2QCYwBCqXj1HEYt3hBm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0y85Hhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0y85Hhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8591F000FF;
	Wed, 30 Sep 2026 20:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790800577;
	bh=bHRAUieKFXhe3YwL9l8D5DWxS34JW3k2sR3rMEAAkb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F0y85HhbKndHM6ps70RRuINjylQnVGM2hdfebHSv/6CjxvNtRc4FbUUkJP2eqLc4A
	 tu32H1RgdKeYtHgl2L225O9MKgfWpVTo+ZL0aPPqLMZwZFhIWgRl6IZ/4aB+Jk6uV/
	 ZHNOxkxXbX4L48XSl57cCFJRuHnChZ3hLr8exatLe+DA5d/ASeaGxlyhYMYBPzP7AB
	 creJi/FDzts3PrtzByL6ZeJNUmDXiY3xwUcMo8Y8+eaidxUALx+ju/zW5zFOj3jVTq
	 Zx1cT9NoHVsc377+v2G5q7B3NI3rtgLb81ciGfKbXuzC2bN0/XwAvpJsoykdEyhPPg
	 PdhZOYKIUdqtQ==
Message-ID: <4bb28c93-f4f2-498a-84e6-96670a336bbe@kernel.org>
Date: Wed, 30 Sep 2026 22:36:14 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 15IWC11
To: Martino Papero <martino.papero@lcb.to.it>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c0b597b8-e7ad-4fba-a2bb-5d252e3dfbd3@lcb.to.it>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <c0b597b8-e7ad-4fba-a2bb-5d252e3dfbd3@lcb.to.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 30-Sep-26 22:10, Martino Papero wrote:
> The internal keyboard on the Lenovo IdeaPad Slim 3 15IWC11 (83RR)
> does not work correctly with the default i8042 settings. Using
> i8042.nopnp=1 and i8042.dumbkbd=1 restores keyboard input, but prevents
> the Caps Lock LED from working. Using i8042.nopnp=1 alone does not fix
> the keyboard.
> 
> The laptop works correctly when atkbd_deactivate_fixup is used instead.
> Add a DMI quirk for the 83RR to enable it.
> 
> This was tested without any i8042 command-line parameters. Keyboard
> input and the Caps Lock LED work correctly, including after suspend
> and resume and after a cold boot.
> 
> Link: https://lore.kernel.org/all/4f43465f-98ba-4722-8e29-03df20315369@kernel.org/
> Signed-off-by: Martino Papero <martino.papero@lcb.to.it>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: stable@vger.kernel.org

Regards,

Hans


> ---
>  drivers/input/keyboard/atkbd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 93650c982..b5ee5697a 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -1938,6 +1938,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
>  		},
>  		.callback = atkbd_deactivate_fixup,
>  	},
> +	{
> +		/* Lenovo IdeaPad Slim 3 15IWC11 (83RR) */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83RR"),
> +		},
> +		.callback = atkbd_deactivate_fixup,
> +	},
>  	{
>  		/* Xiaomi Book Pro 14 (TM2424) */
>  		.matches = {
> 
> base-commit: 551c722f40809618230001baccf219193e22fc5a

