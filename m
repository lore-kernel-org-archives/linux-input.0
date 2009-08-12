From: "Ba, Zheng" <zheng.ba@intel.com>
Subject: RE: FW: [PATCH 1/1] input: keypad controller driver for Intel low
 power Moorestown platform
Date: Wed, 12 Aug 2009 17:25:46 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C17709DB43A65C@pdsmsx502.ccr.corp.intel.com>
References: <61563CE63B4F854986A895DA7AD3C177159F83C1@pdsmsx502.ccr.corp.intel.com>
 <20090507164516.GA6450@dtor-d630.eng.vmware.com>
 <61563CE63B4F854986A895DA7AD3C17709DB43A635@pdsmsx502.ccr.corp.intel.com>
 <200908121106.40691.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14692 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbZHLJ0f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2009 05:26:35 -0400
In-Reply-To: <200908121106.40691.marek.vasut@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Marek,

Can you tell me where the correct location for such keymapping in userspace is and how I can re-use your matrix driver for our keypad?

Thanks,
Zheng

-----Original Message-----
From: Marek Vasut [mailto:marek.vasut@gmail.com] 
Sent: Wednesday, August 12, 2009 5:07 PM
To: Ba, Zheng
Cc: Dmitry Torokhov; linux-input@vger.kernel.org
Subject: Re: FW: [PATCH 1/1] input: keypad controller driver for Intel low power Moorestown platform

Dne St 12. srpna 2009 10:45:08 Ba, Zheng napsal(a):
> Hi Dmitry,
>
> Here's the second version with changes inline per your comments, please
> help review. Thanks!
>
> Thanks,
> Zheng
>

Hi!

just a quick skim over the code revealed a few things:

1) cant you make the NumLk and Fn keys into normal keys (therefore getting rid 
of those three keymaps) and make the keymap stuff in userspace?

2) cant you just use the GPIO-driven matrix keypad driver instead of this?

Cheers!
