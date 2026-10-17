Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C115E5BB;
	Sat, 17 Oct 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792243466; cv=none; b=HsaavNnucO9ir4fFFOBg0p2tfawMgBPE3pg8ABmOjSRU8JrPfAuLoE/hkr6yYOSpo0LGr9NPpw3VnMklvLR4t2xQ4RIHh72Dxn6PpezNoPZkozJT1Z0jvHX4QlPyQBr5D6t06AvReNntKn762srOFGa90krnyJjtA4jAArSNYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792243466; c=relaxed/simple;
	bh=eyYe93Pkua5D16EheUVtWTT7rgP4SfB2jGEauVe/DZY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F/Qp4XwdjtTZ98ROBTKnOFQ/5ErK9BZGEU6qD8VFxLJyUDY8HzRHNE8jJxeLm3/2h156vQz6E5dJVRU49a5PuV6UlkAQt+kmTVr1Qc9tsIiB+lZiuF1JPLCAK7dVhYQOFh8+2hdoSX5EjlfWJnqcYMjXzkDoGkfxf4MUsOJdEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geqyODWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geqyODWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7558A1F000C4;
	Sat, 17 Oct 2026 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792243465;
	bh=7vRV3b/DDylT6lNvECb9EAKBFw+ZakFgIuZrnpW9/6k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=geqyODWl8QVnaN5PIbhg8asATlFwlIddjdNcgkFQzHh9MZH4B28k0M5fCdrzWk3uq
	 aoviOJufeC94hhoFjzBGjo1nWUMtnlcbHF6NTy/p+Qu3WlPizz1YkzDNdXNoHo8fHh
	 uj7sDkGjMvoxKwyheFm36mGiUAdWSDrH2xkrwyeB8i/zJCQt0OBE6YVQ/61O00S8GB
	 PR/cBfJAHiuiHsV4bCPsKe5wn8cfKSvobkjnv5d0+VjpJqUNDZ4oIsdqHU0EWiFahe
	 ni0aaQHxztAPj5A68kL4zvl1/iBu+Hq+x1xk3jUlwwChsMOguvTB/Cv+abVvL1aXSx
	 y6bzyQfadYCrQ==
Date: Sat, 17 Oct 2026 15:24:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Silvan Jegen <s.jegen@gmail.com>
cc: kernel test robot <lkp@intel.com>, Vicki Pfau <vi@endrift.com>, 
    oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [hid:for-7.4/nintendo 2/5] drivers/hid/hid-nintendo.c:3993:undefined
 reference to `hid_is_usb'
In-Reply-To: <3HN3VLNWTGRM8.2HVANQO7V2MPM@homearch.localdomain>
Message-ID: <8q2ss5so-r679-247p-o8q3-pror0844p3nr@xreary.bet>
References: <202610171559.gZ0QBMFv-lkp@intel.com> <3HN3VLNWTGRM8.2HVANQO7V2MPM@homearch.localdomain>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 17 Oct 2026, Silvan Jegen wrote:

> Heyhey!
> 
> kernel test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.4/nintendo
> > head:   77c7155e2707ba5b1d56f3dc1acead48cf17f98d
> > commit: 9417132df63e5cd7230433af05198538e759f3ae [2/5] HID: nintendo: Add preliminary Switch 2 controller driver
> > config: i386-randconfig-1001-20261016 (https://download.01.org/0day-ci/archive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/config)
> > compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202610171559.gZ0QBMFv-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    ld: drivers/hid/hid-nintendo.o: in function `switch2_probe':
> > >> drivers/hid/hid-nintendo.c:3993:(.text+0x6cd7): undefined reference to `hid_is_usb'
> 
> I might be doing something wrong but I have checked out "for-7.4/nintendo"
> from the https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
> remote and my build finished without errors ...
> 
> So I'm not able to reproduce this issue locally.

Did you use config from

	https://download.01.org/0day-ci/archive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/config

? I am pretty sure the culprit is that USB_HID is unset. 

We'd need 'depends on USB_HID' for CONFIG_HID_NINTENDO.

-- 
Jiri Kosina
SUSE Labs

