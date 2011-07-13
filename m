From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] Input: intel-mid-touch - remove pointless checking for
 variable 'found'
Date: Wed, 13 Jul 2011 21:06:02 +0800
Message-ID: <CAF+7xW=GfZsgH8JSzCt0pbtV7Wmfe4pDKJiO=Nx-Z2S0XDdZ3Q@mail.gmail.com>
References: <1310454831.16511.1.camel@phoenix> <20110713065737.GA4201@core.coreip.homeip.net>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52221 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab1GMNGW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2011 09:06:22 -0400
In-Reply-To: <20110713065737.GA4201@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Sreedhara Murthy. D.S" <sreedhara.ds@intel.com>, linux-input@vger.kernel.org, Alan Cox <alan@linux.intel.com>

2011/7/13 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Tue, Jul 12, 2011 at 03:13:51PM +0800, Axel Lin wrote:
>> The implementation does break from the for loop after we assign i to variable
>> 'found'.
>>
>
> Hmm, if we are cleaning this up what about the following?
>
hi Dmitry,
It looks good and better.

Thanks,
Axel
