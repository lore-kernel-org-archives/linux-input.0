Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1CD4E7801
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013317; cv=pass; b=QlSJd4GQQwAYAVhTH83y/RNbB01ggtLfUBAKfkaiNDEqglJdexKuNcOAcE+TYmyLENQkVqif2gWNQCM7q4OqRVgDMip/8gH93ycZaFI2cZU1WqozbtZtoBNvZlZQLyk4pyjfUhc2SJpo1V4jt/Sve0aXtZsYFqdlYYvGQrXbpK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013317; c=relaxed/simple;
	bh=sDKcd2FnnaAXCfLgzj8Tgw4fSqF8/9G0zE8D9gcitow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbF1ahmUXGoxYo+slsTNMSbr3mMTwC1AMfhfSIEqPu0449t+OWc/A0n4djlm6wOvxIxTKUer2hPOxXDo9SMUd5fXateanDgDv1FlkJaEnfPMcrjuPF6w0cNd4umsYey0RXV3OEz7HzzmKlZb3qX/zW95h8B4WthOF7XyotCfU+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXdVqDzL; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXdVqDzL"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a30521ef15so23313831fa.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 10:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790013313; cv=none;
        d=google.com; s=arc-20260327;
        b=QGegd6BdLCP6AKX8BUCs6nFQQk7Cqci3SrB+lhLOEXV2Sf/hVHCWz+fY0CQEueJ5Mg
         RS3jE7nFOXUbWyP4v6UxcuRPq8v7w4FkInWot6grmj86K4S7SHIKu7BaOhY6pZv2OLlv
         P6/KAUyc1sTw8q7N6J08f4GejAWbTmASDt6az04+5KjjU43oJqmpumUZgr+vd9fuMo7c
         Bb4QlUPO4s8fbmr90IJeQ4emJDH261+RRP+7Ul4YHV+34otg+DYZjT3hysPRVox1zhVY
         d88OhEOCJtUx0yYNK6p8plVGqT5jbRPNl2gjMK/0bILo2Ulemzb+X9oXs0ZeQPOWkN/V
         KPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rjabd0V8j0ZscLDVjxMT64ulH3IQfQTqiOQYhc80Tds=;
        fh=DSqf5mvEeoVcE9VEOfvo5gADpxw2EmMGSqyxpVlRTtI=;
        b=SUrL+4VdU8Ah5QynfNh1tdg+NB6zNELlxR61v5Eyhuq2MsueIuAx1mIqoeb9hoKXrL
         jlFHAaq9mJFlPkiLUAJuZ5MPMY8fORyI6dop0qEYMbZkkTiKRVqwov8KDQypSGz7ByL7
         IrmggSLJsWsw+L2YM5sJ8xR2Pd++WuoxH8c0ajpkKeqB8B9dRjcycbiMR3T8wBejCbWg
         q3+X+fnhb1pEu5FLubsZxsZhyjzlNMziNSsZaIkZCxlKDeof1SCvFiZEavbttbkBD489
         7P5ib1AVaiGhmMRC9vqFvMmenFSB/+Q+Dcy89C/XcfTkcXgewdnY0lQgAoUa5To4ige5
         G4Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790013313; x=1790618113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rjabd0V8j0ZscLDVjxMT64ulH3IQfQTqiOQYhc80Tds=;
        b=gXdVqDzLQhDmrUvDEHUFjOxhcxrcG7hHZ1GQtVok3T2jTX5fhXH6ZvrmliWDBrN7aC
         EeB18IVqNgV8L8u1aINvUdSJEvpUbeElJ4y4Sq1EKVtvSNB3DRP7D1UN3UregOQ3MGu3
         NdUzdStnAGMvLdkKKGHLCsdUtQXn8JTdjLHVp2dFzokwMxkGieLrMeTtlt1hrTGSlgWz
         7f7z9LWzcezUj+BArUd9Mlq3oaIcS92ofbmIyI29PwyM56GYtHqK1krS/a6qhsDSZoBK
         JGaK+sb57Hi9GZNNWBZhppZkMoStadqCx7OyuQ61Ubp0HzonQmuokFwyLRs90zNnJBP7
         GuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790013313; x=1790618113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rjabd0V8j0ZscLDVjxMT64ulH3IQfQTqiOQYhc80Tds=;
        b=XoPA9KdmSNs7In8VPb1S0Slqjowu77GAYiXRXAQwf6UIwCtFnIds0wly2JI6y97o6H
         9Do2DZ/j7AKNlavffjhozvGhN+XJwBGCB6Z773lA9xgYsNN9Sd5gARY/AvHqSReRmI+6
         c1whP0nj8l8duk/oULvDEjnuz5pvFqX6/B6aWLmxcEXRBxThDlq3CcO9peozbZg+t1v4
         Jw1mhW+Hgu8t/SVgGhKrF/GjJk4lONlyCDh5yzlA/degQToBfqcxVPYQLlwr9X77U5KG
         R8ZEpcsgLCsgu63CACDkEyxtKUh9Z+SuNpg6D1rQv727mJ2eSPJhtvRW8VRuGm2z9U2O
         kUBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDJYbplGT5mR1yuT/XnicBLtA6yX5+hdRINzb7kU3qQwLmXwoI3/sN3J0cyFNC5vDSmx7lj2TSXni59g==@vger.kernel.org
