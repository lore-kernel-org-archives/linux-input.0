Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609054;
	b=azFYS0BzpSSGdF7nExc2Fp0nSthEilo+e92zQ5AbobOGwAfAceLQewqdX6rvAj4MtK47
	 kuSJme7aIA41z8FQfozsEWF7uYzw4srvRjFaVOT7zCz7o2h3qOTCCmExZIEtIUKgSAn7z
	 VC61ARvGL4z2C2Tunr62uuF/uj0ORkLPj4w7sk7RvwhT+vGBKwV7v8tYrHlvvqX016oHh
	 k48ey9rm//Fq0ZXkfn6k9zIhtPQER+b5MYgJzXg3vFrx8gwNFLWmhKhWx0tBbzaVF2pxq
	 nrEdNGk8mrADTefhkMt2lkZmUOxCHBXDohEm/Qjpp+npecMnjWkqv8nistVQ4A+jfWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lxU+fpXdNAqE/uzoh+966DgHUBkiqVjMoTjja5oXr5o=;
	b=mxsnjOlFMy+FhwNPO97J+0l6ntgU7aErzLB5AKthO+mMiWRurJz03W7W3h+SVMgwfL5L
	 utqAtTrUgVdm8imlmMmjEt36IE06vGqlF3ZyzF4DO7E04LnSfyjloXzwogRbfOy8bvsHS
	 pqb1ULB6CFpRUAER3KHsU4V/JM+Igut8eMx1cpIHrGE9bwgvvJ+qbKrAQdpaWZ8xHQZkS
	 iRtG2EAM7OlVQh/6tmzWQNwJbHKaDwkZPJGufKgVoCHnUk16HaQfklBYE5f+WY4lt8im2
	 OslRiBn86eYFEDiNGbm11iXukLAZMU4P0lOYtWmxhessH+Oa9NoSuRCs/IvyFMnVSPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmVclC5M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7D606A31B
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 18:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F7D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmVclC5M
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b813ac020so14573696d6.3
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 11:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609053; cv=none;
        d=google.com; s=arc-20260327;
        b=OJZA3vL+yl1veGwxErM6E7Wl6U17iXziFtFK/ekPBd3V3ieXXJhkZGvaE49O5HuAwy
         jHYiYRqaKk+/Cx1Tvy3DgY3BwdTmzR8h0PmrJAw7IAHjUSRxpoDN5foUI616rZYuftpG
         29lWAiv1oAk9nFF5KXme+uNbav3clvqtq3UeqCS7Xr8G95AVmeeLWtp3KK2Qzmb1oZYt
         UmGpOZQxmylf7fZPD+MFNKQb0fOd4ikxxziTTifi3aDHCu7wbzWU9v0jv8emb6wJxHu0
         xHukRMgfOHU8KGMqAPQw05FkUP6RAbqjGnWqMKKSpJwV2oHMH2ConRj/KdQN8YvUFx27
         m0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxU+fpXdNAqE/uzoh+966DgHUBkiqVjMoTjja5oXr5o=;
        fh=eTVOLe5b3VHNheCUH2v68KOvsIscf14adyADpq5oWWM=;
        b=WiXt5rZFKM1PhzK85kQ1MiQgEI7Boq2U7+AOzYi6B787h5vwHCn+zY7TlO1+T/3k3e
         xk6DmPFfWVD7QBiwfczbFROZXavk+PxO/H7G6pk9BUS7AlR9w02qxpQddjsygIP3/eVN
         0F4o3+s5ZMxu3rvGFZZ/8FQdJRYi0CTVJmFj+gFmxC+zPUgGwOZHrX0URqVEjUCuAJg4
         X9bLxuOBihwim1yMGkWcXzwoqqzPPbxulTO97ihbjwAxG8yJP9V602ou9WWulaZPqBAr
         P09a178GJVp7qu6XCleNUqeRSaQ5JtIdZsWe1GV4NkXRASBnMrt6AvPBa7eo84F/EmQN
         y6Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792609053; x=1793213853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lxU+fpXdNAqE/uzoh+966DgHUBkiqVjMoTjja5oXr5o=;
        b=bmVclC5MlwrTR45BapWQgbddpL/QxFqMLlQtOhGHP08FQUvEZuWo3GWybvcGgbhhx5
         CWqqf7dJuQqmHyZQAiiycqSDdSXitDAT0MaC6S6UiFQ8Nm0sQu+TlAhY6S+5IeYPdZiW
         RzJakPeQWusbAGhcqb/WPvIFeQDMqGQOT1gB6wTdDou/74bERRmvj+zCS9x6jnHqLNA5
         qpDWoxDYmzaV5IVY+K+W/18QWkty48TAWqaQq2NsmOpQbohk5Z7MhbbkB4N0D+ZcxCsv
         q3nELFMt5li1271WxJim9KthYN/1ypAwRUntNRrxQAmX5v2dBTaod9gLrg1OhCr07RZK
         2KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609053; x=1793213853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxU+fpXdNAqE/uzoh+966DgHUBkiqVjMoTjja5oXr5o=;
        b=rLlyHFmCeAWRBVBw1iYBkok9Mg3fCE11/wxLUpKpdONow5C+e+h8Ms6am/LNl0jxJw
         3viP3c+8U8tDsuli+CN0ZVOoArjsRGCpCrsqkwaAjk1isPNZcnp4ZA6+c9zEpv7EPntc
         fgcvzf1K0rwJYu4xRhqr0XQzphBy7EtzJcRhLvLEWH+/ZM3NtvG8W9ygvoQNXJrOgJav
         MgwhBU497SX2PPxeLF7jAFHb4JacCk8en7cq+0mTdpcLXlZGw7UvB7ye6dNaJkP2loq/
         PI19od2VENryMTkwAqRYmhTnUunY6g2/XmkicOzC3gIaunSi9cU1WcpHZyXBshYJdji/
         QclQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIiAH8c8gjxhqUjnzv4sVBKcnilZt7kGv96UELvqZR1Cdv7OVez6UcmyUQgPqx7Yf/eTbmBqis08HIow==@vger.kernel.org
