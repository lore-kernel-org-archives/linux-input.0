Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A538B7AA
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866125; cv=pass; b=A2SRVoScVEMrq1tDMUVkw29PDf86RyIjcr9IlJ53ZaPhGQoKd5TamJtOQwX979bUOIy8q8lpOn2z1sKK2PdxqhQ1MDCzGC6XcQkTKSrW8p/lAWkUplPPwB0O84etZnS3dLnQKKg5NiDjkZgL0r1KTk8mDgOQRKn5HO1fnxGTnno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866125; c=relaxed/simple;
	bh=rsXL2UR5EXcK76tOJhpe1rFwevsE9SA5NpOvUKAB8XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB57WZbk1sIAf2nVROorCTW5YIlvDwAdGFnhHgrHxdc7CipQz2ZCXL+z7rHaNt9PFn24U6sXR1BUSMcon/EkF0UmPGdfFzrpkSdRSY/qG9HyosYxJkqG9iCKQ72/lpZ9iFLp4E80Zlcdf09ZRZH3dFq8t8mPHjOV1dpSEAVypHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6gIRo42; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6gIRo42"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1677c91969so21619266b.1
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 10:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785866122; cv=none;
        d=google.com; s=arc-20260327;
        b=kUD0YLAvIdqAkGdF6ns2iNSt24jFavJ2vERU79h3LThq6iOeN7rSKW98fkS2O+PUVp
         13O6vIYllMervGZdWjt1EBUZy5VXW8+cbTTrle9U12s4YE6iW8oivtjzY+9ZPKDIqXQX
         IJ1eMSAx0mrxvllVPOy/1REg+10v2RiMD5nrhM18zpYRz51bGLJEFlpAu91yqYLM2mpu
         Y43qF0bnMPefiV+USRLn/UcRBu0Rx9X8N5q/2cYP0g2pzNwJ9Jq1UfCrvs8eIgEwSO/C
         ySj1Ic37knHXfrHHwgQd88KRNKLwfVm2re+qV+wFOxQBe1K7Z9X6SIA3n7thZCK/V8W9
         fZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Eb01qLSNLDeqYafiAwBY3TL1qPMlBL1RSUoNPwSuOa4=;
        fh=qjvUw9JQunQ3VgP90pJLxIO101uxjJVs4fTK8zB+bPk=;
        b=Awzk1WQ2T6v/2DeyFOLHqmB9WzTfFASEsVFh0ekqgzNT5ntXSHF4IJMRRjD+sfHDoE
         Ks40u4TnPB4drSef+g4pndb4ViNSfDjqfpuSxJi7DGfowfRSO6corNbbtTTV/im7A8bN
         16ZKGfSGjWg/vHW2s22OwQQcOLFTPYnlEjglgLdAYDsyffLyyU8hNlWqOEeG/WIpuder
         cCUCPFxKe2sNTGg2zP3Kokeb41RpwlOzvYlJQxC4bpExLrwuQ4hveaZfbXO9QfZ9p2Dj
         kze//hNgeN5HrA2Kpbzdb5aukbPfJoKZc/8Ilz/L8xliekXTLrgoKGle+T3lHLv+Xo/W
         3vVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785866122; x=1786470922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eb01qLSNLDeqYafiAwBY3TL1qPMlBL1RSUoNPwSuOa4=;
        b=N6gIRo42E/DxvbkDSTGaJ6Dv6xR7ISLQsXC/UISwP8i8wkjo7ntQEbdUpW/rk5qSFe
         LaBATdhLm6OggJFS7cVQtV7U2Y1cqwylq7vQmVow2zTA6HQ66CkhkweV1x4ZdwULe1jR
         Wig1+yZsbOgQg1yw22MEtshT0is0dnQiDHK66rJoIO0BNGHmrIVMRUB3JwlHeIi6Bfey
         1fM69sPEz/KQPxvN8MSb+LErxgN1H8AfZ/XOY1uJ/LQ5fF1kaeiOzGgs2e8OCqYmL40r
         u8Y8cq7e5JNPttFBcy9k0JeA2qLam5g3JzbYjmMDXewv1WCBmn8ywl+G+nS+yIXKa1Q7
         ppJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785866122; x=1786470922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eb01qLSNLDeqYafiAwBY3TL1qPMlBL1RSUoNPwSuOa4=;
        b=jv/wK2mKEUoXpzFPFD+o1goxGS4Y3au0sfeCXrjk7hUrqlr/ZTtYWpMqvlMj2hfHVe
         Sjep3dyQtffhMSkXekrNyNcwiF3t9j3g/aBBuBB5XPHi19D5ms0i0JfpNe4oVegbmE8s
         pnuy4KUmLAshLg2T00v1ueyqmdOkIwn5BGOernG4uduZDVZZg2Hh31w3tr3IgxV5Kha6
         brAcSu8X+uEFKQp14+Ao3Uq1ct1sim3EzFBaS5WxJUzCa3w3raz1+a+2iGnw48KkRJxm
         N/NKaDPx3qVOM4SZOb71Eg3UElPUncKSIDqnrtOxLn6xY+3BiiHG7AuIpoyLRzRbAuwe
         Ra0g==
