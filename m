Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698B413225
	for <linux-input@vger.kernel.org>; Fri,  1 May 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659975; cv=pass; b=VrH2NVfvV7gF0QTatCncePoAht2FiND7ILzMd95T/zyVjNo3sktS7RWhD6jycsQoW+b+RfIksyQBjacXM+G8OUGDe44NtZtfHfggkdUsfOBAgn64nnSTuO76B4fhQEu12KFjdLr8kKkZLsCzAI+O905afsR4n9qtaxrGLX625i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659975; c=relaxed/simple;
	bh=pV+suN9W1A6yZfc4Ibsbi1Vqls27R+qZ5YNULCTDH3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCHL6+aDsOsLmz247wEquK79FTD1KVsbRh8l4EuxnrPus+b6SJ4lytddDu/VWm7o7QORBgLmewTVHipyP75MnYLZy5FNawrql55l62tS6StkR0QVtr+QvunLN6EXzG9X12DNNXEVioF39j8ycuyNgS7PcOpUZInVHugUzX1SUL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pef8mdG/; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pef8mdG/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f9568e074so341720666b.0
        for <linux-input@vger.kernel.org>; Fri, 01 May 2026 11:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659972; cv=none;
        d=google.com; s=arc-20240605;
        b=lxBz30UPpKqet6f6kC4m4wkV+u0mBvtJohnNIcyMCzomDxjRi21/ZJq+Xy6D0j0ehQ
         rbDN435iWEfQ+8REsZ1Xm/PfmN3c82J9rlFlRzrkgEaborHc8f/6obgrTjV+8ZOyRrMW
         LHfhu71lUCi7bDvlPW4a0UcmlBfkWJH/6iHrH/L5Y9ix0F6F4rpdcSIODkPciieYcvdO
         wP5J89LQ0Q+/xgPeVxq+rVsRfEpC2nXMama1Gzxjj/4Vslwnt0v+RqRJiNNrDRBk9bhK
         PJqKNFU/0qhvEGwNcmtoELIMKsybBq3hARytJeW3TF9Aos+MD06oe0tQheafTDliBA8h
         Fcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mjEo9TVAU6E8H22fl8jtqKDStep6BqgLc7IS8Y+Q4Uc=;
        fh=ARiZraFj4HtELFO5GaZJD8t7p8jFAQoD1fXslbMStLo=;
        b=kZWTLKu6UwANrXzjjjhtGNjfVfkPimH1FMzLtxGuX8hNqrv9aMXLWmn6vRzwOjGi9f
         3qdEA2An5TR2rLSkREJ85CxtBdyN0RQgnGQKGhls+O2xcVBlkWgy2RiTFGnUu0DsYNx7
         90EoUgc75MVLtUT6AzaIfN56EI2emabT0HhK2eYQqQkxk+qwz0KLHiEelfj5Bj6MKydV
         EYzz/jo+GRl708xRAK8FCfuj6GXRgpUC2Ws+HPDmYmhyxdvU3xvXaEekPMq9BDSSiJYn
         EsX5SQOiiv43a37mOh0udMv6MxMkcBJxbec/4a3OX+qYrY3JcbxwltCCXpcoynCOUcnN
         OcGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777659972; x=1778264772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjEo9TVAU6E8H22fl8jtqKDStep6BqgLc7IS8Y+Q4Uc=;
        b=pef8mdG/fSsLQeWZJ1ZqD7HSUqFOkNFzMfntyjPWlz0C+0uJtLAoxlLvZ4pwDPOL10
         WHN03FNGpDUR7oDFcrcqdYTnEu/IAvO1nn9iXSwjAwrTl43gm+81xC4RfOMRmeuM2Fke
         QT8NzAfQbuAQ6GEBitxCEU4abFD7C9bqH6rJMI22IBnwR/4c6qD7BD0S2Hs8W0+VRlgR
         cUkKqIw4ODhFNdn5g5FBsWUwm3qVbiwmsn+D1QPAjlwnhoxGYoMS6iYH3NOUaAlp4Hg0
         rH0xOYC9iNeLV0Kty8mvx/8i+cUjbRXveB/3b6BCEkaMRloVUGXPHQVTlE6fIyjGZk/C
         4cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659972; x=1778264772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mjEo9TVAU6E8H22fl8jtqKDStep6BqgLc7IS8Y+Q4Uc=;
        b=bW/feGss43IiU/uEWsoYtQYltqtXJaN6m/tbPzXbtGRckv0SSJOob1TRetPuaw2pMb
         u0NWl0UBHUFbzPIEblK7z5IIjSAumXPm7Ato3XyrG0bRwqyvn2bhgPoCejQ3gYqoDOrc
         q+ZslTVHfSJ2JXADz5cav0WH4vEXRLisgyQcUcSCTjx5sCs4d+8LNpHBQ+pWw3WASv03
         w/I1UPJoMk/VICYkKwmc/4t8xCT+DnW0XbwZUxF99W9KrfsHN8sfPRbSCrUzNNiJ8qmz
         mJshv3yvh9kTLtsnsDMT/wRMfD8+0TGKf1Ag4/DdEAcTvSLrBdKVkEDKGaH8wHvlDXKf
         C3NQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vab5PKjaCiW6Q6Mm2HBKX1cN5pMRdVxZMpcv79yv9WjQr1tPBeDsiIo1WQ3fttaV1vUOkoY5b8cHFQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhU7fClol3YGeQ2C1pBZ7FF850ipBJnpUaTVjjbPe7d6gVr4P
	NH+gjaXFPwpbRNVxBTU1Hm/dhhw/eAtOlEt0419RvckRvITHaQr29vRFYfND+TayMtCRdgmbo5O
	CmtNfqffhIQN9InuyA7/FmokuMdn0cgzbiesp
