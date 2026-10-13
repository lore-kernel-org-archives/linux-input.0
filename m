Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143F56E079
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931366; cv=pass; b=sxIIOtRh5dNdqKw5eT6geuGTdkO3iIhFYxQLBgr/VEH5qw/ny4ctHs+O3/lrAqH6fT/FqnnEfUeWl7VsLaOfPohub7m7j5rD5oJ69kk5aBgyHTpq58BqoqcdioQr7WXdaPffxw74udioGF/C0yUZbx4IXSbWDOLpq8+d1ZPKXoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931366; c=relaxed/simple;
	bh=C43seu/VWFpovdumtyJjepkGjp/Pd2/TfXo84siSmcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eImBULDvY6Wirpz1WTvpRvqW+139an5UzzEDweUyG/GlE6APMEPrBkYvJldUj+loDAQzxHLM8XxirrAbTYjm2gX8pWFuGa0sSQZeitumBMmrdIHN07wUHg9b3UGvurinPe9X2cccfl1g8il5qurGkSD/88O4aUsurvSnRHE10GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pe8KxoLi; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe8KxoLi"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e441e14a1so252375285a.2
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791931350; cv=none;
        d=google.com; s=arc-20260327;
        b=g9663fAeMfKaraKtXzZHDDoCr3FibYZ/LcT8Jx+he+8h70WCUfSvLTPKGcD60WhHes
         YGThlKlFu+OdyfCijav+ACqOZvJ5DIKxoW96j2Wm8AunaoQHiIZM2UrYfFXyeoJqqCzS
         TLO8b5OaGBO22qAvHEqh5EE/Z4sx8wOmYTNt3NIeIJtfb1U4T0YqjUdhu/fhn/l27k+p
         ZIxwZEzLYw1F7lpcMMp5AuN/DRoTGItQWMjb0wzxwhQYVETukM52nFZ8ctv5gRL3VG5P
         r5g9rdtEgExVCjrNnYJqixtEutlQ4N/eq1Y576TI7xhgJEYEuo60FbvUainFGB56MTtz
         P+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fU6MFjVMU7wK4vdBVH97bBR61iQQtpiyRXrWiXvtIyc=;
        fh=/Fnmi/ChZ4PSCi6daDti7ivBtiCqCVrMSytCFiSl2/4=;
        b=mdkWZ8vdCIwDDipdRelWRZvHt83hyfAaHLAoqKGnRiUkHki+crF8ng4xw0CisvKl5r
         Q3uF0ImFq2T6rLao4TAaxlzaYthgYJuXoWPzKOxqraXiwFZowhymmJayEXQYG9Girfqy
         msa9yKUOgLKXYKbzxUfYsFbSqBm4i3ZrFyuMJMPLIlxFGj7QyaHboh0m8n8bIGxtMgmW
         LmnN66eNlUojLOOmef2WP0vQqzkC289C9mzxiHCXzt7zOaGs2aOmIh45bxnxCqGESHLY
         Y2qSV3JOnL7tKdtx6x9p37XLJjkoYX6qU4c0aDSbUxl74yC/1n3/5i1JH7mnU0ccQtm4
         KTXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791931350; x=1792536150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fU6MFjVMU7wK4vdBVH97bBR61iQQtpiyRXrWiXvtIyc=;
        b=pe8KxoLiF+935KH9jlcNLXmzLgHfkfzSjVMvKz4B0K5r4Z3JsJpTfXMgVLRoMJBSmg
         crcJAZlrStwp/y656iNs1Qc+Ewlv+2/D+tVtd/5E7S5Deu+/+Iq5gKMilPinCkttLgBd
         7wZDKn+lfpOk957ekMKfTbPkxQhoLZDVhaABoFYncvG/MRZyuJWm77Kk3ITeJ+9Sg0fD
         mlApPgPNQb7lp5eATOAnU76+n/VJVJUwWXmTLk0MfQ4zAXwU3MMdgNoKkuRw1DpwH2XZ
         5Vp78HeRt77SJDjvI3M7XHmBDfh5h5hwye6vUzm3fAyCUZejMF8dQurKAhsBcWpfzO/3
         D9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931350; x=1792536150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fU6MFjVMU7wK4vdBVH97bBR61iQQtpiyRXrWiXvtIyc=;
        b=j9wmjwXTP9Z2M1y/ILjAwfoWjyPK0Yj836Dv5hsvwf98V993M2eXWq/j2nPUei4s02
         to072WkrHo+f2uFHbSCgby4MalkAcuLEEUAjFz9Q85SuKSBF/1LVNK23TXsV3ASpwSKV
         GNTyQZX6ev0jpNWrgxBOYkIWrKMgPPwZyu2mH+fsC/ktPEqdRxxyS7wZkUptiHb+yS8r
         uBM+fsTV8FdXU9tU2N+3LnRJ7QxQfZqeE9eT7Xx413ok1DAs0n7sxf5yTEbtyJyZL7VM
         SIXIJiYm4WcqXjfDPxyWYDq65BL+Xfk25l5hmswCkdvG5BLAYqqHuVFokOgjYrq9ZDmN
         8Cmg==
