Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245531E520A;
	Thu,  5 Feb 2026 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770252071; cv=none; b=hDdHGHWPDI0mP/N15AM9hNIqju12jFh68hOrqR/D/h340ZoGHan0nFOdHS4FyZ3Pd5nryqc0zH5VyqvPlj/fVn9RJBL4+oA0Ftcj+eIzYgLHoPzBugP5Ph8FHmKAx7irjoQeZ/iKdS3ni+ISiIrm76i9MVLuRF2HAxmO+DRfwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770252071; c=relaxed/simple;
	bh=7cGTQaCFjZ3dYYsY/R4Uf7QNzEzCq2dsQDe0gU5zfc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKGaLQOFVr1M/W1CJmODtFkHzISGxdw3f9P9An5zCJqwkELsuPWjaDrbxnMX89WLXsQNbYUJDjd98d/N1YhtlRx+Pz7xNUDTQov/1Ank/OIz4pZRJf9DVn6ha9mHVL/CKTDXup0D/xy1Gjl3QEdX1gP/A2KZZ/6dUVQuLt2t3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn5Lobl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn5Lobl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EB8C19423;
	Thu,  5 Feb 2026 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770252070;
	bh=7cGTQaCFjZ3dYYsY/R4Uf7QNzEzCq2dsQDe0gU5zfc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gn5Lobl6y0EdSTn5w3ewhCIrlFsHRJqMSV/111Nwu3VKPhSOx/K0aVKygoSmZcIiK
	 LrNK7BgElm5qQHvS2Gr7EV+i+0PWOylgj2pDZU1EA15edLZ+Dk58QLPQ25SBqK/mXF
	 OqB9gt5kFtpLtr6kZxvQwt+bJXzGoe2zzDNLZf/vIC1CIQ5T5ibdbylABf7bsnWDxU
	 DkJGKMtlwbRZh+bicjIZXCQRjC7D0zLiLegyHIRvrUbWXTpYIvvDypGqBrQuKsruvF
	 WMPhIYXTPsvN1FnL6Db0fH3Xw4YwPCU2LWjMgqcFd44WSV5p11FKPG0A1DJFlB/v82
	 FUiMZr3dW7hdQ==
Date: Wed, 4 Feb 2026 17:41:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Tomasz =?utf-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	jikos@kernel.org, bentiss@kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, oleg@makarenk.ooo,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: pidff: Fix condition effect bit clearing
Message-ID: <20260205004106.GA2386589@ax162>
References: <20260204133138.475880-1-tomasz.pakula.oficjalny@gmail.com>
 <202602050440.e5LEMod6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602050440.e5LEMod6-lkp@intel.com>

On Thu, Feb 05, 2026 at 05:07:56AM +0800, kernel test robot wrote:
> Hi Tomasz,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on hid/for-next]
> [also build test WARNING on linus/master v6.19-rc8 next-20260204]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Tomasz-Paku-a/HID-pidff-Fix-condition-effect-bit-clearing/20260204-213418
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
> patch link:    https://lore.kernel.org/r/20260204133138.475880-1-tomasz.pakula.oficjalny%40gmail.com
> patch subject: [PATCH v2] HID: pidff: Fix condition effect bit clearing
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260205/202602050440.e5LEMod6-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602050440.e5LEMod6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602050440.e5LEMod6-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/hid/usbhid/hid-pidff.c:1456:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
>     1456 |                 if (test_and_clear_bit(FF_SPRING, dev->ffbit)   |
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     1457 |                     test_and_clear_bit(FF_DAMPER, dev->ffbit)   |
>          |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     1458 |                     test_and_clear_bit(FF_FRICTION, dev->ffbit) |
>          |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                                                 ||
>     1459 |                     test_and_clear_bit(FF_INERTIA, dev->ffbit))
>          |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/hid/usbhid/hid-pidff.c:1456:7: note: cast one or both operands to int to silence this warning
> >> drivers/hid/usbhid/hid-pidff.c:1456:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
>     1456 |                 if (test_and_clear_bit(FF_SPRING, dev->ffbit)   |
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     1457 |                     test_and_clear_bit(FF_DAMPER, dev->ffbit)   |
>          |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                                                 ||
>     1458 |                     test_and_clear_bit(FF_FRICTION, dev->ffbit) |
>          |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/hid/usbhid/hid-pidff.c:1456:7: note: cast one or both operands to int to silence this warning
> >> drivers/hid/usbhid/hid-pidff.c:1456:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
>     1456 |                 if (test_and_clear_bit(FF_SPRING, dev->ffbit)   |
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                                                 ||
>     1457 |                     test_and_clear_bit(FF_DAMPER, dev->ffbit)   |
>          |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/hid/usbhid/hid-pidff.c:1456:7: note: cast one or both operands to int to silence this warning
>    3 warnings generated.

As the use of the bitwise operation is intentional here per the comment,
I think going back to v1 to avoid introducing this warning would be
better than casting one of these operands to int to silence it with the
v2 structuring of the code. v1 matches what I have done elsewhere in the
kernel to make it obvious that each function should be called (without a
comment):

  2e70570656ad ("drm/i915: Avoid bitwise vs logical OR warning in snb_wm_latency_quirk()")
  a02dcde595f7 ("Input: touchscreen - avoid bitwise vs logical OR warning")

Cheers,
Nathan
