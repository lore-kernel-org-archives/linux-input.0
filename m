Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40A363C4B
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776664; cv=pass; b=PSLZS2srdqm3VeSPHB+8rIaOmn9zktvCVVtplf7VYslDLLXK4ee7j8aDSxjPoCSsxnX8+LwW5yu7eu66XFwFLUIMI73FchGQRehvyZM/FnmbzkR9JXKSzAvNICTpx+W//eyxM0gv/RM4KHV/dSRucXniP4ipnnUNFr39N0HO/2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776664; c=relaxed/simple;
	bh=cQcg8aEJEV9XpzivEv8RAnX66jSXDN7/N9WR585nWKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ+TKYN86vkSatqvNT2wE9ulFzwz0fx0SQgmsjaZQj8dFLaGv5yhOw90RiO3gqiybSBU3wbSqBYF3yhNJLQQK4VIgb16cA+WL+4mvj5/+iQj2WpvTplm32lrf0BLN1ulNa0Qw8GTMq21PO5z5WtrPokLWUymp1tvXezb/V0Brzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7715bng; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7715bng"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a05955720so65522536d6.2
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 21:57:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772776662; cv=none;
        d=google.com; s=arc-20240605;
        b=QBbpFsY8J47kDlwZrn42ppMhkRo8bFdWiScBCqVKYypRH1Y08eY8GbLKcHmWRWJPis
         PbPNqgePCIjwX2EGha/eBRsSvCdXt7CB+PsQ1T9vI3KjOdnHliT07XrkTbi9FjXQQNav
         kCC3WhWW2pzcm+qVO/vbTbDnTe6ZJaBxTiOWmwS8HTbsMqB/pX6pV0hk6nO4KHSnb1IO
         0OEDj9sS3FZNxhhKIqLHMKomlT/4F9/PGGhim7nUqgaeUBMRNlrWywznXmkQQZ1bxkB9
         dDsVy9muzTpwt0+/Lmno9d8H45n6KadRJsqhGPpAIRJbZC5niSlGqNgEo6k+59/Vfx/w
         SCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HIRX4SKQwCsAkWE75FfvYkc+NSY8ZXcEIwj78znn0UA=;
        fh=DWGXql5TJw0cp2hwFG35TCrgK4jEtMu0V+PkHRCJEGY=;
        b=N3YYqE6qiR1ZuNFKIU9vUHH7SvLRTJGir68rcwe5N5l5bT1nyUrn+i5IZpxRPFSW+v
         GQxavtJaEdNXnEX9BNGzQw4uRGZjVnBukt5tEhQUhjG18hvnRtipd37YWlsqr+Besfql
         7xzM5hPi2TfAQML+fshcX3ZyAkW+2wwpBqFGE705KWyL4LqvXgGLu5d6awK2+u1LLHUs
         prvlhgSdizmxOgcuapp+5X//WIUQxaGnK3dU1nVrk/HDgHHVEgzyzybvoZUin3j6bBy/
         KrY7ongE75Zfi5g69l8qY99WsaMfQ3z6zhEjFWtLVCfJRrkBP2HpRnUuzqu/8a36ebjL
         JFvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772776662; x=1773381462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIRX4SKQwCsAkWE75FfvYkc+NSY8ZXcEIwj78znn0UA=;
        b=D7715bngWcqOz4aYXFViliFtMZmVddUVkEbvDrLQ9B1Ln+orvpED2U6O1YPEolX/wg
         ETZIPLbu1ByL3DNZeSA55GO4UQouZmNZ1l0GYAX1Q49bHRrmiNvCqqvjCJrpEzoFevqE
         zo8VBFUEu+c//dZIsT/7WUjK41jdii8FordtQ8TxPdRZ0G4aGWJslQOuEO4f0yzg798a
         97fgcq+bQqvyAAUvK+t7HT85Zs6TGeKZpPu8J5/Iv2O/rWSh01PfghlEU2T8XxrVkUaq
         GbtyfZ557SgPpIXOzPUsPq3KAsT6RlKlK+1XV/dLSijsED1soB09lxZiNy04EYoJvyVL
         vS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776662; x=1773381462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIRX4SKQwCsAkWE75FfvYkc+NSY8ZXcEIwj78znn0UA=;
        b=l7YnEm6bTOCLm0t3WAAPnjPF587plRV+0V320z8K6wqxj0bT9nMGcooJ/fTkgFEgji
         WJYtwLAf87lKdsmYfrYJ+C2lMwRlKmn9lev22lj11/6bGneMFqO0Wlxtel+qen8QmZcw
         BXWpM/kqgGGBVHJlcALhE2z0DbuXvx67tb6OwJGE+icWUWzN44H9jmExdrhRI4TCz21p
         FYyi9rJx5AdECtGJu/l5b8yvCXMxcz3zajWZDLDhZeNIHP2RFcK0kzn+VKfsHM3eIJzu
         LYTvJZsoKeXgWcL1nn6etqbFB9V1IjeBzVGOUsctH/ugyWC10wXT1VLCPhKkKLTtnVAK
         Us4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOe5OnYKQic4bN0p38hj/sM5eo35plVJArb65u0yPKTnBGEoCmTKdn+OPn70yupB84KDN8XJJ20lsZpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvSnA5XnE+fQnOOjRqdnQ3ew1oGDgr2qEg/qw0AHtrBSvVxaKu
	dxrhHFlz9Jc/gNQN0NLrMJ0Qc5PjLt/yBtj+eQrfxuc0W0hsP3uF3OXQNcYHAq74HdQOj2D/gnB
	zvASsIdolikR+2oheFYlh8WP5nOP6f8U=
