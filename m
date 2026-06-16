Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCE3CF1EE
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587414; cv=none; b=WMFmlAzY05bVTXDXCNZOhmcG3/oXjO9ORsg7x3SJzQPYfdEa5o0a3loHOpkAJl25EMyBS0WMUK1CrddkyqVTb7UdKQnikhDiqvJcMMvYcYZQKxoJRavS8v9BtiJMZWhTe/orKqvWw9u2GYzahEhJJB73Qr6e8eRdp/JC/tb2SIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587414; c=relaxed/simple;
	bh=WSzSqnfrZn/KFmtovl7BXsXVUQE7u9AOS2Ejz2DJAaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VxTKb98VwCtM8rsczEciF4CzX+xDtfAKQ40yPYGfrZSzz4noPf8CfMdVyCFYLdytinSP88V/029B9TtGL+r/zFmTKOsghkGtvcOQywNIZypfeTc371SOdNwilWYuoqNPpLjogoTQbrT7oBv5eObLwCANi21JuSXAw0mkovyLINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beCkw/5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beCkw/5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23E01F000E9;
	Tue, 16 Jun 2026 05:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587412;
	bh=Jieqt81uTY/D7StY5UFMhfhifQ4IT4/0AWRtyZAzNBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=beCkw/5um/0Q/ksfJI60UtUngLEWqdfBakgyrBFwW8Cek7IdKDHkWvyjMvVs734d7
	 x4SeXvNg9Q66WOR9g5hlOBS0aO4fpCv5zsO7pCXhO178F/UKFB0Ueu1NTM9kKbs83j
	 rJQ7jf3QGEqCOw/R9W0c7h7hhv1kQfha4Cu7IYIeerP04ExfJ6Fst0quiV17fGygDu
	 AlWdtqqWQMTAd7lySLAh1mzdIEE5M5imMl18BNpgYPLekAO/Ja4x04qUTD2WgOGN+W
	 kRGs4gzmECY6foVB2A3rYwGo+RQNKC2kKSlRJWU0/ZwSBM0BGLCgAOwzPZj5Q40Dzs
	 4uW7Qv948NMHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] Input: sur40 - factor out and move input device
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616051235.1549517-3-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:23:32 +0000
Message-Id: <20260616052332.A23E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Deadlock in `sur40_stop_streaming` due to waiting for buffers that=
 will never be processed if input polling is not active.
--

commit 7253dffc6b93516e6c96ea7370f123676e435b94
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: sur40 - factor out and move input device initialization
   =20
The input device allocation, setup, and registration in sur40_probe() is
quite verbose. Factor it out into a helper function sur40_init_input() to
improve readability.
   =20
Additionally, call this helper at the very end of sur40_probe() instead of
allocating the input device early. This ensures all video components are fu=
lly
initialized before the input device is registered (which starts polling),
and simplifies the early probe error paths since we don't have to carry and
free the input device if probe fails during early V4L2 setup.
   =20
Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index e9089b0c3e2f4..1ad68131e3a64 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c

[ ... ]

> @@ -647,6 +647,53 @@ static int sur40_input_setup_events(struct input_dev=
 *input_dev)
>  	return 0;
>  }
> =20
> +static int sur40_init_input(struct sur40_state *sur40)
> +{
> +	struct input_dev *input;
> +	int error;
> +

[ ... ]

> +	error =3D sur40_input_setup_events(input);
> +	if (error)
> +		goto err_free_input;
> +
> +	input_set_drvdata(input, sur40);
> +	error =3D input_setup_polling(input, sur40_poll);

[Severity: High]
This isn't a bug introduced by this patch, but setting up polling here
highlights an existing deadlock in the driver.

If a user opens the video device, queues buffers, starts streaming, and then
stops streaming while the input device remains closed, the sur40_poll()
callback will never run.

This causes a deadlock when stopping the video stream:

drivers/input/touchscreen/sur40.c:sur40_stop_streaming() {
	...
	vb2_wait_for_all_buffers(vq);
	sur40->sequence =3D -1;

	/* Release all active buffers */
	return_all_buffers(sur40, VB2_BUF_STATE_ERROR);
}

The vb2_wait_for_all_buffers() function blocks indefinitely waiting for buf=
fers
to be returned, but those buffers are only processed inside sur40_poll(). S=
ince
the input device is closed, the polling thread isn't active, causing the
process to hang.

Should the driver avoid waiting for buffers if polling isn't active, or
should the polling lifecycle be decoupled from the input device open state?

> +	if (error) {
> +		dev_err(sur40->dev, "failed to set up polling\n");
> +		goto err_free_input;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616051235.1549=
517-1-dmitry.torokhov@gmail.com?part=3D3
