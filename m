Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8483A16AF
	for <linux-input@vger.kernel.org>; Fri,  1 May 2026 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638901; cv=pass; b=RnwrNP1Wewfu2NjwCW/a7P9+Ie6icUgKXVCIEhD3iRHEelHDTOv56ud8Y1aLGBYZ9Db+35trgA8e9ocwkld1HN3Dx3Wha5q0/FektVzhHRTYhJw+KH/9z++tu2lFyr/fszPmrOdKdNOZ0/RjCNwuaoyyBmMqnQ26Hg0BmfNUDZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638901; c=relaxed/simple;
	bh=Ju8zPBoyv7iefTqZFUcMqMsY8QYQ50TTbErq1xhjHH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgrLcSxEHBoNPK9LrrSCVZVcUNOsTO6/duH5aPrXVKx5K63F+nzHgJU9OyGySvoXLWadcs8Ing2WG4BTXMRFea8HjRaGvGga3X2qThxY+dI9r6k7YX1dytwYumLAwZ1eDb+9hEWNHL8GFAOwzcPdgGlRzJV0+DpW0T4E8YPsvx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCg7IMwv; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCg7IMwv"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8f9568e074so297492766b.0
        for <linux-input@vger.kernel.org>; Fri, 01 May 2026 05:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777638898; cv=none;
        d=google.com; s=arc-20240605;
        b=PG2LyDjvwTCEC54jJiAyUBNI+XXyoRsEaaKIQLr3dojBjRU0CXi/nhC3Aqws1H8yfy
         +yrfxy8owGiC52edzSFdysPgGZK7Ok9J9P2Zd6lZTPVUiC3rM8YY7v8zY/Ec2pmkwKaJ
         RAbS393fjh4yNSGOO3Gwd2JyGMNuKXr6N0CD4hJuFGldjtc+IEZbK51OO9m464eiksUB
         uj9xht/9VwIgOZ0Ge5j5l/t3xjZXg2IcZvTs9XWbxBpFZdoX7ROyVNuL7qUQwTq5vgJP
         zZ3m+Vp0BbOH90bkwb6sN4Cbu+ZauoTfPqAFenzowRNCAsGCUJ/XCSvO1zU5gbc/1YjV
         IUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qpx2v2crex3gyZcr2eqVrPJtmJOpEkyIwrbYh1NR/V0=;
        fh=ODf5TU7Vzkopf7r865RddVKS9spcKOnPpZcqMyj4+QA=;
        b=kNk73C5qoiLN3RTGfAmTCUbrg0hSwZ+r03lrZdJ/2Ejbg0kCkxAjjVgdowXfZoTJ17
         RITeNXXAvpV3a7l+9tyX5PFPmUQk2auUYjgsHSIoMeDSi8B5E2gCU9brUtM1c7VE1jBt
         qvvdoo8IVN0l9rO9k4nrbtFWMCt+eYaA0jU2zhLDvFuS6piOMITMOwgm8VsUwrnGCArZ
         4I4Q0JBiKzl+Lc3dvjG4ZIjTooaxytVEtUJN6Ri8FlVtIV14aEkaiU4AZr0M1/vrWF3X
         ftlR/qei7/w1a3aKNJrfCtIt6bM6QPi+1bcF7oRAatrpYmvdloZstaj/08C9OkWukyC1
         XFWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777638898; x=1778243698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpx2v2crex3gyZcr2eqVrPJtmJOpEkyIwrbYh1NR/V0=;
        b=KCg7IMwvPY+2Ojg2DmhHT4kr9P7rXFa/g+10jVVIBmhlGzjiTdYNEy8eSZxECT7Qqq
         WtN4zcg/smUfqmCPQEGUgg7vZbfJJpVJV+wmpcoHjwqMgYdTJrqyalq3THCgrQ70J3sr
         B6W/6h6vgJeU34jYXJdKN5p3Ci8nFBkApdtPKtA1FuyC2aWnnVVjrWmVuOX00XUtRPZp
         x5kQkbc/nv/cBj97QsoWuk9LlJKWVAr6IQGYXndFkW5ImaKnOlAKIYVG1TJyk2ct1GkX
         7nliBFYeETys6DFeRUFt0y5JMIxZiAJV483PUptA0464Xbd/JaH4KbBKM2vXa+Ey1MLH
         vGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777638898; x=1778243698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qpx2v2crex3gyZcr2eqVrPJtmJOpEkyIwrbYh1NR/V0=;
        b=dqQ3QsVA3ePZi3lvKIy4eYgqzSWn2GNBd6BDSFxc6lqiWSySZj40qg8tD0h8Hs40V4
         kenykV4A3AAOlatbLqYvvYfJHQBEh7DBditDIxJ/EoDHW9ZWuFZFwCouUZfmYBUG6Qt6
         cGxe3avm4Nm0CpDg2Ldlzcj/NYZHsGoWF0jDAAX4W0pqL8bXTaYUvZrt/3tTirfclgK9
         4jxuxaXIpt2cNjdv6CyG16RWKmSLbKoesSrRyw5Zhv3h9P5n8LXmT8qppgSjjb9TM7NL
         s/5ODiKBDgWohfCLxMprKl/+Lzotn6xiNzhxkHsotfdSsCHw0qaZrhLlCtL7CzUSdL1+
         j2kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fE/+wwqfvd08xzzHKBfJAvSdGFavZR9pLD3fdEW3y2pg5AKT7OAVY6fjEMilGg9UIxKz+8Eb5XDUykw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe09Nw9Lb5kTUFiH33yd0ovRqBEZANParQQa7DuAvxSbjxJl+w
	C8fEBXd/6jP2WsUM2ubLShb9lEACIkZ5L+6kTqdsEZnTaSiEK9ql7Br81tqo43DrasK69paJycl
	hYckuwbKs1XGZeYDX5KTkAz9Nf1AzLUc=
