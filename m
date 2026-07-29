Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B5304BB3
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296659; cv=pass; b=qQ3asFJhnNJJh+oCaPVWSBsSPGnr1vU3sEpHd3C0TXxpInlYcQtdm/NY7JZdr+D5+xpHCzdeHJLsipzKtdVvgt5IgohoNo1kEqofioVnTWEW/oufC+wN5Ux2UgYHdd2rT2Sy1eWp+sv80fLWZdL/SokPuyYLWDbBO2YWZCehNEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296659; c=relaxed/simple;
	bh=LduJKkx6Wsh6Sa8YwU4+S2sdhwTqlQXe2vhwP1UTAUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDZlBqjMowsjMdUR16raCsZeFKRmy01DwghM5ysotc3FIXra5o3WQcSdeJ2lQ+MLlr+h2Vfi45vU/7gXB+ZNHgq94i7vh4qMP+3f8LGuyc8wIweBPwXzPXqFgwsYW6O+U2uDaDfJvAOw1pAh3bWjr4NmfbvhJqspZjap9wiS2+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AUwsOgmJ; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUwsOgmJ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81eff3ddba4so8881107b3.3
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 20:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785296657; cv=none;
        d=google.com; s=arc-20260327;
        b=WAKQDEwRVJ5dgl0mMX+ooKeeOnC8XKKkKxHho1HkcssqToWgVba15aJ4EG2mygQA9P
         sX3HzMxBdgbQuKlIxPOItqWF379H9wZynGm006fI67FqlH4AUxBeDLlcsUNs+B8OikAu
         c4k9Q+UB0lMhd3GhUDSQTdnUGn5g/bVdO26lFifNBjBh+jYLwoQr7+kLPgwianPJt+R3
         oawGKFtNevoTe7RxykA3m2lblpxNxooTz91XvjlnqYJxaqpGStIh65tyKga5qMe9ukVZ
         h4yn7ryZYeRd14kT6N2UaLdZ8J5UmhSrtSefSZhEiYMSO+n4DOPPXlE5mdAb3eXzr9yx
         4iSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q5SQzLZmnmAyoTu35635s72269K1LO99EjP1yPHjEts=;
        fh=SHty455XBFCtKXNInY2pd9Dvku9jtqXro3abznpddEs=;
        b=OH0mlizcVDipWQLhGSTdd39hnFN8oA9MYMXtGkq8ukfzTLcDSXG+i36p2D902eZRvX
         zgwb+BO4W7QS1iJa88UMHpNEY9TimnbldX+PyeLH/vUOhWuDrQ12581p1Ae4KGrgnqcO
         YKG1qF/K9ckTFdVY1a20xFIEvsr305H5yoiBh1MMoNa6TMxDlaubJ0L17AB6dhY0sMKs
         3y2vvECWClFBR3WV4w+QzQiIJ5qOJyeeygR+X7aSTdI/oQMtm/wTojpW5kUoyKxLCNHu
         rXqymeheVjU87WTBUoMzuJelkNhlHGNp499uKHkhI2co1hlyqDGQmRcLWu7FHC04QJBk
         GtKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785296657; x=1785901457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q5SQzLZmnmAyoTu35635s72269K1LO99EjP1yPHjEts=;
        b=AUwsOgmJL8oLP53E6y0u6AmslRennZBtI2zHFXDAc+3SZK6keZHc+uwQcet+qGvyer
         jNd0s6IVEeOxsp67ThKfUxvL61BkeDJP4jh1Fmv0Vna+msm3YZT6VUtFMt9Qv5R3biRB
         Ogfb92SD7dX1/oaa+fx/2BDQf+9p0QGdNGHIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296657; x=1785901457;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5SQzLZmnmAyoTu35635s72269K1LO99EjP1yPHjEts=;
        b=kySYbnEx+mVj3I39f8KNr4KpsljkBY8Ej6c4g4PBm2TsXklvDYrxsavlbbZf18OZC7
         wZi96dnJ1qeOV02cQI7ogKQzrFYmqrwCFnydqK2QJnKBMiQFkN0+YmaKX4TThJLYgWUd
         UiFiqNuKLAUo8kVRMtqKjWsNwwYedKTUT0JYTRskD4B+pweVRM8emWP+lXFT9BoPrJmc
         9UEKjQqa7v59G2tSOA5RKf3o1FKi6v8rbMdLbp56bm4tmEAAHEjRvxZYMtTPU2P8pSpn
         O5cr83kWXoTanXC+IeW6WrWP5BU3r9eSXcgvK2sRRM2ntrUGN1gbz7znUC7j5O/kdGdG
         3vlw==
