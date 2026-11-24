Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795550192;
	b=0KEkNK9OteQC6eI/y12QG0/7mnrVRzhsdHUiZRaNsHR7agZ9J4PcDxOZIfASuYIkR/g2
	 6yFvwgCx2yD06u/Z3h4PqtmD1N9NCNaXiFf/dsbbqmH7RUTJVi98nKorH5kfnJ/KogqX9
	 Gz4lOGmS18kIvC8U/ZVeDoWeIaOtfhBXT4vFIHZXVOf2xNXloChHVvbDyP6jB5um1xaIU
	 of+8ThWD5o8BI17M6q8mt3SgUDVxeJBtZQLbWuzk0IcPPZfqrl9Vx454ivtNwUnAxWtgO
	 hwx/lePIxlqX8ScbwqS/JqV+xmr/10sl4k/xZsmBZB6ecof/vabUJxGomhl82XNCSoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eWg/QQCM+YqF7QYGmdPOWu5E8xxBIsWNt7MbD4EknIg=;
	b=QvJW5lCCujJENRHL41mOI516SM9G63G4J8VAzLxgcVa/lWWxPbBlOAvvjgyS9dD+kkPg
	 ZFtEmUTTeemUepyIZ0fBfQ1OJPqrldOsW0RIhEZ7pnGwq73ICNkaKRSC8Ldvzqwl3uC0q
	 j+u6bt06maEa0q07D0b3XhoV+uJRZZilQCnNSjjV07twkQ1VX3rwYPXjGdwOuBhofmx7r
	 etcmz/JT7Wv9NzOk9N0OFn8Crhau6V7+UGX0O+bzH9p1oTBFOohhoH2wIZAK7FBkxKcpd
	 AOiADpU7IQ2WJpLUXstjYWEoD8a+AaaK/YgN0MI8p0OtrAn0OL4y23IcgI9j+/ZRR6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iV8fP/V/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97451606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97451606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iV8fP/V/
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-492f0a1b685so3411677f8f.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 11:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795550190; cv=none;
        d=google.com; s=arc-20260327;
        b=aGf/sngTf38sWq+wfKMP57XhzY7olRdggZaVcyh367/DJSgGWWwLwDt6vbXKvmOhGR
         vE24m7bQT3cYERGy16Kkcl4qwJIlp/TA1abv/jIRJbNOQsuzewU79K9aA7oMuRNVbvo8
         ufDd3oM15ADN/kkR4GKlAwrXwOqHZglNoKn9M76hlNk/nELJHQwmVi7HYzJvuS5stgbR
         7HAxOTAtsWhn5uhl9QXJmU46PokmXsm4hBIIq/ITuga/ELJisOoB7xPyQAtFrtJIbGoC
         SHRl2aByTXLuoVElkqg+JuMnbJwRIQKo3qpBd0D8G2PFYeQW8IyEoeKE0hB81tw75w2z
         Ic/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eWg/QQCM+YqF7QYGmdPOWu5E8xxBIsWNt7MbD4EknIg=;
        fh=Pa1axfg1iOXgh4hzbsfNYpYg1UZCNUwMC6kwFSTcqZk=;
        b=BK68O+AKL69SekWSvKjxYVKpWE3JOG10sl8WG/+Rkd07VSiCEaEkZKznYapKymXF81
         nFldd89KjbApncB0dPwVfcVFcGLY3iJ50/EEjUSoIkUc4X2kYBe2TnoHPjqHrviK9aKL
         +Wv3MWOoHbZYU76icLIAgmF0z2S959HYPV71fVdC+Kz7+3AjetPZnJ8w4ZhHyNMFFaqe
         LP1yUqZOAstES0HFMMdYlB0xAfcykxE3dfiJKZZyFEm1sC3x9alAGmElWGdTVmQ9eIiy
         PYc/Dv+kcSHSXxQ4F/pLRELehwQ36mWYLOAZCM/58H2UxriVC0m9rQNRBFFAApMQ98Fm
         +KRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795550190; x=1796154990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eWg/QQCM+YqF7QYGmdPOWu5E8xxBIsWNt7MbD4EknIg=;
        b=iV8fP/V/WNg2cXagsVyG8Wgu9H9hzAbYK6z8yhqr5jf5v7ZByN+0LEAHql9yJn9y/a
         WfAhiIzi3n6E5ID8qmSrcbcQVQSSsjGR6oIm8vaVKb9KFhzPhn/e7xowvlecaLoj7Zqk
         7HoSE+DS+hvMVhUzGjDXMP8GCqtS8xmpHQIBUYE9LbMnftUvcSeaCXZ0z1nUZBOk7PmF
         vumzEgPr0E+qjA5c/X1XxOXMeulSeMRwcY50mXWBACm5aXEjsMg+6iQlSm7qF00Y8cl5
         WqSpKD482CMJ8XNhXnYoD4Eb/+DgyeVDtu2mZbymFVdk4AQOetO+ld6Pr00bt0G3ndje
         D67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550190; x=1796154990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWg/QQCM+YqF7QYGmdPOWu5E8xxBIsWNt7MbD4EknIg=;
        b=c5Rk4u3UzQ4P1N0ytHm69AOa/xRogf3USJ+ctAjG+K4U6RRatgpIi0eYwa0xPFxQrj
         Z6HRyMUS+RRAiWiJNjgDrJUiaIoPGhSX1ilymwDdT3IBId5S6vuFhX8wmdFjOfW0isi3
         s22V2Hq8y0RXtVPhFaPFr+wYBP9XZ9pgabNu06ZKB9G6MLecfWYxzEwQufF2UvUW5ZHj
         hWnO+LrW6l9iQe7rs3QlYI/33w/OxPK7hjaDKdWlnlpQipFq0ugvIajhYfNfxV/XANA2
         Zcv8nfN/wD2m6ThWaS4KUdmWzQQ7sugXTSq7BF19VlGHVpRqYSbWhizEh/9puSTwdbl0
         W7gg==
