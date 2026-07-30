Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329A38DC60
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387221; cv=pass; b=D7f0Zk5h9GVPl1AyIcCq64hQy3UBXS7rxvIkaZWUm6uzG2gyBeMLnPPecMFRgfq4o66WQQ54sfyvydDxXRq8AY1lh1o7XcPESfjidS6e5FB2eINn4Q1aO9Ryi9hs4uVcEEyhnncQS0Dgw1BeuyhOuwYtWl2kKRfZKm0RQMifEN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387221; c=relaxed/simple;
	bh=snSO3QYLbxc8p6gtZOKNrT1i2xcJZRZQFQ6sm/7W3EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvSfTM7VSAtpVVBlYyJ9ecN+/LYhoFpg+uNJjraWRHFoMZ7qS0nA2H62jxrjTvKKfOKcRCFEBUEc34kGXp+gLWa6Cl8rzBwi9mexJSi6tKsZXIOyQ7owtGeZB34WF4tqwPrLyXhS/DhfH8YiRdlrvietDBs1vV2zUk+0TKn9Xn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Se0Apxwo; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Se0Apxwo"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ed073fed0so25236847b3.0
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 21:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785387219; cv=none;
        d=google.com; s=arc-20260327;
        b=pOAuj3ecgxpOvJ6UI0HGyiz1M1DlS9SFRN3zvHO57fiMEUijPa31mYC/3DbBNkW/i8
         1jwmN/fmttiwvi5kHsOJykX4ToJGdVkXdaVmRBNeGM8BqJWvF0PZ2CbuAKb4bOmd4GCh
         oIMkfAuLJuqKHUKpucPmXZ+kzpiTza2Df+7B0+sRhVbDa4bHcxMNscQyrR2Y3KumyDv4
         U9QQpZkZr0rjgv3V59dptRhX4ApPUX8qxevyk2hU9R4LRPddZlNG+PwAzevL+9eYDfOl
         Ul8YaCMvmvE4DT9hX+dQ/uD1IZa5a/cb7/ZK39peu92uFAmjtE2DHefyC+qFw5FHmOsd
         SlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kNQXtzIynC28TDaE/Ql1n0+KoVl8k9chZuF6STvMMrI=;
        fh=SHty455XBFCtKXNInY2pd9Dvku9jtqXro3abznpddEs=;
        b=YudQNuyFhKSXpx1/b4AFP1zMfFortyPGn5cXOqizr/uhFunmaICv+XGLuI17CbB30h
         LGqqyOb6vKd+EN848oV2E7X6hVF+TlUR5QUWwH00XVnVCerEegMoGaXvSof2geSxi92X
         izmsfk2qLHAn0dgBLbrft1vLhevBWuH/Q+GSJ10NKhT6ioMsdpZbQyQp8vdiQReTC6wU
         JeojiYUND0MVLUa5SgFhQ+COpPhhlSXhGCeFbVOg4Jx07f5oGL2IJpPrbJIR1kNyFffS
         EckXnwUOPFHSNDqxG3XLLjx+MxK3l2V+JHOyEz3quI4KeIv8xIIdUHjvhnqDjz5XPeiF
         BL8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785387219; x=1785992019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kNQXtzIynC28TDaE/Ql1n0+KoVl8k9chZuF6STvMMrI=;
        b=Se0ApxwoGztE8GDD5uAYRK6mVOuTzUPBfp3Vjw+Z97c6XeTqVsZAYhXAnT0HRIX6oz
         3BwEnL1RNVzfrrTqgFd5sCiP4tY3E2zJffCl8yYtYZjKs+zi8sIjaWT06LGhpU+9KDtD
         glWJ9ZsbRAls0PeMAumfdtIJXViKedDq0VDJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785387219; x=1785992019;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kNQXtzIynC28TDaE/Ql1n0+KoVl8k9chZuF6STvMMrI=;
        b=O67U70WhqMwf+8WtCWjTblf/J4EkxVWprqGQaL7eshPrrjF4AhakLZl6yJc2Sfu0eQ
         tTqIQ20APG3E02x5gO4a36UyLoTKb4VxcB2sA7U6eQV6+D5+le3cF8zOBOwoLUopSsUM
         Ws/oVD9hDQviLNr08/6icpke88w2YjXDPmxOUBR+yhydEJOsVlkHefHxfDxeNIG5/QLs
         KIpSG5hZ+kIR91j+qxaW+50aFQbSvvmvO1Kp6Rfna5FTRRUYP2Mu9oNC624v5maEulUX
         TeWvpfwGzJPa87Ji/GFWwDKklZJ+m28RMreQaQMhIPnMNaSLgTIKbW4sA5tXAT/qMvsA
         44sA==
