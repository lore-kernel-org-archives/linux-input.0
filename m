From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] input:Add clk api support for w90p910 touchscreen
Date: Thu, 09 Jul 2009 17:00:39 +0800
Message-ID: <4A55B1B7.3090802@gmail.com>
References: <4A555B9E.8060508@gmail.com> <20090709051143.GA14516@dtor-d630.eng.vmware.com> <4A557CBC.3000507@gmail.com> <20090709062929.GD14516@dtor-d630.eng.vmware.com> <20090709073703.GA1785@jasper.tkos.co.il> <20090709085436.GE14516@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:55958 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758465AbZGIJAr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 05:00:47 -0400
Received: by rv-out-0506.google.com with SMTP id f6so3843rvb.1
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2009 02:00:46 -0700 (PDT)
In-Reply-To: <20090709085436.GE14516@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

Dear Dmitry,

>>> Umm, one more thing - we need to add "depends on" to Kconfig since
>>> clk API is not implemented on every platform. Any ideas what is the
>>> most wide dependency is?
>> The most wide dependency for the clk API is HAVE_CLK.
>>
> 
> Cool, thanks.
> 
Sure, but why to add it to touchscreen's kconfig?
it seems it should be put arch/arm/kconfig.

In addition,I never use this HAVE_CLK in ARCH_W90X900, 
only using COMMON_CLKDEV to support clk API. 
