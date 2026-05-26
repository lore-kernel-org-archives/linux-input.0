Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827C38B154;
	Tue, 26 May 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810337; cv=none; b=MJZg8PFGqMcl+ZVjNdC/XXN0CJ9sUZju5gG+7rJqi+fpT0nvjeMkTY8kij9P0Nss77f3AZeviWw3v6SoWbBY4NvVvQIaZpKAOZp0wGHHc2UV9sAJe5A5fC+z8uTM7FB55Q9N7NZhN91ltzD9tUWTxjagbb0DHPIgXSzvn93+rBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810337; c=relaxed/simple;
	bh=KlJU4rNIf2O5u65yVTzOORB7CqSPnAkvVi/IFI9qw4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxXVG2NMnsIeO9N7ybwitAeU1sY3HR8gxkdONY3DrNfQlchq+WiytPiCP8uUFK2fvB400xBajK7HSzf6YN3UOIMaIewNnHJowIPPdK5MqLj3pit5qBzqg9M5yRfAvA6fS2UwI9RRi60Obx0B+Dfdnigxj8hYBoG/TeowWgZFBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcoRBC4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcoRBC4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B4E1F000E9;
	Tue, 26 May 2026 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779810335;
	bh=znv+DR3ecMFMLElt3BVhRhDUW+VvJyxluiam99aBquE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GcoRBC4TnvB52Oq0ioxFPZcA8DpMJ32s/nsuxsPnAIenMir2cdQ9CI1aVNDR7OGSk
	 TTwK0bTUYOODBcfIQpabKDpW2pp3D/waIWprSQQxNIe0AwSY4+aricJM8VktFo8+4X
	 6wY+lGA7q9d0ZIpk50BdYf1pswsp2IHS6MX6uXrPgGXFrAEx91rWNhfv/zbn54+Oxh
	 8GOrLcNGhxd8bb7J2xoAPI1YCUG+KoYwC+rFrAd/cDPGOv7KAh5mOSGsL7Mt/lqg9c
	 eem9Xh4MgXC0jTKxC3sDTgb4GAUxTgmj03pRfbCfiYXO6Lxcu533uTrRSi2r0h86ym
	 EW3tUvmIym6uA==
Date: Tue, 26 May 2026 16:45:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/36] iio: gyro: hid-sensor-gyro-3d: use u32 instead
 of unsigned
Message-ID: <20260526164526.34606428@jic23-huawei>
In-Reply-To: <20260524192059.1193716-3-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
	<20260524192059.1193716-3-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 00:50:25 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Prefer 'u32' instead of bare 'unsigned' variable to improve code
> clarity and consistency with kernel style.

I think it is relevant that the definition of the callbacks is:

struct hid_sensor_hub_callbacks {
...

	int (*capture_sample)(struct hid_sensor_hub_device *hsdev,
			u32 usage_id, size_t raw_len, char *raw_data,
			void *priv);
	int (*send_event)(struct hid_sensor_hub_device *hsdev, u32 usage_id,
			 void *priv);
};

So in all cases we have a u32.  Same applies to other calls the usage_id is passed to.

> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
> Changes in v4:
> - Use 'u32' instead of 'unsigned int' as driver is already uses that and respective prototype has same data type with input from David and Andy
> - Link to v3 -> https://lore.kernel.org/all/20260509101040.791404-5-sanjayembedded@gmail.com/
> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index c340cc899a7c..020812639947 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -187,7 +187,7 @@ static const struct iio_info gyro_3d_info = {
>  
>  /* Callback handler to send event after all samples are received and captured */
>  static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				void *priv)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(priv);
> @@ -209,7 +209,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>  
>  /* Capture samples in local storage */
>  static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {
> @@ -244,7 +244,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>  static int gyro_3d_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
>  				struct iio_chan_spec *channels,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				struct gyro_3d_state *st)
>  {
>  	int ret;

