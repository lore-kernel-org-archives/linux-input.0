Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DA376A10
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142173; cv=pass; b=pPF4Pg4DNBzzicNmpHaoRvHTFkDbs2iPp9FhgvlIvKPeHchS/yAz9vsOoBYzQgdDSqZ2zRmXU5RfKss9cPfxQAZQ5W93jnE2LuVcI3A2dBkoj0CdAI+z83+wGX9IP+44LIOhy33svh5B94I/p9S9MUa4U1Ew2JXralJyj3Yv01E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142173; c=relaxed/simple;
	bh=KQ7uEoW5q7ok/4PPv/9Ic71rSNFWcWnC9QQl4PvoEUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn8uXq5qGDTjKSY9ulHL+aZbWt2rwp1IeZqbgXdv03Qu4U62ANUnnYAX85axE0XZhjyIdo/NQ6Ey80mO3R6LVtRONBaNKoEBeee72zyN1jr/WoGKyqi2mO4d4QEpWC3mnR/3c6zJeb/wiUvfMux2Gb9+lyV69qAGscwYcHS/WiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmIwMH3v; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmIwMH3v"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7fdb04d774aso48776767b3.2
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 08:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782142171; cv=none;
        d=google.com; s=arc-20240605;
        b=D14P/NN3nBJIi6EEPZfC8BE1DxVTVjBGmismZuzAhdLPl2Euti18uBYhF4sygBfKFX
         siU/kYaZ4n9VI6q49Pspu5G+v552ywzw7H0Vt28NGh1VVWD22Kv+BgV5Q7HytZMu6oP0
         /B0MCA2hHWpcrgM3FJUPpQetlJvWtpmElQdD4rR0SydSJ0ZvuUXo8FTRFIjCxEkgm397
         4nigNLmbfR0XWKjK/dfT8rp3t0W9sfcmQGzncGSerkARdsq4EdAvOxlBC6qsnUsvvdPx
         mrpyOGhjxOyLkz38wgN2B24X+w1/0rT7OuWDz7VonOMk0HVmLsuYfck6s1M5ggZWMBbI
         ueMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KQ7uEoW5q7ok/4PPv/9Ic71rSNFWcWnC9QQl4PvoEUA=;
        fh=CvVjOSHqZ6F+w13+Yaw8zARL5+zQNwGYHhURUXLsLbw=;
        b=b8Z9kLB/vfeExLUe9IGzXz4Wi6TsUx222G+keCEsBDxQw8AV9tEs6Kjkmxwtb/x32q
         YRHZ/Er5IBWlrFVKDc2fybcM4RO3oB5I0z+LuayA11cMqPKQnthrcpsISAhr5iEf/HgX
         ZfU09V/rUMNuMmfa6+y4cLdJKy0kj7WEing1wDvRAEGQHM1YdRVR0fuD8hOojM0HnQVu
         6Eqdi3B6F1vf/Ni8dcLwMGygIXXqsLGgROhd3lAdc9z/GOOfYnsGllV3DtYM6GnsAi4F
         /ESZGes+tqkwWLMDt4MVB0uoDpZ0x1wdd68WI6j3eLJGesFanV9WOfmbz49t/tKboFsE
         aaCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782142171; x=1782746971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ7uEoW5q7ok/4PPv/9Ic71rSNFWcWnC9QQl4PvoEUA=;
        b=TmIwMH3vuLmpefS01ItJ5WbZx07d5SMPZUHumIUlTW+zdA9N7RWwwh6xP57br1MxtM
         Aldceh+WTP3ibVAgNbfSIHjVEF6Gzn47BzHItkP+9qJ5pJYTH8EShIAVn8nWlVUB3TBI
         JEr9gq5QZQgvx4DrT1BLwUU6zFrdzIT6lvHyBR4PQ6piZbrKGLsNOlUiY/4qNd0RbaRa
         X4ZijXd6HG0ZEsDbktoqjMBuWIjHRbhOvvUh7dHWFjcHpXl//A4H8mQEHwsrTrwdrpiu
         hEzGd8mYQiNyz94nMqE9la4+NylxzV+o/C+se2InUmYj3A2NywJrCO1J6X4FUxv4f+Y4
         zgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142171; x=1782746971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQ7uEoW5q7ok/4PPv/9Ic71rSNFWcWnC9QQl4PvoEUA=;
        b=eEvOan8XEcKBpGvm190/r1AaAiDzlxwGHyq6sFbSGjz6RtnF8A+jMHBYWDo3QMwjuE
         T0CQ7eRn8KSPFVov6p1jFaH5eeq1RlID43AmSAxX9Nqq31F8/CigzIlmVMHJLeVrZQyu
         NnBqKX3eO9rfKRpjDaMxcGh/JPhFETA62VT1cc85p6qCKVvum2whscFdLiCkpRVppeDw
         hNK8i6A/x8XjfvQ7smGm7Va41KpMZPm1HRMhX2wocPTvTu4Jgap5BVTWJIS5eBmLtnbl
         RHZFOuKfjhAB2lDmzBbwKsCXcZ7PZ42SsfSBes1ytZWZizkE8cIQlT0BwJQ66BW7F/Xr
         KdZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVLVD/juECxoyw5UiOHmge9V/oyX+KwnEa2BYiGJfUYaehsK65j+a12vSDf/sEl5+6VTj3S009Anjkvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+v9bfggc7g+keWHrD4nEgtfuagn9dK/E8RYWTS+nWWD0hQxH
	8t0sn/cDvKCcppXp3NdaR8N+HnQrATFOGh6oPK8k7G6bDyF9QuZ5SqmbJ5U4/k5YXH2KhKTpk0M
	fquVbi8/qVoU5DI2OwubpGkKRhiRy3Tw=
