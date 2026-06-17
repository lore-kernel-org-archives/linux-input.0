Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DC4A33F2
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715358; cv=pass; b=gGrUrbZAyTObCVwnNJVR0vmTjBOOtZiRrOdQbLmIOxGy4ISuhsqIDFMCOCtsb7r/LL6EU8FvH86wjuHuknspvZnf2WTKg3mvKAVR5oT9V7ds8g78Ck0CjOLb0Tc/Z/e9t9NyQ2N1lKHhpvrbHqduU+D74fdOSXQeQuKIpGgBFEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715358; c=relaxed/simple;
	bh=kgRJO7+eLByRWx2Oq5nyx15FBRZPHQJZ9gu86ace5ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OI4zj6cFlSOsStN0tKLbzgsfRyeASaAWesJugdoyb+m8zJ9OZQm5LWJBnMSj+s8wMls7igQKXUmsv4ovEj2AT/PchzkMKMKj1fz98vc76WbcEKgCeiZk6XvvnzQmIhLyX1wVs8QtgJs1X35m8fRLwhbmhwkFT7Gy6pSgodJQg0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BirJHKZx; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BirJHKZx"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-662bcc30fafso2364622d50.2
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 09:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781715351; cv=none;
        d=google.com; s=arc-20240605;
        b=ES1RPLryrYmip30mZvPg4Qd/BQ3jWpxdg++ODaYul0wCKeg3BI/2EZy3lDtsvMl4ug
         r/z5uUwsjJwjAbIRyePQRYkb8M8aaoCjU2gIIujbHaCK2ShrF9+IKTRRLM7uPt98o3ff
         8kh1jlrhVwOPr5yszuPh41CurBKWjl/ngdjG8pFbP55FvlHnAkerYOY/C8pgjZP9dTao
         2dPKdQFeAU+LSKIyJDMolMWQD9O3IuFivcoWe0wH1UqWL/5BC92lj0bI3hvNvRtBMjHw
         HMaLDOeiGAN4L5Lu+SKVonqIxJD08h6oqRmUi9j82KnUw0syIGkHYrCWS74xviZKTcfi
         QPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6bHOQcdruI9mliZJcGW/ry78gg2poCr76ORA042aozg=;
        fh=7H0hS5LZiWB2ojCjG115UoCtg0L3Pu4ck5qvoDAkFHw=;
        b=LY76/tV87Dgjsv/SLW7Hnds/0Ojly3N0nJf06WjRKylpdyjPR8JNlT1yP3lCzAWT6I
         f0Oo2h1rgNyCrMrx5fEanlhU9F2lg0ZpEZ2OHVywEc6dseZY86mYpOSUHLciPzD2e9AT
         UDutvshdw0JYUvYlic0YgijKiiVh3YyUNXF5rYdYNHVPmqQLGqrqhIkYJV2vDF2QZdyt
         IrZSWcw/xt8OcLl1DyGOCjljpidHRqPbF0+rwtbmGMJAb5q7W9++gUJi2QjMFx+EiBnA
         k3VIpYfvNINoLusaGuLP4Cx6LyGi4cp5c5lVZjRDGKo+qrNfCrS/n4Q04l7jjLCoe6Xs
         COug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781715351; x=1782320151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bHOQcdruI9mliZJcGW/ry78gg2poCr76ORA042aozg=;
        b=BirJHKZxSWgEnXyKZ6Vh+OkcK01kCMNFeV9Idhi79KM2glQGmvK8MQBemTkJqU2q5b
         iKDdv2aoHcPVFdxpHcNjGxxHfWNtpLCXUENA5uogQZXKZl/wFAWYLf1rQV9z+Bhlta7+
         cBwuKWEWW3ZZhEeHTRZepjnN5VkTv89RBcLsFrYIWwCjJ1em8iqpUPbj7Sbz6JWxyAVM
         Qm+u15PbQUY4/iUllj3XOk0o7tD3JChRIbeqyzd+2XtoOY5V+1AFcmpKR49jnUR8Ob1X
         wgRYUWZO1pCGFAZcdpDx9PMDMcYIkpMR0KV3D+bD5r47USObHmsUkyLCcIS6peZq8J4x
         lFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781715351; x=1782320151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bHOQcdruI9mliZJcGW/ry78gg2poCr76ORA042aozg=;
        b=LxeoeAMsh0xuAW9U4C/7zCn6sNCwdCISAplSJ7zpOUB38dh5IptEjZfZ+ZY8QXOQ3D
         rmFlT2XDqXfCKDtRoqFcnqFQrhtcQd9u/jjtVIgH6ZIl0wQL28DFpLpwlzJ3JTmnDhnx
         0asOqpM1uVcEg9czdbxAuaxDjJylLLG/d3zmXECexWn54RlURfCFtsA/mz0GB/PcVTje
         FvXGmjS8bp/rxAdZSjihpaqX6cpN1srxpSwfqZE5dkbgEOhd8QqyNhD7yzltc/f/meim
         kVeSbj0qNt1CAV4WKbZn8bzDQaNoIiGd8sCyGVVE5MqzyRsnU1KuJ+aGSCiSqaYsOrn6
         L/wA==
