Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59611451982
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350076; cv=pass; b=g+U0+xKJgJ4s83RlaU2dgDoeteWQ+hy40MSIaTvuMkJR1Xfjii8Im7ZHNyj9B4uyehKe+FxOWfpZamLZ/znN+F8QF0nj9IH0agu59XzVoWx+2gF7vlGjncjgnf8HukzrUtpTR/8Ckbry/7MjF4RmFhV5QzgA7vzKGAyixkdvVaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350076; c=relaxed/simple;
	bh=Y52FFZxBnt3o24JNkj8qFemVWHPnxljAu+U1PxeXx8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKrOe7WXHhRaS2lLzfvYRz7nTEKWk3Hm4LA5ixKTmat0S+CWQeIJ9Ycx/5mBlF6/uoC/ffRlRFRIVehPiXFjM58XGyz2L/kH4rAYEhG4bXdepRdLjTCVf4emhhfoa0Wi9VdadhOuzm6v5BneM+4q8n1pOATqQua6BAxaBsh8qH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqSEYWDp; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqSEYWDp"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso1892920a12.0
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 11:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785350071; cv=none;
        d=google.com; s=arc-20260327;
        b=nDV+I+lUv4p1qBHX73QLkX1e25rkElvNN3+v+dcBZWl13reM0zMwxhUr5NMqV3egLF
         LM1Reydld/xfJ3E8S29q6LKlEUBZlr4PskNlzIqkOeqhMscwvCq6qeLyZL3GsxkU8dsW
         aki5limeD5M/0PFWBb853SbI+FYxVg3J35aMGvqMMSRaQFe6qJvLNGUOSjAtfYJSuRkO
         8TThIBRfLpD0imGoLeCPRhdDMMBaeOua+3XMNoZvkghi8/5ChTKzmY5M3tunPhxxQ4IB
         3T5/Gk3w1HInHCvnRkztRO46zq8FHYRXUSddDbeEbgF55CI3hl3YxDW963DJPXeXnypS
         i89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dEkdeq10zZmR1kctz1fIkkTbV43ha873suiUEwLT1nI=;
        fh=qc0x1N1fhCrGQOAcoOBu/lBgoGtVS1ZyjTtB0YTQV9Y=;
        b=IwcITcrRvmBtJ1teCt/+7iiRWvY5XBhbvvgKiNteoX6H9HUoRr9kdF3QXjYehcrZjP
         kh4zcemsxhvVfT8shRyGh1v0G+Q/nP9riy8vV1FNDSqW9sixieKtLql2XQbyPtd220vB
         dE1oQoGVNn3qpogMB0wSudnOMPzvj41ao1vw0Gguq8sqy+cjpztsMJJp7bl8hoSkBZJC
         vRA7BOZparj4KVkUENRW0Fr4woi1hB7IrJ628ZvB7+pXyWXvn5WHvU9Gd7Csg/reTAps
         RuoYyy26OSt0NAox0OvRi6ls05OtBSsaoHfwJ3cqTaFBo8dfNTeaFe5/fl/M1ewHFdKQ
         dHtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785350071; x=1785954871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dEkdeq10zZmR1kctz1fIkkTbV43ha873suiUEwLT1nI=;
        b=NqSEYWDpDowz4Xvy+u9/v5NG0ALpEqZvP3k2Gcrsu+2ZkLse6DR1ZlsDfKbxaiSZAv
         1wrb+GTVP6zCCvchl02ZJnQDHHIYPUCbHY97WZmTL+exGMjfOP4m3OqhxCIO1qhNYpr8
         N3FMfsIn7hrCVIjJ0XIGvaPp7Y75Efj0PcljZhr7url/+cY+vQCnkdBtzo8MZa0KWmH/
         ejxEWB3jXg8TCFpYDDH1RA/gdSbYX/gDPJJbexHbnxwXDEIWpaOz1ILJv+M8b0mx5KLa
         vfSXRJ9MpGfWsAL7X7Yj10fNdpHMeZ0odzTg5LNTgwcgMTO+m2B4S/1PIheoSeysLWyl
         O/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785350071; x=1785954871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEkdeq10zZmR1kctz1fIkkTbV43ha873suiUEwLT1nI=;
        b=Gge5VGKvy8c6aWwsoyTyqs+P2plU2u+tnXyaVFnGAvNw3pd0rFp4NcOGOL7u3HsI9M
         2WS07hbRBGFDP5407oxqjnGu/a8R5MXmqrccsKp/t6fFATt7ACeYBt3xJbayghM3Q1B9
         iZQlNz47BOQfL/EGFeXRONDMpQLW4P5Na6PwUluQlmxqfSnLoAXbnSTzA//z+iU//L5c
         PyIT8aVA5ndZQiVU9Kv2sbnEUbgnEg3VzwvrxO3pebGFmezTDDDT1U0I03Xm6dmZd4Vm
         aNQsLcbyJsIwX/QBxnaMNht5/x3QGtrfMqGHccld6plAr7LFHtFXdKP9wX0eYQZOOX60
         KomA==
