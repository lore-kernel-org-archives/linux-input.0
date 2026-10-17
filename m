Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7C54779
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195563; cv=pass; b=KGywjzysWUKO16uawTkqTsas1pKrBInxEaCmaDhXcGg1eBa8mt6Re4CvS1SP0XvG0NsO538vNZvTIKrMbRKC5leyHGkLDIc+/duVtbhY7bND6nfv44f/++aEessRWf8FrkQrW6gyIitNxdajN99j0bARv1pFf2/eqMv2UaZ35po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195563; c=relaxed/simple;
	bh=KRMeiaO7g4MIYoIzR4Cxz049s83kjITN4ycU55yobl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB5NVccvtyGdodyux6yZGDM6lRZrCCnC887CcBgqtnqvJ+5atWoC2w8SO6FI/Ua6ZRPCsRulS8Odi+4UtLgocFOT1DHmJldHMoRX+hp7jk0nAyRK0BG+OR9kQmFohjv2qXaq5Rp1uglG7KRBGqLNHGm68I2XVC89vxE5/87l5h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDw+iI/M; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDw+iI/M"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-918f75a68f0so6561446d6.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792195561; cv=none;
        d=google.com; s=arc-20260327;
        b=DJZ0MdBDD1bnogcAFWHk4J6NvII58B44C02+FPFkCg/T9cOCky6/XyLSlxXts9CUQ0
         LuTWI4rhgBP3SDaomMIn9ZmI8YfKBcCsyNx4MkpRj6BZQN4GpY+2k5h4BRu5JDRXWsch
         m6qFIz5HgpHU3qfoT6tzkjwb4qcWmTQ9foq8awA2hXMkM0VrpgfbY9zAHQ0gG32pgSwF
         xzG1FI70U5Q6A7O1uyLsBXJB6GIYePXTn06SfJg5sUMXEezeXTw8jj+k3c30EfyjJdVY
         /1+tlJHNa0BPIwtj6M+tuHRvo7rj5VwF9X9t0KPNmzvDISxhhC6t50qbGytOChEATty4
         ezcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0k4EFzIGMXGES/e/BiJGOgHaWgHC/OgyrD9eOVWF0X8=;
        fh=1O/TbVssGHGEWC910eHapX6OjqGvrE0mB6pxbmIS1aM=;
        b=rReLfNiYVKNQwK5bD0YZScSGpV+4VK0da2c8/hrzzFLeEmz5voWWhjBRXdaKryOnO7
         Eq/Mm2UAgNjJSqEbRqib4jRdAI1CBdZZecIamCWR1RbKUkO1xrOfzIFbXlDLWXmfXWZs
         WhLlAU0TKUHQlnRY8LxMAQ8Gn03DwZRq/nJ1c4SYlUITHTnvk20Qk45TkbLie6NVoiUo
         fWEYMObK0GBe8zXyW4mBpR/21QgU4P4tJjM30DnYl1luMWCBOqh5WVMaRlypvAZbSsSG
         3rvlbIMhwtMyFDRNpi7oYPldNQzLXXhzTV5A27dCAuhPfvq2G2wj5Yj9q0mc3WrHeEl8
         24nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195561; x=1792800361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0k4EFzIGMXGES/e/BiJGOgHaWgHC/OgyrD9eOVWF0X8=;
        b=nDw+iI/MDDdcmGKqVh12XUT7W5Y3pt2IpNmDGSB8J/PSR62edOO6oOWwHHLfQ05fH+
         0qZ74n1hk4EiRYNYtjqyF9SHiAcdnINOwG0LvZ9qWSWJXiKSIUKmUwet/ZT4y3KZSVsZ
         sGrcWOcPSogSLeT3ngWPllEHAzaFA9ids9ixzF+E3d94du+aKA8hQR+y67TFzbXlrQtK
         GhJvqigOoV/dZWGC3prcCLfouNqMMkk9XTUQCmlggcv/EsKYrqZwpJqzBjssWLqCCjRa
         34B1xdwMKDUBQSdrZOc4dNVL0Rjd1VrPhWZioYaL2QT/KAyDj4lItqXf1yucVLvEbjtz
         T/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195561; x=1792800361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0k4EFzIGMXGES/e/BiJGOgHaWgHC/OgyrD9eOVWF0X8=;
        b=iVkR/qDqv8pwMtw9whHKsapPHvb8C0t8ouMjSYKHn/QWBU/JGqP7OE8y28bZwlV1Vg
         jnYA9+O6jXhOBhLGUBNf6L08xNbeHHsYUs0t9225Ng4F//5mrEpXbtw96uWiFam6sxaN
         0HN4MeSgurt8sITQ/dCbuGh4aCN6jGMlc7MXR+CsIgWtVo+Ypcx91hEUN/RwBQ53Jpck
         qr3daVStS7XW7G1Us6YbD8NXAmlnZgKUftEh2actuufO6TxGKcoDOLJ6cSR9qsZhq0N1
         LweRxwwj/PtEWjcFmiEb7oWdO0qaA1HXonfvQZw2Rp1fESES5J4YsQUAm8MM9jDg7GqJ
         dKxQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3gl+RIDsnt1vv64PseMIZhWlDUiYix49r6hxtdYWwumXtbVuXDCSmjsjVrBdaCzNgZaNWvdRZ6WE/zQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYInDlsIaPxXjiwc8eeAy500BY2Ueq3ZhAGGpdvzurXJFn4EGXLB
	5dooy6+XTmCVWA92BtdsI+/h0KU/Nawf0V5S5+X6FKAJzEWuVR7wPAdUWHCh6O+2iUSQqO/jWf1
	mSXUmX4+Lj1aD4RuX9g8C3Ii3fIJ1nFuKGQ==