X-Gm-Message-State: AFq9FYLnxgoUcvwcMZd3PJ3URQtJPa+55N7/ydYlgtG1VffR9T+qKmMz
	SEnpUbVkCX1tEXpxKCkXcwkaPmKy+YLd07PryVLeUZt8Z7ZvT6zYewycPNF6ezXReGOKMtSNT33
	XJUghLUBhiaCos2TsDcU983/BvwRyDtw=
X-Gm-Gg: AYBFou2CtCIgAdHku5Dtwhubkb3Yjj+sNgCKtIOtRL8jwozAZbGs+q6on2PvTyHL0NS
	AvHZLE+IKQHlpnca21p4GogXrkHsJg4WPVVdV3/mbqfxaeJIJwvQSvbhLmiZAb3tZ/is+FmWEMw
	AzkUmgS03zNolxn847yJPvTMlE0q97p/XDgIXhKD9AiQjAznCy8DxfGeAzmbNbua0hQj2eKleHE
	co8/8P4zRER/tHJqdw5L86l6eKMBLhG7A2qEX5JKbFkEAQU7Au2VITfw33NX+gYlGAbdHWBaUqO
	uegvF42XMUD5OzRKlhOIKlrHaf/zK58B7sa01Bt7oM29qemwmUMhZZEYaK8XzXPmR2oAHYkpwUK
	HcQAX3VUbUVVQPfBKMmQCp8zYMPyf4lH2FUKt
X-Received: by 2002:a05:6214:410d:b0:912:517b:40fb with SMTP id
 6a1803df08f44-91c12f1f4ebmr46726246d6.45.1792609052612; Wed, 21 Oct 2026
 11:57:32 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com> <20261018124755.850888-4-jinmo44.yang@gmail.com>
In-Reply-To: <20261018124755.850888-4-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 21 Oct 2026 11:57:21 -0700
X-Gm-Features: AclHuK9stdHp_EZ12QZ6ixOiQE0-gFWmsBr9NPmTz86JK-NBRQoQJ6Axr2WSgaA
Message-ID: <CANRwn3QaVYAvFHS-oLqChjCyhGdMFnmMvOS-jBCV7m4=cLYcpg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] HID: wacom: add NULL pad_input guard to wacom_intuos_pad()
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 5:49=E2=80=AFAM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_intuos_pad() uses wacom->pad_input throughout, but pad_input can
> be NULL when wacom_setup_pad_input_capabilities() returns -ENODEV during
> a successful probe.
>
> Place the guard after the data[0] report-ID check and return 1 so the
> report is consumed. Returning 0 would let the caller fall through to
> wacom_intuos_inout(), which would misparse the pad packet as a pen
> event.
>

The other intuos functions (wacom_intuos_inout() and
wacom_intuos_general()) reference pen_input and a rough evaluation by
eye makes me think that they are susceptible to the same kind of
issue. I feel like it would make sense to add a check for non-null
pen_input at the top of wacom_intuos_irq() to protect its helpers, in
addition to the pad_input check you add in this patch.

> Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/=
Cintiq")
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> ---
>  drivers/hid/wacom_wac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index bec8dbec5bc3..65829de86363 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -581,6 +581,12 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>               data[0] =3D=3D WACOM_REPORT_CINTIQPAD))
>                 return 0;
>
> +       if (!input) {
> +               dev_warn_once(&container_of(wacom, struct wacom, wacom_wa=
c)->hdev->dev,
> +                             "%s: pad_input is NULL\n", __func__);
> +               return 1; /* consume the report to prevent fall-through *=
/
> +       }
> +

Returning a non-zero value will trigger an eventual input_sync() at
the bottom of wacom_wac_irq(). Realistically this shouldn't matter
since we would never expect a null pad in normal operation (so these
spurious syncs are unlikely), but it still kinda pokes me the wrong
way. I feel like update wacom_intuos_pad should be updated to follow
the same return convention as the other intuos_* functions where
wacom_intuos_irq() has a "return result -1" to allow functions to
signal "handled, but don't sync".

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....




>         if (features->type >=3D INTUOS4S && features->type <=3D INTUOS4L)=
 {
>                 buttons =3D (data[3] << 1) | (data[2] & 0x01);
>                 ring1 =3D data[1];
> --
> 2.53.0
>
>