X-Forwarded-Encrypted: i=1; AFNElJ8QA4TAdBu/zuAX2orQEWspTwKPobitx5HCZPK6jrumpuOC3h0rNu/uAm6I5KCBPL3Ta4lsVZIurD7srw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xf80VVx0Q8fZoQLv5JIZU0RgX+M69dmkqh52esdOvH+EngaN
	lmhV4UbHuNqcUYm/lx7J7KtAbcMmZZTuSLxT9EuaOFJiPY/6ZK11YdBtRFNBIsS+nI4h3sZheU8
	Tzov/hN1IJ2eCAqWlBHESqbuGO81aQjQ=
X-Gm-Gg: AfdE7ck+mYHHlHfmBEVfYIITF2MsjM0eSb6h5unS5JsMb8UYXIWMnfiQCfZJFnlE7Hw
	opJVmFybNHfNOHWhaw03ZQmDlHi92srTQoNmcw2CpLwf58mMVoibLg735iTu9dzN1rEpqI3PkIE
	UN7A0KRtZWgdC+qeYIi/azuWI00/iyWkF9uTeQfSNF9r0bS4ZAhOX79oc3fDlZr3CabW00ZbSoS
	rXyQebY4Q7GirUy/X7GuSzjlz0C8CG76cQxDD2V5dJNfuGFxImA9tQ+/xr9o9Kyakl+myYPMQ==
X-Received: by 2002:a05:690e:4396:b0:660:32d9:22c1 with SMTP id
 956f58d0204a3-662cbc81ddfmr3022293d50.33.1781715350622; Wed, 17 Jun 2026
 09:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606040344.4-1-ruoyuw560@gmail.com> <20260617072035.3373487-1-ruoyuw560@gmail.com>
In-Reply-To: <20260617072035.3373487-1-ruoyuw560@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 17 Jun 2026 09:55:38 -0700
X-Gm-Features: AVVi8CcLUf4Zygkv8XTpPDzox9h-5snRraG3WgnZ138JNbMoMg_VwtMEDMOvtjQ
Message-ID: <CANRwn3TWqW5aVnymLbWDFwNKuHC77gXFDYQGs7bLPJQC6Q=jTQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: avoid copying Bluetooth input reports
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 12:21=E2=80=AFAM Ruoyu Wang <ruoyuw560@gmail.com> w=
rote:
>
> wacom_intuos_bt_irq() duplicates the received Bluetooth report with
> kmemdup() so that it can pass 10-byte input report payloads to the
> common Intuos parser. The helper then copies each payload back into
> wacom->data before calling wacom_intuos_irq().
>
> Avoid the allocation and copy by temporarily pointing wacom->data at the
> current 10-byte payload while the common parser runs, then restoring the
> original report pointer. The Bluetooth report parser keeps using the
> original report buffer for dispatch and battery parsing, while the common
> parser sees the same payload bytes as before.
>
> This also removes the unchecked kmemdup() result from the Bluetooth IRQ
> path.
>
> Suggested-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Thanks for the update! The sashiko warnings reveal an existing issue
with this function triggering unaligned memory accesses. I don't think
the warnings should block this particular patch, but instead remind us
that some kind of dedicated alignment cleanup patch would be a good
idea.

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> ---
> Changes in v2:
> - Replace the kmemdup()/memcpy() path with temporary wacom->data pointer
>   substitution, as suggested by Jason.
>
>  drivers/hid/wacom_wac.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..a29bf051ada7c 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1192,8 +1192,11 @@ static int int_dist(int x1, int y1, int x2, int y2=
)
>  static void wacom_intuos_bt_process_data(struct wacom_wac *wacom,
>                 unsigned char *data)
>  {
> -       memcpy(wacom->data, data, 10);
> +       u8 *saved_data =3D wacom->data;
> +
> +       wacom->data =3D data;
>         wacom_intuos_irq(wacom);
> +       wacom->data =3D saved_data;
>
>         input_sync(wacom->pen_input);
>         if (wacom->pad_input)
> @@ -1202,7 +1205,7 @@ static void wacom_intuos_bt_process_data(struct wac=
om_wac *wacom,
>
>  static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
>  {
> -       u8 *data =3D kmemdup(wacom->data, len, GFP_KERNEL);
> +       u8 *data =3D wacom->data;
>         int i =3D 1;
>         unsigned power_raw, battery_capacity, bat_charging, ps_connected;
>
> @@ -1242,7 +1245,6 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wa=
com, size_t len)
>                 break;
>         }
>
> -       kfree(data);
>         return 0;
>  }
>
> --
> 2.51.0
>