X-Gm-Gg: AeBDievAIiOFbRXwa6LjgPoxHIaDoZ/SsEXiP1SrVRTeAJUndetn0qDgttoEsM0WOWX
	KVHTIRIlUKO+4mFuEx+AzJIX/lw2CY9+zJqgKEbxJLp5hZIxeiMhii6ix167G/3Cm6Bi+58+XJ+
	0p68qJie/iVnEVYL/mouMYeJRFZuseyzm8RxRXZl9MGca7aNyRHc+BNOHVBTEysDbNofNpudGQh
	ORZg6N4bsOHl50Pk1Y7oRIKQ5lx/CNRXXApFHzhtqdoRtOFhbW2LWdm+XRpKlDrSH5lPKTimGWL
	CDHowY0orhLHL9/gBCchcPzKkrUxoNvF+zuP+FzZCYMz+8wIkfSHJCPacm6HZRjFUWEJhguOZIv
	E7rlZ1acllVNO8bP17g==
X-Received: by 2002:a17:907:934b:b0:ba9:aeaa:fd18 with SMTP id
 a640c23a62f3a-bbffb951c50mr8523766b.28.1777659971938; Fri, 01 May 2026
 11:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
 <20260429175918.2541914-5-sanjayembedded@gmail.com> <afJdJIQS1vwOcaGT@ashevche-desk.local>
 <12C22ED3-20F9-401C-ACC9-D666393B292A@gmail.com>
In-Reply-To: <12C22ED3-20F9-401C-ACC9-D666393B292A@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 21:25:35 +0300
X-Gm-Features: AVHnY4JiQImi-kzKeeq0M395Ntrx9wDGlULAMAnx041KdEXGJGgDR69IdiMeRVo
Message-ID: <CAHp75VdzPr+SLCPT85zw6aK8pSueBHr-OFpJ1Vmsow61e8=p4w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: humidity: drop hid_sensor_remove_trigger()
 using devm API
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jikos@kernel.org, jic23@kernel.org, 
	srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 10:21=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
> On 30 April 2026 1:03:56=E2=80=AFam IST, Andy Shevchenko <andriy.shevchen=
ko@intel.com> wrote:
> >On Wed, Apr 29, 2026 at 11:29:18PM +0530, Sanjay Chitroda wrote:
> >
> >> Use devm_hid_sensor_setup_trigger() to automatically release resource

resources

> >> during fail, unbind or removal of driver using devres framework.

failure

> >>
> >> This simplify the setup, remove goto, avoid manual resource cleanup in

simplifies
removes
and avoids

OR

"This is done in a way to simplify..."

> >> teardown path.

...

> >> +    ret =3D devm_hid_sensor_setup_trigger(&indio_dev->dev, indio_dev,=
 name,
> >> +                                        &humid_st->common_attributes)=
;
> >
> >I believe the first parameter is utterly wrong here.
> >Or other way around, same issue but in the previous patch.
> >
> Thank you Andy for the review comment.
>
> It looks in same humidity probe of hid sensor with devm API two device po=
inter are used &pdev->dev and &indio_dev->dev; ideally all devm should have=
 same parent device for devres resource framework and over here preferable =
and consistent device should be &pdev->dev;
>
> I would first update existing devm_* API to have consistent device and on=
 top of that will use same device in devm conversation.
>
> While for gyro change device is consistent as &pdev->dev across all devm =
API.

The idea is that you have to go deeply understanding the object
lifetimes for the cases of different device instances along with
userspace communication channels (all possible ABIs the driver uses).
With only that the proper parameter may be chosen or even confirmed
that device managed resources must not be used. Yeah, this is one of
the downsides of devm_*() APIs.

--=20
With Best Regards,
Andy Shevchenko
