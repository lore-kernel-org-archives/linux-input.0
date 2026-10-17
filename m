Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720729B8E1
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245315; cv=none; b=RSRStPpHGIedTRWVu3HzUGZINI/GKo5ITU/Y5Yj+IFV+KerXNwu7wlAan1TgnzKwo5ffiRPjXtcxutHvIVIRULcKxnbmpYFqxr2ptY3S58J+jz3iEn2U+xFOoa8QHGYvXeCpF1+lj+GLIsH0Flt5MBAe7kib7SYIBV+cYtv9ZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245315; c=relaxed/simple;
	bh=4vjgZxzNPTAZHH02uX5JMn+P9yfz6UWbm6ZGNahBpXc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=Oo5XAlok3L/HNPyE9pEB5XnC7CFBwXvwJfIoOiBjrOoH7iSFPjjJaA3NFz8i8nNR83YKUw3v/NVFrgldShsBVcSX1romuEqNmDA9hMf6MLnlAnTRdWwCReAOg9Wb848u7XEDOOXMxmR+Kyam+VwIXW1mqsorepCNDymsDmooYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWNjmBjg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWNjmBjg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso8786175e9.2
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792245311; x=1792850111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BRTQKQ5kOU9+3bYuMCJgO7+zXnOskPhFNRjGsPpvAak=;
        b=HWNjmBjgtKzD0j+F8hqnvnUA2evhSSI6JOV4xinDYTdTj+m2LWtMjEnClhqxzO2BrW
         O++wZamx5UMIhlWL4kvTiRbWR/ZMw5ES8ltUyMt7lMrLHfp34h738zL7UH+VpgBDAgCz
         r4aI1dTuxS2ds25z/mqgDkjmvmS3zCl+j8kaY4kJWBD4pmdb3yNCboRX74oqrzlCqig1
         X0QUJsV0EdGwgmYldbF/wa+geco61qbaxJNOvHt6xl2nIfod24J+gztvSIAsH3v53Cia
         fAvrpibZh0wOtjU2hiDJ0zrVmkbd6JwTRgX3VTJtnxqBOMrJ+zS8+FkIkTWWxG8/vTEh
         peuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245311; x=1792850111;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRTQKQ5kOU9+3bYuMCJgO7+zXnOskPhFNRjGsPpvAak=;
        b=z7UP0pP08gnrDn6QMuCMqqFDXie51iwf6foHOOJ69G4MuGbiwtb5QQTGpselL9xoeb
         3J8DHEiv4de839NdjU4s/649wKC+HF6LEZ4jIqdUxFnXNp7FLRCe1DRHDjDP5DaMFGU5
         fGxI1Q6zmYdibOfZULlz0/AM4AwERWuurvZ6spPMAsFt9CqTEcd3srHQTmxtBh/y/A36
         JA/AJslVzxSxR7xbflZTthd7LzJ0eyDNBjBuN34iBwVAmvf0nWqT6YzJbNTevjHueE/D
         3gj/QzgWVMRM0ctXq4HkM9NHyFWKP7quivTRkelOjjBirLBBGJgl2jnoc6PfLTChLr3z
         68cg==
X-Forwarded-Encrypted: i=1; AKwUvBwRSjIuZjvXxicVqHWvnDLKy3vq5Pd9XJkve91kJqMbdW2sd494XSqqVCnU0F95xq+snwYlLHP2N42cZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLbt2IILXylGJxCRx8rnhd2O4OAPhskRQdbZArd4Hs9KJXb2f5P
	qmoU9x25ta9NyJFnwyWX+mFutPMR+qTDCuTKGInvVa3KEdW2i5A53zCZ
