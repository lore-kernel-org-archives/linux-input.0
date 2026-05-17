Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538FE2FE074
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779049200; cv=none; b=N4FzW1OcGF/ZgbwTSo4ppCLJZE1q7Ovmls/8wERnKwXexiC4OnQtH5/VxZM6ryHc5TYux43ckJxXOMbPwUGLwUJpXnb9/iVdJy8TQvY7tpFO+9Yfrk+bEq9JyFtmOeXCdZqDPWeVGJxF2N3e98KmSzeSAo4DN5ONf32vEZDRHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779049200; c=relaxed/simple;
	bh=KN0a6nuhX5nWRhu85gb98t77AbTfd7ZdFz27bWhNg/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAA7FJjY0w7PbuL6VOlSLD1E80N2ihTdy3NO7az0C/gzyLbWn+VtNQWR09lAQ209K82MIPu27/M0L8Hm+YZ2+4JOgx839kJvXqR6ytnHLTKJvvkb+Ug6rLv2MuXejFm3jx5a5P+IccY67/xCj1nW3VMsJchPYg7sIqjpLhXc1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZLvY6I1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZLvY6I1"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso478034a12.1
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779049199; x=1779653999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xAdsDoDnh5G8WxjQFs9oyIfSvq1lXarEEXfQD3J2Ugc=;
        b=VZLvY6I1G9SbV1i3iG89Nzu3oK1y1Du9xussEaRhwXHphG7NZUcWpOQIl/IWJDIzOO
         OIR+L7F6NH3QWoZbBO9TrciWjyY1vVqybw9h9v8s+B7njnfLX95us0cE7rFgJ7FrZ4Hh
         oU9fQYv0T1dZQVpNVV7mxDgbE9lmT7WmVw4i3knTTqrNl6r7wJE0BXv954f8lvfC0lXG
         N6BqmptWAAZJaUWYnRbKHwCB+u2IqT8X37Bz/PyACdqnElvUzay+c/2ZQKe/QBJkqdGj
         Urc0y12GRX7v69IzmLI0D1C045LiGRhLFHfWrK+qe05zrwpLVQ/N5AJRv9KjAvBaO3DP
         FjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779049199; x=1779653999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAdsDoDnh5G8WxjQFs9oyIfSvq1lXarEEXfQD3J2Ugc=;
        b=Usdbq5lT1hh8LJJzsNqDV1QTSIzsduUmHx0eVG6j9bvQVOieNfGiP8Nwtw9mKT3OBK
         xHfBQ/wgSOIQzSG3ohfCL8/f4zhd0V7blwtXhpVlNcJk+TKiXlxE7mKoX8Lo9x7nhdeL
         rDHook3cA4EHAVvCN1DZCx5VAxHOT2EpwL7L3LwuiMa2s+RCT5u8QjtXuiBzDYgefg40
         a5LHfRuT82hPRyqKvkYt1vJHaEyqIsHTwXZWJOahGZJY+lcB3DCjhlSjKNX4LzkZwj5b
         XcnXfmQUXo8WdyaPXvgNHV9qVGtu3IifWZWDPcVYtRlOcJdrWD5A+F3urMjFn6fovlzK
         MX5g==
X-Forwarded-Encrypted: i=1; AFNElJ8VldSGUvx7eLexEn1CinA3r8fKjUrQN0Adc5VsR+Suc2yBKRoKZaQ1G0hPQM1gIAjxYCtWs74mQuqoCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ON6GYemLZSEYocgDeWuoThP5i36IS98hkl6hPZh7GuEXb4XZ
	Ua0AKtmDqafW8NtqkNdEdD/D3lLOZZ9h3aVPaVqvwdSMgaEZO7FvIHku
X-Gm-Gg: Acq92OE+7lO5L3Fyy7rbP2iUYg8cuhrIME1DqN4OlYWH1DaOKrbHm5ngXrvINsV0X2m
	JbARitN2bA0yS4vJbnYPdtrXZ9Gfj57M/NLqcLWUv/7c2apTeE6JgEYz07CsJMpjw/ciOx94O8B
	/fs2bHFyN8qOr9W6B0n5PGEP3kqV6oBfpcloNZA2lHSdiqHVyLCn+YsUqW67Fm1xsWK3KJk38+J
	EG7HzuN4qNqek33Pe3H0or/A0v7o+XVmxSxDGL5OgzBdci0hNVZ/XAerpEa3wE94aCz0Wp0lCQ/
	1US0+OwJXaYNQTmg9FC4ZtlrstsHxGI4MOTnLZKjmCFi5qIGKS/RpH6AS20ot2SVkvdJTOFe1dj
	Z852WopHLTUWrwQO69XRHvXKgOfj08l6whnMbb4iHmVfeUhk/PfAUrIjsoT2MGYnYDuhGw4JMGv
	WIZtD3xwD/+2a7YuLx0TD8W/5R4sqrYPaIWePH+eZeMJMVw03RLro=
