Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8836A033;
	Sun, 19 Apr 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776604264; cv=none; b=ewGfbGjsP98Qtmi8c6PyZtPgEomSpbpHNIrkDYHrWOH5thfCTNSha7ntLM+bnsRflJesOA9IEjoWj+5oT1YvRdq+5fQfJduZqPHS217pSSFRvVGQMOjjR5dhTTEW3uv9/HcuzL2agqmKw/G/Kxse7tie8s93H3ZuKN3JYYZrys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776604264; c=relaxed/simple;
	bh=qlW2n7rRtX92Ozsh+NeUYTuGmVNLg3xBhGV32Iuhc2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpfZOdHsh1r2uoVH+9QvPfKGK2HIWLx9Cfo8qqvhl5RuCCbCwfB19fy2uuxabqiWGWqKFnH44JBNLJljElon98MTZV5JEsjw8BrEq5ks/5SdJTPlwLK4JvLeQ6EqUGi6xbPRZsPmuA2ZUQapJXqjw+I4jWUYTwMZrKmdQogTn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp8L/oH8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp8L/oH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BFEC2BCAF;
	Sun, 19 Apr 2026 13:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776604264;
	bh=qlW2n7rRtX92Ozsh+NeUYTuGmVNLg3xBhGV32Iuhc2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jp8L/oH8tolLDmRpoClWYDmNp7I1hzZ/Q+XhXziGjBwKbVeS2saKbQvoM+P68pbuP
	 G7QokF/G+qEgp4iNUs8mURTJhGYeQsTLWmgFfyWEulGuW+FAjgaOHj/p4mcv+x/JPR
	 VtMOQQocnX+YqgFU2QSUkS4+b+8PMEg7FnMnxX+kzxJnvNtYr+MLU+m1XECoN4iAo3
	 IL8PndPnPgXD61oIV3GiGkDyTvSkv/My1VlLji3jtSmN4/x3uglB0LfP8BB2rqdtE4
	 gKAq3NuzUbrAY3kRxDa3vyXRGQd8kX77X5M+SRXlsyhH+kQflKpREXtR3HsxRIxmSg
	 NS0wjgiIpQcNA==
Date: Sun, 19 Apr 2026 14:10:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TmF0w6FsaWE=?= Salvino =?UTF-8?B?QW5kcsOp?=
 <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
 jikos@kernel.org, nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Message-ID: <20260419141056.64abf777@jic23-huawei>
In-Reply-To: <20260417225959.16688-1-natalia.andre@ime.usp.br>
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Apr 2026 19:58:43 -0300
Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br> wrote:

> This patch series introduces a generic helper function to handle channel =
bit mask adjustments=20
> for HID sensors. Currently, multiple drivers implement identical logic fo=
r this task
>=20
Other than the stuff David already raised, all looks fine to me.=20

> Nat=C3=A1lia Salvino Andr=C3=A9 (7):
>   iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
>   iio: accel: HID: Replace method accel_3d_adjust_channel_bit_mask()
>   iio: gyro: HID: Replace method gyro_3d_adjust_channel_bit_mask()
>   iio: light: HID: Replace method als_adjust_channel_bit_mask()
>   iio: light: HID: Replace method prox_adjust_channel_bit_mask()
>   iio: magnetometer: HID: Replace method
>     magn_3d_adjust_channel_bit_mask()
>   iio: pressure: HID: Replace method press_adjust_channel_bit_mask()
>=20
>  drivers/iio/accel/hid-sensor-accel-3d.c             | 13 +------------
>  .../iio/common/hid-sensors/hid-sensor-attributes.c  | 11 +++++++++++
>  drivers/iio/gyro/hid-sensor-gyro-3d.c               | 13 +------------
>  drivers/iio/light/hid-sensor-als.c                  | 13 +------------
>  drivers/iio/light/hid-sensor-prox.c                 | 13 +------------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c       | 13 +------------
>  drivers/iio/pressure/hid-sensor-press.c             | 13 +------------
>  include/linux/hid-sensor-hub.h                      |  3 +++
>  8 files changed, 20 insertions(+), 72 deletions(-)
>=20

