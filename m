Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794750785;
	b=zwuAyJpJuVgXAwV44hH+3/WKd4rYSHv/oXPUZynQQCpO4QxeardEmuCuqnN/hwVR7bIa
	 rqsZr87C+RwIw3wcum3YPQMD04rqPwUflB7PwpxfzE7ZiwuaGqzDyNBtF1txgJAe491Uh
	 8oldtdLjHsv5PO9xLOAN3N/HTkj8hFGvYj8CmdW+jFqjZwWvkPareIoyV/U18BRe2/j9g
	 xR2iYEggPld6+8VPaSm8TeiMO6hAMiC45KFRxEH2lNbF/9RDnZ1cJyLPrjJAXYsucpmGk
	 9vxfXl9cWPHePo8udA5eUSvBZ2WFigNhp+HM15Ga+e+2r2Vlm+Ti6YUkfGkiRDwqZwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UCRCbto+itoVVCJOHQCm5Fub/7/mLHD7BiTv/5zNwUQ=;
	b=ffBXopeGYZvLCy5+HcoDfmCXGcZTnE5GNQG0EMeK/wVqRmE1USr0+gxZE9kJSwv9XSOD
	 icKMpbUYbY2ZNQ7xGTJNKth2BYF4YNOzAyFOspWuqVCdmCv0GxFOIxU/Z3NbAkZEZzXWH
	 27jh86BlsE4xqQ6u1vzsmq7cCClzW+vKY0HnWbjq+sj7H2+XX7uSTSWFP2JGb4xcZfFCs
	 lkarzV/7PGZ1hY9sYHHKYb2N6R72LeXzYPxVaFayHnkA6idLrU3a5c1mckZ9jmUXVvAKE
	 p4Z5XgF9rMDSoE6Yy8nPzseXp5YW+CGPEqJh41tsKBvAhHpHw2wMla/h24/FYhZqVhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHISzKQC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03013606A32E
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 13:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03013606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHISzKQC
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67da7d18f2fso739845d50.0
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 05:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794750783; cv=none;
        d=google.com; s=arc-20260327;
        b=BNb6BvW2s2tdSJsIxraXpyVFT1KH0GR3mPsPfxhep0KUyVvAI8KPQWLtoJ90KQQDFX
         9WHSx97ddkYHmhEe5nj2mIJ9JelSYiD0LHNfkztDA4f3b9FQFnmQHGJxMPD/TSVYquvp
         LN/udQ+9EkSXf5gxB7swsby4+lfGl71psNlioj1zYnqE7PTwp+s8e81beOVw551c64cX
         PNXsnAeoqe5/aslO0f9A+bEtBrZ2G8XpfPXwJsq8zb3uX0VPj/b9xkh1pFXuOHva0YEP
         Fw3adYdGWLqgHJPswRlNLNOAS5ICJRjn7JecwTk4oHZi9j7/qHoLNXNA2WC7GATRuc3y
         A1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UCRCbto+itoVVCJOHQCm5Fub/7/mLHD7BiTv/5zNwUQ=;
        fh=fZuVo1dXiFoK8KgEjP+xekmCR7i1VlUF2GUl+lqssfQ=;
        b=h8BftdCLc2N/SUMxjb54yamxT747l/p1qHqfvwCDEcAkXzdj6EZmhS1kYz/5K7XirI
         E5NbxzADPxs+vkYCeMLTQGIbz4cInOpY7mTb42kVSHkVe6nAgqjQ6dWIzG1L4uJ8+RhS
         b41QxS/SZFjNaX8GgitMLzTElQmOlUcmiItGLTrv2Km7IOPN1cToT3K+6AlcTcU2wnwk
         cQPz60K3GBpR4VkkICtB6B9LT7nEtkNBE3Vae1PXCusiSCQJMQpLnChmqwVtMChdR4Rz
         aoGPV39bYJk+GwHivFQff7eFnUUjuT+t5iRUX2nix19UY+M2q+R8zD6czpxKhFJNAcq2
         x2rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794750783; x=1795355583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UCRCbto+itoVVCJOHQCm5Fub/7/mLHD7BiTv/5zNwUQ=;
        b=xHISzKQCob2MIC/7fwGbxd6mATX6RYCkrBRP+jtK7R5lDt25TB+5vsuMqnOz8+yf/7
         LMvSyZrkL+3u/c5PNGEPJQhkyHe4qWTJNg4o3pVw2NKl63Pz3/eCpMPATs4YPxE3L3LR
         M51XJDF8+WcZkiD3QeOWNbEW4ZtwIEyRgSe7HXSwkbXp4BpPbPVNzt9DxO2XbCm3VhpU
         rbGNXcP1IkomRozddP/pAiMJ4TYdzyi4JieBGA5CMnAc+QNv9yMMKohDNskULX2ZK1F9
         wFs/mOWviYCK3ktAY+IrhBaZ9mkfsACOOhN0U1CZrvJryoIVG+VQqW4KqljT5j6zgD04
         Ku9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794750783; x=1795355583;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCRCbto+itoVVCJOHQCm5Fub/7/mLHD7BiTv/5zNwUQ=;
        b=ETkZbw0Dcd5dVfSTMRyE6MSZKb3ceG1CM4r8H8dmRJ9MU/HvDFdQpGgmMIhMQEJiA9
         n0sU6latd/a86IPA/kcoBJF8ISPotJIJFdC1XmlKTHu3XK4VjmZ91haZfd809DvwRwck
         P8hJT926111L8FE49SPEKxS+wppe/mY12LmbtCV2D+OHqDstNFHkpz5naktoqzHW6dif
         mhCRAl64Llt5MmvTCKtRAH+jE2IeurpLprIscg6UWXmQ4xQkCiNeqQEiJH31Ff8komLK
         UAP36pCdGhjuMsmqOfwr6FqRD/EcaHr7LoDhde7AtrQ3Vswva+3/GAEGaOvbuNdnkI2A
         +MOw==