X-Gm-Message-State: AOJu0Yxmk789mJ2lSCjul0r5M7EzhbcvqgSJ1pYxXK96XnmmU6gB1Zm3
	uIDcudMNzlwve8uZPObj8TNjlCp/6ViR6ykNcQ118qr3DQOWKwxwC7wpH72CHpahucvUs5hiK4w
	6tnkLtktWilE/BhvmmdzBtALzBzqH5tflsEDCY+Fq
X-Gm-Gg: AR+sD13k2ZFS+8EbG2SDL4e6NGyTHG6FlT5Fpoc87m8q9dzzDI6RnPJzDjkq1C6l8YA
	fJD84iKrelNsJ9pTRlwdSMugCNG9vXpiPQUkQb2MBQzthYz2Qm26CvchYbNWJwG8ybBHdF791if
	TmggLeSYNpV3JdMior2W7sBUnCfjbv69lOzVj9OmQ9eP02CI3M1laJanQgE8TFylG6cwRhz5hgl
	1UvA7FK393t4dK7/qiL0cAzb8HE1e8mXfoFQ5IFr/R5JOz+VaWni+sQ6MVIzfd/uemOQd/CYFol
	yVDf/pFati1PzR81Yeb9kKRE6hLbAyHFBbzT8lvUU07B98c8Oan2SZyIJh+EjU4LyPsobVveuDI
	St2H6sZANS84=
X-Received: by 2002:a05:690c:c503:b0:81c:eca8:b31f with SMTP id
 00721157ae682-81fb8a840f3mr6908137b3.39.1785387218988; Wed, 29 Jul 2026
 21:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728212438.54078-1-rosenp@gmail.com> <20260728212438.54078-3-rosenp@gmail.com>
 <CAGXv+5EVSc4=ug=GU6Gvdu0UatqM1DD48i-c3AEb4p0GwktRvg@mail.gmail.com> <CAKxU2N8VeE+xPGZ-41nqDCtk_LA_PvgzjrUbnOZ-5JmEb-uKHg@mail.gmail.com>