X-Gm-Gg: AfdE7cm+dADuZ4NPOtVikEOcCaj8P9IJfDGdr7K+hYQE3fbj3HbCnBblRLeFH9c60/H
	4AKhAU6I8CeCg0Fvi1jwn9GaYAPHdLtoZFzUXLXvnezcWdYoyfNn76RSdkJtGLXLxdZU9RvfJmj
	hfkdshAywxdMWVPKEG11M8gZOpvwAPSXAyyH4BYxsl7XqvuQ4W7CQKF22GZ8kFsbqA+vGCcUmbA
	0oJku/VfhGZwcDmUujdzjyyADTEjP4qWNsFWt9vuldQ1wnjLO0UijetQNaoO0lLBTS0g3pzlQ==
X-Received: by 2002:a05:690c:3502:b0:7ff:8c8d:162a with SMTP id
 00721157ae682-80266843e74mr112915737b3.39.1782142170798; Mon, 22 Jun 2026
 08:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622052135.1804135-1-sanjayembedded@gmail.com> <767892206bf6a10de4122f5e1faa8481541170ca.camel@linux.intel.com>
In-Reply-To: <767892206bf6a10de4122f5e1faa8481541170ca.camel@linux.intel.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 22 Jun 2026 10:27:09 -0500
X-Gm-Features: AVVi8CdKjx1UPZeLJTKQy1YQKelEvDPdcHbYi8ty_vxr0rRtarCXghB4ppKXTpY
Message-ID: <CAKqfh0Hk12rA7wkU9wbse=n9qbOgbmxK0vhP6Enj-R2yKCohuQ@mail.gmail.com>
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	hongyan.song@intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:26=E2=80=AFAM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2026-06-22 at 10:51 +0530, Sanjay Chitroda wrote:
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> > Avoid using devm_iio_device_register(), as this driver requires
> > explicit
> > error handling and teardown ordering.
> >
> > Mixing devm_* APIs with goto-based error unwinding breaks the
> > expected
> > LIFO resource release model and can introduce race windows during
> > device
> > removal. In particular, the IIO device may remain visible to
> > userspace
> > while dependent resources are already being freed, potentially
> > leading
> > to use-after-free issues.
>
> Please explain this use after free case here.
>
> Thanks,
> Srinivas

My guess is that because the device would still be registered but
would actually be removed, sysfs still has "wild" pointers to
read_raw() and write_raw() (which don't exist anymore), causing the
UAF. If I'm wrong feel free to correct me though.
