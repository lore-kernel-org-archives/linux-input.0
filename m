Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C918B3DA5A6;
	Thu, 11 Jun 2026 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179160; cv=none; b=mxL5u/jM5ougZEMhFKK443uqlnDnOSzUNUJaAsXtonASPgP7fkqxq7zWUDf8A/IAAhCH6AYNx6rbA2+TQINm2qMyYklGIlC26LAiLChlSgfsY6I4zjMdZpPxO5zVGKfhSXM/ds4NjPD6k0Y+Q48meFPbywWknYLjrNKIQhi4ohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179160; c=relaxed/simple;
	bh=0UAx43NDKA6uCIcpn6dmvPdreXgDlsbs3GB9AFVRPFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFQJpl+7UschlPEzRT+uDUBLeYDPSPC00ESc8WiBgueYLyEKWQfd/imjZKlUQjT0zWk/NEvKjUc2Ia+HO+JWktj8qq4NPRoQ3jAgvsnJcjDqGLdXJhPsGZbxp8bn/hDQLXu4T5FSAIhmlzKiE1RPsQLAaP30uvXYsK7BFWcZjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn5SnWIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn5SnWIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618001F00893;
	Thu, 11 Jun 2026 11:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781179159;
	bh=UIPer9977gK9vwildVgr3HJ9cefkhzAYfl9HAsav/8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qn5SnWIz1BkvNXg489kY/H5F66Yd4MDvz43hbA37/tv/LIw6IjyGvO4sE7wICMeAm
	 yzp6fVU4JXBELK7jxVR+6S1Q8SuIrXllLGbhNSlJ76w5vJn/dej+F2HsvyMmIBDsvt
	 9pSFkf52jjOy4iTtiKXEaiVyNjhHYA9kgV80/eTT9fdnR4hlknuh2wGVA2DaTLH4vV
	 9uC6vpwVXHGNlpUGvvXyHFQucl8ITAijnN9QlSiMQHH9RRGdM7BvqWdzg3yOmFizdU
	 0K3rbZfoC1EMbp3K3Rr6wZ+JLRkA7p7eCrn31/pJmI0Lqt6tRo1TUsys3E0dnaameu
	 CFB6FCLsHAUyA==
Date: Thu, 11 Jun 2026 12:59:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Maxwell Doose
 <m32285159@gmail.com>
Subject: Re: [PATCH v2 0/7] HID: iio: basic clean up for usage_id
Message-ID: <20260611125914.311c7d03@jic23-huawei>
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 21:07:01 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> Hi all,
> 
> This series updates all HID IIO drivers to use 'u32' instead of
> bare 'unsigned' for the usage_id parameter.
> 
> This matches expected callback API type and improves code clarity,
> as HID usage IDs are defined as 32-bit values.
> 
> No functional changes are introduced.
> 
> Testing:
>   - Compiled with W=1 for each patch in the series
LGTM so I've applied it to the testing branch of iio.git. However, I won't
be doing another pull request this cycle so this tree will be rebased once rc1
is available.  In meantime I'm happy to add tags or indeed back this out
if people have feedback.

Thanks,

Jonathan

> 
> ---
> Changes in v2:
> - rectify commit message with input from Jonathan
> - added reviewed by tag in all change of series
> - Link to v1: https://patch.msgid.link/20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com
> 
> ---
> Sanjay Chitroda (7):
>       iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
>       iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
>       iio: light: hid-sensor-als: use u32 instead of unsigned
>       iio: light: hid-sensor-prox: use u32 instead of unsigned
>       iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
>       iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
>       iio: pressure: hid-sensor-press: use u32 instead of unsigned
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 6 +++---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 6 +++---
>  drivers/iio/light/hid-sensor-als.c            | 6 +++---
>  drivers/iio/light/hid-sensor-prox.c           | 4 ++--
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 6 +++---
>  drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
>  drivers/iio/pressure/hid-sensor-press.c       | 6 +++---
>  7 files changed, 20 insertions(+), 20 deletions(-)
> ---
> base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> change-id: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b
> 
> Best regards,
> --  
> Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 

