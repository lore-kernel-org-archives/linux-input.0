Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82164447243;
	Mon, 19 Oct 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394201; cv=none; b=qroLPiNzJ3I6zaSusmAU2qd3TsXisQUvMPjDq9VPy4gq+3jIG3HQG5q6d+6WDo78o4qo1C2CD8WwjV/rVKGoeJlWcrz+qzI1kBr7zuiARi+F3NKOYlTPuSVDMPEb8DRvHFXfqDshalwqzqmWxmHb2nZNeX9VWT6IZBvv2NM/Gws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394201; c=relaxed/simple;
	bh=9QYA1E/vDGBagW/6eYdKGzJivkJ5436ehhNWaIE1AMI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pesxRSxEN/L4GJLzOfDdlaGFvh1e0JWsDuImMRK6FzG++KCAVp6cu0EpgSlmZxYiHFAHx8ezT0/frr78fqOZTqHyF+wnZv9W21poSn/4gLqeIJOLWdwuFA1TrXsECwsr3Vyo4/2ROs1fslut886TbLohRsea09r5I9F4CfeUGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2AZSPpW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2AZSPpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596F61F000C4;
	Mon, 19 Oct 2026 07:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394199;
	bh=cWCgkN2I/0fVOIk1m2O3269S/Vu1y53lkfHljtHOuL4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Y2AZSPpWvybxFrnHUHbNxpNNmrg0leHLUM6uZtM/Pb+K/UYqo66L90UQ3b0GlACjt
	 NldTHpNgVVJZKsE3sZwksGpmklYh6NmM6zFslCIKfR6UtQnBHfkeD3Qcd3LOKVYhh2
	 xjYbDdeTVVEZ1gjpJeESOHI33AZDLOeVDWn/liwjAEG1lIgGdlQA0jesf+8nwSvqn0
	 ZMz8vkmciFTgSdBaIrmr4LqC5q30GSuZxj+SAg6ky1YDXQUnRov5XS7BJdZKpe+u9h
	 drCnJc0QXCign94G+zDCYpQyepAlECr0OtaIXn1z1JQ3JabzgakC69XmOUXWVNCETQ
	 700S6LfjT77Lg==
Date: Mon, 19 Oct 2026 09:16:36 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Silvan Jegen <s.jegen@gmail.com>
cc: kernel test robot <lkp@intel.com>, Vicki Pfau <vi@endrift.com>, 
    oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [hid:for-7.4/nintendo 2/5] drivers/hid/hid-nintendo.c:3993:undefined
 reference to `hid_is_usb
In-Reply-To: <224MMXDV49Y20.3OGRUP8M1CBFH@homearch.localdomain>
Message-ID: <999rr212-sp54-sr2n-6pp7-rq9o69463677@xreary.bet>
References: <202610171559.gZ0QBMFv-lkp@intel.com> <3HN3VLNWTGRM8.2HVANQO7V2MPM@homearch.localdomain> <8q2ss5so-r679-247p-o8q3-pror0844p3nr@xreary.bet> <224MMXDV49Y20.3OGRUP8M1CBFH@homearch.localdomain>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 17 Oct 2026, Silvan Jegen wrote:

> > Did you use config from
> > 
> > 	https://download.01.org/0day-ci/archive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/config
> > 
> > ? I am pretty sure the culprit is that USB_HID is unset. 
> 
> Ah, I missed that this config was used.
> 
> USB_HID is indeed unset in this config.
> 
> 
> > 
> > We'd need 'depends on USB_HID' for CONFIG_HID_NINTENDO.
> 
> Yes, that makes sense!
> 
> I'm not familiar with the correct process in this case. Should Vickie
> write a patch based on the
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.4/nintendo
> 
> branch or will you fix it up on your side?

I will push a fix later today.

-- 
Jiri Kosina
SUSE Labs

