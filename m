From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: FW: [PATCH 1/1] input: keypad controller driver for Intel low power Moorestown platform
Date: Wed, 12 Aug 2009 11:06:40 +0200
Message-ID: <200908121106.40691.marek.vasut@gmail.com>
References: <61563CE63B4F854986A895DA7AD3C177159F83C1@pdsmsx502.ccr.corp.intel.com> <20090507164516.GA6450@dtor-d630.eng.vmware.com> <61563CE63B4F854986A895DA7AD3C17709DB43A635@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:36730 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbZHLJHB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2009 05:07:01 -0400
Received: by yxe5 with SMTP id 5so5469929yxe.33
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2009 02:07:02 -0700 (PDT)
In-Reply-To: <61563CE63B4F854986A895DA7AD3C17709DB43A635@pdsmsx502.ccr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Ba, Zheng" <zheng.ba@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

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