X-Gm-Gg: AYBFou3XyjhCEalrZhg/hb+bGqymTTEO9cDEHQ47+TwVvoVrRAY0puD8XKvK5NXKYzt
	HG+dBtJvNbS+zp72xtcggFxyC/tvtYCQXtkROjnzVgQ91Jmr9lcakRckz1ndMbhUDw9YOdqEO3I
	Gt896J546jl8qO+RE/EoOcPAwttSugFBwjzfB+ggyk7WMal8lv3JEdLx1oBKoTQdM2Pk1wBJKx3
	+jWKyHtbhgmydi0P6QDYhJCiV5mIA8QJaJGfp9NG53v2ai+tBsbNe8n+wsVNV97EjyU0A4k3goB
	N9Sj1PSOX8RFOWIyaQP1eILrf63y+tEToHdVYU9EegPhxAUgjZlVX7c=
X-Received: by 2002:a05:6214:5b12:b0:91b:e365:c58 with SMTP id
 6a1803df08f44-91be3650df1mr7456876d6.14.1792195560613; Fri, 16 Oct 2026
 17:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20260927041138.4112920-5-jinmo44.yang@gmail.com>
In-Reply-To: <20260927041138.4112920-5-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 16 Oct 2026 17:05:49 -0700
X-Gm-Features: AclHuK-TEkpQBeznYhwXdapt_vO6OzSWfXEe7sWyUPaThbNHU8gfKOaANp7FPVU
Message-ID: <CANRwn3SFftn8Yd0v3fJcpA-yxAGtMiRh+Jkhc-Pt5VDuLs-Ujw@mail.gmail.com>
Subject: Re: [PATCH 4/5] HID: wacom: check the input device in wacom_intuos_bt_irq()
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 9:12=E2=80=AFPM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_intuos_bt_irq() reaches for wacom->pen_input three ways without
> checking it: two dev_warn() calls on the short-report paths, a dev_dbg()
> on the unknown-report path, and input_sync(wacom->pen_input) inside
> wacom_intuos_bt_process_data(), which is called only from here. That last
> one is the odd one out, because the pad_input sync two lines below it is
> guarded:
>
>         input_sync(wacom->pen_input);
>         if (wacom->pad_input)
>                 input_sync(wacom->pad_input);
>
> An interface that declares no pen leaves the pointer NULL on a fully
> successful probe, as described in "HID: wacom: check the input device in
> the shared report helpers".
>
> Reproduced on linux-next 20260925 (x86_64, KASAN) with bus BUS_BLUETOOTH,
> vendor 0x056a product 0x00BD (INTUOS4WL):
>
>   BUG: KASAN: null-ptr-deref in range [0x258-0x25f]
>   RIP: 0010:wacom_wac_irq.cold+0x8f/0x16a
>    wacom_raw_event+0x68f/0xb60
>    __hid_input_report+0x398/0x4d0
>    uhid_char_write+0xa99/0xfc0
>
> One check at function entry covers all of them. It is safe to bail out
> there: this handler only runs for INTUOS4WL, and
> wacom_setup_device_quirks() only adds WACOM_DEVICETYPE_PAD for that
> range of types when WACOM_DEVICETYPE_PEN is already set, so a NULL
> pen_input implies a NULL pad_input and there is nothing the function can
> report. Every path that reaches the battery notification passes through
> wacom_intuos_bt_process_data() first, so no reachable work is lost.
>

Similar to patch 2/5, INTUOS4WL is a case where all hardware of this
type should have both pen and pad on a single interface. The existing
explicit check for a non-NULL pad does not imply that pen-only devices
of this type exist. As you describe here, there are no situations
where only the pad would exist, and there is also no situation in
which only the pen would exist (the WACOM_DEVICETYPE_PEN will already
be set, as described). A check for both pen and touch pointer validity
can be performed at the beginning of both wacom_setup_device_quirks
and wacom_intuos_bt_process_data.

> Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 48a58a6672c2..11544adb74f5 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1237,6 +1237,9 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wa=
com, size_t len)
>         int i =3D 1;
>         unsigned power_raw, battery_capacity, bat_charging, ps_connected;
>
> +       if (!wacom->pen_input)
> +               return 0;
> +

As with patch 1, each of these checks is for an unusual error
condition so a dev_warn_once or hid_warn_once before returning is
suggested.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


>         switch (data[0]) {
>         case 0x04:
>                 if (len < 32) {
> --
> 2.53.0
>
>
