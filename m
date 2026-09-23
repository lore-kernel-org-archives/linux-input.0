Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F9388E60
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134076; cv=pass; b=O/ezXhtq2Tz1H23e5ZZqX+vIU/xxOEDBa1odr8lCKPBo5Y5RuBHbr56FAEHhfikvSZL6kZRNC3cCuZ0g85rjM5of7vdR6GMgbYN5Q0N1qHTUurymZVpdS9HdvcNnmTwBmYKORmSmGUlotBtl9AUB/1HpAKbXry3EM4iKIi8/jOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134076; c=relaxed/simple;
	bh=Ou8j4+E40D0Pe2fGqCopDnYBeR09E1t7Pc/ltBE9NXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzzgP2/INQlnWB5w1/Q0i5zlyuNRx/HXdi8WZ/UkGUf2DxSzoq5V1V8va68PYZx3jlNkR41JbLttbxOYyUZJrH7yM92cc+qnVpR0XKp28tswWzaa6P5Cs0TBHbkSmIZbEBulhrPeoUPROya+wYwD1YkPa7RHtUOXfrpnWBrDUBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR+Tx7Jy; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR+Tx7Jy"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aac92dbso420604d50.2
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 20:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790134074; cv=none;
        d=google.com; s=arc-20260327;
        b=rqeCTBbmJ/boPh6PtuQRfj+yS5ZFgXVfJ5fBM2+/aMtOeqxALQwVP9sd73TwFhVtkQ
         +bvBCbW/hJ6hDWEnCqOUtxm+OLsoKFyVxyHwuXizSt61vZU3KpmMx4XCikUQ6k27wt5L
         9PGHIOx+yP3SYWhZ5fdp8bDQwz8icWeDkVzlU4GL447ceaKffOWoLM1k4sREDtWtjsVb
         bw6VmNcvnDUhoBmvnDl4MUBhQyNlebpc0NjUpnt3VAlDZCFf/xv8p/G/FgqbEDRD6Rs8
         BUZbXzSAS1+dXjtUa/VidPEcwsYcVnZH8ftNl6S9BkUHDF8gJ1+zh56wnHJYt7OGEiZQ
         Kphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nYnhqDQ91zzPmdqdz/fNQsWMnF+4xqLcwJOrRFiuz5k=;
        fh=Ogf47TwCtKoY2067QW3Y8xjxdob6TUSZfPFuUB0X9Qk=;
        b=PypcIxrU7RvNKkaQumQ7x5pMOYv86XdS4GZ6FuHlcK8mE0cufoTWIFPh7HMa5Ga5Iz
         PBRU9de4YOMQjOnG84XlP18Y6uDR9Z/pW2vj4DDZkD+N9sOMj9fiH9sqqAGUFR8/lDOZ
         Uiok2YMYvq2IRdTh85Yt1FVPgPmAMOJa6a5PNYTDWiuXStzb/Q2cgAFSa9/Zq/gc/T2l
         Ov7CwlviDdwl5DNUuqc2wjzTyN4JKhb0WbM25wl9GhhPJoNqahM7kwj5N3w0KIzpHm+l
         KbkchKZcvl9A9YY20gF44A54RH+Gv5066owEoIN8SFWqul+3ctsfeewI+afJaJVlhQhu
         EXcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134074; x=1790738874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nYnhqDQ91zzPmdqdz/fNQsWMnF+4xqLcwJOrRFiuz5k=;
        b=HR+Tx7JyhzHSZ78dEycjqSrYI7dN1jNeRHddqwxcKugQlrj4Hh9q5oW6hDkf4qFwuU
         JBQ5mzEIjqgoa7C6aEg1W01uOM11ZyrtGVBFi4++DyKjWJBE3wt+ToptKvMvmJB3dkXl
         lGtIGDVtZLFgDFZ4TNwMpoxv+gtgqm5E35a1/awBwX/98CYYzLsRcf1DrYCYGx+Y1F2Y
         F7/YyOWpZ5lpJVlv2kuVlAUrtdc7S1nUoCBoCee7N4dVqqH8bWMsfcK1udSuicWQ2E0C
         5vnuUqc+E3+YKMH9c+b8Gp3KDN5rPYz74lgRf8qlB3c8Kze4se/DK+wN0NDEa5pyjg/z
         fQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134074; x=1790738874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYnhqDQ91zzPmdqdz/fNQsWMnF+4xqLcwJOrRFiuz5k=;
        b=iyJG/kVMo2DxoBFwwwkEJXSCGc1h9bzBe/Ur55DeEqXH+GKm8dy/mRkcHDGufTadxZ
         7u98tvLUWp5MHYwOkZtcQaYttwPsJStEWTWYbqjsFdkse/xt7yy2CJ/8MsCdzexkTuUy
         v+gXOny8duUeU/WXDPZ8sQWbicLJcT6vXj4lpDi9ws03sLk81GtXrOd5zhAxuV2NXDQg
         KnkH60oIeQM4hJkjFnQmC6JOQkN/9DiiqSUNzdkutsVX+TX8FYMH8lpsfWbKhTzu8Q52
         pdpvUhPfaCnWVAwjMoSi6Xj3avT+pESnmnkRuyBtp96FEFoE7z7a1okFPLbwoL2uazer
         1F9Q==
