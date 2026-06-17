Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C28311946
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681573; cv=pass; b=GNYcG9Pr87M4TELQCpIBQOKTrG5mPmYq9lPpVqQckos1idNZnAPAh4sWpkd2kKwKHoGK/YHKWHjLeNzaZsVRYUGopItmXb/b9k6P/1cyZxxmttJ/E1zwwz5S5TVbNDXjvyiuWsGoYKvqP3D0YbJNlAQJ95Ocntui8nPj92rLYI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681573; c=relaxed/simple;
	bh=Byom1zGxQPYVVK73amaOs55VFHXFRc523eogxv8WVRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fat6DTzeYzOTwU6RU8UTOugEJATlTuLxO4dtWSng1YG8MSKOGjEnrMATWgF5x/8UiXL/V/wkhUIGjPMMIg/IHuqCippF99omKJ9S05xnM3FBEZWQA4+rBPHhvRMZd9jlg0mqOy8wLrkKEavrXGBeUlhbUMQ8rdZ5KDdxiFWG4d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6bTfk16; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6bTfk16"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7fd6b4d5d49so5708107b3.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 00:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781681571; cv=none;
        d=google.com; s=arc-20240605;
        b=Z7kIrCEII7YHMMY1QPg2A2eL+wb5Wu/aLC0QBcCK/ztpzw5Qz2A0UCzSGCTi6fEAok
         ua2iOQzXC6DiwsAk7/yU+BO8dyN54uv2flMIL+vaa2nzls0vqOcAxtRDmo8FgYOYsNN9
         +2M23XHxKQ8GiLzVzkUjoyUU6OrpxMC8lo+cSyS9wgE7Bw9C3qCBDFZwHNdWFG5rjd0+
         ANBpKnocWoTJsKoRO22tK2EiJJUHPBGgDtOf6WjLhoppdM36XHEkl6b1buIMyY/3qwS6
         6unnTwcnfpebjG0ZXSaUL1qvSpMI9O1TFdTE7axIKSzEl4jYGxZu22uVYyJhtr/5iVlV
         P7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JEZj+zhbe17quYQMCn/S6B5vd3nTrZeVnYFHhTTunWA=;
        fh=ALpNydO57yeJBdif8qHqZqldgZvgcUZ25OQkfQXYFSw=;
        b=etUw/MG8BE5mLvGM5X1bWE1wF7QiJUDe1bAqZnKzR1LK3l5Xl5jG2PRfZ9yT71Tznf
         kMISBfS8tS82v2eqeveFFB2jOBQ+F2FhIFb3DUtH86v2LGZApdlsShLb8kSrQvWCmzAm
         uRuJ2/BLoQxm9y6DcLcDAE7xWvYkejh2L/guk19P4LRf0upwvpBZT5zIz9CrVciwepDN
         ELWz+55+2BQwUMLcnEmatpUzRXPl83S+skTJ8a7inxFX8ewrhECv1g8D5sqhDhCbDYiK
         V0sKYs9/kwx5zCbJE1GKfZTL5Fhshih0OPQ9gK2BQuvtYtLBawHn4BbkljbLu6VT0ghv
         bJag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781681571; x=1782286371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEZj+zhbe17quYQMCn/S6B5vd3nTrZeVnYFHhTTunWA=;
        b=O6bTfk16TVPSV7WwLHDGhb+ahhf6AJKJ/3YMRYkh5e3x+zIRKEKb2jBcXCZwwXk1wP
         OUk8tHG0tGqfnt6GGyHqe5meadPeGxTPH2NP8EjBUdgLr16577e26VBr85/MEvtQ79tF
         ZADPFZ0ClOIExanl1wmcfdTVVZc+PXiwvwaCImhfc3oQgag9zJdMd+MYZRWCvfYYdOZV
         JuV1+VRbx7IbWDyqbUSICc0BbCfoM0YBv4XsaPzttm6NMTSl84IH6ItCJD+AS5b0eNN6
         feJl8Se8tDErEMF197/VgiEkv9hNVpbSVQq8+lkwH2Sl4LLTCfrx3dgKI1YeoZqHq22p
         DfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781681571; x=1782286371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JEZj+zhbe17quYQMCn/S6B5vd3nTrZeVnYFHhTTunWA=;
        b=TMVqcZ5RfMgODTiVbytF+yOj1ZSqglJHsBlM+9AWjmFeXIXOEFKkwqTEnx939QWfl1
         7NfEqFbeHjvv3h2kg28y0ldWZbt9IUmxZKxjytae22suQ46d02xrO0ZAArSkjt8mNsJh
         AbDDJOoxG30nH/5CbDB1HpTbZNtLAnhx1sLM0lAJ35QeFPcRp+7m0w1gBYM75frQLT+V
         8+FrcUml+hptAisQLXsDKEYTD+G3M3EIJ4IzJsErrvEwD0q0YKZw/WKMHYSaUK5aGVri
         26v1oh8oZxAL346A8m+5djdUm3l/tWt2+64vIhWw0bHwPJbrCm34Zq8xOkejFsT07TDG
         otSQ==
