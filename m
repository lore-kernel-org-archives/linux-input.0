Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648449;
	b=JXYk5Qhz5ktUfKCb2H3DyZmGvz2Y5Rhc8MvDM5dhtDC8ozft/vcvrm/7HM9JAkIs4lP9
	 z1cnL2RPPm0ZOQMCdrp47kbqM4a9O99JFCQXWXcjwfjDQCZY8JlglAO0zKWjApXfGTUt8
	 F36F0ysqnWgcj95ucARHEXRrwxumiqYiBsGXsP3iQIZXm0S0BCK9BmiwibeFz1otRsIQQ
	 20C3z0WIqLyPbedzRtZSFMT8s83gFzIaTniBl7EV3/wRpJtvClcVePJKwXrB9frwvEHAa
	 Wgn9XnqGmK+iVCO4lb+vYiPgXXlSjcjeq3SX6gIr8/8DOCwJZ3ALV6hs0KhW3an7kNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GbkRke0LXaFu4tmREaLxpbbtBeI6hhfwyv7mLLKRRFc=;
	b=OiMGVeYmk/eKXEH9CNg0w0E0b4h8cyKgR2ZeAD1DcuUr95llhsBe9EET3lLg11dD5GR6
	 suv1fSF8zhZwZe+Xyj2bR6j2m5Ny0cDp7bllHZ9wU2swUi4d/SguUBnaGRrjGdCBwSdli
	 RUqWUutylJgVs58w5XGgscd9rSxnjRdibj8tDjfCtHa/bm4D7nndlyi3cMzHAGpwqlFKw
	 VKXDcbqSbudsa2YCYYnBJS9DmeUZwQBN/gnUsKilm/XJcX3M7/anBqxKuA9PibAk2Iu2X
	 9IbFx3BoYzef/7HRZQuZ6DWk8kBe0CygDYm8PDrialLZil4G2s9DD4oSaKxAKsyfdgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OKi4Se9/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99C6085087
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 19:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF99C6085087
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKi4Se9/
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c63449320so40401166d6.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 11:40:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793648448; cv=none;
        d=google.com; s=arc-20260327;
        b=Ln3V0kbTd2PoBnnhE2uSqGgq/Uf8A6iFzT/JCLv/yt2XGMGeighJBuNAy3gc+6nFVy
         dVR8x5pVk7K9vcXOerRtQz1xtQMDe5fJcXAJ/+D9L6XxUTSHXRKFw5C4J2NEWZ6y7JJY
         mUCvzXL3loHlkrBIX1KTu81j4jsMNtZ/+agCrlontLeqDlYshdn7On/exFbUxwDKeDSV
         ciPtIwEqwWvVZA55VmG1oEwi/FrZp0XAeQo1GXQbzO/nB1oXPjyGovY7fWfzoThjmn7o
         6w89rOGSYmfOfY4UApGpJIPNISdjy4k/SgSBZu7HZUbquSwiYmzHgqdBfDYoTY+oCtyV
         aflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GbkRke0LXaFu4tmREaLxpbbtBeI6hhfwyv7mLLKRRFc=;
        fh=zV3CDkDL9bgYvy/t/wj+yH0mzSlQHf7H7WfecXSOIRY=;
        b=DLKUvpvzco6Bd1PLHYYTWq0u6yWWXS9lqozuJOUJ1Nb5HDYLqhhBj0JuWMlM2ubaKq
         tEOjxK15ZhEpDsG5TmMyUArJLNwzMN5+xINPMFPPqHC2OdE2Np2fO2l0wRk+mt1sCkWK
         z/0SOBl+vvollRbqSGnBk0jqxCmsu6SestVu+gYrIpN5u48oR4bmrE3+GGu+/96GazN1
         IXPsL2pZ08ONquismO35/TAMjCywVlsKkX6PQsa2/LGOoN1PcmL05h0SfQJJPk1lk5EX
         PJ64LVvVzvU+HkvHal2Ef7KHq2ALGxizI6yov2ZtAbrF2a2z8H5veXIukiPe9jRzNURQ
         14mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648448; x=1794253248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GbkRke0LXaFu4tmREaLxpbbtBeI6hhfwyv7mLLKRRFc=;
        b=OKi4Se9/+Bx+TX9sYdgg2EQzP1iPTUoPsr9TgA++Rc9P3UfNMq28jEouD5yNb6uO02
         K+DlENi+agCGov4smmLO0wnQk7Uv4/hUurpTswNu+1/M0lkpq+iYnErjwnfIOelDegim
         sGK4DVI29eWk5ygBDrLzPa9lxzl8T4EY6ChkQ6o/bbb0hSVYOT+jCVr9qn8R5uM1eYZX
         nnF0WKhJyqt2dSxSY2KXSXoBRnfPYEacKzN+lPg4jBxYBcoIfVdx2UskcD9pBFNd7puk
         nGByI1+Lrszq4Bbvrk6cpiKmoKoBnHf017SPeDOWjAVO7Jdnp5HgGfHzFcBQyIgc5YHN
         PXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648448; x=1794253248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GbkRke0LXaFu4tmREaLxpbbtBeI6hhfwyv7mLLKRRFc=;
        b=SGGxi+VN3GKxsz9iBByoEHQ5/aIoPxFGwML1BWSahdA88uuEjkv0ARwy/obdcEImsM
         Gei5/ouOiIdovwBwpcLaKlf6W4VR02HLpmuFI+aqlFu700v42ejX2tcsEKe3j09vpdBx
         tL+6ZMUdEWA1Z5jIBqNeGpkqlipI8fc9SOGvsBlVLA5gZfhmZ4YJZUu4GoI5pH0A5z0d
         yZMD4mS6xaqH1ZLA4jWEaT4ifjD+RJcTx+EFQBsGWPM18ioO2mVVm3auGd52LVZVIOya
         erD9DAwQhBhbuX3oDWIyTKecPMsHJn2CQ9OwMQAoHTdw2cKHhn1SMpdElCipNle+/A/p
         d+3A==
