Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72743DA21
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934408; cv=none; b=NECb94aX/WdpBX0qGERL+i6GQ3ba/pB7AYKnX7Nn9Y39QC5jpjujiW3+hmjsiRq+BDK1AqPB1o5O2Hn/EUQgWTHlD77HEvSCOdsN8cVEjKxslrWigN2JQAKaBH5HHSSbSUf2f+74fRh+eILmvDf9m840zTEApUmjp1jhrcP1fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934408; c=relaxed/simple;
	bh=BuQ1ShCKV2TIwR4iKcKAM95usz7/aYLJ9oCUKkNrd8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQ1X3KxRJzAktROHEBpinUKgfMDVjXFLSvsCxEX2KWyVp39w7K1u+iYvXPz0MBEKk/XKPQbitPETXwqrjRTn1nc7dfiYKVtwYeFUKU0giDv+wMGZrlKxxyAmq0Ddb0foQw/9tM4nDGWKXxFoVE2oOkrvtBmV2Y216JQY/Hz29B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUTs/nPr; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUTs/nPr"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ad70765db9so6461755eec.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768934406; x=1769539206; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LeeG+LydMx9pdpEIlKwJIXhJ7Lz8QyFbhhTyyId5je0=;
        b=CUTs/nPr3Zbf9YvGWz94tNQCdWKTx0iOYEhqJbDnJWcva067NHTDRqYDhfHZec2ZgJ
         nc1aCETo5oNJY5oCT9GJs6FoSviJN7j5bs28Y5FOgtBYTOvbS/UtnH3c4uNp4HgowLUY
         XxVmPbhn8EWqxdHCy3hMRXTMLn2XMD8bUWfYSJvdi7qj+mhesDrB7A4unIn0qxR01AMc
         92Yop6qSWAMREAJ4QJ++1EWEm/Ue7HO4WmO+x5I6xxagTaUYkPPwpt6UKDKs8U//inum
         xAi2bWgHPsQp2iy/JxVnl/Jd4hnRodJizkC7VesTY1GCT8pL62/trv4rXnWvjcbrJfhW
         yCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934406; x=1769539206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeeG+LydMx9pdpEIlKwJIXhJ7Lz8QyFbhhTyyId5je0=;
        b=udDlCJBS+AnK8Bn01Zw1g+dVNWSNBsVDgSIGkuyaSqwNZEAhrBy+LbGVe8RbPk2KcJ
         Dcnxa2/bDGqadqVbdCcZMxZcCVyil6NBOhrgNgUmsRCSGzI3+d94SoBLxKQ10nTu8AQu
         wM30z/DpF21UBx+gLf/8SxQDNJaFGxK0nufs7cb5WZ+S+XfL1Nzt1wCQpa43t4E7b5ow
         5YiBEmq0DSKy3lEif9rlhKhPKnIn42cH9ni2TWYlYYvXnmcn42uDVnWfn3FVX2cmQ5uz
         2WnFCyDw2kr7R22pU+EfYmytBsI3SNm7iu9g6u85l/8N4jdZTXnTYHkJClwhbHdm1MlB
         nTzw==
X-Forwarded-Encrypted: i=1; AJvYcCUdCAQA5tX25NCjF7L3rZTJNoQmlN0+xmNbr6HbkRJhvbcVAX7Y4e7VRfP819e/2KUmzl9WhD/f27pP5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyFNFg3o132LDkEyoTSRcTI0iG7Fzt5VM9fQUgyFcSp1inhtw
	Ot57WNXNJV34GdlzC7yzOH048xltIvrxuoVokZdjLGam1C4xPYsgJQIc
X-Gm-Gg: AZuq6aKgeGB+wpI3OT+7zDgLUy2s79JD9otsPqPT3z8jefCfFzRtKtvEvERHGo9+gqG
	GcFaKJIL1wJldvr34BrRipJLssRm32JZWCPlMJNpqqIBkZu/czkyOy+7x2SZ9vqdVWv6BsUI37h
	RzkDUkkFDP0j93YvqBuHxqDYyn4xJxOmINLL+ng2OAt0wIXm7QwAhLxlWydQMKeRRW+dC/W8qHF
	oIO6rarrNQbEFwcIzeHcWPYLRqzcGFk5V5mMC/7AhUfH4FN20QJ48UiNdnPfDiLO63yx5KvY/lL
	lk8yo+jS4m8kdfYcF3LpkX3ZV2OvuTluONjKW+H5WqtudE4iQQ+r1TGBdRN6dbZekg1KiSzajz/
	Cp+2EaTgVWI6z9JteY4dXkgrGPKumo0UBpigF2lXQ6TzML4islcATLuOTmeKVdYZ482Ky+sW46m
	G+E0ANViDb3ao8epLlSOuzUpxorBUrX8Q0IcvtTjMyMCKspWoCRMQb1Xyg+SDasPeBsaz5cv93Q
	Sx8vpg=