X-Received: by 2002:a05:6a00:2eaa:b0:837:e9cc:d460 with SMTP id d2e1a72fcca58-83f33c2a4b0mr11497444b3a.18.1779049198596;
        Sun, 17 May 2026 13:19:58 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cca8sm12374941b3a.56.2026.05.17.13.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 13:19:57 -0700 (PDT)
Date: Mon, 18 May 2026 01:49:51 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: "Zhang, Lixu" <lixu.zhang@intel.com>
Cc: "jikos@kernel.org" <jikos@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"Lechner, David" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
 cleanup
Message-ID: <agoi55wCo//eY1YQ@hu-ckantibh-hyd.qualcomm.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <SJ0PR11MB5613D4ECB8081985C3F2D82293072@SJ0PR11MB5613.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5613D4ECB8081985C3F2D82293072@SJ0PR11MB5613.namprd11.prod.outlook.com>

On Thu, May 14, 2026 at 02:47:52AM +0000, Zhang, Lixu wrote:
> Tested-by: Zhang Lixu <lixu.zhang@intel.com>

Hi Zhang,

Thanks for the testing and validaiton.
I hope you validated the complete series, including the unbind flow for the
drivers using devm API.

Hi Jonathan,

How should we take this series forward? should I extend the series to
cover remaining HID IIO drivers for this devm API, or this series can
applied to IIO tree first and sent followup patches on top of that?

Thanks, Sanjay

> 
> >-----Original Message-----
> >From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >Sent: Saturday, May 9, 2026 6:11 PM
> >To: jikos@kernel.org; jic23@kernel.org; srinivas.pandruvada@linux.intel.com
> >Cc: Lechner, David <dlechner@baylibre.com>; nuno.sa@analog.com;
> >andy@kernel.org; sanjayembeddedse@gmail.com;
> >sakari.ailus@linux.intel.com; linux-input@vger.kernel.org; linux-
> >iio@vger.kernel.org; linux-kernel@vger.kernel.org
> >Subject: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
> >cleanup
> >
> >From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> >Key highlights:
> >- Prepare change as pre-requisite for devm conversion for HID IIO
> >  drivers by removing redundant argument
> >- Add devm API to setup trigger and clenaup resource using
> >  devm_add_action_or_reset()
> >- few cleanup and prepratory changes before updating driver for devm_
> >- few sample driver update using devm conversion to auto release resource
> >
> >changes in v3:
> >- Added cleanup and prepratory changes before adding devm_ API
> >  conversion based on self review: 0002, 0004, 0006, 0007 and 0008
> >- Address andy's review comment on commit message and coding style
> >- v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-
> >sanjayembedded@gmail.com/
> >changes in v2:
> >- Following input from Jonathan and Andy, squash initial patch v1
> >  series in single change as individual change should not break anything
> >- Add devm API support and two driver using the same
> >- v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-
> >sanjayembedded@gmail.com/
> >
> >Testing:
> >  - Compiled with W=1
> >  - Build-tested on QEMU x86_64
> >
> >Based on further feedback and reviews, I would extend this series to convert all
> >HID IIO driver to use devm_* API.
> >
> >Thanks,
> >Sanjay Chitroda
> >
> >
> >Sanjay Chitroda (9):
> >  iio: hid-sensors: drop redundant iio_dev argument
> >  iio: hid-sensors: cleanup codestyle warning
> >  iio: hid-sensors: introduce device managed API
> >  iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
> >  iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
> >    devm API
> >  iio: humidity: hid-sensor-humidity: cleanup codestyle check
> >  iio: humidity: hid-sensor-humidity: use common device for devres
> >  iio: humidity: hid-sensor-humidity: use local struct device
> >  iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
> >    using devm API
> >
> > drivers/iio/accel/hid-sensor-accel-3d.c       |  4 +-
> > .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++-
> > .../common/hid-sensors/hid-sensor-trigger.h   |  5 +-
> > drivers/iio/gyro/hid-sensor-gyro-3d.c         | 16 ++---
> > drivers/iio/humidity/hid-sensor-humidity.c    | 61 +++++++++----------
> > drivers/iio/light/hid-sensor-als.c            |  4 +-
> > drivers/iio/light/hid-sensor-prox.c           |  4 +-
> > drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 +-
> >drivers/iio/orientation/hid-sensor-incl-3d.c  |  4 +-  drivers/iio/orientation/hid-
> >sensor-rotation.c |  4 +-  .../position/hid-sensor-custom-intel-hinge.c  |  4 +-
> > drivers/iio/pressure/hid-sensor-press.c       |  4 +-
> > .../iio/temperature/hid-sensor-temperature.c  |  4 +-
> > 13 files changed, 78 insertions(+), 64 deletions(-)
> >
> >
> >base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
> >--
> >2.34.1
> >
> 
