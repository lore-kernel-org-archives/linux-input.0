Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA42D12EC
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781650994; cv=none; b=aOWm4fprN8YVBMSmb0v2HAZTlq6vBJ865hR914VtuuirLZdT7vvJNXyThefJwoBiah+tueRatB9Juj07yO3TQWFRNuK001iGdoqkbazDOJw7OCvb7hnxsjsYW8BDZ70ObmovfsBwH7ITryG8y/HHftsqVH/H80QhfVy8eRE7ezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781650994; c=relaxed/simple;
	bh=/+JA0/+x8xTxp72BYKMx9RPOmXh/OU0QdeYU6tSRD70=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=A6SajX+N24AnhHVk3tLS9vk7qhB0Q8l9waOE+N/E1VGWd7ukK3D2qFInja50iA10poJdSDzrbOTzwtctyvTpyZys/mln2Ov7A2D9bknII9jOJkSOFZVgG1inO76G5Sr0rgV/IkGJUtCBvNAy1c9+5ukU88g6uaFiumD8MBeLBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GR+qpQMo; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GR+qpQMo"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30bcdf8232fso590531eec.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781650992; x=1782255792; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH6RTCAKthQn8D3HEOAc82IdePItio5VG4Tc4WQ1DFk=;
        b=GR+qpQMoN7BRETWCDlZiEijbzyeFfvx83pX291ZwwBNT2ug4k9Q90bpRLQ+9tpahH/
         tDFYpdISe/Im0C8GibLgf8hfxzhfq6Orcbn9MiKZXsmI1zcN0rQNPF0FZGz9aAeHM5Lt
         oF0YAT4V4zhDOcWh1y+Q9IlIJ4lag7aEscVJPDUHOA6QuJmDSnJ4+oe9Dsgk63a9UljN
         /lnAN4t9BAqIG/d2ojtioeu8kkySNhafC2vUbFzn9VwVzGPYcN8nz19CKQyCQybpy2BY
         sAeb0dKKJyP51yC/n9gfJ4YdwGHnI+0G1BEwvFxXCtDoX3TQTcyZGkQC5/YOba6XR69E
         nTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781650992; x=1782255792;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WH6RTCAKthQn8D3HEOAc82IdePItio5VG4Tc4WQ1DFk=;
        b=NyIeRSI52uzJlC/qpIfpIoXvQ9SDy6YnE2kS8OMn7y5h2hthuC+iHxoQ2C4E0WfP56
         z5afqytDsBgj/dMD27FAKM+IjysHUTGhDhuNVhhwkwYtVo5cPU541hRiZa+zdEPJiauK
         RAmolADy2YiYi8B+wgGKjGyNi0XU4xnGvXBoIRT0rrFCHcRBjT1FNkXwYLSEhAEfoord
         hok4/E7NQy7CdkQjOLgie89H5b2uusOCDxi4lfqncDcu+7ehk55CqSGnJWf7rBNQzbY3
         Tgeh71nOqGWc4V4fB9r/e9nEBBRIjsOiK4dXLTksv02h3kJZ4v9KUbyODHHQgpV0k11Z
         MntQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7zafS1mecZbzOynWjO2vKUSEOByQ7OqF2k3lz4mteXqhPri8YS/mboo7Oe9mnIrVG+fRwFVhxZZWCZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oy0mQwXaGVg5T5MRVq1bt3MrGOKVjgoIU46nLJzFsPAAL+Qs
	m/61P2QYprcwjxgNOzINzgBG2OGufIhEZYd/YpY+PWNnSC+I1Le3nEScywoKcIuUgHc=
X-Gm-Gg: AfdE7cnkF5tPr0UKkuMjbzeec2Xm/eLjBeT9t0cQiklgSWpcQInEz67Z1fnPcyfaB6B
	NTvGuFcfy97vQk1LLt5paCR5AiXgR42LnEukQAvvNXZDWNEo0BpDP7gjQoFoG7X+qctRPLgb/cA
	kai1Ci4d02rQg1b5QPZItO4RpApIujePXoJr+lDWKqAKGctheN0ZfbzyKCCs1GdyioawIJWRcg6
	xc+I+l/SGxh5eDb6I4kz6NMqmUarZV82BLdNGJW9iBVW6DwaoheluxV5wjfDjsB0pt+aj51ZS+N
	Nfi7JC5ZVzCN3iAH4Pp6yighUBb7NVVgAmvMhQad9fByfh+/rlzcvvG9vhPsS6YpyoXo7S7vN+q
	mRboSW+nLqxMz+VbKeCE+wdZDAn6hlJn98mCp3mlpMP1RXndmntCH9GH87QEqcTiAYEbZQWsR4g
	3+FAFhkGKbGncCBOU=
