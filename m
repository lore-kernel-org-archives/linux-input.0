From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] Input: touchscreen: ads7846: copy info from pdata
 to private struct
Date: Mon, 06 May 2013 12:34:23 +0200
Message-ID: <5187872F.3040301@gmail.com>
References: <1366889633-12577-1-git-send-email-zonque@gmail.com> <20130506032444.GD25084@core.coreip.homeip.net> <20130506102502.GX4945@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:55343 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3EFKeL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 06:34:11 -0400
Received: by mail-bk0-f53.google.com with SMTP id i18so1509031bkv.26
        for <linux-input@vger.kernel.org>; Mon, 06 May 2013 03:34:10 -0700 (PDT)
In-Reply-To: <20130506102502.GX4945@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

On 06.05.2013 12:25, Mark Brown wrote:
> On Sun, May 05, 2013 at 08:24:44PM -0700, Dmitry Torokhov wrote:
>> On Thu, Apr 25, 2013 at 01:33:52PM +0200, Daniel Mack wrote:
> 
>>> In preparation for DT bindings, we have to store all runtime information
>>> inside struct ads7846. Add more variable to struct ads7846 and refactor
>>> some code so the probe-time supplied pdata is not used from any other
>>> function than the probe() callback.
> 
>> I think more common pattern is to allocate platform data structure when
>> parsing device tree, often with devm_kzalloc() so it is cleaned up after
>> driver is unbound.
> 
> Both are used fairly widely.  It's very common to do the separate
> allocation when converting an existing driver to device tree as the code
> using the platform data is frequently written with lots of pdata-> in it
> and may potentially have some different behaviour if there's no platform
> data at all (though that's a bit questionable) so allocating a new
> struct is pretty natural and makes for a much less invasive patch.  When
> there's no existing platform data code it's probably more common to
> embed the structure as this saves an allocation and means that the users
> can assume that there's a platform data struct there which makes them a
> little simpler.

The driver as stands right now uses a balanced mix of the two, as some
variables are stored in pdata, some are copied over to the private
struct. So I had to opt for one of the two approaches, and the one I
submitted seemed saner to me, as pdata is eventually only accessed from
the probe() function.

But I can browse my reflog and switch back to the other approach if
that's preferred. The only concern I have is what I already mentioned:
the allocation of function pointers which are definitely unused for DT.


Thanks,
Daniel


