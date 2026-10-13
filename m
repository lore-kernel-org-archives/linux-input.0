Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D63CFF65
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931353; cv=pass; b=Z+skU9/IcAhwx4rgIVOyosavOHwbkSB7IkFJIkzI319L1xnN8ueoLxazsOkZ5aqEahJGimFhgX6uzpKovwFYpxod6YihjA550NlgEB3AdZ3ejwnl5TwS+LgIV258KlTe5p8McWg0QWL/COr5n2OG/GTP6apYo3IPlrYMAkl9yAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931353; c=relaxed/simple;
	bh=iporpxUYIrTyb06KpXIdN9VXXj9308EjfDIu8iUgwCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlecIk9CRqhysXDr9PND98wR8EU8tfyAqtispdxS3TniQPreXXkit+pqF32pyWgXsZjZwH4fHEyhy6ypXKRNPN2JXnRF98qzSV+5dMwc4XGnaGRkwjuoCfgnuUTdkDrdsG761ssNeuOEE1BV44M5retn4U0rrLJFYcZaGkyZ4dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqHXfsIX; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqHXfsIX"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9144e8021d3so49238926d6.3
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791931343; cv=none;
        d=google.com; s=arc-20260327;
        b=cvNggl1sS6QrseTHn3nbFJngTcJQXT6PlD9GiHydMXLY0AtH7DLqc6lDVk1LpN6qnI
         iuTftaEOAT9l/RrXQYaxzJUOHWhEIaWSiIzh8hQ56/WEW4xNdbJ23FqkRNyoChx55xZf
         zwnNYsZ6iUNj2JoNKrZtL7+bcm4S4rEdAf/5sbizEQAIHttwCQp25L0yGMOAe1lmgJA7
         hpLlQz37J1GrjBDzrdUv0sv0UdHTdZ29PQ9p7iM17rzlh6s8o6VYELLGRcmUQ60ld8s8
         +or9hPn9LzTWg8Ar2wmW4anwAOK31qnMiorsI3cnhKuPCm4YaY/JzT1FIqDLW8DCR9nG
         BBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jK/bI6saLZFEiOcf/Jln9CppeoI9MNJBzDtnRTioY90=;
        fh=/Fnmi/ChZ4PSCi6daDti7ivBtiCqCVrMSytCFiSl2/4=;
        b=QK7jnxzU/+QHi1gCxvDVuvJ8WaG6BvsA7g/UmOeKVfMV7cGxz+d3kh+7tbCEQVwbTK
         PtSA/mYWESQLa20roD7uf5ugXSBr03Kyxi5D9FQyS3fR+RBsBNx75q+U9RzFr6v1s21T
         MnAls/9J8wK6tj4iuYssqrsPxmx1Idh/Qh2PcMZnHXgbXHn/SqX/oS6O9KFLjNSPFZ+Q
         H7PA2OeORUWQSS+ywMdMCuu+/fSkydLdIhM3VDSlCbpxqHinm/6/SapmCcoH6Uvg3Saw
         wnGR90Wr1x+QO9vZtwRIdVCb6SaI+2G7fwcemJdj6/zmuzgzswd7ObjS/fKfVB57TeGh
         Fp6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791931343; x=1792536143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jK/bI6saLZFEiOcf/Jln9CppeoI9MNJBzDtnRTioY90=;
        b=kqHXfsIXk9f0YhZh/UhUBhmeCMXOvN6Si44i4T2KKGrG/MhpDzF3nz5q92VxcRtJ8k
         GUIz3YLxTsYzUtwxI8pjgJ6h9a2VStCPWYkDScFjOQskskhRSIE/qRSRZMF1Jsn6sbEp
         hyzukEspQfeO7re6A97sFtQvCLL+Ulmpn32yStkPEZUO8N8CH9tKs4UPVdXF9ZThHQ2A
         +XAflqcVenkMOBXsQ4cP2e1l2uCVOq1sBVRQTzr8zkRBVHFrf/d24O7Rh0dOzCerBJmP
         /d2KMlbNEq0UoyKMpAQTNOF9wrZCd+ZVEx3Wac8aJBGOI9o2OSXPQXyaQFUPxu6lAQx8
         mJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931343; x=1792536143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jK/bI6saLZFEiOcf/Jln9CppeoI9MNJBzDtnRTioY90=;
        b=jsa4cvvmmMZNy18inEqVu7USsl5a2o9IjolJTCRCdCEOV75IWrCHLei06uSI6OfIsT
         AUCq1CCrCfv1BsGGb5JICwhYeOvi1lbEoEle7FNp4uhPzcpUOrEz9urcYO0Cr00fB1cD
         kwFFiK4ljw9bjmDZkcQ1Seyq9LQK97hDkvBJ3GWw2QYzIeHgKSL41vvS5MYcwBQ7CsRj
         IUnmT/9KrV6nFAGQZcIQRZ5K7fZbB1oneJgWZQETFJy7xM/4A30s+jG0QVVMufbRiIu6
         WI0ko+oRZ4yniGSPIkgUxAzZoBpXgnl9YPWnjd2USUgwDGX8PFNOjMBkD1VJ6nXFlb/C
         Qdcw==
X-Gm-Message-State: AFq9FYIXoIqE8lJ93nvhRWbFY1pslF3L7oEA0N0cO9gsL/bqDe1LAkm5
	6/3PZfbNJ+6W1KbUEWrEb5Nd2hyxSeMZ+NIdHeY8Bq2qlED/ukEOZu5NdFs0YXbhbjePaiodPKA
	vaxu7I8jwhFTINjRsnytQwr/c1o+YeYY=