X-Forwarded-Encrypted: i=1; AL+hErHrXp7Tw/9X8axYkIBgGWx9m3GAlfiQ/CarDmZPtTlmFYGTTHwMH9xHBoqf8ARieEOAAVtNx+vSYvqhkA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+3u0sNvPDlU/1yabj0L86LqQpfWf6SydR5szcitjoVo+e9/1Ft
	jwsx5eReljABgnDGJvqwhV3pBqUp9lmMN6c2whfoR0lUhEn3SULnqz29mcnb7S5PGL08V9yZo/9
	rHIYqhcitC2OpE/1HO7t3nLLFuKgia34=
X-Gm-Gg: AYBFou1Q/aLzTifXNZZtkBEV8AdtkEH2p4+9VHUFNW6dfVEAv/+BavJz3TDu4SuAzK6
	CKYQIU1prs7bzHsDVxXzRvj/7BVZg8KkIK1zkEsJl9BZm1t5K+2yPaZe1KkVMWjD5r+AyVsiYnO
	KfktOLE1hNlut1jMENHhZ+iVEp83SPYdxM2eQ+my+CTq3B2QZUFvtqs41N5yZXVZ/Kpk0QeCP57
	qS3mdSDWUXBCqT2FSk/TDgQ90pAtqdjo+mxQX1N47PK/XByh8Gp5yi1I6q+Rqcuo423m2SSE42e
	rJPivqp/EIDuC2VCXz8oJ/pCy8T7i2qnsmsly/gtQolp4PPWLdl8tGff/7GmvAV1j7QovMp4QpS
	NUITs7ZX+IR9wjsgFc5NEtfR807E0SRUON1vP+/V//mESMFzM5WLON08XopL7lA+VngpTTwYppY
	YBQTL2gZMpXXENDSpKR+fiRCnmcOBEoAIjCgSnTD3PO1hVIfuwMKVjQoi5FJj0dobeOW4VNBysd
	6ywfxjnWSBb
X-Received: by 2002:a05:690e:4009:b0:67d:a565:a57f with SMTP id
 956f58d0204a3-67da565a809mr1759360d50.6.1794750783006; Sun, 15 Nov 2026
 05:53:03 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260912035306.13130-1-kartikey406@gmail.com> <CADhLXY7UbSmK0aXs9SSM+k+MbYcWHxHSy4_8NOKb88Ys8SbLQQ@mail.gmail.com>