X-Gm-Message-State: AOJu0Yw0QINq62ZPCnAGBUL9JYumdwvGRrBuYqDxv2LoC0DbbZ0E2S8g
	sagTvaewZ4+8s9CC2yXyjt29AvW88VoHEw+GLjxx6YSAuo2NO6w/9rBGRKc9h8vGaRTlMCF8+FO
	5G/XWzYAJ36MgZ+tyjDeuirWSenQWHF5CzwSlu2Yr
X-Gm-Gg: AR+sD12NWC3qAXUaFZYACt8FkhMgSw4gwWjpkjbm1HFuQx3I9UfKuEFTdpn+7j+pr+e
	Et6lg3/2+zwf+Jsl+FGRr646IiKnH21mVsWhmU36H+blt3tyTV40uDpoE6mMuKvlZQCSE+nos3K
	m0V/e5cAs4KxLSfKM4Ja9HQYkrdAGm1oQaw66x/nWqeU1WkrosMsbBuetUrdLCfCGxBCyFrxlsG
	AaKHKLxAXsOfXiw4GVT6uXVRrcwa11trd9xjResOucWRtfyZpaIVPw3swnmBTyCjSQIE7AuKlbM
	8asO+vUt7jB/ksYXvGn3FNcYoGNYBbGll+SrqVr0vCV3NKE4PeTX22/P5Rp3bmSvZF9r54NhjGE
	=
X-Received: by 2002:a05:690c:3343:b0:808:f9bb:3832 with SMTP id
 00721157ae682-81f9912e26amr22006057b3.22.1785296656671; Tue, 28 Jul 2026
 20:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728212438.54078-1-rosenp@gmail.com> <20260728212438.54078-3-rosenp@gmail.com>
In-Reply-To: <20260728212438.54078-3-rosenp@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 29 Jul 2026 11:44:04 +0800
X-Gm-Features: AUfX_mySigGaf9N_bx5P2m2Z30yXuSp7TjHLme6C1EdwCx1nkTn3oRTu9esXu2Y
Message-ID: <CAGXv+5EVSc4=ug=GU6Gvdu0UatqM1DD48i-c3AEb4p0GwktRvg@mail.gmail.com>
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

On Wed, Jul 29, 2026 at 5:25=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Replace the separate of_get_available_child_count() pre-count and
> validation step with a single pass through
> for_each_child_of_node_scoped().  Skip unavailable child nodes and
> bail if more than MTK_PMIC_MAX_KEY_COUNT available keys are found.

This actually fixes a small bug. The pre-count only gets the number
of available keys, but the subsequent for_each_child block doesn't
skip over the unavailable ones, so if an unavailable node is in
the middle of the tree, there could end up being a mismatch.

> Set nkeys after the loop so suspend/resume iterate only over
> initialized entries.  Use a local key variable in the loop for
> clarity.
>
> Add an irq > 0 guard to the suspend/resume wakeup paths so that
> uninitialized key entries are safely skipped.

You are trying to do too much in one patch. These other fixes should be
in separate patches.

And why not just modify the driver to keep "nkeys", so that it knows
how many entries are valid? No use in iterating over empty entries.


