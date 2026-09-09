Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB6DF59
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989710; cv=none; b=cRZYU/U1GxBueA6psalpn/hLVh6cXy9VkAwEW9PM2FdfSCsomYbYMZ6mA6avh4lobZ8HV0d+3cRjfW4NrS/Im8nEUtzjy5ZevxhL3J0EZ76Dwa2oXWYW8nmZzLec6XoK894SyfngMG/QGDKD0iNsTmNAPg6MyG6Mx0OVBv/wgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989710; c=relaxed/simple;
	bh=JM0o61Y6ltMUDCEIGTB8aYG4/lxWHsy/P9VIG/tnMQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiuZC61Ro0bEkji44MiRZw520AWJLBA0TLL8eoX/WzFjK1IYt1YgrpNoC7w+rr7epURy00fkuu+LYxI2kK2HiLuCHDGJ3VkZb57sIXm9TwpU11ck4ra3dJ4JM4OIiwWfnFLg5/ig5Uk5mcbk+TN8sb+53MVNsf0e9XXUUSCCUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CyLfGmTf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CyLfGmTf"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2949ed8cc3so20538666b.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788989696; x=1789594496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sMS1hbLMg1gsIduehGePlq8QcJPEKyefk4+J94QrxTY=;
        b=CyLfGmTfY6NlaBxvKiuOvMJbdO/2j8jasUbtw+vR8AzBYZcX2IGHbndts0fVVYgIpt
         XpAsJtnWXSvpnJfBULJ5uVVR8foRT3J004Q8u/2zzJAk7wSKzVC3Ibe4XJH7sbtF75D8
         3SuZpuvdLMJ1moyfmHa1F5LTJ8XvFrdG7nGNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788989696; x=1789594496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMS1hbLMg1gsIduehGePlq8QcJPEKyefk4+J94QrxTY=;
        b=tQk1WCeIi00BCX4JQ4n8UyNboWzvrLfpxJcGRGwHDcKZSaEl5+tdqLqFbOihWGc/yL
         QAGdHkdI77y76WFMQqxGBhPeum75Cexov6bQ1KBycN1hh003XRvJGDcPaBXyom/6B43d
         PLdnv0E3aYU+KHWs4bZfOa1dlX/icMIlbfWquKXxib3coaAMrZRm13rshW+QMi/wsAmX
         1PtuVOq3TCL4pwNRx2JmKl5vWocq+eDi37q9qZSr3YuoYXrEpiXt09j4htS2cuavmjJV
         WKUnUD+VkFaaUvB2p9Pe/ryJKk0gEiIjyvSPJjjO2ACO3OkafmlyCssH9DpgCk9fVFN4
         1fzQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5z8WN9hvmUtMUnR1SZ+afZfeUIdKEDzZKFzpqfKzGTXu6OmyKbgVzVQq7guYx0h8dCmHkm4ayhkELdA==@vger.kernel.org
X-Gm-Message-State: AFuF++nVWUWcb9LkPVlvOLXsbBGpAqjVkJo6Ts4Ejgqv/Rvje7pR3Bom
	1dfSkq+chaZQgYmizPyR2CEI1Qo7JzGWN/rDiCd1kc7mRZAElWaW4JGLeN5HFTPGadWhGbbHFo0
	F4TAyGg==
X-Gm-Gg: AYBFou2MRsBNv1zNzeyU3sjwmyG1zKnXZztZ/rVEKw37mD4z2uVT8llFGLpIKZdM40V
	wA2wSPhhovdV77VoI9PDZGK5oWxRQX35nBWq7QLBOGH+jq4Z6r/OEP16xbYi/i+q5WrQDRYlCYu
	lk1hQiz5zhmn1RPXhQtV+te5u63ExWAKYWPx3ATUQtNxvOQ47fE8c6Rdp69qJM+BTRTHnQY8qQf
	1jA1LudPgviyeZMycPNcz/bUnq1sIvJRTvrt5eMU34PunIr2FPNRaWY7+j1MSMoZZIzAPyhVkJ/
	JPF6vaspAaZXddcBReJyxokqy6VJ7vbk3u99EPjv7NqLcvcxsIDbjf3poRw5UUKpIi+3y4j4Eco
	J2Tnuiy0PzxcAAfTiL9B2Hvcu+Q5XCs3tF4eKQm2rVDyTQXGwUQxzNCqI4rXDWJ8Q1m9VkOlEHW
	0UCQy98cGB+DrfxXb5l/hIgZfaggf2oXHHPj1i8W/bjMa5QOIRBj15mzAOVLBGYMiOtl/4KNCQR
	+mw4wjBGo+3Gf5w7kix4mf02waKvQCg27D9Ug==
