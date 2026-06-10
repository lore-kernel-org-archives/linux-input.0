Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9992E9729
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108293; cv=none; b=oyKq7BWYetDwpsXS7PJWy6duozXdlA76irF4K5y7A6XEPvifB1CdUYMxBSqJXBoy2dGb9jp+HCozbdjY3d3ekQdE9mD7djoGEWq70jgNgWQtv3MAmBEyXIYL4tLXsdTaodBqn6cyleWXMgcu/nETmGrpkPqLbQleQ8uxpY44Rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108293; c=relaxed/simple;
	bh=F3lKU+JV3w4ziO7l8wGKyshm+wzLhk4Xw0mtMXtSSLg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EztpL7oOk7yDu/u/ELBq70sTYrsFF99Qnqa19lfGBHfbr3wlyo/HT2cldvnRbO/T0htqgi4RxfqcPVBKOu0U+kfQGrBmdtvqnsYUDu7BmayBUuDW+NBgp95VPdhTeTkCYm0/M/mWMk7emT4yDSFFg6UCO3SGqZPWPanMwYDBdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA+DCUxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA+DCUxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6381F00893;
	Wed, 10 Jun 2026 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781108292;
	bh=w4UPP7u3EBBwr3hraDk+e9NdaXyL1xSdq+TiYX2Ui3A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=fA+DCUxw1rApChh42dvJD1JGQhR+l9UErxV0+LlqOkHDbcY6cm1gK8oXlqYK/MVG9
	 nG6/YLhMwZ8HGzOLUYJEMGFT4srph/kOy/HOMXe1IqpWcKvfDFislFnwbhFJl0WF8Z
	 FqYLLHdjEMz+3GXYZEIjxv9XcH0DW8sqLAhexiOOIu10PyVcyhMuh1ezawvDshMT3f
	 5euil/aiFOaAL5mE2F1qRq/zgsOOkHqAbK0B1WfhEm7G2OqmLzP5pnJAseUKN1tU3W
	 Z0O5o17YnQxY2gBQyBDBZ3uxlps9jnc34EXl0veg0Y4E3EC7Krm1m1LQPEFNS3NJME
	 Vvip5BxrJsFpg==
Date: Wed, 10 Jun 2026 18:18:09 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 0/3] HID: nintendo: Add preliminary Switch 2 controller
 driver
In-Reply-To: <20260512200051.2534081-1-vi@endrift.com>
Message-ID: <q1756s75-2ros-6o0p-2343-2n36880s8q3s@xreary.bet>
References: <20260512200051.2534081-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 May 2026, Vicki Pfau wrote:

> This series adds preliminary support for Switch 2 controllers using the
> same split-driver model as previous versions. This is a minor iteration on
> v4, fixing some leaked input_dev objects in error paths as well as fixing a
> merge/rebase error when CONFIG_PM ifdefs got removed in 7.0.
> 
> Vicki Pfau (3):
>   HID: nintendo: Add preliminary Switch 2 controller driver
>   HID: nintendo: Add rumble support for Switch 2 controllers
>   HID: nintendo: Add unified report format support
> 
>  MAINTAINERS                                   |    1 +
>  drivers/hid/Kconfig                           |   19 +-
>  drivers/hid/hid-ids.h                         |    4 +
>  drivers/hid/hid-nintendo.c                    | 1504 ++++++++++++++++-
>  drivers/hid/hid-nintendo.h                    |   72 +
>  drivers/input/joystick/Kconfig                |   11 +
>  drivers/input/joystick/Makefile               |    1 +
>  drivers/input/joystick/nintendo-switch2-usb.c |  353 ++++
>  8 files changed, 1951 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/hid/hid-nintendo.h
>  create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

Dmitry, do you have any review comments to the changes under 
drivers/input/joystick, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