X-Gm-Message-State: AFq9FYJ/OxtGs8U0Ur4tNwxGwuS3adq4jszzu4GEcwVcO32+MGraPnDP
	lW41f3dSjSoXWYRO5Zwj9oKSSEGHcNsf9rl34L1wGuu1NoTAMA/ALaJrGDJBZPU7UVA3cHqvWp/
	k6wgrVcjZ8TYrCluF13FSgGAMljFA/SE=
X-Gm-Gg: AYBFou20kDTTd9xqrind68fzzZkl34+6sCPgioU41tScAU0TuIASrDDLrcGsDwoitca
	O2k1SfFvrd0f30Cyok4Dnu1uHNu2lSPmhvTyX9/by1isP4eOierUox7rutKFXESuKZNOYgrgLhu
	sGb+GcnGsc9VavQdXDNvZYjQ4IWwCM5RDJdipKVG1nON1K3aDrR8nX+kCAEf/Dug6ZxjLZWK6sP
	Re8xpSCmRC2+gl94EM3OfY6fXbhoUnuEiYmXUMUJC+gBxTtJtBEGU+BKB2UeGYoAKnpVFLEwbco
	hlERhboFe71jRtJ+UygNive0Q/UIT8ZR+BmbaBMWgjKF1WVfhriUbX0=
X-Received: by 2002:a05:620a:4009:b0:939:733d:cbe0 with SMTP id
 af79cd13be357-93ebd0e4d2dmr2283163485a.3.1791931350324; Tue, 13 Oct 2026
 15:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com> <20261009190746.803607-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20261009190746.803607-3-dmitry.torokhov@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 13 Oct 2026 15:42:19 -0700
X-Gm-Features: AclHuK_vVSdpPBKX9wl3s3nrh7_1Mr_Atvo0afOjkov7vZ5leLMMruIoft8t7r8
Message-ID: <CANRwn3Q-vJd00M3ntY7tLmnAc06Euwpqcf4C2ECm2vpvzfXG3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] Input: wacom_w8001 - use ACQUIRE() for interruptible
 mutex in w8001_open()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 12:28=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Switch from scoped_guard(mutex_intr, ...) with an error fallback of
> -EINTR to ACQUIRE(mutex_intr, lock) and ACQUIRE_ERR(mutex_intr, &lock).
> This flattens the function logic and propagates the exact return value
> from mutex_lock_interruptible().
>
> Assisted-by: LLM

Aside from the Assisted-by comment in Patch 1/3, this LGTM.

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touc=
hscreen/wacom_w8001.c
> index e967f2413706..b34fcac44f63 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -387,18 +387,20 @@ static int w8001_open(struct input_dev *dev)
>         struct w8001 *w8001 =3D input_get_drvdata(dev);
>         int err;
>
> -       scoped_guard(mutex_intr, &w8001->mutex) {
> -               if (w8001->open_count =3D=3D 0) {
> -                       err =3D w8001_command(w8001, W8001_CMD_START, fal=
se);
> -                       if (err)
> -                               return err;
> -               }
> +       ACQUIRE(mutex_intr, lock)(&w8001->mutex);
> +       err =3D ACQUIRE_ERR(mutex_intr, &lock);
> +       if (err)
> +               return err;
>
> -               w8001->open_count++;
> -               return 0;
> +       if (w8001->open_count =3D=3D 0) {
> +               err =3D w8001_command(w8001, W8001_CMD_START, false);
> +               if (err)
> +                       return err;
>         }
>
> -       return -EINTR;
> +       w8001->open_count++;
> +
> +       return 0;
>  }
>
>  static void w8001_close(struct input_dev *dev)
> --
> 2.56.0.385.gd3acb90ef8-goog
>
>