X-Gm-Gg: AYBFou2WFdSvq1HhnxMtKy/dUm7uFsiZFDIILXVzKqEftdJ7gczGvvoQcq8VEKtmSDB
	ppzVWYvRYOGTGxDX1cENsToYkBQolbHVvytRdAS2hOVNRjSoD5F13sIqTRO8wKANgZtlM/BePbQ
	u3GghZeLABSBOF2W5C9TRvTpL4SlrxNVLA+5VRU7ekt5Sfsl7DTg8aw6sl+7E0yJfkpPbERaDpR
	elHN5KRy0EWkeHeGVAsX7wQUsS/2Z96KY0dxnWqEzXU9JHtuv1GxGXu6gITImPvQjMM4TKTwCyV
	Ks1gtToNIdbMdgltMDnnusErvx3PCPXRa/seSuTz1tjR8Y9CnDhqSBG+
X-Received: by 2002:a05:620a:1720:b0:93e:c12c:9b69 with SMTP id
 af79cd13be357-93ec12c9eb7mr2204975585a.68.1791931342622; Tue, 13 Oct 2026
 15:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com> <20261009190746.803607-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20261009190746.803607-2-dmitry.torokhov@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 13 Oct 2026 15:42:10 -0700
X-Gm-Features: AclHuK-J5KWlF3YoPuNS4YkFHAwXoG9gERQNCULJ9cs1_40ZYCpV7_jhcmM4GQ4
Message-ID: <CANRwn3RUdGyEOJEdN1xUjEHwnBX5-UnpZZ+ZBBwY9RBB04FtUQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: wacom_w8001 - assign distinct phys paths to
 pen and touch devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 12:28=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Previously, both pen and touch input devices used the same phys path
> "%s/input0", which made it impossible for userspace or udev rules to
> distinguish the devices by physical topology.
>
> Assign distinct phys paths by introducing separate buffers pen_phys
> ("%s/input0") and touch_phys ("%s/input1") in struct w8001. Pass the
> corresponding phys path to w8001_allocate_device() during pen and touch
> setup, and drop the shared phys buffer from struct w8001.
>
> Fixes: e0361b70175f ("Input: wacom_w8001 - split the touch and pen device=
s into two devices")

Does this really deserve a "Fixes" tag? This does not seem to be as
much of a "bug" as it is a limitation. Userspace and udev rules are
(currently) able to reliably distinguish the devices by name.
Obviously that's not ideal, but I don't see much benefit to this patch
getting backported to the stable trees -- especially when /existing/
udev rules aren't necessarily going to know what to do with this new
"input1" phys.

> Assisted-by: LLM

Same Assisted-by comments from Patch 1/3 apply.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touc=
hscreen/wacom_w8001.c
> index 1c48e2775214..e967f2413706 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -91,7 +91,8 @@ struct w8001 {
>         unsigned char response_type;
>         unsigned char response[W8001_MAX_LENGTH];
>         unsigned char data[W8001_MAX_LENGTH];
> -       char phys[W8001_MAX_PHYS];
> +       char pen_phys[W8001_MAX_PHYS];
> +       char touch_phys[W8001_MAX_PHYS];
>         int type;
>         unsigned int pktlen;
>         u16 max_touch_x;
> @@ -495,7 +496,8 @@ static bool w8001_detect_touch(struct w8001 *w8001,
>  }
>
>  static struct input_dev *w8001_allocate_device(struct w8001 *w8001,
> -                                              const char *name)
> +                                              const char *name,
> +                                              const char *phys)
>  {
>         struct input_dev *dev;
>
> @@ -504,7 +506,7 @@ static struct input_dev *w8001_allocate_device(struct=
 w8001 *w8001,
>                 return NULL;
>
>         dev->name =3D name;
> -       dev->phys =3D w8001->phys;
> +       dev->phys =3D phys;
>         dev->id.bustype =3D BUS_RS232;
>         dev->id.product =3D w8001->id;
>         dev->id.vendor =3D 0x056a;
> @@ -529,8 +531,10 @@ static int w8001_setup_pen(struct w8001 *w8001, cons=
t char *basename,
>         int error;
>
>         snprintf(w8001->pen_name, sizeof(w8001->pen_name), "%s Pen", base=
name);
> +       snprintf(w8001->pen_phys, sizeof(w8001->pen_phys), "%s/input0",
> +                w8001->serio->phys);
>
> -       dev =3D w8001_allocate_device(w8001, w8001->pen_name);
> +       dev =3D w8001_allocate_device(w8001, w8001->pen_name, w8001->pen_=
phys);
>         if (!dev)
>                 return -ENOMEM;
>
> @@ -572,8 +576,10 @@ static int w8001_setup_touch(struct w8001 *w8001, co=
nst char *basename,
>         int error;
>
>         snprintf(w8001->touch_name, sizeof(w8001->touch_name), "%s Finger=
", basename);
> +       snprintf(w8001->touch_phys, sizeof(w8001->touch_phys), "%s/input1=
",
> +                w8001->serio->phys);
>
> -       dev =3D w8001_allocate_device(w8001, w8001->touch_name);
> +       dev =3D w8001_allocate_device(w8001, w8001->touch_name, w8001->to=
uch_phys);
>         if (!dev)
>                 return -ENOMEM;
>
> @@ -669,7 +675,6 @@ static int w8001_connect(struct serio *serio, struct =
serio_driver *drv)
>         w8001->serio =3D serio;
>         mutex_init(&w8001->mutex);
>         init_completion(&w8001->cmd_done);
> -       snprintf(w8001->phys, sizeof(w8001->phys), "%s/input0", serio->ph=
ys);
>
>         serio_set_drvdata(serio, w8001);
>         err =3D serio_open(serio, drv);
> --
> 2.56.0.385.gd3acb90ef8-goog
>
>
