Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793886044;
	b=BiLis5NOayA6toeBE/0JWqxlQaQAKuU84xGALenNGNNFcHLvzamEDm0spklVzLvOsyn6
	 LmYP/NYHVWhbZAFrGd756ZYiZOQazd2fTcPyrs/KWQMR1vaTSiBL+LcvahvL7fdEHLEF4
	 Fgq44bg4gfvxK+jzeSNds2Wjp6sYAkNZbOAUK1HYzKDVoJYAY7k5/yMmVl/CeZBu+ScFg
	 +9AcaT5L9bS+Hd7jhpOHd5bHF74BsLIco9ESVeOk/GGJyFB3pDh3BMpxtKAKA7x9LfcZY
	 y0UVqVmEvFiFhxKLzX8AJXNrtYHm3Rrnv/0vbQPGK1GwKAmE7jaJgof6K16/oKCoGPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886044;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O/MF+yzHtwPFQ57KxiYeQDNOPG9nJ4b8etqrS0FvHw4=;
	b=O4TpXa1yIdkbIxEo2m3lUIvrBDDfXsFI8ybSwQXq+txsyK1hTFwTJffO5Yq/qrkpO1m2
	 986xqTZ46EBLoU49blYG1Twda4sftjLEkOjDr0IqE6yESCblXM5xaOddz5kLqa883Bt1P
	 jgKwkJOramwwf7evLBpSWBZn3l20WTHIl17FdkvEzK5lW5b5NzvjuShLMw62Hpy14eEca
	 GcQFuUxzyUW/lDmnss6Pg50Zo5irL1pZZzwGVc/rhCvC8sYXGR9ElhQNEx1esuqeREtUe
	 N6eb1M2jDfScaFg33boL0NQHRtIJo0zK914+FGqLfA3nFpZHYQuM28IJDzPYTvvI2nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C71HwqMy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6549606A326;
	Thu,  5 Nov 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C71HwqMy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793886043;
	b=T7TXzYPEg7PruJncEnv89umauJb7Vi5xYUB6uI1uDkIYTcjL2euuzwIggk3ldza/fOE0
	 1INMjC3Y46UBFoxoQssAjVm/Drbuw9Vxe4cGHRN+2TgNxwZs3giMdQC2YXq5GCwuVQ0Rr
	 cukwRERgNaQESyF0M1H4sPX8Ht1GQ5aOnuWjatYwXyPkqgfba8NBmm2zUwF/Rdt6VzGRa
	 zOBhiCE8ZYdLt8FMYgWPcbmAzZV1p4MmpSQWqVvL9RTU96iVioVCp8cH7DwrjvN9Q5I7X
	 5GvICb3r17bAlOOuCpW8N4t76aW/9z8qvVlN76pWYFAzd7BG34m3skAYGW+CYZxKIXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793886043;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O/MF+yzHtwPFQ57KxiYeQDNOPG9nJ4b8etqrS0FvHw4=;
	b=xTsRWw8Awc3MJ5GwEcj2h5Zq0+lAHGaI7Ht9oL9cFdqzYrEQtUcOYGf1n9PFE+YP6Y/7
	 tjgJRNTE7+aJLy9vtjIRx1bJNlM9AX8LwgCO62pqYiDi6DEzLAGP/YU0RYE8R3yKkyK1u
	 8+wTF4krb4iGyWp2NCKs4712502ZUZ+b4+ezgffGYsaWF9ISXQhTxIt53vjjuH76qt2JW
	 1HScwHKObBLW6aENHJxgyNjfRWRExbRYlMNjpE5x+aubNuMWscKhM13uDo42Sygq6EdMC
	 Zu7+QeVsyRgb/Y620xc8QW08FY/uEipB1QFSvKhz+RN2lZDuR2jF6XASsyDsmdYs+ZQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id B6C891F000C1;
	Thu,  5 Nov 2026 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886043;
	bh=O/MF+yzHtwPFQ57KxiYeQDNOPG9nJ4b8etqrS0FvHw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C71HwqMyuXLLzXD6fqSJksKKfASWFITkp/Syu32qyyO8hKhvIPR4q14fxuVU4yd+X
	 eYlBiYYhp9yIeLikIkieQdxenjMX/27t0RBSHytF42IKnGHqFCEKPPIOKbjxX1R8IC
	 rMGAFhBLecARKgtNTXIX1DGCJ62usgTfeS2spxBXSTsFej+CtPDB/+NyA7WMuzH88n
	 ysn3lJNU8Dwh6xQLMF92KeGsd+3PchhjKgFnAHMX89mFgVwqKIaBVcWlNSjyA8HrvW
	 0pgOfqP7Ou85bMZz/bQCzfor+6Zo3p7Absua2gF2x2mlGpnYF224anllp00OM84Hhg
	 S1qfQF39PDJfA==
Date: Thu, 5 Nov 2026 14:40:36 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, Jiri Kosina <jikos@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: Remove redundant probe error messages for HID
 device drivers
Message-ID: <20261105144036.00002e1e@kernel.org>
In-Reply-To: <20261105-19-oct-hid-iio-unified-print-framework-v1-1-0b360d9552d9@gmail.com>
References: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
	<20261105-19-oct-hid-iio-unified-print-framework-v1-1-0b360d9552d9@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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
Content-Transfer-Encoding: 7bit

On Thu, 05 Nov 2026 18:11:43 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

...

> @@ -377,20 +377,16 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  
>  	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
>  					    &accel_state->common_attributes);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "trigger setup failed\n");
> +	if (ret < 0)

You could also remove the comparison and just change the checks to `if (ret)`,
as devm_hid_sensor_setup_trigger() always returns zero on success.

>  		return ret;
> -	}
>  
>  	accel_state->callbacks.send_event = accel_3d_proc_event;
>  	accel_state->callbacks.capture_sample = accel_3d_capture_sample;
>  	accel_state->callbacks.pdev = pdev;
>  	ret = devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
>  						&accel_state->callbacks);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "callback reg failed\n");
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	return devm_iio_device_register(dev, indio_dev);


-- 
Kind regards,
Joshua Crofts
