Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B093C344D9D;
	Thu,  2 Jul 2026 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013406; cv=none; b=qrmSK4TifwmgWaGm79ddvVY1kddx8nSX8l9ypxGKrWgemFCLzL9q2jTf+YyELSutSDk1kePmbD0EnVndH4NyXI9cKU4KjM59P9wakv13U49abTNbiNcIwMy9d/R1pXXt1R3yFbr92tSeBVib5oOuGZzBFGoLOp1lZCwvd0U9o+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013406; c=relaxed/simple;
	bh=Xyn2/99GX/7c2H0Ee1whEz5BD82cWGwNvvm0q1n3B2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgHXpL8jF/tn3Drel0iXZ1nIMhv2R1ThypAZSqKwx9+8PyQ2N8o5kc9btV8hrqeDAisc4xDly+ae3BuvAuuKCOrnZabdsfAzOL7ZTXElyewV798czVirAp8bUTNPelG94cJacLKMj/j0FMPkT63+F46BF1JaYbBbD2l9GQ++Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huvQ0kSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huvQ0kSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B741F00A3A;
	Thu,  2 Jul 2026 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783013405;
	bh=wrJBBYZOrJ7qozo+c3a+Xva6cnlQxvDDH11n4sJseHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=huvQ0kSy1DHxB3XuIQIbKSC7LDjerAlG2Bd74l+VaLABpUb/nkiIei9e5G7Gp9bBK
	 aeGlfllsWinJKVu1z0x+M80hytz2uu2ChPi5DzliSOtidK/DKZrVuHn99r9Sy4cL7N
	 Yx7RXM+KYIJytM2ZcP+7q+qphamepMqUTn0ri3g9JC7IDNf2i5/4dSRDdN9nx0UObR
	 XFjwiJe4daefDLK7MEr1qYF3iL4rHfLaq03aHm8Hw6aJ3/nurtEGGe6Of5YbroM6X/
	 tlRmR2JLJ6VCrKqgJf4TkRqDNMOP5MF2W0H9A5mmEX1+ViTOJaJNoa14Tni9xNrWSi
	 yh2d2IGJ9Rwjg==
Date: Thu, 2 Jul 2026 18:30:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: hid-sensors: add/remove blank line
Message-ID: <20260702183001.2964c42a@jic23-huawei>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-1-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	<20260702-15-jun-hid-iio-alignment-v2-1-b87f01f5efbc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Jul 2026 21:47:58 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Add a blank line after variable declarations and remove multiple blank
> line across HID sensor IIO drivers to improve readability and align
> with kernel coding style.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
Given this one is small enough that the churn concern isn't relevant.
Applied.

Thanks,

Jonathan

>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 1 -
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c    | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index c115a72832b2..2f0a1ea42f48 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -282,7 +282,6 @@ int hid_sensor_read_raw_hyst_rel_value(struct hid_sensor_common *st, int *val1,
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_read_raw_hyst_rel_value, "IIO_HID");
>  
> -
>  int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
>  					int val1, int val2)
>  {
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 417c4ab8c1b2..c8ccf96f3d03 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -314,7 +314,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
> +
>  	schedule_work(&attrb->work);
> +
>  	return 0;
>  }
>  
> @@ -322,6 +324,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
> +
>  	return _hid_sensor_power_state(attrb, true);
>  }
>  
> 

