Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210454;
	b=KM2eOvwMFp5BtrcWsNKlKTfiofnjzzWg5u1BHst83MEOYuf0n0V9qZKhd9+1noWSQ7Ug
	 GNhinriSh+3F0hSk8wrNo7YAugFWRvR5FsKeK4Yl8HCv7t+WsJJBesuMhXVdXU3I/nQon
	 nU8xYvokNP0rkaoxDjqbTsQiNmlcPFnE/fCgbjVlijfJrB3NZi/jbI38Z00zlO+4cjW8U
	 UxMZqFHTvmv6t8oo7H61PEs0QHJ0GhZ/aJDCtd30vBI9wTF94vb5umbT2zuI3pxNsb7Dy
	 q3Uym35nEl4mmenHBL9IWKCjtlD9wn9d0+asIpczIwH4nxnE2yfy+994ICR+QMG/Nbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210454;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y0llriglQ2tqApC0loy9XRaNe4pvSJyeEZzccaTnCa0=;
	b=eyY1YZVsaInMqbwETzXuvaQm3er0xWgZJ2dxXYncJvebnGm1J6c4nWnJSTslcUZa2b5E
	 BwbF3G1mggFLHlUF6Zyme2P0OBvrbinRAjqbT4bSb0kQs2qEl8PY2hazUlQIt+VvlGeqb
	 OGMVaAeVfxWawV+UgSyg6usiNb4Aq5TaWUQNdBJFLMBjMI1JpKLTQMcoDq0/HW+KO7sqO
	 8uhLnx++WkVcQxW6CqpuyFtPVOw8Ab1UCFjokKVKnQJmMc5YJsNCyw+i7Dxr21euDh3ru
	 cuzsID+iNh66pY8heCEWxio4Ye1KgBT9nz2Sngsg1KPvpYOZ5pEHbhE7cX0xGcWnVuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtxS1vvD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB9606A31A;
	Wed, 28 Oct 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtxS1vvD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F01F01825;
	Wed, 28 Oct 2026 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210453;
	bh=y0llriglQ2tqApC0loy9XRaNe4pvSJyeEZzccaTnCa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtxS1vvDBBF+2/4MwZYD8XlWcz3Z7iWis85SjMZhtq99cbI1gFnG1Ckvsw9BN856S
	 1TCFquRk9TTMxgrTlzZy6kUi4CftEADVkrBhSVgF8pZNhwZmC0/hCwOLBpbzATdJST
	 IZlbnVLThgyix9rxuWO/o8KYgfTVGxFQGT1UhVtQZc1rqconcz5mZhv+SyvuU7wvVn
	 Ae32f23uSGFlh9xKuInmBZfPgEi4Wlrr8mTjnWm90Ia68MTv5DrXb7hkov037eGsq3
	 zE+gYt532tg19g0isNhhbLtrklOWTgksxTMN/F8sj0EYtHErM8lykmTSkLjFfSvSQO
	 DYsFwEqh790DQ==
Date: Wed, 28 Oct 2026 19:00:49 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, 
	Corey Minyard <corey@minyard.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
Message-ID: <auI4Qq1KUo7YYVtG@zenone.zhora.eu>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
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
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>

Hi Dmitry,

On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> Update the prototype of i2c_smbus_read_block_data() in the SMBus
> protocol function table to include the length parameter.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
