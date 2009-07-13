From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input: Add depends on support for w90p910 ts.
Date: Mon, 13 Jul 2009 11:58:21 +0800
Message-ID: <4A5AB0DD.8070801@gmail.com>
References: <4A56024F.4060500@gmail.com> <20090713034851.GF10819@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:19206 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZGMD62 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jul 2009 23:58:28 -0400
Received: by wa-out-1112.google.com with SMTP id j5so371125wah.21
        for <linux-input@vger.kernel.org>; Sun, 12 Jul 2009 20:58:27 -0700 (PDT)
In-Reply-To: <20090713034851.GF10819@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Dear Dmitry,

I have added this selection of HAVE_CLK in my ARCH located in /arch/arm/Kconfig.

Thanks for your help.

> Hi Wan,
> 
> On Thu, Jul 09, 2009 at 10:44:31PM +0800, Wan ZongShun wrote:
>> Dear Dmitry,
>>
>> Add depends on support for w90p910 ts.
>>
> 
> Since it compiles just fone on other arches that have HAVE_CLK I think I
> will just leave that dependency. Please adjust your arch to sleect
> HAVE_CLK.
> 
> Thanks!
> 