X-Forwarded-Encrypted: i=1; AHgh+RpSAf0RU2p0nxInWicDY+uLL5wZH9yC/PBgyULeF0FdKqNsEWRzC/5oHQRdTPkknXjkLtIPnC096EgU+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJK1lM1oqOSRoxPvKj4OMV70Pduk34f8WlhtnSw80wjxR92OdX
	/9N1PERwAN1HDNmfipVr/H1pREeIfPCJWDfi8NNCbedIwIPckM86/984cLnnFld/bHNWdebrnw2
	mhjimDR1b6OKB2wyrEIOfEY+YtNlhyZg=
X-Gm-Gg: AR+sD13pZKTPWrUSqp6SALQFU0gKAtIzp6Gt7FG0rOfIv9JRitf6VUk+G6q8a0RBTEk
	ToNdG+zKYHeNzu7C6rFsDB7rTSo6GMTiC71IIdyyCdPXtSarli/ebQ8+u5Woe/xchyDwG/OIBjY
	bF/6VK/fOFKEJ9QXK1II53zOC0HXnpjIcfe9/rnwh9kd7swGVTz65PcRCIAj6X2VuV0cFsDvJYI
	onwa0rqHsRt4r0ny9AjLGxQUGi2KB5mmPawfcJEI0FZvgD61WIt8GIRYShNfmzlItWaZ51FlT8f
	RerX/vEYQ3xGbkZSN4NQoMYQC6AwAFs682OfZFhtRk6oDpA+lsDNsC6+i8/gFjid6WfrD+UzCsm
	JONU=
X-Received: by 2002:a17:907:c14:b0:c1f:29ce:76a1 with SMTP id
 a640c23a62f3a-c2039c56269mr18367266b.19.1785866122239; Tue, 04 Aug 2026
 10:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
 <20260727-mod-devicetable-hid_device_id-v3-8-980896ca283e@thegoodpenguin.co.uk>
 <20260727151816.2A2C61F00A3A@smtp.kernel.org>
In-Reply-To: <20260727151816.2A2C61F00A3A@smtp.kernel.org>
From: Ping Cheng <pinglinux@gmail.com>
Date: Tue, 4 Aug 2026 10:55:05 -0700
X-Gm-Features: AUfX_mzjhvsmiFKB39S-6lUJo_O7suxFmOWqO1R9XJNcPRrqYhfOxvi5fQg4Hvo
Message-ID: <CAF8JNh+ZzR5X58FX=e=EN4HofjZvxLzDQR4jfE3tdKQMo0NkYg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] HID: wacom: do not use 'driver_data'
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jason Gerecke <Jason.Gerecke@wacom.com>
Cc: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 8:26=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Critical] Removal of driver_data breaks dynamic device binding via sys=
fs 'new_id', preventing testing of unknown/clone devices.
>
> Pre-existing issues:
> - [High] Missing cancellation of `wacom->init_work` on the error path for=
 wireless monitors leads to a UAF.
> --
>
> --- Patch [8]: [PATCH v3 8/8] HID: wacom: do not use 'driver_data' ---
> commit 147dba29dc34be167b7150ce20799c7b7dd39442
> Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
>
> HID: wacom: do not use 'driver_data'
>
> This patch removes the use of driver_data for looking up product features=
 in
> the wacom driver. It instead looks up wacom_features directly by product =
ID
> to reduce macro complexity and simplify the code.
>
> [ ... ]
>
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 834519751a5cf..4514b2762cc33 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -2848,7 +2845,7 @@ static int wacom_probe(struct hid_device *hdev,
> >
> >       wacom_wac =3D &wacom->wacom_wac;
> >
> > -     const struct wacom_features *id_features =3D get_wacom_features(i=
d->driver_data);
> > +     const struct wacom_features *id_features =3D get_wacom_features(i=
d->product);
>
> [Severity: Critical]
> Does removing driver_data introduce a regression for dynamic device bindi=
ng
> via sysfs 'new_id'?

Both 6/8 and 8/8 are tested with legacy and new devices. Everything looked =
good.

> By strictly using get_wacom_features(id->product), the mechanism for inje=
cting
> unknown product IDs seems rendered unusable because the injected PID won'=
t match
> any entry in the static wacom_features_table. Previously, couldn't users =
pass a
> feature table index via driver_data to test unknown or clone devices?

This particular case doesn't cause trouble since the existing solution
already supports new devices that were not defined in the static
table. Hotplugging worked without problem.

> [Severity: High]
> This is a pre-existing issue, but is there a missing cancellation of
> wacom->init_work on the error path for wireless monitors?
>
> drivers/hid/wacom_sys.c:wacom_parse_and_register() {
>     ...
>         if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
>                 error =3D hid_hw_open(hdev);
>                 if (error) {
>                         hid_err(hdev, "hw open failed\n");
>                         goto fail_hw_stop;
>                 }
>         }
>     ...
> }
>
> In wacom_parse_and_register(), wacom_query_tablet_data() schedules
> wacom->init_work. If hid_hw_open() subsequently fails for a wireless moni=
tor
> (WACOM_DEVICETYPE_WL_MONITOR), the error path jumps to fail_hw_stop and
> returns without calling cancel_delayed_work_sync(&wacom->init_work).

From the logic above, I think we need to call
cancel_delayed_work_sync() inside the loop before goto fail_hw_stop.

Cheers,
Ping


> Because the wacom structure is managed by devres and will be freed upon p=
robe
> failure, could this result in a use-after-free when init_work executes la=
ter?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-mod-devi=
cetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk?part=3D8
>