In-Reply-To: <CAKxU2N8VeE+xPGZ-41nqDCtk_LA_PvgzjrUbnOZ-5JmEb-uKHg@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 30 Jul 2026 12:53:28 +0800
X-Gm-Features: AUfX_mw6g8L8q-LQMW-CQgvcfpzwOR1hh-FNl8gdfMDgDPM6vfWXNYP6-KfvIvo
Message-ID: <CAGXv+5F+a_ZdbtX+ApHdOC0884EfUdkULVkaY=nipFX0JgCZNw@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] Input: mtk-pmic-keys: Count available keys during
 probe instead of pre-counting
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 2:34=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Tue, Jul 28, 2026 at 8:44=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > On Wed, Jul 29, 2026 at 5:25=E2=80=AFAM Rosen Penev <rosenp@gmail.com> =
wrote:
> > >
> > > Replace the separate of_get_available_child_count() pre-count and
> > > validation step with a single pass through
> > > for_each_child_of_node_scoped().  Skip unavailable child nodes and
> > > bail if more than MTK_PMIC_MAX_KEY_COUNT available keys are found.
> >
> > This actually fixes a small bug. The pre-count only gets the number
> > of available keys, but the subsequent for_each_child block doesn't
> > skip over the unavailable ones, so if an unavailable node is in
> > the middle of the tree, there could end up being a mismatch.
> >
> > > Set nkeys after the loop so suspend/resume iterate only over
> > > initialized entries.  Use a local key variable in the loop for
> > > clarity.
> > >
> > > Add an irq > 0 guard to the suspend/resume wakeup paths so that
> > > uninitialized key entries are safely skipped.
> >
> > You are trying to do too much in one patch. These other fixes should be
> > in separate patches.
> >
> > And why not just modify the driver to keep "nkeys", so that it knows
> > how many entries are valid? No use in iterating over empty entries.
> >
> >
> > > Assisted-by: OpenCode:BigPickle
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/input/keyboard/mtk-pmic-keys.c | 71 ++++++++++++------------=
--
> > >  1 file changed, 34 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/k=
eyboard/mtk-pmic-keys.c
> > > index fd684ac16938..e2ced6e5165a 100644
> > > --- a/drivers/input/keyboard/mtk-pmic-keys.c
> > > +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> > > @@ -267,7 +267,7 @@ static int mtk_pmic_keys_suspend(struct device *d=
ev)
> > >         int index;
> > >
> > >         for (index =3D 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> > > -               if (keys->keys[index].wakeup) {
> > > +               if (keys->keys[index].irq > 0 && keys->keys[index].wa=
keup) {
> > >                         enable_irq_wake(keys->keys[index].irq);
> > >                         if (keys->keys[index].irq_r > 0)
> > >                                 enable_irq_wake(keys->keys[index].irq=
_r);
> > > @@ -283,7 +283,7 @@ static int mtk_pmic_keys_resume(struct device *de=
v)
> > >         int index;
> > >
> > >         for (index =3D 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> > > -               if (keys->keys[index].wakeup) {
> > > +               if (keys->keys[index].irq > 0 && keys->keys[index].wa=
keup) {
> > >                         disable_irq_wake(keys->keys[index].irq);
> > >                         if (keys->keys[index].irq_r > 0)
> > >                                 disable_irq_wake(keys->keys[index].ir=
q_r);
> > > @@ -324,13 +324,13 @@ MODULE_DEVICE_TABLE(of, of_mtk_pmic_keys_match_=
tbl);
> > >  static int mtk_pmic_keys_probe(struct platform_device *pdev)
> > >  {
> > >         int error, index =3D 0;
> > > -       unsigned int keycount;
> > >         struct mt6397_chip *pmic_chip =3D dev_get_drvdata(pdev->dev.p=
arent);
> > >         struct device_node *node =3D pdev->dev.of_node;
> > >         static const char *const irqnames[] =3D { "powerkey", "homeke=
y" };
> > >         static const char *const irqnames_r[] =3D { "powerkey_r", "ho=
mekey_r" };
> > >         struct mtk_pmic_keys *keys;
> > >         const struct mtk_pmic_regs *mtk_pmic_regs;
> > > +       struct mtk_pmic_keys_info *key;
> > >         struct input_dev *input_dev;
> > >
> > >         keys =3D devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> > > @@ -353,45 +353,42 @@ static int mtk_pmic_keys_probe(struct platform_=
device *pdev)
> > >         input_dev->id.product =3D 0x0001;
> > >         input_dev->id.version =3D 0x0001;
> > >
> > > -       keycount =3D of_get_available_child_count(node);
> > > -       if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
> > > -           keycount > ARRAY_SIZE(irqnames)) {
> > > -               dev_err(keys->dev, "too many keys defined (%d)\n", ke=
ycount);
> > > -               return -EINVAL;
> > > -       }
> > > -
> > >         for_each_child_of_node_scoped(node, child) {
> > > -               keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[=
index];
> > > -
> > > -               keys->keys[index].irq =3D
> > > -                       platform_get_irq_byname(pdev, irqnames[index]=
);
> > > -               if (keys->keys[index].irq < 0)
> > > -                       return keys->keys[index].irq;
> > > -
> > > -               if (mtk_pmic_regs->key_release_irq) {
> > > -                       keys->keys[index].irq_r =3D platform_get_irq_=
byname(pdev,
> > > -                                                                    =
     irqnames_r[index]);
> > > -
> > > -                       if (keys->keys[index].irq_r < 0)
> > > -                               return keys->keys[index].irq_r;
> > > +               if (index >=3D MTK_PMIC_MAX_KEY_COUNT) {
> > > +                       dev_err(&pdev->dev, "too many keys defined\n"=
);
> > > +                       return -EINVAL;
> > >                 }
> > >
> > > -               error =3D of_property_read_u32(child,
> > > -                       "linux,keycodes", &keys->keys[index].keycode)=
;
> > > -               if (error) {
> > > -                       dev_err(keys->dev,
> > > -                               "failed to read key:%d linux,keycode =
property: %d\n",
> > > -                               index, error);
> > > -                       return error;
> > > +               if (of_device_is_available(child)) {
> >
> > Instead of re-indenting the whole block and making the diff huge and
> > unreadable, please make this skip over the remaining code when the
> > condition fails, i.e.:
> >
> >                   if (!of_device_is_available(child))
> >                           continue;
> Yeah probably better.
> >
> > Or better yet, just use for_each_available_child_of_node_scoped() { ...=
 }
> > instead.
> In v1 this is exactly what I did and was told not to.

I see now that the interrupts are tied to each key in order, regardless
whether the key is enabled or not. for_each_available_child_of_node_scoped(=
)
is not the right thing to use indeed.

Could you add this bit of context to the commit message?


Thanks
ChenYu

> >
> > I normally suggest people read the API docs (either on docs.kernel.org
> > or the kernel-doc sections in the code) to find better suited construct=
s
> > to use.
> >
> >
> > Thanks
> > ChenYu
> >
> > > +                       key =3D &keys->keys[index];
> > > +                       key->regs =3D &mtk_pmic_regs->keys_regs[index=
];
> > > +
> > > +                       key->irq =3D platform_get_irq_byname(pdev, ir=
qnames[index]);
> > > +                       if (key->irq < 0)
> > > +                               return key->irq;
> > > +
> > > +                       if (mtk_pmic_regs->key_release_irq) {
> > > +                               key->irq_r =3D platform_get_irq_bynam=
e(pdev, irqnames_r[index]);
> > > +                               if (key->irq_r < 0)
> > > +                                       return key->irq_r;
> > > +                       }
> > > +
> > > +                       error =3D of_property_read_u32(child, "linux,=
keycodes", &key->keycode);
> > > +                       if (error) {
> > > +                               dev_err(keys->dev,
> > > +                                       "failed to read key:%d linux,=
keycode property: %d\n",
> > > +                                       index, error);
> > > +                               return error;
> > > +                       }
> > > +
> > > +                       if (of_property_present(child, "wakeup-source=
"))
> > > +                               key->wakeup =3D true;
> > > +
> > > +                       error =3D mtk_pmic_key_setup(keys, key);
> > > +                       if (error)
> > > +                               return error;
> > >                 }
> > >
> > > -               if (of_property_read_bool(child, "wakeup-source"))
> > > -                       keys->keys[index].wakeup =3D true;
> > > -
> > > -               error =3D mtk_pmic_key_setup(keys, &keys->keys[index]=
);
> > > -               if (error)
> > > -                       return error;
> > > -
> > >                 index++;
> > >         }
> > >
> > > --
> > > 2.55.0
> > >
> > >
