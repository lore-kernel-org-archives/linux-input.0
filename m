From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] Input: touchscreen: ads7846: copy info from pdata
 to private struct
Date: Mon, 06 May 2013 11:31:43 +0200
Message-ID: <5187787F.70206@gmail.com>
References: <1366889633-12577-1-git-send-email-zonque@gmail.com> <20130506032444.GD25084@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:51881 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab3EFJbb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 05:31:31 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so1496125bkc.18
        for <linux-input@vger.kernel.org>; Mon, 06 May 2013 02:31:30 -0700 (PDT)
In-Reply-To: <20130506032444.GD25084@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

Hi Dmitry,

On 06.05.2013 05:24, Dmitry Torokhov wrote:
> On Thu, Apr 25, 2013 at 01:33:52PM +0200, Daniel Mack wrote:
>> In preparation for DT bindings, we have to store all runtime information
>> inside struct ads7846. Add more variable to struct ads7846 and refactor
>> some code so the probe-time supplied pdata is not used from any other
>> function than the probe() callback.
>>
> 
> I think more common pattern is to allocate platform data structure when
> parsing device tree, often with devm_kzalloc() so it is cleaned up after
> driver is unbound.

That was exactly my first approach as well, but I refrained from it due
to the function pointers in the struct, which I didn't want to carry
around for the DT case as they will always be unused. So I don't know -
I can switch back to that if you still want me to.


Thanks,
Daniel