In-Reply-To: <CADhLXY7UbSmK0aXs9SSM+k+MbYcWHxHSy4_8NOKb88Ys8SbLQQ@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 15 Nov 2026 19:22:50 +0530
X-Gm-Features: AclHuK9wBrH_chg0fK25v0wArr17Inps9k5_5Hwct0maENlMAwuq3wRoG1IN54Q
Message-ID: <CADhLXY4zo1m1s_YS_VoLxQb5bdSq+HP-ZiiFyY6SN0Y6W1dggQ@mail.gmail.com>
Subject: Re: [PATCH] Input: sur40 - fix use-after-free in v4l2_release on disconnect
To: dmitry.torokhov@gmail.com
Cc: kees@kernel.org, oliverburns.kernel@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 4:23=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> On Sat, Sep 12, 2026 at 9:23=E2=80=AFAM Deepanshu Kartikey
> <kartikey406@gmail.com> wrote:
> >
> > sur40_disconnect() unconditionally freed the sur40_state struct
> > (which embeds struct video_device vdev) via kfree(), even while a
> > userspace process could still hold an open file descriptor on the
> > video device. video_unregister_device() does not wait for open file
> > descriptors to close before returning, so if a process closed its fd
> > after disconnect() had already run, v4l2_release() would dereference
> > the already-freed vdev, resulting in a slab-use-after-free.
> >
> > Fix this by giving vdev a real .release callback (sur40_video_release)
> > instead of video_device_release_empty, and move the v4l2_device
> > unregister and the kfree() calls into it. This defers the actual free
> > until the last reference to vdev drops to zero, whether that happens
> > during disconnect() (no fd open) or later when the last open fd is
> > closed.
> >
> > Tested-by: syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
> > Reported-by: syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D34957180b0ed2581edaf
> > Assisted-by: Claude
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> >  drivers/input/touchscreen/sur40.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscr=
een/sur40.c
> > index 09d8c5f8d09f..bd8d9f6190fb 100644
> > --- a/drivers/input/touchscreen/sur40.c
> > +++ b/drivers/input/touchscreen/sur40.c
> > @@ -179,6 +179,7 @@ static uint gain =3D SUR40_GAIN_DEF;
> >  module_param(gain, uint, 0644);
> >  MODULE_PARM_DESC(gain, "set initial gain"
> >         SUR40_PARAM_RANGE(SUR40_GAIN_MIN, SUR40_GAIN_MAX));
> > +static void sur40_video_release(struct video_device *vdev);
> >
> >  static const struct v4l2_pix_format sur40_pix_format[] =3D {
> >         {
> > @@ -750,6 +751,7 @@ static int sur40_probe(struct usb_interface *interf=
ace,
> >         sur40->vdev.v4l2_dev =3D &sur40->v4l2;
> >         sur40->vdev.lock =3D &sur40->lock;
> >         sur40->vdev.queue =3D &sur40->queue;
> > +       sur40->vdev.release =3D sur40_video_release;
> >         video_set_drvdata(&sur40->vdev, sur40);
> >
> >         /* initialize the control handler for 4 controls */
> > @@ -820,6 +822,16 @@ static int sur40_probe(struct usb_interface *inter=
face,
> >         return error;
> >  }
> >
> > +static void  sur40_video_release(struct video_device *vdev)
> > +{
> > +       struct sur40_state *sur40 =3D container_of(
> > +                                               vdev, struct sur40_stat=
e, vdev);
> > +
> > +       v4l2_device_unregister(&sur40->v4l2);
> > +       kfree(sur40->bulk_in_buffer);
> > +       kfree(sur40);
> > +}
> > +
> >  /* Unregister device & clean up. */
> >  static void sur40_disconnect(struct usb_interface *interface)
> >  {
> > @@ -829,10 +841,6 @@ static void sur40_disconnect(struct usb_interface =
*interface)
> >
> >         v4l2_ctrl_handler_free(&sur40->hdl);
> >         video_unregister_device(&sur40->vdev);
> > -       v4l2_device_unregister(&sur40->v4l2);
> > -
> > -       kfree(sur40->bulk_in_buffer);
> > -       kfree(sur40);
> >
> >         usb_set_intfdata(interface, NULL);
> >         dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DES=
C);
> > --
> > 2.43.0
> >
>
> Gentle Reminder. Please let me know the status of this patch.
>
> Thanks
>
> Deepanshu


Gentle Reminder. I have been following up this patch for long time.
Please let me know the status of this patch.

Thanks

Deepanshu
