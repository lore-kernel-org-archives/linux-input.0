Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994542;
	b=Y6S7JQvrnU/raHyQiGeXJln7ga8aE3xaoVIzMgnZEQG9/sRETTknzXU57Ma+JKnjOWT2
	 Bd+VD8DxtTr+rsN9OMdVvrkaz9qvZtTQvNNK9wHHy0B84WxD6sgqgjSRGsQfuJqE0P1Ox
	 wPMjulvCDbtcE/meNEDqDe/9qzAYjXCEAH/TVBGNrQkUWw+O5JYIvoN8OD+9+7HCYUvip
	 SZxSM0s9bUeYm11WuyM46ME37y5+qSXdQgUSduu7x+LE+sf6cP0pWIQL7/zti0m8PBDMg
	 PvipSIXM6amvUZN0TqLuNTuYkmErMshCTW82pffyg54t5YZVRZcu/VWe3ltbQn+pmrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DbZu5q+W+xtqYiktZfPU34LNXZ8FfBPEek4cd/Iy6iY=;
	b=m3Wm9he6T+14Qr5DQLFXqBeroG/37cNyFE+JfuPM6aBNE0RUE0QeM2lcGf9oTMM8o9mL
	 hvUPjb5DGmX/UtVEsb+FDBu5ev70IjmR3ObyjEwcbRr2MfJRECBDjuCvO+yRVt7ckl51R
	 ixQJfBnTYfjcieB8d1oTg1ILQx5LxSdFbmklm9frxS0ZURGRQ/rXWImUaUnv71nhG19x9
	 Ouysw51k9smCrtg+/My08o230nJWeEKw8YgtbV9T2RYqZwjGrS3SFHL27M8XABMvFj4nZ
	 UEh3de7QFciAp5lPABWgEfF28nCj/n0clf+bsFiJTVVFDCruRlUyZ1kvspZP6WuGtxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyPperED;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D5606A329
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208D5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyPperED
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5430f70c827so11691551cf.2
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 11:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994541; cv=none;
        d=google.com; s=arc-20260327;
        b=BvUE8A/TqJbKCgYJ9JB7fa2ZL6bsi9XIwN3y7E74/Q8JuDBDGeZB1MBRSBaZ18uaRK
         8Wez0lp3EbNpcsOqTOQINR1C1gKdUDVSvZjXLqbNMXdGzdofWxRocHNZyaxXbWugQJ7o
         xHWCQxftcY0gdrG2iixFVah6oVHQf9ltIy6jtlFEju1mTNjeOJ2zVje6EfeNxnviO0PT
         OqjPhE7ES6M18aMW16mOfaf0QU1wp9y+1aiT8lE+I/sU8Kvee539vPqizRRgdH7S65Y+
         6DgFOkXXDQg2SWsZQva+E/jkiL9a7AslZDC4EpChiYmjOuXtxPbrUuQmvpvLspGw8Mf1
         SN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DbZu5q+W+xtqYiktZfPU34LNXZ8FfBPEek4cd/Iy6iY=;
        fh=D2Xw1g8bXNa2jJnfZpErSqmGeOtH9OjV2XWSSMyh0Aw=;
        b=ZQXYK/5Xq9tSpy0GrdOu7iWNdEe6dxx0jDXq7fEV8s5JQSRQN3WGuLqpbq7A0/R+Bv
         KeGuM6Wr0vXo1AZLMcaMcCOpVcEktxWEeEVU0g2Pkomv54T9Rjj1V/TTE4Hlt0/uhx1M
         YnNSTcD1a5cEDmFU+3IPg15Eb4lKPIaNa0kgtEcj4IBrUui6YUFZpWBJuseGu8r0q+DG
         z4Nz1Acdhs4vFy89eKjNW3GSkUk81nOd7/8Khy1QuuJgWdRFQFscMgmkK4EfSBwbsDT2
         SNzmWYHwT3vn3F3vAaH74j5U1N5jhmJUMI/JcCt3skk2LAlwGOY1z3TfB4JT0x6vfcW0
         xrpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994541; x=1794599341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DbZu5q+W+xtqYiktZfPU34LNXZ8FfBPEek4cd/Iy6iY=;
        b=wyPperEDJFDS5ADQ8nuKsgHhpHE7PYSaU768vbWgKoHreydewdmho6uuzVeAienWkS
         /Yn0kyQMk0a2dfdx3CpmgxlEM7P3KliO1+hXpHPemuBw6uZthvK0K6E0NpGJdf2oQ0yT
         KVlxRUguqQtWBosSe2XX0crKRy0NPNvCnLgsPQWrURCxCYt4d8CgzO/lxjKESf8aIyWU
         9wJpLYrsCvMmYtIiOe7Rr+McCyHoIap5CjwpiRI/CbZTj6gt8vpNPj3kMgRQjtz+BWu/
         MtazFNqZ6mzCTGo+5m9IOYWmvtE55hAlfN8JXQ27ZUQHn9D1jXPpRDmPGctgcnW2+D3w
         2xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994541; x=1794599341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbZu5q+W+xtqYiktZfPU34LNXZ8FfBPEek4cd/Iy6iY=;
        b=YAOX5PsPk3FoGbbVZy5hwlIRMFi6lz76PodTy1VpAlir+Shr2FQGdNMLSAzHNkpYQJ
         UnRogbGQMIcNJLklRSqb1cHaK4W3MdLz39pBZTjaL/dtZ6uSKKNd68Ad0yk7pQ4QjyJa
         4R1EZLnbytI/cGdX74pCSwdTvshy8bEEb6yuXQGVwrMUD2RxxMeMK3lpqjWtv1/In1kn
         6+9XEzc46LoRqdE6MSWcFRgNY+hMTfMByqa7JyZcGKRI3iB+pZRPm6gbSTX2TQZY+DUq
         Ti8geFvRtd9Lho7kyp+OCzKq8CgkkM7dGu7PWa7hmnkB5d4FZ2p3BPqa/g2cvtr9Lhzy
         7MdQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1qTv+sCBHaT2s/et4BYI3YBt54tEBrD9p38bbX/gaCfp43Q5KFJFtjQVPv5V7jqLN5fEApEgMjpP8+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/yUq3Uw/sl0wYj9gqFq4nIur3hz7GZrq8hRQpIibgHToY4s3/g
	LSRhsTMdmSSEnQq685ki8OcYtyb3ZJBuTZ01wa6Q9v1EaAmR2Xa7sM1nL8XmrURafLj6aRRUsHF
	5IHDgtU/HGwuPkFQT40gFm6T6ynNvi/gHM5N6
