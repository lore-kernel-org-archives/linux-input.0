Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C747F3AA;
	Fri,  2 Oct 2026 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932461; cv=none; b=jXvLXSlNRMaaFnJW7jJKZOpmDNFKktyxSez6CXrnqSk4vH17spDfyGQ57PuBgASjOGbyE0A4Sdnk160l5kqILD4Rt+VRH41jBF3PWmmGTgVXf6UfgbA9G+VDJulZQzvV7eLpKELVBzyKOO+y33s7NvHSjGF01mtFzsmoRh5G/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932461; c=relaxed/simple;
	bh=RMRK4o0+tC2VSLcsiYJL8XOxK0iUl6vp4Lc6OaSyQEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LzAmk1EvJj6Ba7Dlp4WT8lxQNrZCsxHq25JMnYhNHx3racAX/5pZy63XRApXXzEYDll7uZ28CuG9UXyn0OFgW35lGpsqT5/vUVQcpEGdGrFQS8fIE4+tPdL0cm0BWFM//q60xuoed8zusTATT7FJXAKq9Y+3DD3HqmbzNK4xhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsYfV20n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsYfV20n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF6B1F000FF;
	Fri,  2 Oct 2026 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932460;
	bh=TRvmrkCOYomY87ANP6FwDLXpBvqL1FScxqZSlWMXwwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SsYfV20nqz/wk14wpHhtmhgD52Yg88I2m85xioyRiik8VtK3LsymM9WNuidB2fLTQ
	 kZ3HAyK6RBbjuzt5uN8uNjH7oVxd87u+82T4RdkZFeMbiXaeaeZ8P3gPDOz3GuCDBZ
	 K4J+kG1qgSntu/xK0+U0rCwLOr4fwHxfnrRWe3/hNZfrBgCsziX2XrIgx8RMs75hky
	 DBnpzOmImCmIi2wjpyXUVTfjP04BNhwGIENIvRgGNMOhFCutr2yroMzk1Auj5bZcmg
	 h80cH/UmL80vPV3cQge1AQFxZ+liJTmkdNYxoJgFArc1gflO7POsJf8jTbldY1XbUq
	 Q8SvR4FtmPlow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 03/12] bpf: fetch the vmlinux BTF where
 kernel types enter a program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: linux-modules@vger.kernel.org, dmitry.torokhov@gmail.com, sched-ext@lists.linux.dev, linux-trace-kernel@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, linux-input@vger.kernel.org, bpf@vger.kernel.org, ojeda@kernel.org, linux-perf-users@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20261001225214.12351-4-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-4-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:19 +0000
Message-Id: <20261002091419.AFF6B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> bpf_check() fetches the vmlinux BTF up front for every program, whether
> the program uses kernel types or not.  With the upcoming
> CONFIG_DEBUG_INFO_BTF=3Dm the BTF is a module that is loaded on demand,
> and since systemd loads socket filters at boot, a program that needs the
> BTF only because bpf_check() asked for it would pull it in on every
> system, whether anything uses BTF or not.
>=20
> Stop fetching up front and fetch at the points where kernel types enter
> the verifier state instead:
>=20
>  - bpf_add_kfunc_call(), for the first kfunc call of a program;
>  - check_pseudo_btf_id(), for ldimm64 of a kernel variable;
>  - check_ptr_to_map_access(), for accessing a map pointer's fields;
>  - check_helper_call(), when the helper's prototype takes or returns a
>    PTR_TO_BTF_ID, or is bpf_snprintf_btf()/bpf_seq_printf_btf(), which
> [ ... ]
> With CONFIG_DEBUG_INFO_BTF=3Dy the vmlinux BTF is parsed at boot by the
> first kfunc registration, and without BTF the new helper check is
> skipped, so nothing changes for either.
>=20
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D3