X-Received: by 2002:a17:906:4fc7:b0:c25:8bf0:36ef with SMTP id a640c23a62f3a-c260c987f6bmr1508890266b.14.1788989696053;
        Wed, 09 Sep 2026 14:34:56 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c293ac38ddcsm116405766b.41.2026.09.09.14.34.54
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 14:34:54 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d05d51553so39678875e9.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 14:34:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzMYFCfWDwiNxdx0oYORWWzz0Vb/mv6aTBKoCn3AqQ5znVij8Eal2/hL/14MYibUqmel4hQfRwOA8M1Nw==@vger.kernel.org
X-Received: by 2002:a05:600d:640e:20b0:49c:fc6e:a3e1 with SMTP id
 5b1f17b1804b1-49cfc6ea77dmr253931435e9.32.1788989693915; Wed, 09 Sep 2026
 14:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908013843.368364-1-justin.yeh@mediatek.com>
In-Reply-To: <20260908013843.368364-1-justin.yeh@mediatek.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 9 Sep 2026 14:34:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ui1XYRXb6ZqmAgWqF3TZaAcGqfsV6KodqPbk-sGqHdaQ@mail.gmail.com>
X-Gm-Features: AcwNN1UfpgY7Rw4Gy4MtVJB0f5LgowF3gCGJtAAU-5vzKs2VDiX_yyNNYapd3c4
Message-ID: <CAD=FV=Ui1XYRXb6ZqmAgWqF3TZaAcGqfsV6KodqPbk-sGqHdaQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Unfollow the panel on shutdown
To: Justin Yeh <justin.yeh@mediatek.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Maxime Ripard <mripard@kernel.org>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 7, 2026 at 6:38=E2=80=AFPM Justin Yeh <justin.yeh@mediatek.com>=
 wrote:
>
> i2c_hid_core_shutdown() sends SET_POWER(SLEEP) even for panel followers,
> but nothing in device_shutdown() guarantees whether the panel, and hence
> our own power, is still on by the time we get there.
>
> Do what i2c_hid_core_remove() does and just unfollow the panel.
> drm_panel_remove_follower() calls panel_unpreparing() only while the
> panel is still prepared, which powers us down properly; if it is already
> unprepared no transfer is attempted at all. On MT8196 the panel is
> unprepared long before us, so this also drops the ~2s i2c bus timeout
> from every reboot.
>
> Fixes: 96a37bfd232a ("HID: i2c-hid: Support being a panel follower")
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Justin Yeh <justin.yeh@mediatek.com>
> ---
> Changes in v2:
> - Unfollow the panel instead of just skipping SET_POWER, so we no longer
>   depend on the panel having been unprepared before us (Doug).
> - Link to v1: https://lore.kernel.org/all/20260904035009.4114363-1-justin=
.yeh@mediatek.com/
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 0ff07fdab442..c7e46004f513 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -1355,7 +1355,16 @@ void i2c_hid_core_shutdown(struct i2c_client *clie=
nt)
>  {
>         struct i2c_hid *ihid =3D i2c_get_clientdata(client);
>
> -       i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
> +       /*
> +        * Like in i2c_hid_core_remove(): if we're a follower, the act of
> +        * unfollowing will cause us to be powered down. Otherwise we nee=
d to
> +        * manually do it.
> +        */
> +       if (ihid->is_panel_follower)
> +               drm_panel_remove_follower(&ihid->panel_follower);
> +       else
> +               i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);

This seems right to me. One note is for panel followers if the panel
_hasn't_ been powered off by now, the drm_panel_remove_follower() call
will cause "i2c_hid_core_suspend(ihid, true)" to be called. That does
quite a bit more than just "i2c_hid_set_power(ihid,
I2C_HID_PWR_SLEEP)". ...but I think that's fine. I would expect most
systems would be powering off the panel at shutdown time anyway.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