X-Gm-Message-State: AOJu0YyQODKhltOvXsWEnXYdViJg85cUu7l2QxME3fY966AEm6Yf5Ho+
	z3ZOtL3ExPXPJXbufWxWHMc0mn3apIwkGSrDIX6dRrI6bJFYH7jL/MkJnTd2b/TN0jf6UXmLe6X
	+2JgTPsqGdKgJbyO8LE65CmmFVI9AEEMiBgit
X-Gm-Gg: AR+sD124I2GhZ+8C5DtTcbUuPgYR3t4iZIdtW9TRB3xaDA5EoKTGrrqPcMkCT4LPlfB
	qBRbrSaCkktLGr1g1NuMzXYeUpU8SUHw3776yL4OtgGYrysmSoPFZ0QgOPCo2hdQfPcNKd450SB
	SzYQcj7P29fZOHujlkW/fkCKPMQ81N8xaUIn5PFE7IIJNh/4/RKSNkVWg0yoLserldzpx69+pLL
	PtQ3+uAeF04S1O7V/BXQoFCWqOQLw7LUv+XnS9M9KcQYLGSGHgpgCSu7dub3X1xDzcstm1EJkcd
	q5aoDddEUi7lb4T7G1fpFaZwM9Mu+0kNnXjqvESUrTrrO4IJfN+4BpJY/OUJp7X9QW1JL24+h3x
	BWX5HpQom7UOcIHRjzGkM+Dn6i11qlwzfXcuaj++fUsa5HDIKpFwQf/7n5YbyaPPYmOfYWVGtUy
	YvxO8trOl4BkUUv2LxF8EHslP1V+ZILoZN7AWs+GPdiSTgiUOUT2bxiKw=
X-Received: by 2002:a05:6402:2345:b0:698:50ea:2d97 with SMTP id
 4fb4d7f45d1cf-6a034ab91cfmr4406703a12.20.1785350070955; Wed, 29 Jul 2026
 11:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728212438.54078-1-rosenp@gmail.com> <20260728212438.54078-3-rosenp@gmail.com>
 <CAGXv+5EVSc4=ug=GU6Gvdu0UatqM1DD48i-c3AEb4p0GwktRvg@mail.gmail.com>
