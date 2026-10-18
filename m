Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53018D62A
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320831; cv=pass; b=OV25vq4ZX4XjhFgyuVAf/rZO5UUQdOL3nvxvj+VY78oxvY5GJs0d5OxiKPzQiHIpl1C9KW7ybpSAhTv2f1f3MmIOMtRDt1dybEFeJZKFVhQTZTH0E9PJvQf8ulfanDTn1WI2N9SCGiHt9cADWN/gbBS9FcMp5aWU9IhxsthHFpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320831; c=relaxed/simple;
	bh=s8BhPsWAttUTh1yAfTpJLpQ1XWeD9Np43kxWRn3JZ6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlED28bgDZbBtmYFWQFrg1otBdKzUGdtdr+0FbECiaosAk50RMY6fGTFwcRn+nHDl2Fv4i7j2le8QANPp40Ss9AQ/waHyA0VocJnqqNiK5Cmk7dycDExkKuv9cgZSTqk0X6n1A/jyqp4GsHS0xbb6X8nfEWk7nPGuCzWOzoESP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNx9StsL; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNx9StsL"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8acda240937so8985167b3.3
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 03:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792320828; cv=none;
        d=google.com; s=arc-20260327;
        b=T67YZQViI0nROanEJ7AvoD8GRJMDB5yu30pS59XqcQeT3/MsRaegu5eehbkngmAsKS
         J5OWc+AEQqkJAfeELHBumSuTDV7MapKpb/0A0VDZLoy5BzbxH9Z2rH9tOcaiZwMpCSk8
         e3cGtMaOCIKx8hUJK8n0HPDXo1ZiBI+nrtudr0J3Hpd1snfCaxP7MQ7izEZpXH+7DsWR
         qzQGkNbhrkYitV9Ge7oRWHmt4lPbfJ709FgJIp4G+3zd4Af5egTdMMS+QEOhaZJrmNhe
         4iGwcKea9W4jX3W23rzoygLeVLqm1lC4KpVeNwfCglia8N2N2PAwC/C7QaoRuc1YK322
         AYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QdtHTyJE7LF6dzD+H/UzvrJM+aiJZLLku+R5qZeHVv8=;
        fh=rFEP96EGBne0dXJs4LUsvtN7lodaa2VibRk45z5B5Ow=;
        b=jlymKrGfrLiWjvOM/gbx1tIpKUypwSeDM3+EX0/K6bDawN9sNkYZLl+v1WSL7JsDo6
         EZOknISRKhN0SuV0ULFepkBDvPeiICAGjTy0+gi7UAR5GL5DHP7hjfJxzFD9a+DvEnK+
         sI3w4piuxlCzSsTjqnVD7TfiNQHEeTqbamvCJ0LybAY3I4qFEjZEoaJA7zR8vVD4kIsf
         GV7rT4wQvNpaQksVXRtuwGspBQ+2idl3JwZwhGbhetexf6xT/yHXRvVL1lDne+Tt4gxd
         vJ2xA0evZ6s9p+xN+D2uD6f/0hpPejcrO75waC4ITRqNCsYZYPVO7liHXmFUPTPRpLwG
         ujfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320828; x=1792925628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QdtHTyJE7LF6dzD+H/UzvrJM+aiJZLLku+R5qZeHVv8=;
        b=bNx9StsLWBKqK2yXsnpfBRY5W1KMctveL4u3/IG24xPWV10KpcYQwEQWD4DEL+C87m
         0hfM+7AYblbkzixa61IyNUT2MuVzbFVPTABFgrMCTUEueqA6uUznE8IQyjPDgb8hZqsr
         /XOzWgDQ/hEaV/kiHiV0DNiaZDD17GWbNUmsvNOJHUp6e/oQFKoWhiOVaqWxuWnhZ4jo
         wMAbqTor73ST44aifD/9nMWJYzeq2/4zOZA8RNBxCnxeklYBE5NmWlZKoFnQDI+1L/TH
         8dBhEScZk5scOGQLtFVuUs5za/mCDqglBogC6hoxEOOGQUyMVd43Rr0+7jfuwKkX8Abm
         ytTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320828; x=1792925628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QdtHTyJE7LF6dzD+H/UzvrJM+aiJZLLku+R5qZeHVv8=;
        b=CAaZeLGJYax3vJe6cXu9ds7A0CRmR2c9MykjeCPXEaJ71rsU+Z1wUUtwwtgjmhkb6T
         582WPNSfQ3BNivJPP1qT/oLhl3ofY754uqPg//Gi+sqr1gsN3hYbL+p8WGmYkNv/wK+G
         Gmj5wQZIEt/Nph99z9D0VptlfJbY+9cQmjkorEmKW/UKhKMV32b56E9ETnGdDm0B73dA
         WdriDr1yjS8ymVoNUdZHoKzH8bvsqKV63yiuOzvWY4F58bSFCnLUeU3Zm4QO1Yb+64SO
         /j/4r1DSXqDVDHgMplL1gQ88T6ZWM1gYmdaVLg2l6HHbOG3JVawrdTswvfNjS0FQLnPp
         lN+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLbafmlo8YwkcNCxBTq8nZ4XQ01d0n8M6iWyQDgH9IhepqjKzbq3jd/Z6Lh/8tSarYxT6V7dkTRCD/KA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIfeFnGCcG2J4+6qzQAp9VZ+XKolaJbTZayYgCDFOnJcvfdQ825
	kksMMgqt10YogFTnnU/zKxw7WE1CR2yRLI2g0AANwyltqz3g4jyYeU0seiwkmo6oXuqSbAXDANr
	oHVJ+kOQKFCSyozVeLRk2xgwyrW6Txgg=
X-Gm-Gg: AYBFou3mso5jgb6sjRe2Z4iQiTl+vv764DXtn1iw07DdNEAu9t7R2wzeLQ9d8O+JwlJ
	hiV+ocP3mfTp0j9BDY0qNc0i+adCRdcpZ2O3ik3HNzfkR84eJR86v/W9ckNwbb5RAFu3W6o0wQ0
	WkL8cWr/vUR2izN4uNBU+Rg8+n+FtVJlO56rPBSoybV5i8983thLvfA72yer9N1y6mDoAnjoEBB
	JWEN9lXldp3cHjGiiiX2AqvYc11R7fqK0vrhNlYE+wS4/R8gfHKh2/rOg57JE7/U2RH8MDvdlAm
	GCG64Xt4YRxejCb9pVFLv75r2ZuS5bZsLrX5nh1RxJC+dP4O1AgW3NNaXmpBAlhPvLVS9egD3pF
	BsbIaRHEFe95iHDXYmh3FVGG7Q2nJteoVavAiHvA7/2TWsWwdnIALuQY=
X-Received: by 2002:a05:690c:6a08:b0:8b0:ce9f:29a7 with SMTP id
 00721157ae682-8b0f21d1304mr15098167b3.61.1792320828649; Sun, 18 Oct 2026
 03:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912035306.13130-1-kartikey406@gmail.com>
In-Reply-To: <20260912035306.13130-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 18 Oct 2026 16:23:37 +0530
X-Gm-Features: AclHuK_JNPlkrQh4-6nIuKBewsgwTmmfpoDehy56tr1liNf5bBsF54SNPXi3UGQ
Message-ID: <CADhLXY7UbSmK0aXs9SSM+k+MbYcWHxHSy4_8NOKb88Ys8SbLQQ@mail.gmail.com>
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
