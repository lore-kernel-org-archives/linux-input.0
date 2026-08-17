Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D23B71B1
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954539; cv=pass; b=Xgq+zri+zTC+mILL+sWiH9Xtk0wP7pWDqroAGIwJeWRnTGn/KBl5KCltPjgvTv6jgNZ93+Yjye3BrwXWiu/hmx4R/QNYuknU5w09Ir7KoepXFr8Zs5pMBt9Jx2bwE/7t1/tRtARs+lX9/KfSJXcapMgvuevNFHk1Mq3LhnCZ6L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954539; c=relaxed/simple;
	bh=ZZh7jM0O1yH5uRME7FtyFk3wmqBtWGo4//0SVBqpovc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3CK5ewxuAANrXX2OAfdY7/Aie7CQYTtki8qH2dtUhsh0mtcmWGC413H3LzZ2Orq46hGWc3JXzLnGdzm6eDCUswvb1YXKoks1ukTFz7qmlfzBgyZYNHSRUjEGfLsR4Mu/2N39OLs4mS079ghxv5wUdNpkimEicdK3Toe5RZrAL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPBYNGua; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPBYNGua"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so562714666b.0
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 01:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786954536; cv=none;
        d=google.com; s=arc-20260327;
        b=jMUtfwu8FR58yemf+Fc0mdTDMXF+ut2LyP08eHNN81EumsUtblPGqd2MRbAFJkZmbE
         NZy/XFOiWcWRhq7ljTtH9WhQqYxPTEtpYty6MWcAqqBsQ/B7D0eAKApMVRwbQaYs1V/N
         lUwrVndlrEuMm2u2C4cmxS4ORdZ5oZrJFhlWT2xba6+TWq2J1Ubx02A9YXGpqPMFQnA8
         lKxlX/zMMZtodVplwJvIYX3vp0S4PTqzWoRFhKsLtfbVOzZhoQjP8U31CSqcp7DEZrzJ
         ZYv/qKebYv7f9HbUgVCkDXuFpIlbrykUFPq8ATogrGJS7u6wzQ7i2qceu5f7i5Tlon8K
         yj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wVfP4yvTXK2XEfxigLgUWNpzoCb0TARiSJCqOSPnETo=;
        fh=RlhTxD77Ow880eqrTAlehrA5R92+cuE9nzPgBgkt7xg=;
        b=kp5fM9QcecfPhHVHs6GJvI6ief3exKDj03DD3VDGxDWzSN2UftZ7/95iHv4YshSlzJ
         bI3Lrh6pGqyHpdQzI5RyEr5+ed07Js8HEel/G3oZ+ax0BUZNYOd4ctm/rml84GLJ/ZE0
         FB2LAS83HhA79sFvHA8Lim+WRWet5liHT/4Lt2PO7lDDPCyaCDQUZ1zVKeghop35rOf6
         OXYYE3JoFinkzuuMcd5ACwFUqBDEnZno/7FUypeMskGOJHqRfy2GZGeuKYuWTVJV2pSn
         KPsmciZNe/DKxYGD3Yi6WsGGKBcy2UHbFelJYfkf2N4CbNjIcJJcljCVSCyiUHcnXZja
         40hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954536; x=1787559336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wVfP4yvTXK2XEfxigLgUWNpzoCb0TARiSJCqOSPnETo=;
        b=CPBYNGua9AMzZ2jZG3rh4I+i9oEkDTBcJJevAEP92hzAHrUiwIf8VMkaVbmEShECKA
         xJ9BIR7WtouK+EHjLEKH8ll5XlaS2rWDDydasyj6lOcOaz5LPTJjeVrAQWNL8+Qmv7Ry
         dVfKsBZ9TYMtjL3CjN2s3cZnkgxFpIuSLTpiITAD2Acm0y7I1v+YVrxi2sS3oVQuIcdA
         OGz+1E0qL+iKZXiZY8EsYqNQk37fDdEaeGXCF5j0p1UPpkvE2VNhzqyFUzaH4Wr3aPRq
         xlcXbmRK0Ln7n8f+x/sU4zd0/JGQEYqD7op8lnX9Q4nphxBOcUcs3b2MavASttbdlDUQ
         xvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954536; x=1787559336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVfP4yvTXK2XEfxigLgUWNpzoCb0TARiSJCqOSPnETo=;
        b=fnvhFzy8dhMRtHefAp0Km9EOzQg1NhZhzWU85/Uqzft05DENtadIwSKRON6epoXGlQ
         IlJLpHOsuol2lF8CM5+2gx0Jo8x1RlHYf0GZHVrgDW2QKY7kzWPHDr7QKgR76KX0VQNH
         VqDxo+20lnjrUyxjJ4OTm3rYOs4O5ZnahuAkgEGB4lqYcOhyYWNCNRPtUw079U/C6LKg
         O3y3mm1zfR4NL1vBVlpzfFG/mqR/2vZKoSwiN2KsBiTgi/614IKtE3jzZ1mYmbqlYKdg
         Eo4gd4xVPhI5jevbuL4jd9hyP/lGEplVnoan3e1VnQjk3TfKfi1sZh7Gzgrh/I8cJxGR
         /uRg==