X-Gm-Gg: ATEYQzwq9GUKKPo2V3iIMgC4jHtu8cDGykKKHf7Jc8Mcka8pR5n8FWvEiemJ9CCYcsI
	KkZfwoh+ZgbpiJdTXlOiUrwkwoJxJrtYoc7JusCOgvUcIrFYbA1J6+RW7WeqYxxfYsn+L1osxfy
	4VEzjlR6m/QN1JPykc2UaQqdPVA5q2Ciu7cVnTWVCMA2zT8YmZvt0FbSjBHZ6DeepHV8D3vrQog
	YmUvM1vz4ts2wxqaGnMD2SqY92OYjn7LTYS7GtT7jD9qkOYELCATygGdN+fFWqyKwz73ALOGfaD
	8jjTJnk=
X-Received: by 2002:a05:6214:1d24:b0:89a:717:1e48 with SMTP id
 6a1803df08f44-89a30afcc1emr11612926d6.58.1772776662358; Thu, 05 Mar 2026
 21:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227205444.1083103-1-ethantidmore06@gmail.com> <20260227205444.1083103-3-ethantidmore06@gmail.com>
In-Reply-To: <20260227205444.1083103-3-ethantidmore06@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 5 Mar 2026 21:57:31 -0800
X-Gm-Features: AaiRm50QiCpwnELooxJF42EpgTBAAou5zZ-nvYmNs8uwYAbj0jl9EQnPyUERYkY
Message-ID: <CAFqHKT=Kh1xRAPbwoVgYhrV7QXFdLZkRr_+vS6rD0H7346siJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: hid-lenovo-go-s: Remove impossible condition
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:55=E2=80=AFPM Ethan Tidmore <ethantidmore06@gmai=
l.com> wrote:
>
> The variable val is of type u8, so it can only be 0-255.
>
> Remove this condition.
>
> Detected by Smatch:
> drivers/hid/hid-lenovo-go-s.c:508 gamepad_property_store() warn:
> impossible condition '(val > 255) =3D> (0-255 > 255)'
>
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  drivers/hid/hid-lenovo-go-s.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.=
c
> index 0ef98ba68d86..a24737170f83 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -504,9 +504,6 @@ static ssize_t gamepad_property_store(struct device *=
dev,
>                 ret =3D kstrtou8(buf, 10, &val);
>                 if (ret)
>                         return ret;
> -
> -               if (val < 0 || val > 255)
> -                       return -EINVAL;
>                 break;
>         case FEATURE_IMU_ENABLE:
>                 ret =3D sysfs_match_string(feature_enabled_text, buf);
> --
> 2.53.0
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
