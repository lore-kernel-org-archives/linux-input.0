Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177309;
	b=dbOeRe3BUwKOzggITLlRQsC9NTBF9bPtAiA34AsWsZ+6v+Es/MXOA9hi/qmfiyvRWGGQ
	 u4FmwxTSST1Q5LWJBB5DZvwSMpvDKWILGqIXH8WMNGdemyQmZaKZKBSXGufwhbsxnIDVR
	 rnhzWtHzmYdjP8IpGvN+012qPSR7dyKnGIS4oI07wJyFXf5e8hDPVtdyr3n1p7K+oiDDM
	 4/OE/v8ucz83uNnfDhRTByDrUBrBgYCkHYFvIJRZDNjPnOgWxmlodygav7VjhuXRRReEj
	 uamAYy4RkvvlPgwTPpSgSfyq0kd0o7kVWI4WjFvv7e1VKVjShPB2+wkdg/IIxFtdwuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DgsEZjUslj1Yrfr/vHzcv5cNZ+mqUn4KMypBjJcjvK8=;
	b=f9WXYajjCrwMK2NJmhDSWWP3DyePzMKJ/PaytDQ2xmdQsc+VJiNR5fd06grgXq1Z1iPr
	 CrE/asJWXhUtxQ35Jqv1CTmcYSKu8MaBtYG0cVEf05zdfmc39APinzOFfruElj/QcSi0n
	 UXMwGnRSiKPmAk1E6pty0sq+ApvoBi5WaAIUM1RDJ6NRb0Gt3TKoCfTTy1n16r9f9Lol4
	 KmA+nHqbmTRXVqjmBKg0Eug7FpuVmFABH1eizqu3D8nvMMiABT6NtmmHO5FD4zoN7KpyT
	 HDCYCfPRIGxfPSV8Idq218cO+QntfE/vJsICgCPvHfPOsd+c8YHxHaA9eE8MLChKzWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGN9WcmM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F85606A325
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGN9WcmM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695841F000C4;
	Fri, 20 Nov 2026 12:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177308;
	bh=DgsEZjUslj1Yrfr/vHzcv5cNZ+mqUn4KMypBjJcjvK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGN9WcmM6DR/NxzjuErTAVn7kUfw+11FU5xkNX4vPqoC/WtrIXi93HUQEHp0q9SpX
	 CRdfFrBQo2Xdr+EiG7lmnCzReGBqYJZeDsA4WJK4ZdMUupYQQoVJ87J7Wkz9jsgZu5
	 k4a0Jm4pkc+ITYQmnttK7wEjsb449T1AYAXpTyMqWuciWSeCYUKnY1Z4Y2kZ693eQC
	 1KT/H/53CsDOwLfcYA1BzYI1QPd6AjoN1BzlqSZ4wB3G5KQTogScYaw1kev1Zk4Awx
	 8LhN7EVKyK7of5QXboavfmWnwUUYnoUNnyMFxHhfeC5FGVkPz+wuMdOudXoYMKyDd/
	 fmNwiOUONRTrA==
Message-ID: <sashiko-outbox-225135@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in
 sensor_hub_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ayaan Mirza Baig" <ayaanmirzabaig85@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261120121256.35339-1-ayaanmirzabaig85@gmail.com>
References: <20261120121256.35339-1-ayaanmirzabaig85@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:21:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] HID: hid-sensor-hub: NULL dereference in
  sensor_hub_finalize_pending_fn()
--

commit 5391cb83740840042fa3d18d4f3751bd37f573af
Author: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>

HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()

This commit moves spin_lock_irqsave(&data->lock, flags) from
sensor_hub_remove() into sensor_hub_finalize_pending_fn() to avoid holding
data->lock across device_for_each_child().

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 028e70ec7bace..4ade5b5ece565 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -836,9 +836,13 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
>  {
>  	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> +	struct sensor_hub_data *sd =3D data;
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&sd->lock, flags);
>  	if (hsdev->pending.status)
>  		complete(&hsdev->pending.ready);
> +	spin_unlock_irqrestore(&sd->lock, flags);
> =20
>  	return 0;
>  }
> @@ -846,16 +850,13 @@ static int sensor_hub_finalize_pending_fn(struct de=
vice *dev, void *data)
>  static void sensor_hub_remove(struct hid_device *hdev)
>  {
>  	struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
> -	unsigned long flags;
> =20
>  	hid_dbg(hdev, " hardware removed\n");
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
> =20
> -	spin_lock_irqsave(&data->lock, flags);
>  	device_for_each_child(&hdev->dev, NULL,
>  			      sensor_hub_finalize_pending_fn);
> -	spin_unlock_irqrestore(&data->lock, flags);

[Severity: High]
As reported by Arnav Kapoor on v1 [1], doesn't device_for_each_child() still
pass NULL instead of data to sensor_hub_finalize_pending_fn(), causing a NU=
LL
pointer dereference at spin_lock_irqsave(&sd->lock, flags) whenever a sensor
hub with child devices is removed?

[1] https://lore.kernel.org/r/20261119201555.185270-1-kapoorarnav43@gmail.c=
om

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120121256.3533=
9-1-ayaanmirzabaig85@gmail.com?part=3D1