X-Received: by 2002:a05:7300:8188:b0:2ab:c284:d5d2 with SMTP id 5a478bee46e88-2b6b4e2841emr10118777eec.4.1768934405935;
        Tue, 20 Jan 2026 10:40:05 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502d22sm18159145eec.10.2026.01.20.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:40:05 -0800 (PST)
Message-ID: <45b3df2a1b83a90c134b265ecd713731173556f0.camel@gmail.com>
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
Date: Tue, 20 Jan 2026 10:40:03 -0800
In-Reply-To: <74fbaa99-024b-4e42-bda0-99ae792d565b@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-5-ihor.solodrai@linux.dev>
	 <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
	 <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
	 <b92382bdb9b9b274c0eda1d2bf8aba69c9768ecd.camel@gmail.com>
	 <74fbaa99-024b-4e42-bda0-99ae792d565b@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 10:35 -0800, Ihor Solodrai wrote:
> On 1/20/26 10:19 AM, Eduard Zingerman wrote:
> > On Tue, 2026-01-20 at 10:11 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > > > @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
> > > > >  	if (obj.efile.idlist_shndx =3D=3D -1 ||
> > > > >  	    obj.efile.symbols_shndx =3D=3D -1) {
> > > > >  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbo=
ls resolution\n");
> > > > > -		goto dump_btf;
> > > > > +		resolve_btfids =3D false;
> > > > >  	}
> > > > > =20
> > > > > -	if (symbols_collect(&obj))
> > > > > +	if (resolve_btfids)
> > > > > +		if (symbols_collect(&obj))
> > > > > +			goto out;
> > > >=20
> > > > Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx insid=
e symbols_collect()?
> > > >      To avoid resolve_btfids flag and the `goto dump_btf;` below.
> > >=20
> > > Hi Eduard, thank you for review.
> > >=20
> > > The issue is that in case of .BTF_ids section absent we have to skip
> > > some of the steps, specifically:
> > >   - symbols_collect()
> > >   - sequence between symbols_resolve() and dump_raw_btf_ids()
> >=20
> > > It's not an exit condition, we still have to do load/dump of the BTF.
> > >=20
> > > I tried in symbols_collect():
> > >=20
> > > 	if (obj.efile.idlist_shndx =3D=3D -1 || obj.efile.symbols_shndx =3D=
=3D -1)
> > > 		return 0;
> > >=20
> > > But then, we either have to do the same check in symbols_resolve() an=
d
> > > co, or maybe store a flag in the struct object.  So I decided it's
> > > better to have an explicit flag in the main control flow, instead of
> > > hiding it.
> >=20
> > For symbols_resolve() is any special logic necessary?
> > I think that `id =3D btf_id__find(root, str);` will just return NULL fo=
r
> > every type, thus the whole function would be a noop passing through
> > BTF types once.
> >=20
> > symbols_patch() will be a noop, as it will attempt traversing empty roo=
ts.
> > dump_raw_btf_ids() already returns if there are no .BTF_ids.
>=20
> Hm... Looks like you're right, those would be noops.
>=20
> Still, I think it's clearer what steps are skipped with a toplevel
> flag.  Otherwise to figure out that those are noops you need to check
> every subroutine (as you just did), and a future change may
> unintentionally break the expectation of noop creating an unnecessary
> debugging session.

I'd argue that resolve_btfids is written in a clear read data /
process data manner, so it should behave correctly even if collected
data is empty. Is there a difference between no .BTF_ids and empty
.BTF_ids?

> And re symbols_resolve(), if we don't like allocating unnecessary
> memory, why are we ok with traversing the BTF with noops? Seems
> a bit inconsistent to me.

He-he, I never heard about consistency :)
Just don't like flags, they make me think more.
