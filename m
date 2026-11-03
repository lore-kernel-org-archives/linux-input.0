Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697834;
	b=HPaVxxUPYzje0/E5pjDb4x2QUu5s9zXVGqTlFL1Ls3syw9QVfFUXxIqsUOUKw+v0y3MF
	 5uEbs4pzhUzO6X/Fv13QWMXfmVqO4C4PR0rg2AxtD7ezlopf0EkUSicFt42/w+RgIGmWu
	 J0Lp0biXHelwE1PlYTFezw0P7JrL0pXhj+uGkwX9F52iz3TwjHJLKyhQkFzUoKyzoAgsx
	 fvONtQdMLbMjgfOLkabqIK8IOuYJ6kmKBnKd2ixRqpx3DNkhT07D8IBi0hN3seQ6sAOuE
	 u3FEqxZOODPPnlJrX0eg1FWrKoDGxQflltn9b90CeXpp3Tv+tAJOBdi01UQB5TIVCBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Disposition-Notification-To:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=tpCaZ3gvIQBzjv1rcZJeDml96AKnPdsrDz4opTSfiHs=;
	b=qiBflgOSZGWXp9N7Llrawv8iHJBD9KDhBdFoCZR1nelKWnH3gtWvc7yVG+GUZ/7uZ54o
	 hyYI6Zc+dTXiOLl3m9cQLWfiA2yNOyaElvSkMhl1Mi6gRuJyl9tkvCoB/ryTrjjoe6KOy
	 GWafBGswa62NZ1lKaexcAXoTrDDi8lQdh0iPgVJvG4kY4JccQTLLfTjMIxjlUA4WeqE1O
	 SvH7cc/9jGjjlPvaKhA2gjymVse1bztzeHaykf3XLWBm93qye88/eLvn4EZqHHeKm42oF
	 FAYAvs5amf/llOvOwoq48TTqu/SYIOmpwX/J47ZpVUtf6CdMn/H29ooT7nFXPElbj8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbeKc2NB;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14B606A329
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 09:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB14B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbeKc2NB
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c40aa03a96fso75062366b.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 01:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793697832; x=1794302632; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tpCaZ3gvIQBzjv1rcZJeDml96AKnPdsrDz4opTSfiHs=;
        b=cbeKc2NBkGygMQ4SUsJf6NBV80GKqKLRZyQOx3gFMEtqZMwNAUO84uXHJCgDw57rkF
         hQq1QXnMxV0DlfUzw4mVgkE3bo2nouQOToZzwLXPNTYIzHvU0nbo4dcfbUMgcISn2ufy
         ooFEKXhzM5ch8L9aPaZowPRHgrvPmdqYd8GqW7KmffvCChXaUQRm95lOsQXvVWMrxzNl
         7OyJveqprTG2fG8FOxQJta32jnleYtbkc+eoc7bRAbplTaRamvUbB2ivDV8S09c71oYd
         NfboXvjWUaVpxWda3wjBAMym0CXlvq+E0+/p+8xtt2qyoAk4pn5LuGacvgjtN+glacbu
         8+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697832; x=1794302632;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tpCaZ3gvIQBzjv1rcZJeDml96AKnPdsrDz4opTSfiHs=;
        b=renCRDI4RelCUI5tgcGUdeNtzeMixpn5VQqFXl2oMCoSyW7NWpolGxLkpt4s52K9uq
         rg08M3cDt/bmVFiV7EhL13UH62msE/5W6p/SUhn9uArNoLMEPVHqMWl5cm+vaveqy7bA
         Gr/7n/OImAVfzuiE45vVpLn7Kyv6xtKww3t6s5pjYIUAAhubUF0jNP6Vbks4LIuO+IQS
         D5b6c6RFAUKzykTaDmwRva+zJhrFnmgzePAZBrX0V8nI0MdntFbCse+UsUVOC6dmvLMy
         nZz1EEn2fFa4tX1/jVNtHF45G9zMeP+Cj3kmrnxVpPEDUenFUjULt5OSPIzrLA3adZOI
         mBww==
X-Forwarded-Encrypted: i=1; AKwUvBy3I6PNABUCbdB+gpjCOMAap/zttpmfntLP6yb3evHicLzTZH0BrpxWHhDSoABdlTlgEsKQtYKWPEy5EQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8wQRQFQ6nqbnqtw1Oi0OqhPYgLwToAxRCT6ZSVGqtyj+GfkmH0
	qEKCvse+Em7jH4sxO1CXmlZi7ejUtqByqq8pRS2YSBrLLm9S3K8QRsl5