X-Forwarded-Encrypted: i=1; AFNElJ97tmVE9Q0ZpI/mnqf6FagPoMuOX+eoaJSOC55xGiaKwv/pF4sJfg1tTGlM82nG22j4rI8pRuvLsnugCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlulqVogL+LloJvvOJxIM0ZbDMZIg4ZEt0Ur5y8VSqAc/rzZe
	Yd+REN6xNrKP6NlV2s99yFu6wI0kJPo6CF+hq9FFnu8XaBFPA/kLE99DcS/bcp+E6jGAAkn8FuP
	SLRJP9C1eAxRJ49u8aU6zc0HIbVXI924=
X-Gm-Gg: AfdE7cnyXHaKVamDcSqA/67AAJqHj8XZJDRQcjmpN+sE05W7zDK9+IOQajurhSuSMrJ
	9GQEd/3nqOaQMoO1/vYT9W1gJx/AiM29QnOqb4V49advzwm1lxCCsfGZZb+Lydh5H6CVbON87cK
	bf/4vqD/S6DDFDzGAvcyV3rFuq1YFG+yrpwFUFjxV+xMGbNRzz+CTZEYh+U3bGlNeM6F+/JOi77
	cAnLKheIEyoOrTRzBGgF29ZmTJ3g77reaxV9DTxD8qyIoTZIFu1fyrCMF+QNqIQKDaNOQ==
X-Received: by 2002:a05:690c:11:b0:7c6:e377:1dc6 with SMTP id
 00721157ae682-7fe7051621cmr15709297b3.0.1781681570744; Wed, 17 Jun 2026
 00:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 17 Jun 2026 02:30:37 -0500
X-Gm-Features: AVVi8Cd_HvLMTsqngLzpvQafjQsoXhetBUbHiz4Sgi5h0vcMxswj93lMAZqNo9A
Message-ID: <CAKqfh0GEeyQ3UMuMupevgPfCon+zccAv302sV5YKCETWMua-xA@mail.gmail.com>
Subject: Re: [PATCH 00/11] HID: iio: warning clean up and prefer kernel coding style
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Zhang Lixu <lixu.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 5:26=E2=80=AFAM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> Hi all,
>
> This series updates HID IIO drivers to resolve checkpatch and
> kernel coding style issue.
>
> This improves readability and follow standard kernel coding style
> No functional changes are introduced.
>
> Testing:
>   - Compiled with W=3D1 for each patch in the series
>
> ---
> Sanjay Chitroda (11):
>       iio: hid-sensors: add missing blank line after declarations
>       iio: humidity: hid-sensor-humidity: align parenthesis for readabili=
ty
>       iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
>       iio: magnetometer: hid-sensor-magn-3d: align parenthesis for readab=
ility
>       iio: humidity: hid-sensor-humidity: use common device for devres
>       iio: position: hid-sensor-custom-intel-hinge: use common device for=
 devres
>       iio: temperature: hid-sensor-temperature: use common device for dev=
res
>       iio: hid-sensor-magn-3d: use ! instead of explicit NULL check
>       iio: hid-sensor-rotation: use ! instead of explicit NULL check
>       iio: hid-sensor-incl-3d: use ! instead of explicit NULL check
>       iio: hid-sensor-accel-3d: use ! instead of explicit NULL check
>
>  drivers/iio/accel/hid-sensor-accel-3d.c            |  2 +-
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |  3 +
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              | 58 ++++++++--------
>  drivers/iio/humidity/hid-sensor-humidity.c         | 48 ++++++-------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 80 +++++++++++-----=
------
>  drivers/iio/orientation/hid-sensor-incl-3d.c       |  2 +-
>  drivers/iio/orientation/hid-sensor-rotation.c      |  2 +-
>  .../iio/position/hid-sensor-custom-intel-hinge.c   |  2 +-
>  drivers/iio/temperature/hid-sensor-temperature.c   |  4 +-
>  9 files changed, 102 insertions(+), 99 deletions(-)

Firstly, for all of the style patches  (1-4, 8-11):

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

with Andy's comments.

Secondly, the style fixes are all churn. It would honestly be much
much better if you were to squash those (even despite the
one-logical-change-per-patch rule).

--=20
best regards,
max