X-Gm-Message-State: AFuF++kTEXHZ0VjmF4N7pQdyFi4OYGMz7xhRPPJEmNkXGto5Mldxh/Sb
	hDb+ItxRmi82Myr1ljPyf3rw8y/mehDKUACIfR5GLeQnmNBBnmSe1RC2R8gVjga7tDAdwhIAGeM
	iEs9c1//UMa353pKijld7/hqvGvSz9jY=
X-Gm-Gg: AYBFou2F0Q1v/kk8ACB/U4r/TJMnzsd+3iihS8mgQnAzrThk7zvDnquiazOs50fZBX5
	Yku0GxPtBiD3ErdhL9M6YY3fuSqZw9cdUIidBB64He/MRrV9/jeOSjD7L92QQoAUtb8XeExL5Kt
	VNI8nsgzWk7LmIKofLXaWoRVA9Qzi64tSn04YgBd/tdnYnPDmAXgGzsdpxAC8SYhVdfLmON2M7U
	aqelRlLelbfILD2wSzQjhF8b3U2g4SgjK8UCNtKcEeIQiRXlSqQEqjWZFS34V2fnw7YqVC3dB+h
	Iv98FMSbGoCdNMjtEPmB/sczbqQuLSgMWUMZfXZd7vLHExYQTO+4BkdI/XTuCcbVx8LG3tkde+w
	4ppuy6WiFUX9h7Q==
X-Received: by 2002:a2e:a596:0:b0:3a5:ba1e:8b05 with SMTP id
 38308e7fff4ca-3a5fbeb587cmr24355231fa.1.1790013312546; Mon, 21 Sep 2026
 10:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916020301.24188-1-ping.cheng@wacom.com>
In-Reply-To: <20260916020301.24188-1-ping.cheng@wacom.com>
From: Ping Cheng <pinglinux@gmail.com>
Date: Mon, 21 Sep 2026 10:54:58 -0700
X-Gm-Features: AcwNN1WsqrMyphsW-EW6Ps9_PEVpIsbZuIuSPnPJCCSeEIrGt3RcSjG4E58g2RE
Message-ID: <CAF8JNhKTVO7xro4qAoq4NG=4TWheb7rFU93AZEfeRJfJeqUfRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Write shared touch initial status only once
To: lee@kernel.org, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <Jason.Gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Do you have any questions about my patches, especially this first one?
I added it to make the assignment consistent with your patch. Since
the is_soft_touch_switch can only be set by pad, we would only get to
this assignment once. It won't be assigned more than once with the
current firmware logic. If you don't see an issue with the patch, can
you give it an acked-by?

The second patch adds the softkey touch switch back, which is
important. I hope my fix can be merged upstream along with your
patchset. Otherwise we break userland.

Thank you,
Ping

On Tue, Sep 15, 2026 at 7:03=E2=80=AFPM Ping Cheng <pinglinux@gmail.com> wr=
ote:
>
> From: Ping Cheng <ping.cheng@wacom.com>
>
> To match the same logic as with other shared data during registeration,
> use WRITE_ONCE for is_touch_on too.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
>  drivers/hid/wacom_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 8dc7aa1c0a26..33fa491fba92 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wa=
c *wacom_wac)
>                  * match historic default.
>                  */
>                 if (wacom_wac->is_soft_touch_switch)
> -                       wacom_wac->shared->is_touch_on =3D true;
> +                       WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
>         }
>
>         if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
> --
> 2.55.0
>