X-Gm-Message-State: AFuF++mWdV2RD/40+wjm1AXVC3KcRjujsbjuaGpNYyRYK4PqBsB08UVs
	ceD3INeK73Vnt2ZtpH+VBjpRukLNVzG5RJQX6Unh9aOV/ipoaUqQvIXvo9k0Gv6V9MR2GMXyu1s
	lBMsv+egJMcvVg/WDJ5JxgkZILkk0IN0LoBG3
X-Gm-Gg: AYBFou0yydMuTlcErg/j689/EvIV4XQ/dLO5ikc3pjP9Ex+eqDRWagq5px5EZFhjLWo
	sfCkSd4oMzBQXBmYDCtyqJKHNm6XJTW53ZItOpVvJuqzdkv9WzgYgrC9oAISpeuQBR7Yy+eZ1SB
	wjXtWFxstWohe4SE22igS4i7PJUPm1x0VxWfRF0LFyflyy3EyOrhq8lve3ZDIvzq4VcXjEudvT1
	s2beZVJJTXTjAk8sMnUEIvtDP3U/qpzas3cQSP6vZaN+PpW1674q1qeywiUHyQRwOWyJE0ZtfaP
	Wz66uWVlkUIz85otXEFT5EpXXv8BynywV3E7w1ILcEtRRyNbRF2yyriOrw/iVSM2skKPoHDul5Z
	xktihv7yIHKndfE5BREMI6DHHNTFZh2Yz9CjeLf69LyB902BKQeFcCQ==
X-Received: by 2002:a53:ac9e:0:b0:672:de6f:ae0d with SMTP id
 956f58d0204a3-672de6fb1e1mr91515d50.20.1790134073681; Tue, 22 Sep 2026
 20:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903121206.6893-1-kartikey406@gmail.com>