X-Gm-Gg: AYBFou0Qkjt6B10bZ9mBxtzsWJJMHHC+i/eZko1Y5cWGh3+5NLyEeK51tzfod/quwCe
	G6fQVwVJ6gVcMV1cBelpqtJ2tI7jfri6cepfqoYUKvfrnYhb8oCvC5SPE6qsAZ0/KHvJpXxmV4G
	MjhVW5buEGBDgwcVIXP3k5Ijxu8CGo8jLCCSXf3UqnfLJ4RTiTTvduSuOD603QfQEC3fWLjXVm+
	nIFNJpij1QbDkYk7iS/ISROxAyp3TUpsYHF2NIlwJKf1xMXRByVi7JoGE9kTfWRbnlrv/j8CFq2
	zjYvDSYjCSoSrIy8JXW3UOeTtCOzyJX+IDAcxydahmfAqgyVD7RNXqbnbYksX1gDmKyUTKLLbJd
	bi2xrmh5p5VHF5f+nSMGz/RR0DlZIIogIRfKyN6HMup12lXotVyLD6zYH+IlOTGexi9oMHM1pLc
	mDR5yMB1/HND8CqCE0T5a+D6+IK+QJUZo4t3nMnEekk5PWPi0eZjaCD0rZx4QUKjgg2Lgt//Nme
	VEv/SX0v99z6ia8MmLt67QTlHPD2ROI5iJHIwHLcXjxSey9E3qnaZg+6YghPTpreW7KcDj6Iyzx
	hdVZKLavNhl5LxZmxLTTrSY1L2GdF6MBasnDYPMsdGSDJnBjeI1xHitZa72syH/Xhrwn8PEFGeE
	vKiI2cdeGnDPDbsc+C3n7ommllR1mnfBTZn8=
X-Received: by 2002:a17:906:f15:b0:c43:f1ab:167c with SMTP id a640c23a62f3a-c4ca7970666mr995749566b.1.1793697832181;
        Tue, 03 Nov 2026 01:23:52 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebebff55sm67442166b.29.2026.11.03.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:23:51 -0800 (PST)
Message-ID: <8f4bdf112918e848fa236877b41f8142194db69e.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: validate effect type usage indexes
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>, Oleg Makarenko
 <oleg@makarenk.ooo>,  Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Anssi Hannula <anssi.hannula@gmail.com>,
 	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:23:48 +0100
In-Reply-To: <179362071771.29269.11607321878213733518@stu.pku.edu.cn>
References: <179362071771.29269.11607321878213733518@stu.pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-02 at 19:58 +0800, Yifan Zhang wrote:
> pidff_find_special_keys() records usage positions as one-based values, bu=
t
> pidff_find_effects() uses those values directly as array indexes.  The
> Create New Effect and Set Effect fields are independently allocated and
> need not have the same number of usages, so a malformed descriptor can
> make the lookup leave the Set Effect usage array.
>=20
> KASAN reports:
>=20
>   BUG: KASAN: slab-out-of-bounds in hid_pidff_init_with_quirks
>   Read of size 4
>   hid_pidff_init_with_quirks
>   universal_pidff_probe
>   hid_device_probe
>   uhid_device_add_worker
>=20
> Convert the stored position back to a zero-based index and validate it
> against both fields before comparing the usages.
>=20
> The reproducer is rejected without a KASAN report with this change.
>=20
> Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
> Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> ---
>  drivers/hid/usbhid/hid-pidff.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 22951b7ecd174..5e4a937237d55 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -1373,9 +1373,16 @@ static int pidff_find_effects(struct pidff_device =
*pidff,
> =20
>  =09for (i =3D 0; i < ARRAY_SIZE(pidff_effect_types); i++) {
>  =09=09int pidff_type =3D pidff->type_id[i];
> +=09=09int usage_index;
> =20
> -=09=09if (pidff->set_effect_type->usage[pidff_type].hid !=3D
> -=09=09    pidff->create_new_effect_type->usage[pidff_type].hid) {
> +=09=09if (!pidff_type)
> +=09=09=09continue;
> +
> +=09=09usage_index =3D pidff_type - 1;
> +=09=09if (usage_index >=3D pidff->set_effect_type->maxusage ||
> +=09=09    usage_index >=3D pidff->create_new_effect_type->maxusage ||
> +=09=09    pidff->set_effect_type->usage[usage_index].hid !=3D
> +=09=09    pidff->create_new_effect_type->usage[usage_index].hid) {
>  =09=09=09hid_err(pidff->hid,
>  =09=09=09=09"effect type number %d is invalid\n", i);
>  =09=09=09return -1;

Thanks very much! Now that I look at it, find_effects was never
overhauled and I don't quite like how it does things here so I'll redo
the function + include a fix for this issue.