X-Gm-Gg: AYBFou1iZHI0VLNZA8nvI7PNbXzpk1lIRkh3Sc8EMORxaT51FpOrqj0YKR04YjqbK96
	GSMGoY8BqGMYxN0RsIp+T5rW5m5iaXNttJFHP+jRUvjgthwadsUGhXchnjCytAVoLUhMAdJATe6
	JxDHPzevH4b/J/Z/CDIyVfto4vgSEG2L4sAPD+N8aTm3Os/ZWtGKuJ+zOyMoExUhpOxSSWd1/Im
	bRrQ/2z5nH1+H8ZHDZHUsYDAFZ0T45mhdcypqE+LnYMMUkx/r8yQfKKS8cd8Cj/DlGxhLac216J
	89n8tHAyhv37w+5VsJC7nIpBoOJxHkl8VbhZJglcK1737EdwBu0sVgayQrYtCsDColkR+onNbLm
	jtbSa/WAWA/+r8zmiNGgNugzHwsyCfLJXPBodernrvJBEe+xjqX5LnGqIpGpAmOX9MdmcU/2U3K
	to58KVDkvo8KQQauDfllBDFI3tP6QTfRkvt3NG66gjoSS8/Kf/G92i5CuKm5TY849t/FUSUpdp
X-Received: by 2002:a05:600c:3508:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4a1d762251bmr59162435e9.32.1792245310684;
        Sat, 17 Oct 2026 06:55:10 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc952d63sm52702875e9.2.2026.10.17.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:55:10 -0700 (PDT)
Date: Sat, 17 Oct 2026 15:55:09 +0200
To: Jiri Kosina <jikos@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Vicki Pfau <vi@endrift.com>,
 oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [hid:for-7.4/nintendo 2/5]
 drivers/hid/hid-nintendo.c:3993:undefined reference to `hid_is_usb
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <202610171559.gZ0QBMFv-lkp@intel.com>
 <3HN3VLNWTGRM8.2HVANQO7V2MPM@homearch.localdomain>
 <8q2ss5so-r679-247p-o8q3-pror0844p3nr@xreary.bet>
In-Reply-To: <8q2ss5so-r679-247p-o8q3-pror0844p3nr@xreary.bet>
Message-Id: <224MMXDV49Y20.3OGRUP8M1CBFH@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jiri Kosina <jikos@kernel.org> wrote:
> On Sat, 17 Oct 2026, Silvan Jegen wrote:
>=20
> > Heyhey!
> >=20
> > kernel test robot <lkp@intel.com> wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git f=
or-7.4/nintendo
> > > head:   77c7155e2707ba5b1d56f3dc1acead48cf17f98d
> > > commit: 9417132df63e5cd7230433af05198538e759f3ae [2/5] HID: nintendo:=
 Add preliminary Switch 2 controller driver
> > > config: i386-randconfig-1001-20261016 (https://download.01.org/0day-c=
i/archive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/config)
> > > compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/reproduce)
> > >=20
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202610171559.gZ0QBMFv=
-lkp@intel.com/
> > >=20
> > > All errors (new ones prefixed by >>):
> > >=20
> > >    ld: drivers/hid/hid-nintendo.o: in function `switch2_probe':
> > > >> drivers/hid/hid-nintendo.c:3993:(.text+0x6cd7): undefined referenc=
e to `hid_is_usb'
> >=20
> > I might be doing something wrong but I have checked out "for-7.4/ninten=
do"
> > from the https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
> > remote and my build finished without errors ...
> >=20
> > So I'm not able to reproduce this issue locally.
>=20
> Did you use config from
>=20
> 	https://download.01.org/0day-ci/archive/20261017/202610171559.gZ0QBMFv-l=
kp@intel.com/config
>=20
> ? I am pretty sure the culprit is that USB_HID is unset.=20

Ah, I missed that this config was used.

USB_HID is indeed unset in this config.


>=20
> We'd need 'depends on USB_HID' for CONFIG_HID_NINTENDO.

Yes, that makes sense!

I'm not familiar with the correct process in this case. Should Vickie
write a patch based on the

https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.4/nintend=
o

branch or will you fix it up on your side?

Cheers,
Silvan
