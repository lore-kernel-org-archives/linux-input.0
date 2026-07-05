Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713E30DEB8
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261654; cv=none; b=JhKtfo4If1mK6TNPuRi5aQgnSwHJcJAAZqaVcNz2VnylUSoy8vc5CKoeD3cUFPFvzCXbHcqnUh/p42dZ6v8whA29y/9bhyaFE5lEah76SoqDEhqtXbbKaQ33FVkN9eH+rNAHDOTXSG0nptYpe08iavAyPaKntDTgJKGc/8EHI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261654; c=relaxed/simple;
	bh=J80P4pAhL9+tso/HnmcpPQg3m+UswzwFTI+T88/wgh8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=lvO3Po6RzZx0znMgus04QDijgIMF+JX4k9twHfTTz2UGmKYirm7FHkEuuNwdYsj8JseVcZ+gWsqtkM+7FzjJyPRUeVIPRGD+pAKXkmBnnmat097KxCHGFJCmUD6cqm4jUqHo2hZOn+CjPRcls6ur1pavTjG299cE1SOqzCuHTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZtmtzoH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZtmtzoH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46ed4f66256so1932560f8f.3
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783261651; x=1783866451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rhVO3bMe6JjO2EXVjiT5T7OtJJNmOkBToOIJ1Qq0vbo=;
        b=aZtmtzoHjy9uhaSwA48cz857bZq+oIuizkg7MoNF5OToewOdwh7h+rAbxm8AxNpfdL
         aGNmerxv8rHNoayJUHydpsViYmBWrpjZcCttmeix+24FH1iZix/T7fhMkAkruo5BSCwn
         /NYesr9iUSJ7l59tFs6wGGf8s6adkExISBcaa4Tw3KESl432xEwiCsNrGKBCVjq5Slvv
         +qYwo+LBTU48xwy2q39JC0M1zCjV6ksuKpPFk4FCaskPm+tVWuATLNNky/dOQjdw7qYO
         MEkSMfY1asP7eQ9xFIHdkRxahMcZgwIF3eD9O7rb2CBQoO/Lcffrtkud+hKl8e3sAk3P
         QzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783261651; x=1783866451;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhVO3bMe6JjO2EXVjiT5T7OtJJNmOkBToOIJ1Qq0vbo=;
        b=eZUlO4tKdZTcedmpnuw1J3VLvSCZXXdf4ef5R4nSzxTbYw8eGT02WYlIwuuHvkv4/l
         hNRTsKTlQ70E0dqwK2EeqnArq2ZXbXXFs8rnKJKird8KT5nCyTZ/FsgWL0IJKaZ1uuzv
         KGQugdbT3uGAJ5W3ppNM4REjMRAJ8RdYyBYSDoUNqMexUyfTSRh56P2LVJgZjAuyBMO0
         7MCaqwWxp+eiZKJxQ4C8ZagdN9gXGxw7cTTTndHI0Au3f7jkrnOfaDLA4+muG+4fQ5m6
         wNRcaqZuxT0tt4Q+vS92utPGlDeXx9/pPN4wuxPNp90rGjEg2yDLToA0n4DPjCIKOh2U
         RDDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrrw3p+8ZpAob4KrfuggJ+XFWvp7S+uFsJ7edwRG7F+N20EgLfPv1E+NPHyBPGTPcWoTtuK3nFEqu65GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGv1VKe7Xqxg7bSwgZ4FZ5W3rfQEDwOdNRk8BA3MaZ8P7j3Nay
	sbotKzpxOHL0kSDaiW/kxDIyYhFC13K91ekbJ9oRfrThCXfQhGWNwn0z
X-Gm-Gg: AfdE7cl2e4qFn6FV+R9FfNQrhAP9f7EuuKLUnAdu+wfXXKRPq2+1tJPrD9jr5X2YuMe
	aRmi8jPbWUeZEKdOo6QZO5da81zzhafDX3AWarMKaUQ+ocVN8YxCjmjIUZCXc5pLQ/AZY3+0ZT9
	ukENp/k2ypNnAhNSitzKsaUfaOsaUCfYS5pg6vxMh0S9wOmiS9j/6iO5PEo1AIOfprB1ZrxUsWH
	3LsdphoiQ3/y2bK7jimeprmaZ7eMKVun7vXwTUXzNQti8dUJz1HeCeTub55DvBEm9uFQ6Zdt43g
	OzMDSNLTwp6saBTPAq/ZPJ0rPo7w9JbCZj9/Yss84GfSRUihyDcGOQYlhlKQ+b4n6yJyklY620x
	FYqIUuwekKhWpyDpmYUyKLPeD4WB7E96EDDb5cHVuh1wCMQy3tUe24WyUS2OkOCKTLnHyNWdCgE
	s4Xjwsbg==
