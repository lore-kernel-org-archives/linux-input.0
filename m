Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082333195FB;
	Sun,  1 Mar 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772365601; cv=none; b=hWcN+iMLRm6e9/PYh7LA01IHP/2zM9CXJ8XlXyYGSVW52Tk4AG6+Y5woNTvMrbxKqhXRRhuZtQEePIeyBZ2sFNDcGbSD5lYCInP1Dv5G4/DQRRiS/qEBcMgdCYm/5TKXYRKWxKhtDSLlj/8lUWbJqLyVLlWOWJnUoGc7XUMF4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772365601; c=relaxed/simple;
	bh=Uf6R+zZfxmRaLMbKNZcouztUXn0nl8uS1Dmf+sKZl8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSVFgRFntTm80dVXusk7Aak5xCv3dAGbwL9X6JHk94wINMAbLyr01k6XxCuEf3t/au9DuAc/tykSDnouDe0XUZ0ngy4ciRv/42O3YzTuzmUQUsdhYTVf3bstSUxGFTz46nAGPAHDMK0k/GJRoDOPi6C9WdcymXyPb8a+B98oQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr5yEOo7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr5yEOo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EBDC116C6;
	Sun,  1 Mar 2026 11:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772365600;
	bh=Uf6R+zZfxmRaLMbKNZcouztUXn0nl8uS1Dmf+sKZl8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lr5yEOo7XLOLkl/eowdyuHzTcVg16AUHhhk+v26oLUVzUhtc5SYxs+yI6lEXiXlXC
	 Cas6BenRPs12bQ3mwmI3zug9N6Ieup0ItZGxtjwCK/7wqzoU7wJ8AT2aUnQa7jyaAH
	 ewBltwzUuntSULFW2xY16Oas6x2M1l3YrIS/02iLfUCPzyLFeGtjHU+3M0bIIyMhzm
	 sNKkXkihI+FqEgrUXztm7bSRL4VMHDGpSnEq2TVpXEwLxIvUFiZtXqIjZTVk3rvaMY
	 zZsTKQNcOOKJGFRiF0DweU7aStUypgjcFY+hCUvBAJ2usXYxzHZnIrp+a0ZDT3DzI4
	 DmNXWRRXSTYdw==
Date: Sun, 1 Mar 2026 11:46:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: hid-sensor-gyro-3d: fix typo in array name
Message-ID: <20260301114632.28bcc9fd@jic23-huawei>
In-Reply-To: <20260228191400.19244-3-rougueprince47@gmail.com>
References: <20260228191400.19244-1-rougueprince47@gmail.com>
	<20260228191400.19244-3-rougueprince47@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Mar 2026 00:44:00 +0530
Bhargav Joshi <rougueprince47@gmail.com> wrote:

> The array 'gryo_3d_sensitivity_addresses' has a clear spelling mistake
> in its prefix. Rename it to 'gyro_3d_sensitivity_addresses' to correctly
> match the naming convention.
> 
> Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
Hi Bhargav,

This stands on it's own so I've picked it up.
Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 8e3628cd8529..4f88fe478d84 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -42,7 +42,7 @@ static const u32 gyro_3d_addresses[GYRO_3D_CHANNEL_MAX] = {
>  	HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS
>  };
>  
> -static const u32 gryo_3d_sensitivity_addresses[] = {
> +static const u32 gyro_3d_sensitivity_addresses[] = {
>  	HID_USAGE_SENSOR_DATA_ANGL_VELOCITY,
>  };
>  
> @@ -297,8 +297,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  	ret = hid_sensor_parse_common_attributes(hsdev,
>  						HID_USAGE_SENSOR_GYRO_3D,
>  						&gyro_state->common_attributes,
> -						gryo_3d_sensitivity_addresses,
> -						ARRAY_SIZE(gryo_3d_sensitivity_addresses));
> +						gyro_3d_sensitivity_addresses,
> +						ARRAY_SIZE(gyro_3d_sensitivity_addresses));
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup common attributes\n");
>  		return ret;