X-Gm-Message-State: APuU4Z8NePtNkQEC4TciqoFsPefrZ8fLnpbHT+4BuQQniHzeZUHbK8Sx
	7z9kClC3TXIr9INm3L6oRG7vjOrcMobOxqebXfylP7ikv5YMhNFYUyecjD3/GJ/C9inzuxDyP9Y
	yP5YjOgiPT2oyAei6PSuS7R+UEMo44DjH2Jh60iw=
X-Gm-Gg: AZFdTZfX3Ld+v1+uX1U4c7+gEXKbAO9iltmUW99QhXXK6QanegK1Rvgn7aMFwRE/ViM
	1oO4dI/yOIWXRhXgfFVxsS2Lg8n8pQc4H+XWCaFxD6SB49T0rzc848hcKZ9ylN6Udh5AMYbFnsu
	Bmvq3s0SKzd66nLfX5Zl+yOZ8IkPwds2Y7tHCjo0jMWErwJqSXUgBNqQL/IUsBTbdeyj1sI3Pm3
	hF1LjEvN7qJbI1OjIGCWEPqB5fiJG8KHnBO4Cg76xlLB3MY1LsrzjWxQH2K6UJ0AMt15C2eyFrU
	f7OwNlVLk759E4LstA9Po3Rsa+DW6rUjOPhArCoEk2SA12fSC4P4/ZaN1QASAwemeHdB+w5kbWj
	nEcfCMq+Gj+Kj5oDWqDbM0nRL4tCJTMUR7IzbjZlb3IVL6rtj/psi1o2NbCmee8X32V/A
X-Received: by 2002:a05:6000:290b:b0:4b7:8363:682 with SMTP id
 ffacd0b85a97d-4b7836306d3mr5700739f8f.16.1795550189704; Tue, 24 Nov 2026
 11:56:29 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124184158.50142-1-pooyan.azadparvar@gmail.com>
In-Reply-To: <20261124184158.50142-1-pooyan.azadparvar@gmail.com>
From: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Date: Tue, 24 Nov 2026 20:56:17 +0100
X-Gm-Features: Aa3M54odh9Ew0uo2ToBLG3q5QcXmtIHm3OUImpk8w5E2C9SkHnEo0-J41LwTzJU
Message-ID: <CANC3H++ZyY4dnTJ+-i72C2CM7dUuOzftMnv3Dra3GcF2gUFw8A@mail.gmail.com>
Subject: Re: [PATCH] Input: raydium_i2c_ts - preserve bootloader mode after
 firmware update
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, robh@kernel.org, jeffrey.lin@rad-ic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,
This patch was sent by mistake. Please disregard it.
Sorry for the noise, and thanks!
Pooyan


On Tue, Nov 24, 2026 at 7:45=E2=80=AFPM Pooyan Azad <pooyan.azadparvar@gmai=
l.com> wrote:
>
> Initialization can succeed in bootloader mode. The firmware update
> path then forces main mode and reports success, so the IRQ handler
> can try to process touch reports without valid report parameters.
> Devices that first probed in bootloader mode still have a zero contact
> size in this case.
>
> Keep the mode detected during initialization. If the controller is
> still in bootloader mode, return -EIO so userspace sees the update
> failure and the device remains available for recovery.
>
> Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
> Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Link: https://lore.kernel.org/linux-input/3e575d6e2eb90d4a3707319d37134c1=
a@gmail.com/
> Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>
> ---
> Codex helped implement the post-update mode check and draft the
> changelog. The driver object built with W=3D1 on x86-64 with this patch
> applied on its own. A userspace test with mocked I2C and the buffer
> patch also applied verified that a controller remaining in bootloader
> mode causes the update to return -EIO and skips touch report reads.
> Hardware testing is pending.
>
>  drivers/input/touchscreen/raydium_i2c_ts.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/t=
ouchscreen/raydium_i2c_ts.c
> index 6d6db1395bad..c50fe4aa058f 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -844,11 +844,12 @@ static int raydium_i2c_fw_update(struct raydium_dat=
a *ts)
>                         "failed to initialize device after firmware updat=
e: %d\n",
>                         error);
>                 ts->boot_mode =3D RAYDIUM_TS_BLDR;
> -               goto out_enable_irq;
> +       } else if (ts->boot_mode !=3D RAYDIUM_TS_MAIN) {
> +               dev_err(&client->dev,
> +                       "device is still in bootloader mode after firmwar=
e update\n");
> +               error =3D -EIO;
>         }
>
> -       ts->boot_mode =3D RAYDIUM_TS_MAIN;
> -
>  out_enable_irq:
>         enable_irq(client->irq);
>         msleep(100);
>
> base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
> --
> 2.34.1
>
