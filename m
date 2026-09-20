Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560941C8604;
	Sun, 20 Sep 2026 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866027; cv=none; b=MGnEiRC+yJToYdjoqauDaG3M4soUSWHPP9AZrYXiSvfbXVnL/V9Y6KJJZFTRKazITKS/2r1bqR+EWqlTRWlGjPM7fb6oFysNmwL2tFJ/9ICFPlyt6JQIzODuvFh/mLl3yaOOEcNE+exR++kKynWW5ENSxiPfUYzpwyX8VwosSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866027; c=relaxed/simple;
	bh=1qrjpqpG9QUZlyBSmtYaOQnIJCwODXRamyibCuKZR80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rv7trSqkGO6FztpMDE44zpsjpzbFRU2OeZ1nelabnfW3RLGdZLsK4THqx8FBSl7ACGMZBQYEoePyDgUyurT1KSpdjwbluRKQ1WAg6UXAeyyY4WqUA+bWmnYw2eWFwWS9o6qO5lE3ZEAIXhLck0OQhVq/PKvPTHeGFe2BlXFWWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB4IYm+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB4IYm+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4371F000FF;
	Sun, 20 Sep 2026 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789866025;
	bh=qOPFtxDSA7b050I9Up1IkDf88H+iz2tylUf2JuKFjDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oB4IYm+XY7TbFb1jyN5Jc2/benzc1xSQrDaLmjvSR7Zjd48qF0QZErBtFpX4hi1r8
	 lDHU21fN/zlm8A5mgxudohpwh01RTnb4ivaqwrrhgzvEe96fDYgWNEdif81lTn0cwp
	 GawManpSoK6k61YeOlObzsojK52ynsokW19voMcycqHtYyA6zVolI+qd/R2vpcsL2p
	 3+/ooJyjg9zgKuWeZ1O1yCjAtm1tnqAuNa5SwlH3zPIiQqj6tT1cwEWVAKyqr0Nw0M
	 M1AoC19GwaB5ozoqknFPXGOdJ7sVT1gBdkIRnzCiMrkoHf7s7tC6bghF1SRw+m6Zkb
	 9pyO3nAZJNoMA==
Date: Sun, 20 Sep 2026 02:00:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v6 03/14] HID: hid-sensor-hub: introduce device managed
 API
Message-ID: <20260920020021.3c5f08f5@jic23-hlaptop>
In-Reply-To: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-3-d577b2371b3c@gmail.com>
References: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
	<20260919-28-apr-iio-redundant-argument-v5-temp-v6-3-d577b2371b3c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 16:06:26 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> sensor_hub_register_callback() is common API used for the HID IIO drivers,
> prepare devm API devm_sensor_hub_register_callback() to acquire resource
> during setup and release using device managed framework during drivers
> fail, unbind or remove path.
> 
> Store the required callback removal context (hsdev and usage_id) in a
> dedicated struct sensor_hub_cb_devres, and register resources with
> devres framework and helper API.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

One thing in here. If it's all that comes up I might just tweak it
whilst applying.  I do want to give a bit of time for others to look
at this series anyway before applying so won't do that immediately.

Thanks,

Jonathan

> ---
> Changes in v6:
> - Add kernel-doc for return statement for the new devm_*() API, as
>   suggested by Andy.
> - Keep kernel-doc for new devm_*() API in public header file, along
>   side where existing API documentation is available.
> - With suggestion/input from Jonathan, use devres and cleanup frameworks
>   together to implement device managed API support with less complexity.
> ---
>  drivers/hid/hid-sensor-hub.c   | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-hub.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 6470a290ebfc..de35e72b4d88 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -4,7 +4,9 @@
>   * Copyright (c) 2012, Intel Corporation.
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
> +#include <linux/device/devres.h>
>  #include <linux/hid.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -187,6 +189,39 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
>  }
>  EXPORT_SYMBOL_GPL(sensor_hub_remove_callback);
>  
> +DEFINE_FREE(devres_free, struct sensor_hub_cb_devres *, if (_T) devres_free(_T))
> +
> +static void devm_sensor_hub_remove_callback(struct device *dev, void *res)
> +{
> +	struct sensor_hub_cb_devres *dr = res;
> +
> +	sensor_hub_remove_callback(dr->hsdev, dr->usage_id);
> +}
> +
> +int devm_sensor_hub_register_callback(struct device *dev,
> +				      struct hid_sensor_hub_device *hsdev,
> +				      u32 usage_id,
> +				      struct hid_sensor_hub_callbacks *usage_callback)
> +{
> +	struct sensor_hub_cb_devres *dr __free(devres_free) = NULL;

This must be as tightly coupled as possible with the allocation.
	int ret;

	struct sensor_hb_cb_devres *dr __free(devres_free) = 
		devres_alloc(devm_sensor_hub_remove_callback, sizeof(*dr), GFP_KERNEL);
	if (!dr)
		return -ENOMEM;

No idea why we see so many folk doing the = NULL thing given the guidance in
cleanup.h that says never to do that!  If you are bored, it is a fun saga of
weird things compilers can do and not warn you about + fragility of resulting
code and the desire to keep the code readable.

> +	int ret;
> +
> +	dr = devres_alloc(devm_sensor_hub_remove_callback, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	ret = sensor_hub_register_callback(hsdev, usage_id, usage_callback);
> +	if (ret)
> +		return ret;
> +
> +	dr->hsdev = hsdev;
> +	dr->usage_id = usage_id;
> +	devres_add(dev, no_free_ptr(dr));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_sensor_hub_register_callback);