X-Received: by 2002:a5d:5d83:0:b0:474:fb6:b049 with SMTP id ffacd0b85a97d-47aadb16046mr7735498f8f.38.1783261650867;
        Sun, 05 Jul 2026 07:27:30 -0700 (PDT)
Received: from localhost ([85.195.223.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm16200988f8f.3.2026.07.05.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 07:27:30 -0700 (PDT)
Date: Sun, 05 Jul 2026 16:27:29 +0200
To: Vicki Pfau <vi@endrift.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v11 3/3] HID: nintendo: Add unified report format support
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260702214704.1859350-1-vi@endrift.com>
 <20260702214704.1859350-4-vi@endrift.com>
In-Reply-To: <20260702214704.1859350-4-vi@endrift.com>
Message-Id: <2DO5IYQ73TOPO.2Z7J5RU0B02GW@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Vicki Pfau <vi@endrift.com> wrote:
> This adds support for the "unified" report format that all controllers al=
so
> support, which has overlapping fields for like buttons and axes between
> them.
>=20
> Signed-off-by: Vicki Pfau <vi@endrift.com>

This LGTM!

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

> ---
>  drivers/hid/hid-nintendo.c | 151 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 146 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index a36f4fd9a1da..ca2126f85bb3 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2873,6 +2873,36 @@ static int joycon_suspend(struct hid_device *hdev,=
 pm_message_t message)
>  #define NS2_BTN3_SR	BIT(6)
>  #define NS2_BTN3_SL	BIT(7)
> =20
> +#define NS2_BTN_U1_Y	BIT(0)
> +#define NS2_BTN_U1_X	BIT(1)
> +#define NS2_BTN_U1_B	BIT(2)
> +#define NS2_BTN_U1_A	BIT(3)
> +#define NS2_BTN_U1_SR	BIT(4)
> +#define NS2_BTN_U1_SL	BIT(5)
> +#define NS2_BTN_U1_R	BIT(6)
> +#define NS2_BTN_U1_ZR	BIT(7)
> +
> +#define NS2_BTN_U2_MINUS	BIT(0)
> +#define NS2_BTN_U2_PLUS		BIT(1)
> +#define NS2_BTN_U2_RS		BIT(2)
> +#define NS2_BTN_U2_LS		BIT(3)
> +#define NS2_BTN_U2_HOME		BIT(4)
> +#define NS2_BTN_U2_CAPTURE	BIT(5)
> +#define NS2_BTN_U2_C		BIT(6)
> +
> +#define NS2_BTN_U3_DOWN		BIT(0)
> +#define NS2_BTN_U3_UP		BIT(1)
> +#define NS2_BTN_U3_RIGHT	BIT(2)
> +#define NS2_BTN_U3_LEFT		BIT(3)
> +#define NS2_BTN_U3_SR		BIT(4)
> +#define NS2_BTN_U3_SL		BIT(5)
> +#define NS2_BTN_U3_L		BIT(6)
> +#define NS2_BTN_U3_ZL		BIT(7)
> +
> +#define NS2_BTN_U4_GR		BIT(0)
> +#define NS2_BTN_U4_GL		BIT(1)
> +#define NS2_BTN_U4_HEADSET	BIT(5)
> +
>  #define NS2_BTN_JCR_HOME	BIT(0)
>  #define NS2_BTN_JCR_GR		BIT(2)
>  #define NS2_BTN_JCR_C		NS2_BTN3_C
> @@ -3121,6 +3151,22 @@ static const struct switch2_ctlr_button_mapping ns=
2_left_joycon_button_mappings[
>  	{ /* sentinel */ },
>  };
> =20
> +static const struct switch2_ctlr_button_mapping ns2_left_joycon_button_u=
nified_mappings[] =3D {
> +	{ BTN_DPAD_LEFT,	2, NS2_BTN_U3_LEFT,	},
> +	{ BTN_DPAD_UP,		2, NS2_BTN_U3_UP,	},
> +	{ BTN_DPAD_DOWN,	2, NS2_BTN_U3_DOWN,	},
> +	{ BTN_DPAD_RIGHT,	2, NS2_BTN_U3_RIGHT,	},
> +	{ BTN_TL,		2, NS2_BTN_U3_L,	},
> +	{ BTN_TL2,		2, NS2_BTN_U3_ZL,	},
> +	{ BTN_SELECT,		1, NS2_BTN_U2_MINUS,	},
> +	{ BTN_THUMBL,		1, NS2_BTN_U2_LS,	},
> +	{ KEY_RECORD,		1, NS2_BTN_U2_CAPTURE,	},
> +	{ BTN_GRIPR,		2, NS2_BTN_U3_SL,	},
> +	{ BTN_GRIPR2,		2, NS2_BTN_U3_SR,	},
> +	{ BTN_GRIPL,		3, NS2_BTN_U4_GL,	},
> +	{ /* sentinel */ },
> +};
> +
>  static const struct switch2_ctlr_button_mapping ns2_right_joycon_button_=
mappings[] =3D {
>  	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
>  	{ BTN_EAST,	0, NS2_BTNR_B,		},
> @@ -3138,6 +3184,23 @@ static const struct switch2_ctlr_button_mapping ns=
2_right_joycon_button_mappings
>  	{ /* sentinel */ },
>  };
> =20
> +static const struct switch2_ctlr_button_mapping ns2_right_joycon_button_=
unified_mappings[] =3D {
> +	{ BTN_SOUTH,	0, NS2_BTN_U1_A,	},
> +	{ BTN_EAST,	0, NS2_BTN_U1_B,	},
> +	{ BTN_NORTH,	0, NS2_BTN_U1_X,	},
> +	{ BTN_WEST,	0, NS2_BTN_U1_Y,	},
> +	{ BTN_TR,	0, NS2_BTN_U1_R,	},
> +	{ BTN_TR2,	0, NS2_BTN_U1_ZR	},
> +	{ BTN_START,	1, NS2_BTN_U2_PLUS,	},
> +	{ BTN_THUMBR,	1, NS2_BTN_U2_RS,	},
> +	{ BTN_C,	1, NS2_BTN_U2_C,	},
> +	{ BTN_MODE,	1, NS2_BTN_U2_HOME,	},
> +	{ BTN_GRIPL2,	0, NS2_BTN_U1_SL,	},
> +	{ BTN_GRIPL,	0, NS2_BTN_U1_SR,	},
> +	{ BTN_GRIPR,	3, NS2_BTN_U4_GR,	},
> +	{ /* sentinel */ },
> +};
> +
>  static const struct switch2_ctlr_button_mapping ns2_procon_mappings[] =3D=
 {
>  	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
>  	{ BTN_EAST,	0, NS2_BTNR_B,		},
> @@ -3159,6 +3222,27 @@ static const struct switch2_ctlr_button_mapping ns=
2_procon_mappings[] =3D {
>  	{ /* sentinel */ },
>  };
> =20
> +static const struct switch2_ctlr_button_mapping ns2_procon_unified_mappi=
ngs[] =3D {
> +	{ BTN_SOUTH,	0, NS2_BTN_U1_A,	},
> +	{ BTN_EAST,	0, NS2_BTN_U1_B,	},
> +	{ BTN_NORTH,	0, NS2_BTN_U1_X,	},
> +	{ BTN_WEST,	0, NS2_BTN_U1_Y,	},
> +	{ BTN_TL,	2, NS2_BTN_U3_L,	},
> +	{ BTN_TR,	0, NS2_BTN_U1_R,	},
> +	{ BTN_TL2,	2, NS2_BTN_U3_ZL,	},
> +	{ BTN_TR2,	0, NS2_BTN_U1_ZR,	},
> +	{ BTN_SELECT,	1, NS2_BTN_U2_MINUS,	},
> +	{ BTN_START,	1, NS2_BTN_U2_PLUS,	},
> +	{ BTN_THUMBL,	1, NS2_BTN_U2_LS,	},
> +	{ BTN_THUMBR,	1, NS2_BTN_U2_RS,	},
> +	{ BTN_MODE,	1, NS2_BTN_U2_HOME	},
> +	{ KEY_RECORD,	1, NS2_BTN_U2_CAPTURE	},
> +	{ BTN_GRIPR,	3, NS2_BTN_U4_GR	},
> +	{ BTN_GRIPL,	3, NS2_BTN_U4_GL	},
> +	{ BTN_C,	1, NS2_BTN_U2_C		},
> +	{ /* sentinel */ },
> +};
> +
>  static const struct switch2_ctlr_button_mapping ns2_gccon_mappings[] =3D=
 {
>  	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
>  	{ BTN_EAST,	0, NS2_BTNR_B,		},
> @@ -3176,6 +3260,23 @@ static const struct switch2_ctlr_button_mapping ns=
2_gccon_mappings[] =3D {
>  	{ /* sentinel */ },
>  };
> =20
> +static const struct switch2_ctlr_button_mapping ns2_gccon_unified_mappin=
gs[] =3D {
> +	{ BTN_SOUTH,	0, NS2_BTN_U1_A,	},
> +	{ BTN_EAST,	0, NS2_BTN_U1_B,	},
> +	{ BTN_NORTH,	0, NS2_BTN_U1_X,	},
> +	{ BTN_WEST,	0, NS2_BTN_U1_Y,	},
> +	{ BTN_TL2,	2, NS2_BTN_U3_L,	},
> +	{ BTN_TR2,	0, NS2_BTN_U1_R,	},
> +	{ BTN_TL,	2, NS2_BTN_U3_ZL	},
> +	{ BTN_TR,	0, NS2_BTN_U1_ZR	},
> +	{ BTN_SELECT,	1, NS2_BTN_U2_MINUS,	},
> +	{ BTN_START,	1, NS2_BTN_U2_PLUS,	},
> +	{ BTN_MODE,	1, NS2_BTN_U2_HOME	},
> +	{ KEY_RECORD,	1, NS2_BTN_U2_CAPTURE	},
> +	{ BTN_C,	1, NS2_BTN_U2_C		},
> +	{ /* sentinel */ },
> +};
> +
>  static const uint8_t switch2_init_cmd_data[] =3D {
>  	/*
>  	 * The last 6 bytes of this packet are the MAC address of
> @@ -3802,11 +3903,51 @@ static int switch2_event(struct hid_device *hdev,=
 struct hid_report *report, uin
> =20
>  	switch (report->id) {
>  	case NS2_REPORT_UNIFIED:
> -		/*
> -		 * TODO
> -		 * This won't be sent unless the report type gets changed via command
> -		 * 03-0A, but we should support it at some point regardless.
> -		 */
> +		if (size < 0x3f)
> +			return -EINVAL;
> +
> +		switch (ns2->ctlr_type) {
> +		case NS2_CTLR_TYPE_JCL:
> +			switch2_report_stick(input, &ns2->stick_calib[0],
> +				ABS_X, false, ABS_Y, true, &raw_data[11]);
> +			switch2_report_buttons(input, &raw_data[5],
> +				ns2_left_joycon_button_unified_mappings);
> +			break;
> +		case NS2_CTLR_TYPE_JCR:
> +			switch2_report_stick(input, &ns2->stick_calib[0],
> +				ABS_X, false, ABS_Y, true, &raw_data[14]);
> +			switch2_report_buttons(input, &raw_data[5],
> +				ns2_right_joycon_button_unified_mappings);
> +			break;
> +		case NS2_CTLR_TYPE_GC:
> +			input_report_abs(input, ABS_HAT0X,
> +				!!(raw_data[7] & NS2_BTN_U3_RIGHT) -
> +				!!(raw_data[7] & NS2_BTN_U3_LEFT));
> +			input_report_abs(input, ABS_HAT0Y,
> +				!!(raw_data[7] & NS2_BTN_U3_DOWN) -
> +				!!(raw_data[7] & NS2_BTN_U3_UP));
> +			switch2_report_buttons(input, &raw_data[5], ns2_gccon_unified_mapping=
s);
> +			switch2_report_stick(input, &ns2->stick_calib[0],
> +				ABS_X, false, ABS_Y, true, &raw_data[11]);
> +			switch2_report_stick(input, &ns2->stick_calib[1],
> +				ABS_RX, false, ABS_RY, true, &raw_data[14]);
> +			switch2_report_trigger(input, ns2->lt_zero, ABS_Z, raw_data[0x3d]);
> +			switch2_report_trigger(input, ns2->rt_zero, ABS_RZ, raw_data[0x3e]);
> +			break;
> +		case NS2_CTLR_TYPE_PRO:
> +			input_report_abs(input, ABS_HAT0X,
> +				!!(raw_data[7] & NS2_BTN_U3_RIGHT) -
> +				!!(raw_data[7] & NS2_BTN_U3_LEFT));
> +			input_report_abs(input, ABS_HAT0Y,
> +				!!(raw_data[7] & NS2_BTN_U3_DOWN) -
> +				!!(raw_data[7] & NS2_BTN_U3_UP));
> +			switch2_report_buttons(input, &raw_data[5], ns2_procon_unified_mappin=
gs);
> +			switch2_report_stick(input, &ns2->stick_calib[0],
> +				ABS_X, false, ABS_Y, true, &raw_data[11]);
> +			switch2_report_stick(input, &ns2->stick_calib[1],
> +				ABS_RX, false, ABS_RY, true, &raw_data[14]);
> +			break;
> +		}
>  		break;
>  	case NS2_REPORT_JCL:
>  		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,