X-Gm-Message-State: AOJu0Yw4NAiPirsySNpIG1+eNfa0ZNLcNvcPVCWJCJkCzQA07TzInZ5S
	cbSC2BI5C/6Xk/i5ta8d6Gd7cQ2f1ULAhSwrARM88t0OThy0yufOn4AngQeaJUR0hAmwqBQEHZp
	CBGcYIq2g2jPZqWFEGYTdlWmBHe59FL5yhETV
X-Gm-Gg: AR+sD10QULav7jNJWdNPsxKLHM/Ob5iGP4HA7HtVa19KFEe3dkRhuDQ1JTircvnqFd9
	/r2p23/bRv6zpY4lhHLcdHm5MQoUWtx/X04ChJq/EYrWktSOPBs3I4LVHbQQKZslGBIBX+2Dfw3
	A9nKmqFcgQF3slptq42Xz0lme1FggzTIATtxUMiLzk05S8Y8inmXMOmmgFQ7uU+1x896QaJi9ir
	cVUaBmCwR8KkTb6ASu6GJfFdYVHSfuwmEtAWwrSXh+WGlkGLvQEccYBKNuvx5hTUZILd+fJh78c
	dorg3NBwphOJVtCHWw9vSpkxDgkYTgappd/+lq0Ug4uZJ5zdjLMJH+6AEUIJRZgjNKxOQ6ed1vF
	JQ4E=
X-Received: by 2002:a17:907:1c1b:b0:c12:6d25:2c7a with SMTP id
 a640c23a62f3a-c212a2ab2edmr986472866b.17.1786954536090; Mon, 17 Aug 2026
 01:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727124307.11155-1-ishaan.dandekar@gmail.com>
In-Reply-To: <20260727124307.11155-1-ishaan.dandekar@gmail.com>
From: Ishaan Dandekar <ishaan.dandekar@gmail.com>
Date: Mon, 17 Aug 2026 13:45:18 +0530
X-Gm-Features: AcwNN1X22c2JKXxgp7E0njO3qpgb4sfbeHa6-M-MUOZ7lZFxwgGMPbUIrXIe17w
Message-ID: <CAG0uPa8_BP9i+0e3ScBpg58sqr+jfoeh4GTp34OYQ6ssqV9Uug@mail.gmail.com>
Subject: Re: [PATCH v3] Input: xpad - add support for generic clone X-Input gamepads
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,
Ping - just following up to see if there is any feedback on this patch,
or if it looks good to be queued up for the next merge window?
Note: The companion USB quirk patch for this hardware was recently
pulled into 7.2 and backported to the stable trees, so this xpad patch
is the final piece to get the controller fully functioning.

Thanks,
Ishaan

On Mon, Jul 27, 2026 at 6:16=E2=80=AFPM Ishaan Dandekar
<ishaan.dandekar@gmail.com> wrote:
>
> This device exposes a vendor-specific Xbox 360 interface (0283:0001)
> but was previously ignored by the driver, causing it to fall back to
> a generic hid interface. Adding its ID to xpad_device and xpad_table
> allows it to initialize correctly as an X-Input gamepad.
>
> Signed-off-by: Ishaan Dandekar <ishaan.dandekar@gmail.com>
> ---
> Changes in v3:
> - Swapped USB_DEVICE() macro for XPAD_XBOX360_VENDOR().
> - Fixed comment alignment.
>
> Changes in v2:
> - Wrapped commit message at 72 columns.
> - Separated from the USB series to target the input subsystem directly.
>
>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.=
c
> index feb8f368f..1e5eb601e 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -99,6 +99,7 @@ static const struct xpad_device {
>  } xpad_device[] =3D {
>         /* Please keep this list sorted by vendor and product ID. */
>         { 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 =
},
> +       { 0x0283, 0x0001, "Generic X-Input Gamepad", 0, XTYPE_XBOX360 },
>         { 0x0351, 0x1000, "CRKD LP Blueberry Burst Pro Edition (Xbox)", 0=
, XTYPE_XBOX360 },
>         { 0x0351, 0x2000, "CRKD LP Black Tribal Edition (Xbox) ", 0, XTYP=
E_XBOX360 },
>         { 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
> @@ -496,6 +497,7 @@ static const struct usb_device_id xpad_table[] =3D {
>          */
>         { USB_INTERFACE_INFO('X', 'B', 0) },    /* Xbox USB-IF not-approv=
ed class */
>         XPAD_XBOX360_VENDOR(0x0079),            /* GPD Win 2 controller *=
/
> +       XPAD_XBOX360_VENDOR(0x0283),            /* Generic X-Input Gamepa=
d */
>         XPAD_XBOX360_VENDOR(0x0351),            /* CRKD Controllers */
>         XPAD_XBOX360_VENDOR(0x03eb),            /* Wooting Keyboards (Leg=
acy) */
>         XPAD_XBOX360_VENDOR(0x03f0),            /* HP HyperX Xbox 360 con=
trollers */
> --
> 2.34.1
>
