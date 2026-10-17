Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCC29408
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195559; cv=pass; b=ILZk8ne4QzCh0AjTT8QoL3tAFgrCWyxsfwWhKDmwhM97fsaYEq2Hl49XY8NNj0FjJno8F4/RBCdxYlfY1S9g0Xg3WbRrJhT2/VFgyFdxh7XMTJP2pSJt/3esr06nOxroYDyXoh1aKA8Pbv0uj0Egl04xiZZbPP8MUkPCq0A7iGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195559; c=relaxed/simple;
	bh=A1yBBpLJ1bJ3Rv9E3+TAn047VSvJob1S4KjyARr4O0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhFZBQeaY53rZ6L4+n3byHUpQr6hJ2Tpkv6aHsZ2Kx/GvKH2k9kfgqg7y0EG5mF3uE+p9YeVjWMy+UOsKqEHWd+WKU9QncXfsX3ZLTfiqTpO5zw1I4G+Y4nPWzcLVMBC7l4eaQsvKmgp3mnk6ibbGdN+3kHW732jq+Jjph4ySUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdQoA7gQ; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdQoA7gQ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e762768f3so49138385a.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792195557; cv=none;
        d=google.com; s=arc-20260327;
        b=o97sWgBwzSmMKVi1E6Bxe9DhjzzmnDDf0clIiYmD2nczvZfIWSWtdf5KXBwInaNpMD
         vZYFPnVXPQWviEvuwZYP92GcbphNT84FeLOTvus+A6H21MA/HWRA9vsug7egHgv8nbBt
         PCwwCAf7yDYn3+xqRD+b1inu8KFzIyLsBbxAoVOGPpH6Pec+cIz/vbLYKtQcejLkZ0ch
         gOU0gLrHrTHx8G6V3i6Quh/8qIqWqu3JRQM5nImGLY8f+/jlm42YtI0Cuzm1LuVwsoz3
         6SbDkk9TyV85R6d2qeHN7L3Qhjvqp/PvVFQ0UMd+qSEOepbNMD2Y2z2Ywf6M0NPqtB1+
         6dBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9m04eWmztaCm3Wj7dJ9THoHZwUu785KZfKba5Fj3Wfg=;
        fh=BwU1XuvNqS+gGRZTySb6kxCBLJdQ72ImBd5cctKYHX8=;
        b=IsbY9DvJQEBRxQ0Shfd9RiNTfniesxFa9FttbDT7vW7CpSUw+pdIjhK/yoniIHJim2
         jLrdqEul1X5SE3gVNE1kb+4YZR4fmrn0eNgyrdtZ2tdfIPPDNafp9nPSWRGiEytIXwrx
         GxYkWmW+8lgOHhk0oEUBu6gGCZ50ky4L+6ajvAzMIF4Y/vg4Xw9Ue37PA5JSnaOS0qZk
         OB/HvM8MrKaRe3wKFmmyDSs3xFSf/6kWFkbwDgOr4oSG1X4UwFflaOzkaNuZRNRBlnds
         4ZwXYp9P8U5r4+sw7wAe7xpf0wq4kF6zk0slGMknbYejd8hKsoQuSHBaPFE9RMu04n0/
         A/kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195557; x=1792800357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9m04eWmztaCm3Wj7dJ9THoHZwUu785KZfKba5Fj3Wfg=;
        b=VdQoA7gQkThRoloVTJi3lLyl6W/YSOqabe47GQKVkVANrIrNj272DpJkOt8kK7BT2e
         O25+869fWCIkuGNIk5ep4NhBPcwEeMhPo6YN7oPXUJhAJMHasQHWm+lHHX4hvfrr8TCq
         yxaL0JyFRJ3itPc61U2svcirnk/ScSGacEtmot7XM/BqDciMQBNiWkIz3/5jwJzKT+fZ
         GYY3h/jDDsdIhuMsLRo8DqGZJWLLSIfRZVMrStrrODCj94/qVzQe0pGcRp932x9ISP5Z
         feYo6R3tpaxUje6WmGbIJs1FlLFD4V+MhciT/IqX2m/CKnJAiX5041XfbqJG8mqzVo4M
         h/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195557; x=1792800357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9m04eWmztaCm3Wj7dJ9THoHZwUu785KZfKba5Fj3Wfg=;
        b=cofikQ4ItARKjuPCpBJeAohlvMSbH3Js6ZlOXLUgl8j2NgB/zfpjoR3zPLDKrEVeow
         ccQuNWsn6vj3JsVU/NDg0spWg7Nk+02vKo1M7PXJR8uX2TDkXg+s2BZMkgZ9pKSPyZBX
         cDN13Mysq02wR4w/LXL0ihE3llCYfgVz0+HTiKpL8TWoUlpQ/5eaMwwQPtUdgh/d4peZ
         U4FBKfmrpEKGHRnVmVrW3gfdMabPhLK4QdZUOu9SWWcJZIiTDmddUAz+QPDI4D9BBJvi
         qmtqOSkq0DsWoeT0AKdMyjnGFgRY0hBPyPwENoGS4oypWDYsnQOYkRA3kLnQOSyD9Zuh
         tWJA==