X-Gm-Gg: AYBFou2cxZAIUNMttex9/v1FSOBo3gfNmqO94hKTzeNTL4/9FWGIfHWz69S7X/XQ49V
	E0moi7ZPDbo7DUEdsUpap1J+Lzb9tVFxrTArQ7iMK6BzgTICjvI5+8+DCjUOTil4EgAwoGAOXRR
	fbDOhoIDH/favoDPOmLh6Bw5o1ao7bBJmZqzDbZhekA4ZQZ/W60P8D5I4j7P8FIe2KfFAmUI7sy
	2yO0aOVUl8cJ8SZRzEGwXpYz/1rlf3tZLwlhtyRogukoY4l37qxDSwKP3FMof1VWMBEENQ5qw1j
	XXJwRf+55Zm0GXxQI3fXQ0Fox6GrkZlGU0doLG0BHb0ZyIQ13Pp7jwomPtS6+lW9wTRvBBNJ11H
	WLEmcke9qABi7ppj4eAg9SBnmmTQwf8Q5RmdW
X-Received: by 2002:a05:622a:5b08:b0:536:64c9:b1af with SMTP id
 d75a77b69052e-54e1329ad88mr53720801cf.24.1793994540966; Fri, 06 Nov 2026
 11:49:00 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260915041248.2432629-1-qwe.aldo@gmail.com> <20260915042546.2454238-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915042546.2454238-1-qwe.aldo@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 6 Nov 2026 11:48:49 -0800
