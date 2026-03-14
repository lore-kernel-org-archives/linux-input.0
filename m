Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F42DE717;
	Sat, 14 Mar 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773483915; cv=none; b=pqnjmKl2vhUJRC+17w67ZZamuPWrhCdOj5kN4LbUH2CV7NcNn9IOVYrxrxrjeelitwh8a9iqo7dTTlYt69/7Q3elGDoNp/rJXRQjxX1+2VhCBKxD71AW80zj42N19nywZYm4jiXTmVSd1ZKqVIBpTNnupwb3BdnQGzNGgI4OK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773483915; c=relaxed/simple;
	bh=xEoA34MGACPszqT64gX/WicktSCq3OAR48eYOy3S1MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm87XnzlE6WVxK0ZKT8wHzXL1LYJBqE7ph7y6XePCInZ0FDGSkB7F3YgidcbESIMDQVtIZYIyM3P/l1J3ql49bMeR+8VWIdCH1FW/TzkhdsdfMFR01J8xWxufYH4EdSS3LYy0/quej64RP0ExfZ0r9RYXLnfRzpHatvOz4cK/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsjQbv4c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsjQbv4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D254BC116C6;
	Sat, 14 Mar 2026 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483915;
	bh=xEoA34MGACPszqT64gX/WicktSCq3OAR48eYOy3S1MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsjQbv4cMrmklNBknq4n7qaX4o7uXTuj8T6DJSMWr0tY/vLVfs2Y/oDLk4B7Sw6yK
	 tAd6w+JiyeRl3494tUELBX+kKnjB9/EVTpUgnI1c6Kjfw4RxYSvLTV5HZIdvwqK7M3
	 IfS2qgMyEX1c7sc+OsHML+GdzGwvy7109YHhH+/1FsV8HphsCfFUbX4+qBNHlUBGur
	 m7TpJJyg1a9iiQNYrDttJV8EitcG0cGDTLu+OsprJz9vFwS91xQ66+4TU4+HX+SuXZ
	 E22eCK6tLAGyi01O9gP5UNNQljB9GaIqwNwKZOR/6OhXO+ETT5ce/zttNNv6Hfbz0p
	 qfMZMryNpPgug==
Date: Sat, 14 Mar 2026 11:25:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhushan Shah <bhushan.shah@machinesoul.in>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - add support for FocalTech FT3519
Message-ID: <20260314-successful-nano-hyrax-cc3b21@quoll>
References: <20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in>
 <20260313-edt-ft3519-v1-2-fe5ffc632fd2@machinesoul.in>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313-edt-ft3519-v1-2-fe5ffc632fd2@machinesoul.in>

On Fri, Mar 13, 2026 at 12:09:51PM +0530, Bhushan Shah wrote:
> This driver is compatible with the FocalTech FT3519 touchscreen, which
> supports up to 10 concurrent touch points. Add a compatible for it.
> 
> Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index d0ab644be006..52188e1aa9bc 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1479,6 +1479,10 @@ static const struct edt_i2c_chip_data edt_ft3518_data = {
>  	.max_support_points = 10,
>  };
>  
> +static const struct edt_i2c_chip_data edt_ft3519_data = {
> +	.max_support_points = 10,
> +};

So same as edt_ft3518_data? Why are you duplicating it then?

Best regards,
Krzysztof