X-Forwarded-Encrypted: i=1; AKwUvBxpoivbk9u27xC92qOjgsOrSJ/wcWOlXvbhhC8hr5a/o+lWut8SX4y0tLtI/iXx+hu91CzrvpfcaXSU8w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4zbd1xw3YV3lsybM6NDBzi12Sy+uu20N3N4Vt7WjV6sXj4BnO
	5YHunVh2OoPv+H2wereAzu22Op8iRBowIAnw9Ek7LYo//9kO1shhEhe8v1j0i7RNf7vzRn5N6Kp
	9sB8w9xUbSlxI2P9ZarsKLUNAWJn1Kx8=
X-Gm-Gg: AYBFou358ACWSWYuOboCHmkXRuWWeSGbwwXRbdylKNQ5emGz+A32jqGyDwOwI6R2iev
	6no880iWv/FsrpsU+yQxP1oQHLVmfXrr8rlHAIW9Md50loAHd4DbKncK5BEh5qRJLBR/5+TWRlO
	PhkkGXHWv5bnMgeDHHsYc7k6G0LWfd16NGxHaZPPM4lbhYOkkabxa9MFW46eYq4gj2//yN9smj4
	pU5Z+Op9ay9ycY3/kJc4ZxD1HPWpay3aSfMH7Ikob6RKCh31u5XnnvIzzGlypGLAM2psDYqcyI+
	dEEdH6yKdw9cWrdHDKJTDbT7LKOTKOfS+7DJOi8hdIFel+2Mh2dtock=
X-Received: by 2002:a05:620a:6cc9:b0:93f:baf:279e with SMTP id
 af79cd13be357-93f29b72b3dmr256358185a.8.1792195557231; Fri, 16 Oct 2026
 17:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20260927041138.4112920-4-jinmo44.yang@gmail.com>
In-Reply-To: <20260927041138.4112920-4-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 16 Oct 2026 17:05:45 -0700
X-Gm-Features: AclHuK8DOt62Xds_xVpqa-lc0Zk5FJujgPMgnOItP_EsoMr5iLn6xlgBeOOCC30
Message-ID: <CANRwn3S26juDz-Ad74Ehh2q7SFvbjzBNDMjS65WMdJvK=zaU2A@mail.gmail.com>
Subject: Re: [PATCH 3/5] HID: wacom: check the input device in wacom_intuos_pad()
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 9:12=E2=80=AFPM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_intuos_pad() takes wacom->pad_input without checking it. An
> interface that declares no pad leaves the pointer NULL on a fully
> successful probe, and wacom_intuos_irq() still calls this function for
> pad report ids.
>
> Reproduced on linux-next 20260925 (x86_64, KASAN) with vendor 0x056a
> product 0x032A and report id 12:
>
>   BUG: KASAN: null-ptr-deref in input_event+0x44/0xb0
>   Read of size 8 at addr 0000000000000028
>    wacom_intuos_irq+0x1b46/0x3300
>    wacom_wac_irq+0x1b59/0xb3f0
>    wacom_raw_event+0x68f/0xb60
>    __hid_input_report+0x398/0x4d0
>    uhid_char_write+0xa99/0xfc0
>
> The function only ever serves pad reports, so the check goes at entry.
>
> Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/=
Cintiq")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 794c2865064a..48a58a6672c2 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -553,6 +553,9 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>         bool wrench =3D false, keyboard =3D false, mute_touch =3D false, =
menu =3D false,
>              info =3D false;
>
> +       if (!input)
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


>         /* pad packets. Works as a second tool and is always in prox */
>         if (!(data[0] =3D=3D WACOM_REPORT_INTUOSPAD || data[0] =3D=3D WAC=
OM_REPORT_INTUOS5PAD ||
>               data[0] =3D=3D WACOM_REPORT_CINTIQPAD))
> --
> 2.53.0
>
>