X-Forwarded-Encrypted: i=1; AKwUvBwzpGHNx6qJZyBlQ3/u7TKnelKzjY+IvP5QlLPF65gO2M7X4EENR1YeouObhPwX6PIZ1Ep8i0q/Zh21Cw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ruZrwUK1/YZefqmWHwb7JFnbzcwYjjbb/BkcJH2IoAdnfGZgV
	NKYfwdkhQv+cJQ58NtuYTs0eM88Dj3k3pk5+dVZ0f66ilTA0YT+lwS0B0J7oZZXgxGYPCnwi0p+
	IZu9PxtmRRNh+LyxpFvkL3I6YY+GLsLk=
X-Gm-Gg: AYBFou13Xi7lz46gSFMFH1Sv2Xz1M6gYP21NtiY9RspF7Wf+35DZr6ls+PeRCtn5yR6
	v9r0eKN2Zgua8LSrnnlTuwBm5YLNZE1A5qAacEVmuP519NlTHkY9tEf28/mHId37gdoTwEbK7YO
	jVRbfmhw/py2YJVjSKNZA5xAZ4ASBl+iKnPkCVL0tUqfAWr0vzymIP5qZO+wVdZQ9OLQ4IL75Kn
	x356pWPLBvk//Ct9gOmr1yoaVDeD80QZS9FX7pVgmOCJerpzh3rRoCHw+yTmFWLXmXMLJpUZn3G
	GRgzhWxdPhUPsA0UC588xxBRuwxHyyAyOkXUrbJkzgH04d2OkZVWNc2+jkDjNDsZ6pFcwOmqu/b
	HnQo4hTPeyDiOrAAXSt1qMrsnQZ4Hsuv9M5sA
X-Received: by 2002:a05:6214:3198:b0:91c:81c4:e662 with SMTP id
 6a1803df08f44-91ca4a14f3dmr165578386d6.8.1793648447373; Mon, 02 Nov 2026
 11:40:47 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101054830.291749-1-nehuenlian.kernel@gmail.com> <20261101071818.529598-1-nehuenlian.kernel@gmail.com>
In-Reply-To: <20261101071818.529598-1-nehuenlian.kernel@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Mon, 2 Nov 2026 11:40:36 -0800
X-Gm-Features: AclHuK8oDm4gifU63gIrj6gclHFrmc3QapE0pRwdGP2PhXvL4poeX3QSq5R4Ap0
Message-ID: <CANRwn3SnB97Oeg4rKBiYX2DD9r51Km5Cf3kpnAn7s2xd42c0BA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: wacom: replace sprintf calls with safer
 alternatives in wacom_sys.c
To: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 12:18=E2=80=AFAM Nehuen Lian Bova
<nehuenlian.kernel@gmail.com> wrote:
>
>  Replace sprintf() calls with sysfs_emit() and snprintf() calls in
>  wacom_sys.c, which are safer and avoid buffer overflows.
>  Also include the header '<linux/sysfs.h>'
>
> Signed-off-by: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
> ---
> Changes in v2:
> - Use snprintf() instead of sysfs_emit() in __wacom_initialize_battery()
>   as suggested by Sashiko bot.
>
> Changes in v3:
> - Pass sizeof(battery->bat_name) to snprintf() as suggested by
>   Sashiko bot.
>  drivers/hid/wacom_sys.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 628372ab818a..7d9bbcb13ae0 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -6,6 +6,7 @@
>  #include "wacom_wac.h"
>  #include "wacom.h"
>  #include <linux/input/mt.h>
> +#include <linux/sysfs.h>
>
>  #define WAC_MSG_RETRIES                5
>  #define WAC_CMD_RETRIES                10
> @@ -1838,7 +1839,7 @@ static int __wacom_initialize_battery(struct wacom =
*wacom,
>         bat_desc->properties =3D wacom_battery_props;
>         bat_desc->num_properties =3D ARRAY_SIZE(wacom_battery_props);
>         bat_desc->get_property =3D wacom_battery_get_property;
> -       sprintf(battery->bat_name, "wacom_battery_%ld", n);
> +       snprintf(battery->bat_name, sizeof(battery->bat_name), "wacom_bat=
tery_%ld", n);

If you're going through the effort to use snprintf the string, you
might as well also read its return value to check to check for
truncation (return value greater than or equal to size) and handle
such an error condition appropriately.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>         bat_desc->name =3D battery->bat_name;
>         bat_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
>         bat_desc->use_for_apm =3D 0;
> @@ -1928,7 +1929,7 @@ static ssize_t wacom_show_remote_mode(struct kobjec=
t *kobj,
>         u8 mode;
>
>         mode =3D wacom->led.groups[index].select;
> -       return sprintf(buf, "%d\n", mode < 3 ? mode : -1);
> +       return sysfs_emit(buf, "%d\n", mode < 3 ? mode : -1);



>  }
>
>  #define DEVICE_EKR_ATTR_GROUP(SET_ID)                                  \
> --
> 2.43.0
>
>
