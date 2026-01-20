Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBF43E4B5
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933450; cv=none; b=LyGeGdKCIoTdgxVEQnJKdmQeK9pUs0gAvrPwyG3nNiJpZELORQK5Bg9/gFTEpeHRIMpeHu7Ku5/qmkuF02YmwkVX9wC1Q0RAdVLhH0T/juBH7cGaXc04DfMHreUMkUPeN2/AlMgi5rjcENMvJCwS03e5VOdBuB82ukyKdXW13iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933450; c=relaxed/simple;
	bh=29zanGHiBZfhozLtontjzQB65eZThapuTECyiNTRulQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q72xLPnpd8hqFJUmcNMwEPFY4nmQ5+fyF19wNoHnsQO5iiPX5czF5KA17/swLM3ZbQ3cdCkjyygaoQYP9Qj414JMaGBMYXViYKBNwUFH7LOEuHCEXHicIqWnKP4h/Mk51E2WejmhZ7O+z0cDkvzzzCMLU25MAmoiQHzorO/c37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqip1vSb; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqip1vSb"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso5585910eec.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933447; x=1769538247; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pkh1VgmMwAo0HD+P2CeAspKvOAMYStcAc5u1cCV0Ebw=;
        b=Aqip1vSbKSf0OHixF551WFRA/Q951m7A9K6pOx7s+rdJeJtHf3Ay214ICH6HNDPHtJ
         o64uoTDQVGyKWVesSx6esS22NhRNnPbG7e3P1bLV1z6Ym2gf2Yh4v7bMmgQ2qCeco+9h
         uOC8svAjuwGjl398po8HRg7jO4xjWi8tpD7f1PC+MJidEPo1NN32d++2cZvTdqMY6IxN
         rahrTrLsEWCa7Io8A2vayvTHM4LDyu+awOeXcaYrJeNaQJe2i8IocPqG1S4EaA4so9cX
         6MA1hsaDvqxhLnP57zKUJ1ojRWsml4MX75QVsalPU1lCPOioLysMw32IDQuX6JFv/EyB
         IBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933447; x=1769538247;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pkh1VgmMwAo0HD+P2CeAspKvOAMYStcAc5u1cCV0Ebw=;
        b=ZrkaOSptZt87TzSKitPLrABLJivN/XX1z4EwffSFbLgP7yilLqMssZhhfzg6sZx1JD
         94f22bAgbMVJRh92BGXYUixvkImJT5w9EK6tnyiqW77MTws5hevMASSeYb7afe0bAgm/
         8enUruEiiepUqCl+eFkw/n4bC1wpilJxmLsnxnmLtCwYhYi9ZX1R7Ryla9WeISH9lxPG
         QSalr8ck9+vEo6REGqivzw4vfCmc0h1kifiC77WtRYZb71TPYBMk6r5X55gBzpp+JhgB
         txB/qtY/eHrGMHvIaKTxE6JQWITOgB7FRwjb2uhDqweVd5yxvjYeStVEkSl6pxlkyuxl
         yb9A==
X-Forwarded-Encrypted: i=1; AJvYcCXNBoq+skBD9rDdoJgouju28PPzHrfknmTh1Dj4eB39G/zqG+vfs3qqzbGYDu16oK8TMlHGM0sVM1zv/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3krzQy1m+TdRZEkGcKvFJ8mCpEnuyLxqINzXa0neA9oigEo9
	5IhjfpJGiwBbVnXIM49J+XxQIg2qKzpjZUj+4XewrRIqmHBr6I2+ZCGF
X-Gm-Gg: AZuq6aLvbdUaoRC+qxsieAJVpF7/ZVFBr6zg84zxK+upoOhjSsNZIWZJ4O2Sh1y0exX
	5EmeNVsKyRy+PZT7FyfOksn/s5a7Lx8nNj1uy4wvr+aqYi3IaCZOesokUTzYWgdoBsrnqfXkQr1
	8BNTHmYYzaJ1LTGkzDuZ7djHmDZg8MT0OQDcSyLVVuXzQJJB/eWOYD8h0VT+VRpkMCXmer+KqyE
	wKcvb4JMIp3V5dHGPhHkyREC2/RI5V1NfMtMEy6bY8UvdvZswa0zv0PFiw5nsO6kQaGSpj3lWtQ
	X5kN2tZZzprRxbl6kwNhDKefsvDEggNZ2dm+hW1ypK3xEcxbuG+NDlHgy702qeVZHxMU9XYbwg2
	zzwZ3vNZzg2Y7aaoiKLHTOFzC0xwoLZcWvhTd0/JUtkprvwybvXioK6JkqK1lji4aVwI+wRawSP
	wWWBfZnq/lILX19Xpq1EohD372AZ0EznI2M7wq/Al0Ve2HmnWO236WWAOuMN4OzRG/Uvh7
X-Received: by 2002:a05:7300:1489:b0:2a4:7b58:1a25 with SMTP id 5a478bee46e88-2b6fd7905c1mr1870168eec.27.1768933447364;
        Tue, 20 Jan 2026 10:24:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7047b099bsm2133967eec.31.2026.01.20.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:24:06 -0800 (PST)
Message-ID: <772e728b89205fe2a6c70cefe6d594c2a8eabc83.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/13] selftests/bpf: Migrate
 struct_ops_assoc test to KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Tue, 20 Jan 2026 10:24:04 -0800
In-Reply-To: <4cb38afd-e795-44d5-b71e-e28ef46a713e@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-12-ihor.solodrai@linux.dev>
	 <b5fef9672be4395b76619b8bd39697bf28b93350.camel@gmail.com>
	 <4cb38afd-e795-44d5-b71e-e28ef46a713e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 10:20 -0800, Ihor Solodrai wrote:
> On 1/19/26 5:59 PM, Eduard Zingerman wrote:
> > On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc=
.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > > index 2357a0340ffe..225ea30c4e3d 100644
> > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > > @@ -161,7 +161,9 @@ void bpf_kfunc_rcu_task_test(struct task_struct *=
ptr) __ksym;
> > >  struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
> > >  int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
> > > =20
> > > -int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) =
__ksym;
> > > -int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, voi=
d *aux__prog) __ksym;
> > > +#ifndef __KERNEL__
> > > +extern int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u=
32 id) __weak __ksym;
> > > +extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *a=
rgs) __weak __ksym;
> > > +#endif
> >=20
> > Nit: wbpf_kfunc_multi_st_ops_test_1 change is not necessary, right?
>=20
> Right, but it felt wrong to only change one of these decls.
>=20
> This header is weird in that it is included both in the module code
> and in BPF progs, although it is typically not a problem since the
> most kfunc signatures match.

I think it is used this way, so that compiler can warn user about
signature mismatch during development.

> Maybe it should have #ifndef __KERNEL__ followed by kfunc declarations
> that correspond to vmlinux.h format? I haven't tried that, but seems
> logical to me.
