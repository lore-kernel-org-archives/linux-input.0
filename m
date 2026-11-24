Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795540360;
	b=hbCzt1c9oGs35CkdgYxMVQS2/QgKIVw+RjfgZd6x9g24debb69k3UVBrS4msjOVvryGa
	 cgQm2BTCr8MCMNg57HlY2TujJ81RGEun4b6vpZWXkzZD2ujO9NKrE3z+dElEXrtDdImCH
	 wjvGKRa1mYDtlacqbf3fK1IDTPoGbcCtqwtNNNSZHXB85S2o/pnaMnw0ckEd0fVtHbeG5
	 x8NQascConBd0Akx0U2KpbEnvmXas41LgiWeiNHD62j9TClIZmedF/e87Fva6/wQu04+A
	 nX4LSdYttaJwne43VBg4h4NdQDzwlGadWGVs1B3JnU7t7Fkg2+UkOJzwpdAlSkgs0Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540360;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=SLOOv/u5txnHgUHzcfRtK3xy/OPHT+Ffq5I0G4nIvqc=;
	b=uqtDvf1noDkqI7lVnaoa2+xf3Bc7tQe32n95j2zvwBpd4VbIwzBMxeHbv+ibUY32pC3C
	 FAKtraN1sJtWJsCbI4oA+Vmpw+McryASiu/dH8RZrJz7B/F0jhH1Wu5Ho/bt4oTZ1GFaZ
	 HIcukyZlcxLqVdex/JVCfbk/gLnaaTXdIUlOPcMS7IT7GifJvnSZxnEDWo+HA8qg699WI
	 aZUCLh7R2xEl0csnZ8mEVRdwDATaNiKwdU7UcyQVcxDQv40pjxxhLRUjcz17n0TqeG4FT
	 8R/fSkzzXgTCrqpgKgKv3w6Wxoxz1/zEs91hosCGosYNVDTUpAehsQEJU8x4nL0l5Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=jw0hIujl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF8606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 17:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BFF8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=jw0hIujl
ARC-Seal: i=1; a=rsa-sha256; t=1795540355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DckYbAUcVMO4Mirjnj5sJ31Gd0MH3Xw2aQiqHOzMzyEcoyNCswe7oKTpTPnAqAGoR5V0Q1YERNcVvwlMgq7++YjYQKe+Wt1j17Wi/g4JM24ARBRU/JWDU0eWh91bEBDAldPnjR7HN6FDva0ya8itXl0UsysbHvFSebIqy4/Y+IU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795540355; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SLOOv/u5txnHgUHzcfRtK3xy/OPHT+Ffq5I0G4nIvqc=; 
	b=bSfd2Mw3MW07WKS7CRLjv8SEoKTlftlQUfRC385MyqGSB0bIKdFbBfidgNzuo5fRpK98uz5HV4ayXZeRQRKFIuhTFXXoUJaHNEmlZKx1RZozf9c0toa7mmpBuk7ydnAqWMcl8yxsceGCXMgrapPVYvylozF3YL7BWmKvcaESkBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=jw0hIujl1+9LcqnwUPYivulIviZKYL/TdvhG1jshMVyoczmC0oaeleQJ9OrJ9YWOmis3WEhSTGJFv8My+Rp+NFX0+BlR/QX+u4wmriAzrdqDOANqeVEc5md64ziRqY0yPAo5Pq+EejBMIHgjxdvNZVTg7O+DSu9JPZ/5268yGqQaKcw1yPup8sftxD1nq5Gv4jkYErJMGm1NwnWt2Qh1VbMIS6PveuSYFWFZaRBehu4fQwp1j2tVW4EZ9HWwuTNCqJF8KvhGrAQpB7uO5yqLpGU4KaT3U4OMd4qumwKAC9MFud6N0stU1Ceog8Qi/G5uwYtiChQil51oMwoYsuFiXw==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=SLOOv/u5txnHgUHzcfRtK3xy/OPHT+Ffq5I0G4nIvqc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795540352703268.87578966460944;
	Tue, 24 Nov 2026 09:12:32 -0800 (PST)
Message-ID: <e7b9f2600bb42e1ed514d02f59ec905757de7ae8.camel@rong.moe>
Subject: Re: [PATCH v4 1/9] HID: haptic: Get rid of input_ff_destroy() in
 error paths
From: Rong Zhang <i@rong.moe>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <sashiko-outbox-231650@kernel.org>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
	 <20261125-hid-haptic-kmod-v4-1-03713a89f656@rong.moe>
	 <sashiko-outbox-231650@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 01:07:26 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-4 
X-ZohoMailClient: External

Hi All,

On Tue, 2026-11-24 at 17:04 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] HID: haptic: inaccurate Fixes trailer in hid_haptic_init() fix
> --
>=20
> commit e6d3c5552e5a0755862fb250069c54d74d75f7cb
> Author: Rong Zhang <i@rong.moe>
>=20
> > HID: haptic: Get rid of input_ff_destroy() in error paths
> >=20
> > It's painful to have error paths after calling input_ff_create(),
> > because input_ff_destroy() frees too much things but does not restore
> > some other things. For example, every error path calling
> > input_ff_destroy() frees ff->private, while the others don't. This
> > divergence has caused quite a lot of trouble.
> >=20
> > Additionally, the driver's get_device() bail-out path calls module_put(=
)
> > right before hid_haptic_destroy() calling it again, causing refcount
> > underflow.
> >=20
> > Since commit 2ae35f090d02 ("Input: destroy force-feedback device on
> > input unregistration"), the HID device is now guaranteed to have a
> > longer lifetime than the FF device, making get_device()/put_device()
> > unnecessary.
> >=20
> > Due to the driver being unable to build as a module since commit
> > 083a4f3f3cc7 ("HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC"),
> > try_module_get()/module_put() is needless, too.
> >=20
> > Remove the said calls, so that there is no error path after
> > input_ff_create(), eliminating the call to input_ff_destroy(). In this
> > manner, we don't need to restore dev->flush and dev->event either.
> >=20
> > Fixes: 083a4f3f3cc7 ("HID: Kconfig: Fix build error from CONFIG_HID_HAP=
TIC")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Link: https://msgid.link/f44447354f28c295e79a025bbcab7a4e@gmail.com
> > Signed-off-by: Rong Zhang <i@rong.moe>
>=20
> [Severity: Low]
> 083a4f3f3cc7 ("HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC") onl=
y
> changed CONFIG_HID_HAPTIC from tristate to bool in drivers/hid/Kconfig.
> The broken input_free error path and double module_put() in
> hid_haptic_init() were introduced in 344ff3584957 ("HID: haptic:
> initialize haptic device").
>=20
> Should the Fixes: tag point to 344ff3584957 ("HID: haptic: initialize
> haptic device") instead?

No. This commit removes try_module_get()/module_put(), and thus depends
on the current Fixes: commit.

Thanks,
Rong