X-Gm-Features: AclHuK9iaJcHe9K1bRdtuipGjw8e3uQB2h1pAJywOj53Kvv9pWIoHDLbZ4NPWUE
Message-ID: <CANRwn3Tt0VguzG=_azEZAP8vfxr0BbyWj=Nu-R3a0TA1nNGqog@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: validate battery range before scaling
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 9:28=E2=80=AFPM Aldo Ariel Panzardo <qwe.aldo@gmail=
.com> wrote:
>
> Battery events divide by the difference between the logical maximum
> and minimum without validating the range.  A malformed HID descriptor
> with equal limits can therefore trigger a divide-by-zero exception.
>
> Move percentage conversion to a helper that widens the arithmetic,
> rejects non-positive ranges, and accounts for a nonzero logical
> minimum.  Clamp the result to [0, 100] instead of rejecting
> out-of-range values, so that real hardware whose ADC occasionally
> reports slightly beyond its declared limits still registers its
> battery and updates capacity normally.
>
> Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measure=
ments to percentages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

I realize this is *very* late, but (similar to the just-reviewed
sequence number patch) I'd like to request a version of this patch
that only addresses the divide-by-zero without introducing variable
widening. It is unlikely that the range of battery values would ever
exceed anything more than a very small fraction of __s32 so the
widening (and associated requirement to use div64_s64) feels very
unnecessary. Checking `if (range <=3D 0)` on an __s32 range should be
sufficient to catch overflowing and empty ranges. I think the
introduction of clamping is pretty reasonable as well and should be
kept in the v3.

Again, apologies for the delay---hopefully we'll (finally) get this merged =
soon!

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> ---
>
> Changes in v2:
>   - Clamp the computed percentage to [0, 100] instead of returning
>     false, so that slightly out-of-range ADC values do not prevent
>     battery registration (WACOM_QUIRK_BATTERY) or silently drop
>     updates.  Reported by Sashiko AI review.
>
>  drivers/hid/wacom_wac.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85..XXXXXXX 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -7,6 +7,7 @@
>  #include "wacom.h"
>  #include <linux/input/mt.h>
>  #include <linux/jiffies.h>
> +#include <linux/math64.h>
>
>  /* resolution for penabled devices */
>  #define WACOM_PL_RES           20
> @@ -1937,6 +1938,22 @@ static void wacom_wac_battery_usage_mapping(struct=
 hid_device *hdev,
>         return;
>  }
>
> +static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32=
 value)
> +{
> +       s64 range =3D (s64)field->logical_maximum - field->logical_minimu=
m;
> +       s64 result;
> +
> +       if (range <=3D 0)
> +               return 0;
> +
> +       result =3D div64_s64(((s64)value - field->logical_minimum) * 100,
> +                          range);
> +
> +       return clamp_val(result, 0, 100);
> +}
> +
>  static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_=
field *field,
>                 struct hid_usage *usage, __s32 value)
>  {
> @@ -1950,7 +1967,8 @@ static void wacom_wac_battery_event(struct hid_devi=
ce *hdev, struct hid_field *f
>                         wacom_wac->hid_data.bat_status =3D POWER_SUPPLY_S=
TATUS_UNKNOWN;
>                 }
>                 else {
> -                       value =3D value * 100 / (field->logical_maximum -=
 field->logical_minimum);
> +                       value =3D wacom_wac_battery_percentage(field, val=
ue);
>                         wacom_wac->hid_data.battery_capacity =3D value;
>                         wacom_wac->hid_data.bat_connected =3D 1;
>                         wacom_wac->hid_data.bat_status =3D WACOM_POWER_SU=
PPLY_STATUS_AUTO;
> @@ -1958,7 +1976,8 @@ static void wacom_wac_battery_event(struct hid_devi=
ce *hdev, struct hid_field *f
>                 wacom_wac->features.quirks |=3D WACOM_QUIRK_BATTERY;
>                 break;
>         case WACOM_HID_WD_BATTERY_LEVEL:
> -               value =3D value * 100 / (field->logical_maximum - field->=
logical_minimum);
> +               value =3D wacom_wac_battery_percentage(field, value);
>                 wacom_wac->hid_data.battery_capacity =3D value;
>                 wacom_wac->hid_data.bat_connected =3D 1;
>                 wacom_wac->hid_data.bat_status =3D WACOM_POWER_SUPPLY_STA=
TUS_AUTO;
> --
> 2.43.0
>
