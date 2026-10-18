Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EDD40BCCE
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320974; cv=pass; b=tU03c6SoMEIrQ+am7ClzV7R1pUZjJ1RIZ46rmEVNlm2RMstJOmI6YpG4b0A0G9ObEGn33h5+foy9xZ7YyML0qDc1iSW0H2nNfGOlVevM+BXigSFPVjf1ZmtMWDMlSZyQ1LAcaopNvQhpyL7v2ACHxwQw6EhjJhOHOWag7xjW5C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320974; c=relaxed/simple;
	bh=sFPavGr/h0ZHdN3hzHdJb954J9MdnjNQjSyuWYY0wbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRttBrd1tam4ribbT6RZj+rYtAzHnCYSBj0rIgi79IdBvzF2dSkUlicYnPSoMRaSjeuqer9DzXeRFstAp6Pjmy4uDUZeHwrNQvVxHOEpHni/42S1uqP9VUXVSanlPxypGMZdB/PbJIBFPfIE+KeirrEeiBQUhNe4wyn9MfwNeKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnWuhic7; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnWuhic7"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6798c43a3d6so790228d50.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 03:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792320971; cv=none;
        d=google.com; s=arc-20260327;
        b=gbc7lOyRE0mB9eyjH0sIfQ+DoIyuDV3tthEr/ElxIcsOAhhjJdgk12u5M5AF8m9WUq
         WnljwCZ6TJChJnNLGSoIZQlirrPpQ4nXw9DTl4N22WhjoURyVpZO+3I6iaq+bnRDWMyM
         Jj2EFL9syyIueE4RHQSKIHaBSy/XsPXa1p06M7MUfNpWGKq5lmNx6PXEAOPo98lHJWDQ
         aB1UqtOM+0+7g7KGBbdgdEBpVHzpyflMKBioAouuv9SRaIKMssBv/ph/VSwAUx5btjwl
         nSX7qg0rbww9sMKa1Pd2aeNYH4KVIL5F0+Vt451KkNaizV4GDzKys+aFxMCYVDru+Jtm
         Ewpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuZNxZeD8jYEYOcfZtp8NI32HtWmzdfwkii1MWiectE=;
        fh=Ogf47TwCtKoY2067QW3Y8xjxdob6TUSZfPFuUB0X9Qk=;
        b=SGIXi37rnaChvm5x1FbxhwLps7LgXsYNtKUgb4z2orBQ5YgRJaAnPcrs6Ev1HMC1ZY
         i8ycUnC2M7eXYZK1eYAZi6+e4o9fzGm2FYFkdZ0+rm+WiwFD1wpDEpaeSNbspJDw5jqX
         qRls/4Wx9uohPwlwbsujYSfiGXTOyf5ovGeyFLuM9YvNEcFhqg7amxgIJg+8TKR3m9Qs
         dWHHeIVQd6jBc+iE2+mogVqcqer6bTiIaDGpl/c8EFp6oZHPnnNa/bzEjg+Sso+gYUHs
         PDlfmFpCX2nahcSqTFccjcJnp2Ac214TvKHYrRjigh7HtSNGIIGxiJ7lM6PMwcgNtFwn
         JeZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320971; x=1792925771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuZNxZeD8jYEYOcfZtp8NI32HtWmzdfwkii1MWiectE=;
        b=rnWuhic7K+Lv5Igv6MdLYc9fscz91oL5wrhLLfv6mzalw0/p7jzJNuBIi8psPHvwJB
         q3I5o9IJ70hEqxZWibzVGleJlePDTU/3M8S1KUKJNBfufoVsFmgGK4L1PgZytF1OrHGN
         Ron8cIcYsj6rmBVWMLmPSxa0CYTSjh1rVR6VvTu5eObPuVAoSVsaXI/5o8pzXxaJ08H/
         2qMla4Cv5xcUhjqdA0yIbaNyWR5hXQLXm7svjj9L1eTj5HhBkaJFIRUzWe6rD2WRmRBH
         EhfdM7srf7Y5ay6kst1O1kTrSvezZyG3iFkJGuKiyhZDpZHFb8+KB3NbiXJ/myy1DMlV
         G1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320971; x=1792925771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuZNxZeD8jYEYOcfZtp8NI32HtWmzdfwkii1MWiectE=;
        b=KrIswLjbFZsJ1kBfDt0MZZYJp6ndPj8U4z9KLFdyhTdiRE9YZItX3uUvWvQiVoT+Ev
         HDK3Mdbw6sFlGTb2xo0QL+NOydShwddqqQIDrV6onNbhWw0ndl/rsBcn3sKYgxIEd3hb
         tEBPlj6wRJJ27oxFh2edoH6Jant9DaeKrg1arpB+poqZgnA/ETgICS35BwUbOZFWycG2
         Bggcs9DjCvUcDLYxja9gX+7UDyf0SBBLDtqag5C9Cd273PkqqubtrCy9wJddsenxhK6d
         pVNyGEMs3o40TpL11OK9N69Ea1b92sEZ22nIIYDHVhr+aSg0/mDOFOXUrp3UKLwbPEmk
         3KpA==
X-Gm-Message-State: AFq9FYIUTajMmQ/W7MXwppilpULowrPGxmF8Q8j/EayzxRX7JQtxk5B1
	COgrOlO//nb9hlkIqtOI9gVNceFIW6kzIaRZXZFfALqoCqIyCxRz40lmAlHll8Zzzo4VdOhT03k
	G5s80xKoNu3oSRpcj5ipPlxOZymeNBh0=
X-Gm-Gg: AYBFou05zIW2lNAJ/orsArZ1entl8Wee5H0BlOz90sTFnybtZwPhWX8DSiFmbx1DdS+
	pzN+XKBnBomgN5ky6ljeU4LJgdiWKviELA4A9z4thyuQwjWM2Zl/jBTU0coe54viUkJ9KiucYp0
	xzrmsWre50Ax61kBN2JKA/0OvhNbix1mhM+faXGRmAuYwI+qnxc/+NyOTKGEiF9lP+I9vkM9Uyw
	XBhgrVZ9y11i72+DXeSUSdxlBmsnTq4cVHkzbblOmsrk3gOjUrNl+bhS053sNLE7CLl9qXfMtv9
	4qMktJLbRSSdoMsYUurWu3z06eVUG0SFDjSDvMFHlAB3HxLiAJxX18yFqqfmUdlihw913+Eyoqi
	wy47VeLsuKziCMSOHFflClJPmI9v2UDyDFNfVwvX65etw
X-Received: by 2002:a53:a588:0:b0:679:a730:8e50 with SMTP id
 956f58d0204a3-679ca9243admr745378d50.135.1792320971266; Sun, 18 Oct 2026
 03:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903121206.6893-1-kartikey406@gmail.com>
In-Reply-To: <20260903121206.6893-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 18 Oct 2026 16:25:59 +0530
X-Gm-Features: AclHuK8RKncByJNy0JFba82F6DPlDITfiDOhggPPgwKkilTd5tgoEuZJJZ9kw44
Message-ID: <CADhLXY7oT9q+p_Nf_NrOea5LKJ1t8rFNT4_6EQ3h9H9V=ejJ3w@mail.gmail.com>
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
