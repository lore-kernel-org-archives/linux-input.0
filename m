Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D533EAF9
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152307; cv=none; b=WGZIEMCUB8RRj+4vt8WV0xYIGJNil0fH9/vEBON6OSL4Y8IVMVtq+KWjkRttInYf59jAb1QJ+yk4ltaM+XxKA3pGahlb2yZOfMPScXJGTbmHng+KoUFot+0v/5kuC21Loix1u0jw9z2WKJMnLok309WMhr1aW+w99tGIgP8jETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152307; c=relaxed/simple;
	bh=BPs0E0Sg6JSePXrntU9OMcGGkos5S/qvj3HCBcV4X7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hIEpw++3vBb1pUVrOLi6gVBItk/1tUSzuRpbWHZIsrcJxHtX3vP6k6aZiKdqjk7uSh6meIcIWSRXQ3TUPawa2eJ4UfnLPbpRWnM1mDg1v7arocY3OTg4AaE8TwHXpgj378O/HPhCR0fqQ8HK4qeH3uxZ/8npGstoo8T3ySeKviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD53GlfJ; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD53GlfJ"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30c52cc5285so743551eec.1
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782152306; x=1782757106; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8UVsKCK9kHa09INWL8qmL+CtZFk3R2BbfKJt8UkBDd4=;
        b=TD53GlfJXNQrbigVFEhwBvEkYKlxBUSicqZ9kNsYrEGy10ELYPKboOlhoB9GxevsXB
         v371mFBVez4m2lP3AFmC/WnF41GMe1P0doQ062fUIUP+lTF9ylYroXnOlYxPsGOn2Hwn
         8h4LKcwmBYopmARtpCYeGoUrwr3LVi7kiKr3HXFbTBwGcfIF7VrscB9e4IhVuSb37qDU
         Rdg7v1vV2zzu2dL/erFAGJUg9HAWS7AO6ODrY6QmigJbNPCNXrZ1UlARbNF3HNkx2HeT
         28zEDme0Q9QKJpU/o3cU7epWMl96/UGUQpamM3ge4iVUoj4rM2VmIjpi3bjXLuiBp2ZE
         beeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152306; x=1782757106;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UVsKCK9kHa09INWL8qmL+CtZFk3R2BbfKJt8UkBDd4=;
        b=j4TbBmrBwM4cHaekn+3UrzftpARfG/n6a3FtU7HeaNw3O+eTRpBWGzfNnucgSU/Jyw
         MT3ctnVWFKmGKIITQC07ngO/rvP4Iw3TCDdKwMTRYLzBjzP+H08uhtTpRF8y7Rhz3ZP4
         wDrnrgR0tRs1nq6TJ5heoqHj/E5pbJ1S60xKxjg/O7jX9zTwgwrfkmpftdKAhtG8ZW9I
         T9oXGGUo1yX4nsBIHYRF+Rnk4qSlDy3YU7izsSouJtWn95rTZeZwk5wPrV2VZCOxY0jy
         D1k4/AcnafxThNEobVMRkMIUfCsfKYiFlLFqBwmlW+TnMnSUZWSwgioV0IXWLC6Lkv9f
         oAkw==
X-Forwarded-Encrypted: i=1; AHgh+RroCfCGYRvi9E3/i+eK749c8bcipazd4cj2zNJMnmSTOmGKlewMMHSra46yBeFJ2q1m7gfQKmCCtwm97w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXFDlrU95hi0jC3yC0VFn/+yyoMZ88UdlRhsSqaep3rbb4K5P
	pHm5NKCoSE5kKvE3nl9V5Ui0sk0dw2eOe9JP/HpDPzphCbUtstAu1F1X
X-Gm-Gg: AfdE7cmsxlPvCbkAahiabNDutDNqySqMF+Ww6P7x+s7PI4koGFrCyB8Pf/ylEDviGiN
	Rnss+RSHSW6FPy6phjSyDl3oVMx3zhtV9b9SZxrEY/C8tWSKq/Ct100BzZYI50h1eXyhAe53Bvy
	Hs6rSmE7t7W4mmp53mrnSct+t2grhh6gl3i44CH1k4+Y2Y2Vm27g2aKX7B3Poh0heBl38/4vwmL
	kQ1r3HrLkqV+TCKjqQ3P5FEUsi6zRFgCsA377nZyQ8bfvbILK83qyJ+ibzQ+kNTLiwdXyxk45MH
	BvExS5UEJcf6I7iwOF1EAsl9tEp/9SzMpbDoAHW897oBNs8jdyuv79V8A9DKMLrouXyIxIbB2JC
	eqLyrPysVjJjY9xkJ7m8sev3TkMrUzjRUlK/1V3pR3YM1k0d8bSlRQtEWQJ7V0Cge/zmA16Y0gk
	5jUG7+z11djv/rD9IxKxE2QIFXR1/JDMa5LPWDoYJw+zKhFEuhtHdsd9/mbTgsPbW1Vj8=
X-Received: by 2002:a05:7300:3c15:b0:304:ccdd:594a with SMTP id 5a478bee46e88-30c06d4bd52mr13258922eec.5.1782152305404;
        Mon, 22 Jun 2026 11:18:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6e2:c699:67c:63fe? ([2620:10d:c090:500::1:5387])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d75csm10223340eec.15.2026.06.22.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:18:25 -0700 (PDT)
Message-ID: <ea4cec012200acbca4a772898967bdc6f5f6aae1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] HID: bpf: Fix hid_bpf_get_data() range
 check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>,
 bpf@vger.kernel.org, linux-input@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song	 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 11:18:22 -0700
In-Reply-To: <20260622073011.423657-1-chenyy23@mails.tsinghua.edu.cn>
References: <20260622065246.414380-1-chenyy23@mails.tsinghua.edu.cn>
	 <20260622073011.423657-1-chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 07:30 +0000, Yiyang Chen wrote:
> hid_bpf_get_data() returns a pointer into the HID-BPF context data when
> the caller-provided offset and size fit inside ctx->allocated_size.
>=20
> The current check adds rdwr_buf_size and offset before comparing the
> result against ctx->allocated_size. Since both values are unsigned, a
> very large size can wrap the sum below ctx->allocated_size and make the
> helper return a pointer even though the requested range is not contained
> in the backing buffer.
>=20
> Use a non-wrapping range check instead: reject offsets beyond the
> allocation, then compare the requested size with the remaining bytes
> after the offset.
>=20
> Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF=
 programs")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index d0130658091b0..09b45c40d84f0 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -299,7 +299,8 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned in=
t offset, const size_t rdwr
> =20
>  	ctx_kern =3D container_of(ctx, struct hid_bpf_ctx_kern, ctx);
> =20
> -	if (rdwr_buf_size + offset > ctx->allocated_size)
> +	if (offset > ctx->allocated_size ||
> +	    rdwr_buf_size > ctx->allocated_size - offset)

Nit: imo, this is harder to read, I'd define a variable to hold the
     buffer end position, update it using check_add_overflow and
     then compare it against ctx->allocated_size, e.g.:

  if (check_add_overflow(rdwr_buf_size, offset, &end) || end > ctx->allocat=
ed_size)
      ...

pw-bot: cr

>  		return NULL;
> =20
>  	return ctx_kern->data + offset;
