Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794585232;
	b=NETiANiKpRENSidgmAo5taaRd7xw0O2y4gdG2ETX1T6AdBFChN2RZ+zxXU18koOf+iYp
	 PLqKiOKlXgvJLJUegXpFi2fpREX1uqSzlye3j0IapcCjdBMxr2K2+683Sp2UgQUL2d+wZ
	 /DjJvglTjGtZGa/4vicvb+/8fJ7+u8pO9FL7b5c5V2oRRQqKLYWt+ffheWTroJxu7XKGO
	 nCDZK9GfmZblGhotGcYXGGEKVd5xwhYlHzNINqXmQQzvzxaZM787vxtquV8CtLeMtwzBv
	 gVQMM3xUO7D57QxiogtiVee6BsbSztHFm10hYxgXLnrUKp87smYwcDLxYDfqmnRyqnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585232;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=XcWoVluvejfy6goOP0kALQEQw4mtKjYbJbV8gWTCIpo=;
	b=yL86DaXBCtPBI0OnkJLEhk8OxkDKjpPZYIydogp0DkjxkPXl5lnE6Mj2Mz4APp3B6MpV
	 tR7kGVw4VfZk62+BA/oQa3ldxG0QQodO8JE5dak6/65cXvmJRBlNFYE+2lR8Vh0hDUW70
	 bANKnYGfhyPhCwRj7TmOKfGRew+5yJEVyUEg97G0K97QVEEulYMBfy83Wb2ITgNmVQRrL
	 /OPNDGI4u4qPJNIfNUslFF+gs+fdzSobMX1Ra3D6XLnFNZgVUgAdnZI3BNVy5QkOff+lb
	 fIEBM5373FvqRiFzpEd8C8vd2mzGhVvn/Y20qpuxIyo/UCivDlJBUPsPscWAOSCM6wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=QYZB2biv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F8606A334;
	Fri, 13 Nov 2026 15:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D53F8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=QYZB2biv
ARC-Seal: i=1; a=rsa-sha256; t=1794585217; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tas54hvfU60KxHGwArBLdl9zT+G5xsO58mRfGoRESYJgTwCE1x2ZCACSDSjJ6z4VlzNF1LPoT6ylyY3LvDhiQA3vaqv/n5KSaURnqa7WcEMdlvfzs4MMPhsBazDTkq3xg4Z1Zy/o0K0n6woh7jkDTM3tHro/46hvjkIULc9rAwg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794585217; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XcWoVluvejfy6goOP0kALQEQw4mtKjYbJbV8gWTCIpo=; 
	b=B3y/UNhk1fg/t1PNNFLLbATR3c5+8qqE9uxkyhqfl62NAGOb1bBHWonwIJV4T3NR5n2zQqFtjFIT6okHMAuzGiG70ZzmHw9EBxyb7HZkwXAp4DHZpm/QspHGN+NXkmyPC0zXBJXQ5vj+orP3GBHTDmXhxxlGbRtz/VUdam+TrfQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=QYZB2bivIOrBLpRcIiTnFQikZJpchg+bfLYkq2dx3oko+yGUR4efJals0hzYakhua8NFzQOpSaQisFQ7qIDgBanAdTYDSBN3wlwHvDNLZPRKORDC5EetM7r9XZLT5TLEDQ90vchw6GJlzmNC2nZvrwo2hyh7qWcSEdbQaRzydLibeJLasWgpnBpWUAfyzmL1cByynfFc1RMRiVEOO8NfnBOn2KF0nrblrilBsDqq9zWhMSZRqy9IZsQ51AkMHx+GhdV6/f6j6LncqeiXrMWxmbmYIG3NI8am3ugV1sb1/ZBmTzCF7U7kqRR4CbTDswsUyp59c0AJekcqTyGFHV3qoQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=XcWoVluvejfy6goOP0kALQEQw4mtKjYbJbV8gWTCIpo=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794585215915172.50852571582186;
	Fri, 13 Nov 2026 07:53:35 -0800 (PST)
Message-ID: <4b1d3cd7d5d6ef4029285d0a7ddb79be7b7fd131.camel@rong.moe>
Subject: Re: [PATCH v3 2/9] HID: haptic: Get rid of input_ff_destroy() in
 error paths
From: Rong Zhang <i@rong.moe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>,  Angela Czubak <aczubak@google.com>, Henrik Rydberg
 <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
In-Reply-To: <f44447354f28c295e79a025bbcab7a4e@gmail.com>
References: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
		 <20261113-hid-haptic-kmod-v3-2-e7dfa8766c0d@rong.moe>
		 <f44447354f28c295e79a025bbcab7a4e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:48:18 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Dmitry,

On Thu, 2026-11-12 at 21:50 -0800, Dmitry Torokhov wrote:
> Hi Rong,
>=20
> On Fri, Nov 13, 2026 at 01:53:55AM +0800, Rong Zhang wrote:
> > It's painful to have error paths after calling input_ff_create(),
> > because input_ff_destroy() frees too much things but does not restore
> > some other things.
> >=20
> > On get_device failure, the module's bail-out path calls module_put()
> > right before hid_haptic_destroy() calling it again, causing refcount
> > underflow.
> >=20
> > Besides, every error path calling input_ff_destroy() frees ff->private,
> > while the others don't. This divergence has caused quite a lot of
> > trouble.
> >=20
> > Get the module and the device beforehand, so that there is no error pat=
h
> > after input_ff_create(), eliminating the call to input_ff_destroy(). In
> > this manner, we don't need to restore dev->flush and dev->event either.
>=20
> The only reason hid_haptic_init() had try_module_get(THIS_MODULE) and
> get_device(&hdev->dev) (and their counterparts in hid_haptic_destroy())
> was to work around input_ff_destroy() previously being called only from
> input_dev_release(), which could be deferred until after hdev was
> unbound or the driver module was unloaded if userspace kept the evdev
> node open.

Thanks for the clarification. Yeah, it was a painful design...

>=20
> I am queuing an input core change ("Input: destroy force-feedback device
> on input unregistration") [1] that calls input_ff_destroy() directly in
> __input_unregister_device() once all handlers are disconnected and the
> device is removed from sysfs.
>=20
> With that change in place, hid_haptic_destroy() is guaranteed to run
> synchronously during input_unregister_device() while hdev is still bound
> and alive (and dev->dev.parent already holds a reference to &hdev->dev
> anyway). That means get_device(&hdev->dev) / put_device(&hdev->dev) and
> try_module_get(THIS_MODULE) / module_put(THIS_MODULE) are not needed at
> all here (until patch 8/9 where hid-haptic becomes a separate plugin
> module and hid_plugin_get() is taken before calling self_plugin->init()),
> and simply dropping them eliminates the error path after
> input_ff_create(). It also avoids the devres lifetime issue with
> put_device(&hdev->dev) mentioned in patch 1/9.

Thanks for fixing the ff core and reviewing this series! The lifecycle of
ff does look much better with your patch.

I will follow your suggestion to simplify the fixes in the series and
resubmit it when your patch lands.

Thanks,
Rong

>=20
> [1] https://lore.kernel.org/linux-input/2f722967b6db0692d4dd4164aff39b62@=
gmail.com/
>=20
> Thanks.
