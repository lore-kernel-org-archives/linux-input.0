Received: from mail-yx2-f23.google.com (mail-yx2-f23.google.com [74.125.224.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA32332EA2
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133827; cv=pass; b=fdk8r+Bc5fvJe9Tri/trRHqX1/eoPYFeU4u6gbSXD3Z/xYoFhfyOiRQ+i/rFXnmZeJ+PKE1zrISnzKPAmLpu2eNusR723ksGv6kMmEP/XgNFJMMxGka44w7evFQIPPJgBgzD8lAZMQhxM5r1evfaw4dd1f76+ttLFMQ8vEbthCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133827; c=relaxed/simple;
	bh=hTaa0ekNdm0ClfdmyzHYT7ItvbWXA3cvQZ7wVxy2Cl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh6iIf2BzpWbkGI6OHy/a1GH2tg9fZX1SeO5HcDJU3oMVoGsPG1TsakSW29QRrE/qdSdxq/hFBNrbXcWqtK7TMbfVHtASjK8v/GWZ33/0EMCjp6pL3mM2qvNub7OAd77pUAvzyrCHKXprMUk1a6EDvcu61UgV375rHKhyKFVy6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHuJqe0n; arc=pass smtp.client-ip=74.125.224.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHuJqe0n"
Received: by mail-yx2-f23.google.com with SMTP id 956f58d0204a3-66e4aa8e6bdso244533d50.1
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 20:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790133825; cv=none;
        d=google.com; s=arc-20260327;
        b=O9FcBW2ii9Ti6zi/0DJUoVqHB/Z2Mn3LBFBVkB6T9Fse+kbh0lOeJ6TZKFqysdYJXN
         heL8ievtDmD4vFHiemld3iWAyaWN74ttP0Iouzl/no9wHLc4EYxDt39rpjOZSgMkXAsO
         QIAnFB3ars8S9uzsDbf2M3fQYec7+vLJ0cfyQS7uSqojCAUUMsuNcm2wDLyfIQuMpO8v
         /eEV6V1sOT7lm9qwD7OmQQcxD4Gq8g0uK7xgFHD+kcPmgcZOpDv1aUQkesrxv8LgC5G5
         qBLe414nuzQ4zeKwCDcDUCueMVRVENFjLQ/gGGNNH1t4n0z4adHRy+HPLxpJdgZaV1NV
         Q0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2d+jrvEZexjVenG78loJJdYCjfuKeXtpLvBaz250Jnc=;
        fh=1WlfIksDOLwWtrOfaQDL0Dv4ReFtbBtooKs1+Fnr7+E=;
        b=CYdevQ1yOx+6uWJmkgj3u3T3OoX15xUATqGSeNBvN5QiyLWYMulJjosvGyb7GVg6W1
         orJiyFLvlM5S29axQ25lkKqzWe0Og1NXbKTvGtBUPXxLzWHEdIaflP9t1ze0jLIfapCD
         MEotfVfYrI/Y7qn+czifgD4UUAt6wPlNOsWjNASykF46XDZoBW1LyiXFsBBAgI1K6o+e
         ZyGdM2YlnrV5qkemC57K4nT+7CzWOb0BZShCu0nn/WYiFyip3D++u9PDvCe9K75qyLC4
         w3/wRFl/uvTES3eJ66tixPjdQEvry1oud7RfQpRIzFesq1dUlU2/pVUMkl+4VjcYqHN4
         WUpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790133825; x=1790738625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2d+jrvEZexjVenG78loJJdYCjfuKeXtpLvBaz250Jnc=;
        b=XHuJqe0n5TsE8C2Ostezgf45VbBTckyRjNr+SZTPaLMNVZ9vc6aH9N6CnMgncuRfUa
         B+xavvqPcbtXr/D6wymkmW0GqUueX7yGWUnSnCU3OLM6gT2t4QtxH9RjePjulpmRgYqy
         yDzKRXFj3BZNMBYE1lx3rV71/TQL04szVFInva/ZsRPCTWDNZ/d8AGN29b009a4nVsQf
         2B8PxcajE1SuqSD5pc54xioTn4uDnC0WyTfBC2isWNikKwCAwxjZTB9UxwJ/mwW5I3Ud
         ZF4oxkYdvuMLkbRGsWBe/JgxZAalU4oDPyo5neKLR300aL8w9Dx4MNFNGiTFbp70KOp2
         ytXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790133825; x=1790738625;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2d+jrvEZexjVenG78loJJdYCjfuKeXtpLvBaz250Jnc=;
        b=q+lxGkJGpnjqjKCLkA8w37HKk1Qd634fSPffzKP7s/sx9hxojOGAYy2uoP4u16hv9G
         2efXrpWFfpwtPp2CG/n4/wnjAp4Vb0vGiUj01fuprVWUGVUGdtA4ONig2dazD08/vJ7r
         +SeY61JGJf/eUN30wRukOc+9LdKE7y5OdmYo6f2ZQYATVlgMwAP5YNe05gE10eHCfdnR
         qBEnjv1YEZR/8s1t+lil1htMcmbrsE2KBfyj5R1kmsJKa7Rw15aTJc8f54a3jylGAQFR
         5KCX0Wl4Gw+JBAYvD3+ye5YkW3UaP4rvM1nzSRfOTBVNVZn6iqxuC0Dz7GJej9/3dBSY
         Zdxw==
X-Forwarded-Encrypted: i=1; AKwUvBznBDzz6u/gpIiNqRpwhJa6urznflGDQX2XDFaZEVJHbcj92qqZwXj05fxjTfbGPXx32i84k7rMNCJTJQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k7x8DAySRtmIOLoXijJzuZEHs83P6sCThQDYNXDeH50Gm+OVEE
	7Q9LzcZ4VyXjukgR6mYDacS1y4kr4nSRV6layLH0eVvs5ZtY5M+3glb6rWI0kXZnDP7IW/j5WD9
	b172iA4vZJhOShQvQY+TT07YZIqDXHio=
X-Gm-Gg: AYBFou09yNp6OxCMm30X629W7wuf2ZMUTjmedpFdm/1p4WuNg6tlynNE/Dst4vo1tqk
	9tek8dg4B4W16ERrEhn7GvlYySQD++npGV188f2HEdgr8nj52JhHXmEFkHApXUVBFa683lTGp/P
	qPZGeAkMpHDFJ+kknDt59mwTVlKnRbL9ZEy3/5BVzUT58q6D7q5lXv3I22SATpITxofE9iofHsn
	GSnkbQOmVjNLBiML4J7fip0h0UcsRvjNWhZw/KC15f7MAa6/c5s7JQHhbgKAYio4p8+WwON4ZJO
	uAxhNqETkX3zPcwieOSWdu8w0UF21Z7lfgx+iJMBBsApMOoLSWLouYoqudMtG1cpW0pdr4q5zDa
	QvIwj+YWyZ8UDO+PuxUwwytVE9MnWm9TtRVeA3IO8bH7as4dEdbAQ3A==
X-Received: by 2002:a05:690e:4887:20b0:671:40ee:ddf4 with SMTP id
 956f58d0204a3-672d5a672f5mr517247d50.48.1790133824920; Tue, 22 Sep 2026
 20:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912035306.13130-1-kartikey406@gmail.com>
In-Reply-To: <20260912035306.13130-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 23 Sep 2026 08:53:33 +0530
X-Gm-Features: AcwNN1V63Mvj_g22-PUgvs2G9LwXk08boBIvwUHModkUD8SqmI6fT1lk081aeSE
Message-ID: <CADhLXY5Rg5EAtfJ=+SyTWNp9-s7RVMdyZThJT5yC15GYh6X-2g@mail.gmail.com>
Subject: Re: [PATCH] Input: sur40 - fix use-after-free in v4l2_release on disconnect
To: dmitry.torokhov@gmail.com
Cc: kees@kernel.org, oliverburns.kernel@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 9:23=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> sur40_disconnect() unconditionally freed the sur40_state struct
> (which embeds struct video_device vdev) via kfree(), even while a
> userspace process could still hold an open file descriptor on the
> video device. video_unregister_device() does not wait for open file
> descriptors to close before returning, so if a process closed its fd
> after disconnect() had already run, v4l2_release() would dereference
> the already-freed vdev, resulting in a slab-use-after-free.
>
> Fix this by giving vdev a real .release callback (sur40_video_release)
> instead of video_device_release_empty, and move the v4l2_device
> unregister and the kfree() calls into it. This defers the actual free
> until the last reference to vdev drops to zero, whether that happens
> during disconnect() (no fd open) or later when the last open fd is
> closed.
>
> Tested-by: syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
> Reported-by: syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D34957180b0ed2581edaf
> Assisted-by: Claude
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/input/touchscreen/sur40.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 09d8c5f8d09f..bd8d9f6190fb 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -179,6 +179,7 @@ static uint gain =3D SUR40_GAIN_DEF;
>  module_param(gain, uint, 0644);
>  MODULE_PARM_DESC(gain, "set initial gain"
>         SUR40_PARAM_RANGE(SUR40_GAIN_MIN, SUR40_GAIN_MAX));
> +static void sur40_video_release(struct video_device *vdev);
>
>  static const struct v4l2_pix_format sur40_pix_format[] =3D {
>         {
> @@ -750,6 +751,7 @@ static int sur40_probe(struct usb_interface *interfac=
e,
>         sur40->vdev.v4l2_dev =3D &sur40->v4l2;
>         sur40->vdev.lock =3D &sur40->lock;
>         sur40->vdev.queue =3D &sur40->queue;
> +       sur40->vdev.release =3D sur40_video_release;
>         video_set_drvdata(&sur40->vdev, sur40);
>
>         /* initialize the control handler for 4 controls */
> @@ -820,6 +822,16 @@ static int sur40_probe(struct usb_interface *interfa=
ce,
>         return error;
>  }
>
> +static void  sur40_video_release(struct video_device *vdev)
> +{
> +       struct sur40_state *sur40 =3D container_of(
> +                                               vdev, struct sur40_state,=
 vdev);
> +
> +       v4l2_device_unregister(&sur40->v4l2);
> +       kfree(sur40->bulk_in_buffer);
> +       kfree(sur40);
> +}
> +
>  /* Unregister device & clean up. */
>  static void sur40_disconnect(struct usb_interface *interface)
>  {
> @@ -829,10 +841,6 @@ static void sur40_disconnect(struct usb_interface *i=
nterface)
>
>         v4l2_ctrl_handler_free(&sur40->hdl);
>         video_unregister_device(&sur40->vdev);
> -       v4l2_device_unregister(&sur40->v4l2);
> -
> -       kfree(sur40->bulk_in_buffer);
> -       kfree(sur40);
>
>         usb_set_intfdata(interface, NULL);
>         dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC)=
;
> --
> 2.43.0
>

Gentle Reminder. Please let me know the status of this patch.

Thanks


Deepanshu