X-Gm-Gg: AeBDieshon4BzbcvIvr/+n/ONtyBiMr7E5HpLJGwkv0Fx7HrGEA5wD6oAQpfrm7KQ0F
	61zzqmvy6sX7J54EE3qVO9zp9T9vvKXFsCiuhhDjGeVk2EDmKvvp5X2OzYkskOog0cQT8TLI5UM
	jx9z8dz4OcJRRY2ocDdAOdBCeAgpG2smib4B7W+4LWwRaeZZSw+rTk7YLVF4u/SESFD0I04I6AI
	jBQV4i73W1b2INY8ImoBCdHxbgUxCbVp+S7YyL/+B4ZcIQQsTrJXN5OmrehFkYR6Kwls7icAKUX
	nVg4U9Zh5z/+F2Vu3DIT8vxHs3bv7/q5Z5F4+5iUZM4qcCDivWLA02VfBNf5Ih6/rd8/lj4tXWr
	KrmPNR+IG5pYLJdExNg==
X-Received: by 2002:a17:907:70e:b0:b9e:f58:c581 with SMTP id
 a640c23a62f3a-bbac8279454mr425610766b.45.1777638897805; Fri, 01 May 2026
 05:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
 <20260429175918.2541914-3-sanjayembedded@gmail.com> <afJcj34Fc_aUMVhe@ashevche-desk.local>
 <D8E78026-517D-4CE8-927E-6F4AC7E21454@gmail.com>
In-Reply-To: <D8E78026-517D-4CE8-927E-6F4AC7E21454@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 15:34:21 +0300
X-Gm-Features: AVHnY4Ik6EO_c-m2FAeYZ7zn3flnVR2Cxw0BTvJ6-MQWUxz-I9e59ZOS6vfn9xY
Message-ID: <CAHp75Vd7PZX1Hnkc7SwBrWDa73k9M_FJobzqYjr6WtT_d8+yow@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: hid-sensors: introduce device managed API
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jikos@kernel.org, jic23@kernel.org, 
	srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 10:30=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
> On 30 April 2026 1:01:27=E2=80=AFam IST, Andy Shevchenko <andriy.shevchen=
ko@intel.com> wrote:
> >On Wed, Apr 29, 2026 at 11:29:16PM +0530, Sanjay Chitroda wrote:

...

> >> +static void hid_sensor_remove_trigger_action(void *ptr)
> >> +{
> >> +    struct hid_sensor_common *attrb =3D ptr;
> >> +
> >> +    hid_sensor_remove_trigger(attrb);
> >> +}
> >
> >Casting is not needed here.
> >
> >static void hid_sensor_remove_trigger_action(void *attrb)
> >{
> >       hid_sensor_remove_trigger(attrb);
> >}
>
> True, the cast isn=E2=80=99t required. I kept the typed variable for clar=
ity and type checking on devm_add.. API which pass void * callback and remo=
ve trigger API which has struct hid_sensor_common.
>
> Happy to simplify if preferred.

Please, do.

--=20
With Best Regards,
Andy Shevchenko
