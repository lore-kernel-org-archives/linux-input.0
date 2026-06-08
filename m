Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C133E00A8;
	Mon,  8 Jun 2026 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944121; cv=none; b=uOzyWentjNEB95fecvdgjz5PDT29xMuS6YVRsI81+/V+mrAV+rjNqzZ6QWENRDia3DqZSxJXcozwhA9VMvM5dHlkv3cFKfLsSr64o6IBnJU+r0OABB+blOf07DI8LNNtph5k0i1Oyj2jBbiD2SJ+V+042mcZTwhPFNavhWXc+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944121; c=relaxed/simple;
	bh=oeVa9ABLJlnIRPZxCrtOS2iHpQJNZHKn94cg1yiokyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+QjDO+XWInTpb+I9icEvx3D9TvUppK2xquae8e+8tz2dY5ki6QIiNryqYJc4PRtwF1BEYuUpShWqNn2ctckMm04hGhj0HhBUfjG8qldTWql34Iw8kbS1vxvYkg6M+0QuTiebxAy9e+Fx8cxNIqUqiLvpdIVoraE2MWaWxwVJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru37uSnF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru37uSnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EA81F00893;
	Mon,  8 Jun 2026 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780944119;
	bh=r054IIi4uHrItpFohYYN+G7pKeDbGo3cxOJu4v4px8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ru37uSnFj5D1QpTP2pO32R6Sf9990GFQScwljXd0UPo12MNi4oN0K8ru0G6tI232X
	 ntX8kWIpsOH1Mq6pSliAjPc1Q/Ao/SpeuFtkw11vuBkHDZ8UFp5VtEZnK0/CkWtwUf
	 6IUXcN8B3SukLj0hdf3oX1Cep1AisxHR21OeVheBme8H9Yt+5+mg9pCObsjQKzKo9X
	 y7dZkg3YmqdeGalz/nj3C8sUSWr/0aBIwXfHud/iapoHnnTlb77WL1pAHr3BFzDPCv
	 RyaFscnuOeAQoyn+G/FGgBJsBMNUlx3+ieFuTRmdlvxW2DWicOt/j/ClR4crEDnUVR
	 TF8U8KTYfpiWw==
Date: Mon, 8 Jun 2026 19:41:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HID: iio: basic clean up for usage_id
Message-ID: <20260608194153.2531cbff@jic23-huawei>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jun 2026 17:47:41 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> Hi all,
> 
> This series updates all HID IIO drivers to use 'u32' instead of
> bare 'unsigned' for the usage_id parameter.
> 
> This improves type clarity and ensures consistency with kernel
> coding style, as HID usage IDs are defined as 32-bit values.

Other than adding some more detail to the consistency part
(make sure to mention the callback signatures), this looks fine to
me.

Jonathan

> 
> No functional changes are introduced.
> 
> Testing:
>   - Compiled with W=1 for each patch in the series
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