X-Received: by 2002:a05:7300:cb88:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-30bc996dedemr744821eec.4.1781650991914;
        Tue, 16 Jun 2026 16:03:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ddaf69asm21582184eec.0.2026.06.16.16.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 16:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 19:03:08 -0400
Message-Id: <DJAUKD3DHGGL.18W70CTDB1G04@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 <bpf@vger.kernel.org>, <linux-input@vger.kernel.org>
Cc: "Shuah Khan" <shuah@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/hid: Cover hid_bpf_get_data()
 size overflow
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1781627122.git.chenyy23@mails.tsinghua.edu.cn>
 <49d892af0a5e994676723a81d2584fb91bc22a9d.1781627122.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <49d892af0a5e994676723a81d2584fb91bc22a9d.1781627122.git.chenyy23@mails.tsinghua.edu.cn>

On Tue Jun 16, 2026 at 12:35 PM EDT, Yiyang Chen wrote:
> Add a HID-BPF regression check for hid_bpf_get_data() requests whose
> size would overflow when added to the offset.
>
> The new rdesc fixup callback asks for offset 2 and size ~0ULL, then
> records whether the helper returns NULL. A vulnerable kernel returns a
> non-NULL pointer because the runtime check wraps the addition. A fixed
> kernel rejects the request. The test only checks the helper result and
> does not dereference the returned pointer.
>
> Also add KHDR_INCLUDES to the HID selftest build so hid_bpf.c sees the
> current kernel UAPI HID definitions on systems whose installed headers do
> not provide enum hid_report_type.
>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  tools/testing/selftests/hid/Makefile    |  2 +-
>  tools/testing/selftests/hid/hid_bpf.c   | 11 +++++++++++
>  tools/testing/selftests/hid/progs/hid.c | 18 ++++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftes=
ts/hid/Makefile
> index 50ec9e0406aba..357c6eb5ff5ee 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -24,7 +24,7 @@ CXX ?=3D $(CROSS_COMPILE)g++
> =20
>  HOSTPKG_CONFIG :=3D pkg-config
> =20
> -CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
> +CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT) $(KHDR_INCLUDES)
>  CFLAGS +=3D -I$(OUTPUT)/tools/include
> =20
>  LDLIBS +=3D -lelf -lz -lrt -lpthread
> diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selfte=
sts/hid/hid_bpf.c
> index 1e979fb3542ba..f0a210900e63d 100644
> --- a/tools/testing/selftests/hid/hid_bpf.c
> +++ b/tools/testing/selftests/hid/hid_bpf.c
> @@ -887,6 +887,17 @@ TEST_F(hid_bpf, test_rdesc_fixup)
>  	ASSERT_EQ(rpt_desc.value[4], 0x42);
>  }
> =20
> +TEST_F(hid_bpf, test_rdesc_fixup_get_data_overflow)
> +{
> +	const struct test_program progs[] =3D {
> +		{ .name =3D "hid_rdesc_fixup_get_data_overflow" },
> +	};
> +
> +	LOAD_PROGRAMS(progs);
> +
> +	ASSERT_EQ(self->skel->bss->get_data_overflow_check, 1);

Can you just use the return value of the method? Why the separate
variable?

> +}
> +
>  static int libbpf_print_fn(enum libbpf_print_level level,
>  			   const char *format, va_list args)
>  {
> diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/self=
tests/hid/progs/hid.c
> index 5ecc845ef7921..c6ae2cd045b0e 100644
> --- a/tools/testing/selftests/hid/progs/hid.c
> +++ b/tools/testing/selftests/hid/progs/hid.c
> @@ -13,6 +13,7 @@ struct attach_prog_args {
> =20
>  __u64 callback_check =3D 52;
>  __u64 callback2_check =3D 52;
> +__u64 get_data_overflow_check;
> =20
>  SEC("?struct_ops/hid_device_event")
>  int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx, enum hid_repo=
rt_type type)
> @@ -240,6 +241,23 @@ struct hid_bpf_ops rdesc_fixup =3D {
>  	.hid_rdesc_fixup =3D (void *)hid_rdesc_fixup,
>  };
> =20
> +SEC("?struct_ops.s/hid_rdesc_fixup")
> +int BPF_PROG(hid_rdesc_fixup_get_data_overflow, struct hid_bpf_ctx *hid_=
ctx)
> +{
> +	__u8 *data;
> +
> +	data =3D hid_bpf_get_data(hid_ctx, 2 /* offset */, ~0ULL /* size */);
> +	if (!data)
> +		get_data_overflow_check =3D 1;
> +
> +	return 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct hid_bpf_ops rdesc_fixup_get_data_overflow =3D {
> +	.hid_rdesc_fixup =3D (void *)hid_rdesc_fixup_get_data_overflow,
> +};
> +
>  SEC("?struct_ops/hid_device_event")
>  int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx, enum hid_rep=
ort_type type)
>  {

