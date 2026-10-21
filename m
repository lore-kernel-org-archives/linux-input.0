Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577213;
	b=N2a+dGtqAgt7v0dnTcTTcms+ryLkanXDdMLNHNIiSnBU/F85V5N+HpMz3RRtxrz8cEmN
	 Y0rGYkvL5STSl5DE88/QwAahrFcEQJgg3zsWwabQmhCDTjUyVCF1LKt2/AcmfTaK9N2ml
	 qZ0IF01F65S2Dliv9Dja4rpnowW4B32vEvIo44qfpTLp5rcI6E3k3ZUs7SSnqMxzvwrkW
	 my8Gy/XXjOCDgDbRG1djbKYjsZgFRVOjctKTzOjMQoXsKId8ABR+yYotPLwh5/HsGhz/b
	 Ie7ldbwp2pHAOEgoaGdWjYs7F5ENyEYp4pAipJPEDw/ZFq4Cx8HhlDsHsNOqVjkRodQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577213;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=ZIeabLWc8/+X+ra1sWD8SHeL20genn2WdJFRc0Rla+4=;
	b=1pbOX4lrHnwumn1nUG/vldabh2AodP+Y5ci+poaKjHrTm3HC8IjZWw5UuiZIkwFYus+I
	 KTGREEi0MMkgWqI7W3oDnjGcojvakA1UbHPx52QozIbr+wOuG/5oj8GTMLC0kbRkNvNJC
	 AVtqZdigmh5+VdqO2op5LcbbILvXep+a3V5i0fFlWCb1CshjOp1/h+ju4dUdtqIkxAAVg
	 iqqMRbo8RK/8MkoRGjj0szV/hY47OsJcotzIqPU9ikS46qOvMTaa5eGEYNBZzF27q3olN
	 e076ogxJDL3iVyiGO1YVJ8w4U0adqzZ1S9o3Aa3cw/UK0gg5TUF5sd+Jy8j2rDravOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=My+NPPXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACE606A31E
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=My+NPPXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223341F000D2
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577212;
	bh=ZIeabLWc8/+X+ra1sWD8SHeL20genn2WdJFRc0Rla+4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=My+NPPXdZzilgi8OU5XGXQa2QWI7Agq9xVcLjDqT6xp/zKF547A6W94nmbklZWwjg
	 rzBYhnKsaVPSSAGbOgdsXGrP5foSTo4jaqPw3swymrzkIYZiq25uiokhyDz+bSCBjB
	 oUTwulDO68uwZXx2+PsfP3JfvtsBH5J7e3Qk/7/x6eGCTzvO5RWW7yjWnNW8u3O7t0
	 gEdGgVqZf7yj9QrugZUbIkrJpTESFLpgW3wyTawItnYm3knuCb7X9MqZA/Wx5ICUyB
	 +WUn/IXuq2OHQFDWydtYc8PPlzEFiYP/iNH7+nlEqBM9ueY5CRR8b66TUuHpOGi8c3
	 tOZxLwWVHvCkQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso567864e87.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 03:06:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxNXQFv6pYt4tNps8wf0al97wO1mPBfgbJ7AbA5w6eW4B7oGD4kmCkWCX6dHQDlzpk+VdyiEWZ8QuOKkg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLzqIaDzXdqYsAeQKIKaRpUuSq/JHaUyWiYeXbGy2fc4vG2oDK/
	r7c8uipac2M7rGWNZSsHy/6FpfwBOP3NVjkgAHpHUQioOvQn8ZtcgQIp+rRGI34j90hHoxp2r80
	CTA88vyX+ukT85fB+gnnnkIU3FZs9QbdYEuQcJc/9oA==
X-Received: by 2002:a05:6512:3d25:b0:5be:54c7:75f5 with SMTP id
 2adb3069b0e04-5bfa1be93b6mr617058e87.18.1792577210780; Wed, 21 Oct 2026
 03:06:50 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:06:49 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:06:49 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com> <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
Date: Wed, 21 Oct 2026 06:06:49 -0400
X-Gmail-Original-Message-ID: <CAMRc=McawKQvXKPHzrSsbjxm3nSmiy5gEGEjfeitBwDX=jBDyg@mail.gmail.com>
X-Gm-Features: AclHuK-DUw-TDKgIDp7kls7bG6fjPSgpfM8RhNNzpQbvwml0tw0TvFN9P4v7edE
Message-ID: <CAMRc=McawKQvXKPHzrSsbjxm3nSmiy5gEGEjfeitBwDX=jBDyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: soc_button_array - use __free() cleanup
 facilities to free memory
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 03:50:00 +0200, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> Switch to using __free(kfree) cleanup facilities instead of doing manual
> cleanup or abusing devm for allocations that are only needed during
> probing.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
