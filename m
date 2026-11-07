Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082408;
	b=ci3OilPlnuzvio8dcNDBqNIsRivNYRww8T+gbs/fheH3UNXMAcEFDgZfi95VfXH1hk5f
	 RaT7KSDSQxjxsJPQiO9zbDq4RnhI92xO+r6FO3Ed2GhuBrORrzk772UbqgOf9WWv0TYaD
	 Hnjyq6/l83TrpwcUxyS/uSTJeCm8azBbSJ/0+zjCpO85giGIQmHbhc/Q8PB7QjNqbf6O6
	 xu2uEi1kCcRT11Z7MW+Z4/xveAVm2HX+hprYkUnzQ8vuCynPyVEFA2Wn+IrFudFZohRKo
	 L+zWZwi0Y2YY6iTN3DTFshPoMykSjjKN7ELP9u3aiku7no5ExLsFSWKuKoFi2MLOhOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082408;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ERTBlzUdFoDfton7ShqaRUah2+gc/i29+LWYPPh83VI=;
	b=boslhL9jwNZ9Ebj8e2T/GmqXqGPwU+vRe2uzZr1ZeOMmuaHmAugj4GOACAhrFkBCSqg1
	 Lgq8rIJ8OUFcVKdAXglHKCZRCc4IZ2SwWD9oLe/784jZIkUR1+7CUZ5FHuPRr9ph/rKU4
	 9tJMqzoUtGTGbbWDAK7vxf8812jXoEoX9EymW+TEjn9GqnAlvyNAd6mkT9MRVHUFc7ouv
	 mVchzV3CwRAOODzilA3Gnlb+/8le8Vq/IDw6ZdRmAFEI0T+4QAJlAimqHfVplkEXDKesj
	 Y+YMzKjrhLhmRDr1DXvxW9vGq2lvpyQuS/yy5iGfRG3xyA/s7xJeOfIjGi3vB3rC+qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsF8sTE9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED5606EE91;
	Sat,  7 Nov 2026 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsF8sTE9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC621F008BC;
	Sat,  7 Nov 2026 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082408;
	bh=ERTBlzUdFoDfton7ShqaRUah2+gc/i29+LWYPPh83VI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VsF8sTE9Jq7H2cEPwCcycGZ4nUtWmwkUwVyNuNs31HVfLIA5SCdJmcELnSNWh6QOh
	 DoTwyXs94QNZI41O4zJsOGh1YiyC2LJHVlpP9QjvKKc1417kjUEXdlDUQ2ufDcT3nF
	 j4rLM1uFopdt7xn75IJ8KzEN4w/vhgyLSw0zuDlOLXOORvNb12skVZOu+FVVHKrEm/
	 eBtEP4nuN5ILVTgYhWHse6d6skxdO/vVN3Sof2qJ8TFARo+qEFbDmvNHvABkmQ7oek
	 nuux35Vx5+InkccYfXPwZyJbG5MXamVLLd5mmYGAWN0pMPCX+D4qSKffearbFt2Dy6
	 gL0+ZCD4YN3BQ==
Date: Sat, 7 Nov 2026 20:13:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 simeon@maryasin.name, lixu.zhang@intel.com, crofts@kernel.org
Subject: Re: [PATCH v2 1/7] HID: sensor: hub: Synchronize callback removal
 with raw events
Message-ID: <20261107201319.0f496662@jic23-hlaptop>
In-Reply-To: <20261104201403.2039921-2-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
	<20261104201403.2039921-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Nov 2026 12:13:57 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Raw-event processing holds pdata->lock across callback lookup and
> invocation, and takes dyn_callback_lock during lookup. Removal must
> prevent both active callbacks and future lookups before client state can
> be released.
>=20
> Take pdata->lock before dyn_callback_lock, matching raw-event order,
> and unlink the callback while holding both locks. This ensures active
> raw-event callbacks have finished and prevents future lookups.
>=20
> Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
> Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=3D=
eUdbPthG2xrLqwQQ@mail.gmail.com/
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Maybe a minimal fix is good for now, but I do note that we can
make this code nicer with some guard() magic.

Perhaps a follow up series to tidy this up.

Things are getting very messy around this driver wrt to fix vs
cleanup.  Hopefully it won't cause too much of a problem in next
until I can merge the fixes back after they go upstream.

> ---
>  drivers/hid/hid-sensor-hub.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 6470a290ebfc..0c4884c5821f 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -173,7 +173,9 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_=
device *hsdev,
>  	struct sensor_hub_data *pdata =3D hid_get_drvdata(hsdev->hdev);
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
> +	/* Serialize callback removal with raw-event callback execution. */
> +	spin_lock_irqsave(&pdata->lock, flags);
> +	spin_lock(&pdata->dyn_callback_lock);

Do both of those with appropriate guard()=20

>  	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
>  		if (callback->usage_id =3D=3D usage_id &&
>  						callback->hsdev =3D=3D hsdev) {
I'd just go long!
 		if (callback->usage_id =3D=3D usage_id && callback->hsdev =3D=3D hsdev) {


> @@ -181,7 +183,8 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_=
device *hsdev,
>  			kfree(callback);
>  			break;
And we can return here.

>  		}
> -	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
> +	spin_unlock(&pdata->dyn_callback_lock);
> +	spin_unlock_irqrestore(&pdata->lock, flags);
> =20
>  	return 0;
>  }

