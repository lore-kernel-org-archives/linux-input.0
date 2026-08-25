Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479AF3DBD5B
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645628; cv=none; b=BNURNfjfHEakHv8BjdRKPYJbKALxvvf9rxI+j8PGxk1lQDI2Y+Ezm7pD6lo7W2Gsdh5Z9R85yceF81CjzlQVPVXJZg0wFLmWY1pKKaY9zULif2l8cegHZT4RUrdDWFyvAPpPAkIBFtfw/vpy60bJEdfpKaw74Ed72HUM7vUPSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645628; c=relaxed/simple;
	bh=KDRmRdX5XB9CEj1j6CcQhRvh9dMDghgqwdgxgbWmk/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fb6HqsTBRDanr9+hv9ZHEzCrEM4LbeiiSVp64s/rbvWlFbFPBiPEva7uZ4ZPg0BuAYXdU2xxy1ZVkshOclBzn01GlN9F4h2Cpn8sv59YqpwQjDo81PN55g3v/kwx99IPsjNjTqWSBXwMukh9j90gkGbyOGYQfI1T+PTKVBDxDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYWjq4b0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYWjq4b0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4C51F000E9
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 08:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787645627;
	bh=+QTZdJ4yAYJg5/4kWADx9YMkbH/Y7qCB1mZmjIu8RaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZYWjq4b0o/aebnkKj/tWqyxPPVGai6CDq2DPLZb5QeK2DNKu6WFWjRYD636LjJ/hr
	 lZsqIZ5LpwVhM8JfVJUPjsYzF5O6MtOUx1WgYcVkuL5AtG/567xgHvzx9ZdybMmSQb
	 2wE5V1JbC5ebzNtRzLvvQh8r/uDRoErZThJ5Po98ekehPLrfAMNjmsCWf1ahz2SrVY
	 k6g4jIVWfysCYd7QReR/wC0ZDP4GNQE5DlPPSnVbQJuZH9qIPceZv3LP+0I5nD0yGM
	 EJR+KDBfWN87N7jVlNOlvwajjcXkWhKTTUxpY5VL7lmm8e0sueO8PQhZIcE4+D81Cb
	 Qn9fo1YYk5+wQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so643392e87.1
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 01:13:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RopBDTYWzqdnkxINsm94dpVVyro7/EOEtsJKXD9CT9QkMU6si8b4j+AQK7Bw+IuBEPI68Ekg9WBPvPw1g==@vger.kernel.org
X-Gm-Message-State: AFuF++lYTX2zR3Op/twV5GfoOyal+kCrjQ165NQEeo4lNWIkwd1gEPPo
	ObHM5d20pj1WADzRqE3szmWWHNrZFmPQGSlqnYJ1ksnLnkLrdR+SlL53iTZYLHsDheEsuHaA2Dt
	SL2XnDhOa1rKoR78s1ADklONOAUPZEqE=
X-Received: by 2002:a05:6512:3a81:b0:5b2:aa5d:9ce7 with SMTP id
 2adb3069b0e04-5b49c79e6a9mr967204e87.10.1787645625882; Tue, 25 Aug 2026
 01:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822213941.98882-1-michael.zaidman@gmail.com> <20260822213941.98882-10-michael.zaidman@gmail.com>
In-Reply-To: <20260822213941.98882-10-michael.zaidman@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 10:13:33 +0200
X-Gmail-Original-Message-ID: <CAD++jLmugu4-1_XvqwV1xYw0L8F3V6CDP8qW3PCSvVWY6gqh4w@mail.gmail.com>
X-Gm-Features: AcwNN1UDJlLy-YyJD0zWZAVD8kOpDK1dBDVnIGblWqGLnK_ZMutrNV7bdRuQJM4
Message-ID: <CAD++jLmugu4-1_XvqwV1xYw0L8F3V6CDP8qW3PCSvVWY6gqh4w@mail.gmail.com>
Subject: Re: [PATCH 09/13] HID: ft260: gpio: group sysfs attrs per HID interface
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Germain Hebert <germain.hebert@ca.abb.com>, Rio Liu <rio@r26.me>, 
	Bruno Giacomazzi <brunoceg1@gmail.com>, Christina Quast <contact@christina-quast.de>, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

thanks for your patch!

On Sat, Aug 22, 2026 at 11:40=E2=80=AFPM Michael Zaidman
<michael.zaidman@gmail.com> wrote:

> Split the single sysfs attribute group into per-interface groups based
> on chip mode (DCNF0/DCNF1):
>
> - I2C-only (mode 1): full I2C + GPIO attributes on the I2C HID iface
> - Dual mode (0/3): I2C-facing attrs on the I2C iface; GPIO and UART
>   attrs on the UART iface
> - UART-only (mode 2): GPIO and UART attrs on the UART iface
>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Drop "gpio" from the subject of this patch, it's all about sysfs
nothung else.

Yours,
Linus Walleij
