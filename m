Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE94746AE;
	Fri,  2 Oct 2026 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932451; cv=none; b=IG3E0s3Oh6bJhGWJH7aQsctea+4/M/Xg5pxzwArYuKLapS0Y/nkMelXKFebdwCOO+Ch6XUxL9XUNrR1El207gbBmmuu3pqPXYOKkwlG1K6M6Y46OLs4SffNFKpF9xAI9gMVuk7rjoO7K/WhkIaBIMOhTEdnP8xRUp78Ap9JFmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932451; c=relaxed/simple;
	bh=wXu8dhMo2bsSxUSZhJktlvCIasuzGG+QNiQOGp3U/Vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIjAdmxedWwGRqwcZaxtPcijbgfK/NtcOVr/agbkx3BBz4RZCdis0r1UqTPyu6ega130FOaOGttGGwlI8XIbmTlOsuvRAawA7fBWKZik/q/1TT9aEyDzu39rPWoxYgbtW++U6IDNMiCAu1DUCLkHfv8selQO0HdXGAQI0OwqSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL3keaBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL3keaBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677291F000FF;
	Fri,  2 Oct 2026 09:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932450;
	bh=4u4vBePMh0J3wmPEX+7SUbcx5gd6zMYkdpd2swJ27Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kL3keaByzkHxKfvm02mKW2wC6Vk/tNognksKQXWWUG2Big5QQ5WkagA/ELatos0te
	 Ov2PtaPGP/TW5V4Rjuh84vrvfFf3XIvjlYassJADltO2OgcM/+FirXzJtLut1Q4zIH
	 YsCAKkOVoQpLWczboX8AnrPc6H0p6WYy/fQ3ZO1mDieggHAuD6TNnAdVIQI48nti8g
	 pNmUwmL22DWgqeeVnkyVMDYp2CGuGZjUswsG6xM5dUM5ZqdgQru8i8PULZnciiZV7o
	 0dd457PrIs7gIImUSfh/W3VcvXQVzR3fTlXD3O0L86RiBRISN0oFzg3POG/nL23/5h
	 X2BcZVwvmo95A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 01/12] bpf: pass the vmlinux BTF to
 btf_parse_module() and let it adopt the data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: linux-modules@vger.kernel.org, dmitry.torokhov@gmail.com, bpf@vger.kernel.org, linux-input@vger.kernel.org, sched-ext@lists.linux.dev, ojeda@kernel.org, gary@garyguo.net, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261001225214.12351-2-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-2-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:09 +0000
Message-Id: <20261002091409.677291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Make btf_parse_module() take the vmlinux BTF as an argument instead of
> fetching it with bpf_get_btf_vmlinux(), and add a data_owned flag: when
> set, the passed .BTF data is an already kvmalloc()ed copy that the new
> btf takes ownership of on success (on failure the caller keeps it).
>=20
> Factor the sysfs file creation out of the module notifier into
> btf_module_sysfs_add() and the teardown into btf_module_free(), and set
> btf_mod->module right after the allocation rather than under the mutex.
>=20
> No functional change.  This prepares for CONFIG_DEBUG_INFO_BTF=3Dm, where=
 a
> module can be loaded before the vmlinux BTF is available: its .BTF is
> then copied and exposed in sysfs first and parsed later, at which point
> the parser must take the copy as is so that the sysfs file keeps
> pointing at valid data.
>=20
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D1

