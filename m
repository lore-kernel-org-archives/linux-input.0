Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE69348875
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703837; cv=none; b=DmfKh6S3tGOUEg2XCHS7aSoKgKwPXOKnkk5a192jpHPTmwb16doWpZfMQufcIR5n07L/F0ee31UkD22NPvVl1WE60abc2sZOhVyvRLV5+eC1EAfUR1ntEahhxmXX8JtSGX7GYRygKFRvNihzaH3vP6NLICQiISMaOauSvSa89GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703837; c=relaxed/simple;
	bh=aZleQswx95SUVtU4qIhfOWQFLgB3VqA9ou0HiRBCy/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKoqGZoEHkvMuw+8hwej59rF51UKz2eIBXM+v9QpM8jkL7QxcrGXuk5OiaPXRywAZ1D+y2n8wUlD1PW5FNoLYFuouR9pn0KSLuF1GybgvutXKhcLSIpBBFAAbwIe4JaGz2RAC+mnnSJYqAaHNVSE36hnEWnNHisRpp20hOglolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=r8NRq+/5; arc=none smtp.client-ip=80.12.242.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="r8NRq+/5"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTP
	id RSFMwLSweXFQXRSFNwAo3I; Mon, 25 May 2026 12:09:21 +0200
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id RSFEwljTZXaDMRSFEwBNwF; Mon, 25 May 2026 12:09:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1779703754;
	bh=8WrFVk33dA4Qcl+hSjcBwJymF/rHXq6XmyeWPA6deLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=r8NRq+/5uuWqDScrWi0WP41nmm3ub/BnrWlG0cSqOVZabcK+iTsELGipBwcYCSHEi
	 ZB0KJ7Flf4JrWLz7xWPkDBacr220u4CDl3PGfW8Z/eyR7lTBQFsR7KyLjMZwxIuV4+
	 RwUl5P5kz32olDoIi2TIi+6po4axxi1xXV7jyNIwEFUsRgeWU6O7/kLcsvXkQU0IVm
	 cusS+zNdQ3TJaN11xPRlkzIx7WRwspLDRNMy396sBu/XFlUs5hVIIQ3fI+3IhpL16M
	 XB+nIzTGRdGjh7yHEkHyK7CqMN2YFmrL2WA3pkIC+3frrDFjvPGAkkO4r6SylLzoBh
	 Gt8I7n2huqajA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 May 2026 12:09:14 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <0a8ebbd2-5de6-48d2-9218-f7b816eb3455@wanadoo.fr>
Date: Mon, 25 May 2026 12:09:11 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 35/36] iio: pressure: hid-sensor-press: drop
 hid_sensor_remove_trigger() using devm API
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260524192943.1196773-1-sanjayembedded@gmail.com>
 <20260524192943.1196773-6-sanjayembedded@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20260524192943.1196773-6-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 24/05/2026 à 21:29, Sanjay Chitroda a écrit :
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Use devm_hid_sensor_setup_trigger() to automatically release resource
> during fail, unbind or removal of driver using devres framework.
> 
> This simplify the setup, remove goto, avoid manual resource cleanup in
> teardown path.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>   drivers/iio/pressure/hid-sensor-press.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index fee7dcb86801..8438498c9aeb 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -291,8 +291,8 @@ static int hid_press_probe(struct platform_device *pdev)
>   
>   	atomic_set(&press_state->common_attributes.data_ready, 0);
>   
> -	ret = hid_sensor_setup_trigger(indio_dev, name,
> -				&press_state->common_attributes);
> +	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
> +					    &press_state->common_attributes);
>   	if (ret) {
>   		dev_err(dev, "trigger setup failed\n");
>   		return ret;
> @@ -301,7 +301,7 @@ static int hid_press_probe(struct platform_device *pdev)
>   	ret = iio_device_register(indio_dev);

Hi,

Looks like devm_iio_device_register() would now make sense and simplify 
things even further.

CJ


>   	if (ret) {
>   		dev_err(dev, "device register failed\n");
> -		goto error_remove_trigger;
> +		return ret;
>   	}
>   
>   	press_state->callbacks.send_event = press_proc_event;
> @@ -318,8 +318,6 @@ static int hid_press_probe(struct platform_device *pdev)
>   
>   error_iio_unreg:
>   	iio_device_unregister(indio_dev);
> -error_remove_trigger:
> -	hid_sensor_remove_trigger(&press_state->common_attributes);
>   	return ret;
>   }
>   
> @@ -328,11 +326,9 @@ static void hid_press_remove(struct platform_device *pdev)
>   {
>   	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
>   	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct press_state *press_state = iio_priv(indio_dev);
>   
>   	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
>   	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&press_state->common_attributes);
>   }
>   
>   static const struct platform_device_id hid_press_ids[] = {

