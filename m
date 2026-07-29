Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7215B135
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289146; cv=none; b=W+mHIjmV33Dm6d0rVE+0KgGR/9BH+XCyJRAnp5wTdCizuhJcZTlufxPUsQcshEIaENcn1uiPgzkTHGkP6ShytDBrajdKjCf7oU61lXbpaOXhVAmLIrKKu//SPFqTMYDN7IWvrux2fJiRYwk1fp4+yX910qAGto6CdZ9d1ZiPBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289146; c=relaxed/simple;
	bh=wPc3ZJ1vXqgKLmROd5nVuryKCN9Wowg3Ohdpk9V9tBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2Xih0erk7EOC/Vhl5yV4QZ6wvFe3zAEX3qakhRJtgXQVn0i4ScyavUF+4lk+QuLZphjVD580FFfHhdqMF805J7Cfk/XU5JZ0NOZMzeyzeDWg5egUD405qkTz8CglXQA3+e7Ok7ieNz/DNF0eoNYUBxY92kgKOk1FBVao4Qo0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev6H/Uy0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev6H/Uy0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso456800b3a.2
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 18:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785289144; x=1785893944; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wPc3ZJ1vXqgKLmROd5nVuryKCN9Wowg3Ohdpk9V9tBU=;
        b=ev6H/Uy0+liZgABgp7hkz9FiueeYaWtGxjHTCyaU8Ji9T+dBxMDwmHtI8jIJI4/vl8
         559QB7CV436QbGytLpVjTzBhDIW0EryFY8yH3YfyRabQUh252g+RpIqKqYQ/nfdo9uBR
         oOjEuV/+km2uapamPxnWhq07gBKNECEnZzIavMA91/Kg4052J26mgp6Wf7XmpK/IYiT6
         0O312EnL+ZIUq/C1pYI9F/JyUBP0w9AiFiC8j5754FQd3up1hzzV/lDWu5pp7vE6t8sS
         PrmWo4s+R3RMzjKUiszLYqjXH3DBgN8VkDLs8XVaN7Nh5MsnW+wniVCwElJwOLAiyLJL
         urUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785289144; x=1785893944;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wPc3ZJ1vXqgKLmROd5nVuryKCN9Wowg3Ohdpk9V9tBU=;
        b=ONgC07oAwHeJSkIp8rCPjakkdczLhgNigMCF8l5k3hDH1by7sXl12ZgxVXo6Istj8H
         DxRx6CL/Mytx/U9IEqr9OAGaQFGOO+L3MmuV1sY3NFxFR1UwlcVgkIfbvvjqIhHWC9QJ
         ryi7uvQSnSm1r55uSuJLxK4/HT98yF+QiJu+o6PboDCNx0qJICRlU/zQZYp3lxNC1lr/
         DYHd0up3Xdz8cPiYPTcmH4oRY9UMPSwKX056r9qOsnorNkaUzS8+JeppEZ6u0HESRUn3
         LvnG3cR2dGfrG2RfE88Np2/Jg8NTbPkN7IOiAa3UfCsOSXB2KHR7mdGW5EfiF/nmtb4P
         Veng==
X-Forwarded-Encrypted: i=1; AHgh+RrLmA64jq7x0ccxlre/UIHI+CqzyvV6E/1ojptty47hw49kV8AMiV4YAjiFSWHZKCxaj1mAIkhuc55i3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9PllQDOliKk6dgayZBuqAwT57I3W7V6lOL+gh/fadFCax+CL
	R7rk5AhSjl+cUQb/ZZB1XvAs0gScYKly2irhdasiLritzw2FFbKhl+jb
X-Gm-Gg: AR+sD12hjVhqFc2z0/NezdaqN7FrMsA/8Jx1C7ous0Ro1v14H5i1Z1MZMJB6kD+AQbt
	FrR8tjzrvnMy2R0uBAvJ6hZIwGs6cZcJtf7ppuj2w7yf+oANDsZqgDbFeiKqoYkRbqsJbDcFcni
	//xfYJgsyI+IvDbp9rQwWloEqTVbNjpK43BEzarnT3PKneZfzEHTiXBayZAOcLk2aMuy7d4Bs6N
	f1JKJp0GF6alodUOKVrSEod+wizXMZYdMeRJpGvH7xfmX6LJKtFS/Q0tLv+RpmsqcaRI34ZhlRW
	ZXv0G2KQ4629vk8LQeheURikRRMvKa1OuDNocuFNTM9u297vkoBdWsFKHx4A/DcL+ouKMZmfCI8
	mbb7Ut1eMkqE0IflCvGy8OhS7N2P+nJLSMiXZEoqkB8XVY1vdd4F4crjp5rsnfJ8FHwh15ijRla
	OpkpngHF3tAEzXXk18Ec2rk0x20/ZdFiqkGUAOQBljyLW+Zmt1DMgiHisL+5w0sdAJjC05wntja
	m0G6M0Xn/6FB+db2F7dKveeoDcww2yqfH7S514eb11Itd9tPGNpeZgjFX5an28=
X-Received: by 2002:a05:6a00:1396:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84e93198bf1mr4947632b3a.3.1785289144366;
        Tue, 28 Jul 2026 18:39:04 -0700 (PDT)
Received: from ?IPv6:2605:8d80:58a5:c474:f5cf:239:70ad:a743? ([2605:8d80:58a5:c474:f5cf:239:70ad:a743])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0051591sm615408b3a.19.2026.07.28.18.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:39:04 -0700 (PDT)
Message-ID: <fcd03de340be36340b293d393b731f0173749627.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] resolve_btfids: Discover kfuncs from
 BTF ID sets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org,  linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 18:39:02 -0700
In-Reply-To: <20260722233518.778854-8-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-8-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> collect_kfuncs() currently uses bpf_kfunc decl tags to identify the
> list of kfuncs. The decl tags are generated by pahole, which makes
> current implementation implicitly rely on those tags being generated.
>=20
> The authoritative source, used by the the BPF verifier for kfunc
> registration, of functions being BPF kfuncs are
> BTF_KFUNCS_START()/END() declarations. These are BTF_ID_SET8 under the
> hood. Currently resolve_btfids reads kfunc flags from these sets, and
> populates them with BTF IDs.
>=20
> Implement kfunc discovery from BTF_ID_SET8 symbols in resolve_btfids,
> removing the dependency on pahole's emmission of decl tags.
>=20
> Walk BTF_ID_KIND_SET8 sets, and use the address-to-symbol index to
> look up set entry's BTF_ID symbol name (before .BTF_ids is patched),
> recording the paired flags directly. This makes find_kfunc_flags()
> helper unnecessary, so it's removed.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