In-Reply-To: <20260903121206.6893-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 23 Sep 2026 08:57:42 +0530
X-Gm-Features: AcwNN1XV1G4f4sZRuSQ9NX5nYEFn9KbLJMeGSbSC9b9fvzo6Jzf6goe_HdrhsJI
Message-ID: <CADhLXY7AUqUNCtZpWDBUKBRMbd8Sj_MSu2uzL8Hy4tG4z-u7oQ@mail.gmail.com>
Subject: Re: [PATCH] HID: roccat: fix use-after-free and uninitialized-mutex races
To: erazor_de@users.sourceforge.net, jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:42=E2=80=AFPM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> roccat_disconnect() dropped devices_lock between reading device->exist
> and later checking device->open to decide whether to free the device,
> letting a concurrent roccat_release() free it first and turning the
> later check into a use-after-free. Fix by keeping the whole lookup,
> state update, and free-or-keep decision inside one devices_lock
> critical section.
>
> roccat_connect() also published the device via devices[minor] and
> device_create() before initializing device->readers_lock and
> device->cbuf_lock, letting a racing open() on the newly created node
> take an uninitialized mutex. Fix by completing all initialization
> before publishing the device.
>
> Reported-by: syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc492a9e154f81127551f
> Tested-by: syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/hid/hid-roccat.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 4f15eb951039..1d57f8a44a3d 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
> @@ -316,6 +316,14 @@ int roccat_connect(const struct class *klass, struct=
 hid_device *hid, int report
>         if (!device)
>                 return -ENOMEM;
>
> +       init_waitqueue_head(&device->wait);
> +       INIT_LIST_HEAD(&device->readers);
> +       mutex_init(&device->readers_lock);
> +       mutex_init(&device->cbuf_lock);
> +       device->hid =3D hid;
> +       device->exist =3D 1;
> +       device->cbuf_end =3D 0;
> +       device->report_size =3D report_size;
>         mutex_lock(&devices_lock);
>
>         for (minor =3D 0; minor < ROCCAT_MAX_DEVICES; ++minor) {
> @@ -324,37 +332,28 @@ int roccat_connect(const struct class *klass, struc=
t hid_device *hid, int report
>                 break;
>         }
>
> -       if (minor < ROCCAT_MAX_DEVICES) {
> -               devices[minor] =3D device;
> -       } else {
> +       if (minor >=3D ROCCAT_MAX_DEVICES) {
>                 mutex_unlock(&devices_lock);
>                 kfree(device);
>                 return -EINVAL;
>         }
>
> +       device->minor =3D minor;
> +
>         device->dev =3D device_create(klass, &hid->dev,
>                         MKDEV(roccat_major, minor), NULL,
>                         "%s%s%d", "roccat", hid->driver->name, minor);
>
>         if (IS_ERR(device->dev)) {
> -               devices[minor] =3D NULL;
>                 mutex_unlock(&devices_lock);
>                 temp =3D PTR_ERR(device->dev);
>                 kfree(device);
>                 return temp;
>         }
>
> -       mutex_unlock(&devices_lock);
> +       devices[minor] =3D device;
>
> -       init_waitqueue_head(&device->wait);
> -       INIT_LIST_HEAD(&device->readers);
> -       mutex_init(&device->readers_lock);
> -       mutex_init(&device->cbuf_lock);
> -       device->minor =3D minor;
> -       device->hid =3D hid;
> -       device->exist =3D 1;
> -       device->cbuf_end =3D 0;
> -       device->report_size =3D report_size;
> +       mutex_unlock(&devices_lock);
>
>         return minor;
>  }
> @@ -369,15 +368,12 @@ void roccat_disconnect(int minor)
>
>         mutex_lock(&devices_lock);
>         device =3D devices[minor];
> -       mutex_unlock(&devices_lock);
>
>         device->exist =3D 0; /* TODO exist maybe not needed */
>
>         device_destroy(device->dev->class, MKDEV(roccat_major, minor));
>
> -       mutex_lock(&devices_lock);
>         devices[minor] =3D NULL;
> -       mutex_unlock(&devices_lock);
>
>         if (device->open) {
>                 hid_hw_close(device->hid);
> @@ -385,6 +381,8 @@ void roccat_disconnect(int minor)
>         } else {
>                 roccat_free_device(device);
>         }
> +
> +       mutex_unlock(&devices_lock);
>  }
>  EXPORT_SYMBOL_GPL(roccat_disconnect);
>
> --
> 2.43.0
>

Gentle Reminder. Please let me know the status of this patch.

Thanks

Deepanshu
