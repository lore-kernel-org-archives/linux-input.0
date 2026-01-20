Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB1438FFD
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933155; cv=none; b=l8ro4G9XMny2qg2aPVBlO/cR1Ap1j0OD7P19R/9xrRLtJE7GUITzI5tylo/n9/yuYbyh7ooe58z0pVjIZDvR+Zo32MW2QbZkMjUkFLErEe2mzdAhbv0bvtwKfctaxnVOorZV07Z/DHdjOjb/2R5cMuLEZxQoKifD4mTlahsJStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933155; c=relaxed/simple;
	bh=Z6WkaZNjD+eEC5S2sCu+mWSNmR7uwq/DhhVRU9ARdG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fE6gLQP4p3vDBwCXhnNTeUoNlCBdJO1F/ajvuv0bkMmUzBLuy7gjHwRYvSAYx7SRTUAen6KL/XSRR7TzLvQp0A92FANl3/hcupV/QjR45oCMQ/0yEUR6ztKajGYjUPmc0fellFl4WuSiheSXmoB+1S9PbWjJo7wrJR9fs5EbA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSKLxziI; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSKLxziI"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1233702afd3so7303892c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933153; x=1769537953; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SBww9KLEHQwBhj2b72CiEvbmeQf+WrCHcUWGacrEJTM=;
        b=nSKLxziIag/pKIfQCKmFiGkaJ10nI3Vn1oWj9LoMCM4B/JQIUJjJtXIp80lS0/n4rs
         u/6JuYY3/WpvkahE7NmVWNvO9e1jete2f9sK81KcilSOvIYsS7U+6RATjtIzd5g0Zq2+
         GRHKFYGBI/mpgqpLo3eepLVmbbZO/muS28mGiU8EabYjxlSk+Uo3WmodNscZk5HF8bek
         X/igo3BykZ6TozWfgSUvFimICZhxgKdKliCMF62DOim4yMFAZGv+vkuSusU2YAL/Tq2T
         ZsGmEZC5bppH+HWhqImSfp9lXven/RxZk0J3DvdyTqwLuGlFB5iicdiEDXUaA9BOIE2B
         tXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933153; x=1769537953;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBww9KLEHQwBhj2b72CiEvbmeQf+WrCHcUWGacrEJTM=;
        b=J/nImZs9wBE4SbiDjmSTuqb3TpYofjUdirD1wxzZnU2ZgNn41+zksjFzRYahjSP/f6
         Eni551zRFPy0la04fV3mi+ztoGTKmLLjcNs7geMd/QMxINeO5t10xqMMZ23QIUxHN5nH
         WeEs1EnwLYWJbXsyH32oucCWXmeketHtsYoMtIZgHuNZEW0ULQ9KO0mRcEOCBxXK6YBh
         1qUo4YQh02+mWQXbi+sI45gyaR06OgYHctuMXrtH6r/Q/MbpJiyWdPIKESicAIEVI8vt
         8nRUzWNLi+hsoRBYLydLCgbRv93huJsXhToo9/bMw89vHkJ8zp0Vg4RUSaBVjhOAyyrO
         TbQA==
X-Forwarded-Encrypted: i=1; AJvYcCXx/PlU8s3TIbVyE7z4HAMi/vGK/KfA8kO/I5G8I9pyGfVBSXKtfDA1Xm+TD/EbnBABnCFYIlDy/fhMpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Sk+lKJa9/2gbIdHl9bJJbHKYl7iVb8DrUeZ7HAWSigvhK22Y
	40gwbCswkgJY6XEJq79kBc6s+Lqpi4lnD9HSebtgQDongd9MepMzRC88
X-Gm-Gg: AY/fxX6DAwU85Ubo9artQ2u4+mekjMcb6R8cDfHyB5zJzK/kuitPGibsEd3qhHxWU3W
	OrKtDKGyy1ebY43nsZspUh/HCEYrLdLzKMPjbjveApijj2EI+quxYZKT9BZnqiZPfQRvoQYoT7e
	AVRES9S99LrjDOcpbfXFo3A5G0BFogESQMD190xc+G/7EYLDJCv3ka7h4tvmiEU+24oT+FZwhOu
	ouCc0asANaB3iL0oOOitFd+0gCiUOxv8OmuOgA41kEUJe6xV/Rlx8Vp+8rx1mzU5gQbKFWCxxZC
	rdBwlU3nPqMbzHsyHI5xTZQgkRMzZUefTYjs8xuT+aYP9fA2BSKCLZRDKkZJU3JIVmWeCOOOCB7
	JDGn/OUoxIzAkJUmw9syKS2zYVLoSv7E2UWIDLopYzppLd5IBOH8fz3eNwmlxTzzqLBv3oX5JyD
	XxlEJqg3mWmPRarn/lK2uNJZy5qpSe6c3TLSNs95kD14VUDzM9uK/HfMmMA/EB5j848s8l
X-Received: by 2002:a05:7022:e1a:b0:119:e55a:9be7 with SMTP id a92af1059eb24-1246a955faamr2004520c88.3.1768933152685;
        Tue, 20 Jan 2026 10:19:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm22503340c88.10.2026.01.20.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:19:12 -0800 (PST)
Message-ID: <b92382bdb9b9b274c0eda1d2bf8aba69c9768ecd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce
 finalize_btf() step
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Tue, 20 Jan 2026 10:19:10 -0800
In-Reply-To: <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-5-ihor.solodrai@linux.dev>
	 <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
	 <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 10:11 -0800, Ihor Solodrai wrote:

[...]

> > > @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
> > >  	if (obj.efile.idlist_shndx =3D=3D -1 ||
> > >  	    obj.efile.symbols_shndx =3D=3D -1) {
> > >  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols r=
esolution\n");
> > > -		goto dump_btf;
> > > +		resolve_btfids =3D false;
> > >  	}
> > > =20
> > > -	if (symbols_collect(&obj))
> > > +	if (resolve_btfids)
> > > +		if (symbols_collect(&obj))
> > > +			goto out;
> >=20
> > Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx inside sy=
mbols_collect()?
> >      To avoid resolve_btfids flag and the `goto dump_btf;` below.
>=20
> Hi Eduard, thank you for review.
>=20
> The issue is that in case of .BTF_ids section absent we have to skip
> some of the steps, specifically:
>   - symbols_collect()
>   - sequence between symbols_resolve() and dump_raw_btf_ids()

> It's not an exit condition, we still have to do load/dump of the BTF.
>=20
> I tried in symbols_collect():
>=20
> 	if (obj.efile.idlist_shndx =3D=3D -1 || obj.efile.symbols_shndx =3D=3D -=
1)
> 		return 0;
>=20
> But then, we either have to do the same check in symbols_resolve() and
> co, or maybe store a flag in the struct object.  So I decided it's
> better to have an explicit flag in the main control flow, instead of
> hiding it.

For symbols_resolve() is any special logic necessary?
I think that `id =3D btf_id__find(root, str);` will just return NULL for
every type, thus the whole function would be a noop passing through
BTF types once.

symbols_patch() will be a noop, as it will attempt traversing empty roots.
dump_raw_btf_ids() already returns if there are no .BTF_ids.

[...]