In-Reply-To: <CAGXv+5EVSc4=ug=GU6Gvdu0UatqM1DD48i-c3AEb4p0GwktRvg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 29 Jul 2026 11:34:17 -0700
X-Gm-Features: AUfX_mxHHY_oKlFmxwUp_dDYkgE3HyOB09yEzi4_yjeUnpEenThghULANdcA5Us
Message-ID: <CAKxU2N8VeE+xPGZ-41nqDCtk_LA_PvgzjrUbnOZ-5JmEb-uKHg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] Input: mtk-pmic-keys: Count available keys during
 probe instead of pre-counting
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 8:44=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Wed, Jul 29, 2026 at 5:25=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > Replace the separate of_get_available_child_count() pre-count and
> > validation step with a single pass through
> > for_each_child_of_node_scoped().  Skip unavailable child nodes and
> > bail if more than MTK_PMIC_MAX_KEY_COUNT available keys are found.
>
> This actually fixes a small bug. The pre-count only gets the number
> of available keys, but the subsequent for_each_child block doesn't
> skip over the unavailable ones, so if an unavailable node is in
> the middle of the tree, there could end up being a mismatch.
>
> > Set nkeys after the loop so suspend/resume iterate only over
> > initialized entries.  Use a local key variable in the loop for
> > clarity.
> >
> > Add an irq > 0 guard to the suspend/resume wakeup paths so that
> > uninitialized key entries are safely skipped.
>
> You are trying to do too much in one patch. These other fixes should be
> in separate patches.
>
> And why not just modify the driver to keep "nkeys", so that it knows
> how many entries are valid? No use in iterating over empty entries.
>
>
> > Assisted-by: OpenCode:BigPickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/input/keyboard/mtk-pmic-keys.c | 71 ++++++++++++--------------
> >  1 file changed, 34 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/key=
board/mtk-pmic-keys.c
> > index fd684ac16938..e2ced6e5165a 100644
> > --- a/drivers/input/keyboard/mtk-pmic-keys.c
> > +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> > @@ -267,7 +267,7 @@ static int mtk_pmic_keys_suspend(struct device *dev=
)
> >         int index;
> >
> >         for (index =3D 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> > -               if (keys->keys[index].wakeup) {
> > +               if (keys->keys[index].irq > 0 && keys->keys[index].wake=
up) {
> >                         enable_irq_wake(keys->keys[index].irq);
> >                         if (keys->keys[index].irq_r > 0)
> >                                 enable_irq_wake(keys->keys[index].irq_r=
);
> > @@ -283,7 +283,7 @@ static int mtk_pmic_keys_resume(struct device *dev)
> >         int index;
> >
> >         for (index =3D 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> > -               if (keys->keys[index].wakeup) {
> > +               if (keys->keys[index].irq > 0 && keys->keys[index].wake=
up) {
> >                         disable_irq_wake(keys->keys[index].irq);
> >                         if (keys->keys[index].irq_r > 0)
> >                                 disable_irq_wake(keys->keys[index].irq_=
r);
> > @@ -324,13 +324,13 @@ MODULE_DEVICE_TABLE(of, of_mtk_pmic_keys_match_tb=
l);
> >  static int mtk_pmic_keys_probe(struct platform_device *pdev)
> >  {
> >         int error, index =3D 0;
> > -       unsigned int keycount;
> >         struct mt6397_chip *pmic_chip =3D dev_get_drvdata(pdev->dev.par=
ent);
> >         struct device_node *node =3D pdev->dev.of_node;
> >         static const char *const irqnames[] =3D { "powerkey", "homekey"=
 };
> >         static const char *const irqnames_r[] =3D { "powerkey_r", "home=
key_r" };
> >         struct mtk_pmic_keys *keys;
> >         const struct mtk_pmic_regs *mtk_pmic_regs;
> > +       struct mtk_pmic_keys_info *key;
> >         struct input_dev *input_dev;
> >
> >         keys =3D devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> > @@ -353,45 +353,42 @@ static int mtk_pmic_keys_probe(struct platform_de=
vice *pdev)
> >         input_dev->id.product =3D 0x0001;
> >         input_dev->id.version =3D 0x0001;
> >
> > -       keycount =3D of_get_available_child_count(node);
> > -       if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
> > -           keycount > ARRAY_SIZE(irqnames)) {
> > -               dev_err(keys->dev, "too many keys defined (%d)\n", keyc=
ount);
> > -               return -EINVAL;
> > -       }
> > -
> >         for_each_child_of_node_scoped(node, child) {
> > -               keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[in=
dex];
> > -
> > -               keys->keys[index].irq =3D
> > -                       platform_get_irq_byname(pdev, irqnames[index]);
> > -               if (keys->keys[index].irq < 0)
> > -                       return keys->keys[index].irq;
> > -
> > -               if (mtk_pmic_regs->key_release_irq) {
> > -                       keys->keys[index].irq_r =3D platform_get_irq_by=
name(pdev,
> > -                                                                      =
   irqnames_r[index]);
> > -
> > -                       if (keys->keys[index].irq_r < 0)
> > -                               return keys->keys[index].irq_r;
> > +               if (index >=3D MTK_PMIC_MAX_KEY_COUNT) {
> > +                       dev_err(&pdev->dev, "too many keys defined\n");
> > +                       return -EINVAL;
> >                 }
> >
> > -               error =3D of_property_read_u32(child,
> > -                       "linux,keycodes", &keys->keys[index].keycode);
> > -               if (error) {
> > -                       dev_err(keys->dev,
> > -                               "failed to read key:%d linux,keycode pr=
operty: %d\n",
> > -                               index, error);
> > -                       return error;
> > +               if (of_device_is_available(child)) {
>
> Instead of re-indenting the whole block and making the diff huge and
> unreadable, please make this skip over the remaining code when the
> condition fails, i.e.:
>
>                   if (!of_device_is_available(child))
>                           continue;
Yeah probably better.
>
> Or better yet, just use for_each_available_child_of_node_scoped() { ... }
> instead.
In v1 this is exactly what I did and was told not to.
>
> I normally suggest people read the API docs (either on docs.kernel.org
> or the kernel-doc sections in the code) to find better suited constructs
> to use.
>
>
> Thanks
> ChenYu
>
> > +                       key =3D &keys->keys[index];
> > +                       key->regs =3D &mtk_pmic_regs->keys_regs[index];
> > +
> > +                       key->irq =3D platform_get_irq_byname(pdev, irqn=
ames[index]);
> > +                       if (key->irq < 0)
> > +                               return key->irq;
> > +
> > +                       if (mtk_pmic_regs->key_release_irq) {
> > +                               key->irq_r =3D platform_get_irq_byname(=
pdev, irqnames_r[index]);
> > +                               if (key->irq_r < 0)
> > +                                       return key->irq_r;
> > +                       }
> > +
> > +                       error =3D of_property_read_u32(child, "linux,ke=
ycodes", &key->keycode);
> > +                       if (error) {
> > +                               dev_err(keys->dev,
> > +                                       "failed to read key:%d linux,ke=
ycode property: %d\n",
> > +                                       index, error);
> > +                               return error;
> > +                       }
> > +
> > +                       if (of_property_present(child, "wakeup-source")=
)
> > +                               key->wakeup =3D true;
> > +
> > +                       error =3D mtk_pmic_key_setup(keys, key);
> > +                       if (error)
> > +                               return error;
> >                 }
> >
> > -               if (of_property_read_bool(child, "wakeup-source"))
> > -                       keys->keys[index].wakeup =3D true;
> > -
> > -               error =3D mtk_pmic_key_setup(keys, &keys->keys[index]);
> > -               if (error)
> > -                       return error;
> > -
> >                 index++;
> >         }
> >
> > --
> > 2.55.0
> >
> >