> Assisted-by: OpenCode:BigPickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 71 ++++++++++++--------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index fd684ac16938..e2ced6e5165a 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -267,7 +267,7 @@ static int mtk_pmic_keys_suspend(struct device *dev)
>         int index;
>
>         for (index =3D 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> -               if (keys->keys[index].wakeup) {
> +               if (keys->keys[index].irq > 0 && keys->keys[index].wakeup=
) {
>                         enable_irq_wake(keys->keys[index].irq);
>                         if (keys->keys[index].irq_r > 0)
>                                 enable_irq_wake(keys->keys[index].irq_r);
> @@ -283,7 +283,7 @@ static int mtk_pmic_keys_resume(struct device *dev)
>         int index;
>
>         for (index =3D 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> -               if (keys->keys[index].wakeup) {
> +               if (keys->keys[index].irq > 0 && keys->keys[index].wakeup=
) {
>                         disable_irq_wake(keys->keys[index].irq);
>                         if (keys->keys[index].irq_r > 0)
>                                 disable_irq_wake(keys->keys[index].irq_r)=
;
> @@ -324,13 +324,13 @@ MODULE_DEVICE_TABLE(of, of_mtk_pmic_keys_match_tbl)=
;
>  static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  {
>         int error, index =3D 0;
> -       unsigned int keycount;
>         struct mt6397_chip *pmic_chip =3D dev_get_drvdata(pdev->dev.paren=
t);
>         struct device_node *node =3D pdev->dev.of_node;
>         static const char *const irqnames[] =3D { "powerkey", "homekey" }=
;
>         static const char *const irqnames_r[] =3D { "powerkey_r", "homeke=
y_r" };
>         struct mtk_pmic_keys *keys;
>         const struct mtk_pmic_regs *mtk_pmic_regs;
> +       struct mtk_pmic_keys_info *key;
>         struct input_dev *input_dev;
>
>         keys =3D devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> @@ -353,45 +353,42 @@ static int mtk_pmic_keys_probe(struct platform_devi=
ce *pdev)
>         input_dev->id.product =3D 0x0001;
>         input_dev->id.version =3D 0x0001;
>
> -       keycount =3D of_get_available_child_count(node);
> -       if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
> -           keycount > ARRAY_SIZE(irqnames)) {
> -               dev_err(keys->dev, "too many keys defined (%d)\n", keycou=
nt);
> -               return -EINVAL;
> -       }
> -
>         for_each_child_of_node_scoped(node, child) {
> -               keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[inde=
x];
> -
> -               keys->keys[index].irq =3D
> -                       platform_get_irq_byname(pdev, irqnames[index]);
> -               if (keys->keys[index].irq < 0)
> -                       return keys->keys[index].irq;
> -
> -               if (mtk_pmic_regs->key_release_irq) {
> -                       keys->keys[index].irq_r =3D platform_get_irq_byna=
me(pdev,
> -                                                                        =
 irqnames_r[index]);
> -
> -                       if (keys->keys[index].irq_r < 0)
> -                               return keys->keys[index].irq_r;
> +               if (index >=3D MTK_PMIC_MAX_KEY_COUNT) {
> +                       dev_err(&pdev->dev, "too many keys defined\n");
> +                       return -EINVAL;
>                 }
>
> -               error =3D of_property_read_u32(child,
> -                       "linux,keycodes", &keys->keys[index].keycode);
> -               if (error) {
> -                       dev_err(keys->dev,
> -                               "failed to read key:%d linux,keycode prop=
erty: %d\n",
> -                               index, error);
> -                       return error;
> +               if (of_device_is_available(child)) {

Instead of re-indenting the whole block and making the diff huge and
unreadable, please make this skip over the remaining code when the
condition fails, i.e.:

                  if (!of_device_is_available(child))
                          continue;

Or better yet, just use for_each_available_child_of_node_scoped() { ... }
instead.

I normally suggest people read the API docs (either on docs.kernel.org
or the kernel-doc sections in the code) to find better suited constructs
to use.


Thanks
ChenYu

> +                       key =3D &keys->keys[index];
> +                       key->regs =3D &mtk_pmic_regs->keys_regs[index];
> +
> +                       key->irq =3D platform_get_irq_byname(pdev, irqnam=
es[index]);
> +                       if (key->irq < 0)
> +                               return key->irq;
> +
> +                       if (mtk_pmic_regs->key_release_irq) {
> +                               key->irq_r =3D platform_get_irq_byname(pd=
ev, irqnames_r[index]);
> +                               if (key->irq_r < 0)
> +                                       return key->irq_r;
> +                       }
> +
> +                       error =3D of_property_read_u32(child, "linux,keyc=
odes", &key->keycode);
> +                       if (error) {
> +                               dev_err(keys->dev,
> +                                       "failed to read key:%d linux,keyc=
ode property: %d\n",
> +                                       index, error);
> +                               return error;
> +                       }
> +
> +                       if (of_property_present(child, "wakeup-source"))
> +                               key->wakeup =3D true;
> +
> +                       error =3D mtk_pmic_key_setup(keys, key);
> +                       if (error)
> +                               return error;
>                 }
>
> -               if (of_property_read_bool(child, "wakeup-source"))
> -                       keys->keys[index].wakeup =3D true;
> -
> -               error =3D mtk_pmic_key_setup(keys, &keys->keys[index]);
> -               if (error)
> -                       return error;
> -
>                 index++;
>         }
>
> --
> 2.55.0
>
>
