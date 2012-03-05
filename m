From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] Input: cyttsp - Fix check after pointer dereferencing
Date: Mon, 5 Mar 2012 08:26:30 +0100
Message-ID: <CABxcv==9V0kB4nhGadQB8Qck+p9hg6_goSkrOwvPik-X+H1V=g@mail.gmail.com>
References: <1329302572-1651-1-git-send-email-javier@dowhile0.org>
	<20120304154140.GA27647@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:51817 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755976Ab2CEH0b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Mar 2012 02:26:31 -0500
Received: by obbuo6 with SMTP id uo6so3767525obb.19
        for <linux-input@vger.kernel.org>; Sun, 04 Mar 2012 23:26:30 -0800 (PST)
In-Reply-To: <20120304154140.GA27647@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <martinez.javier@dowhile0.org>

On Sun, Mar 4, 2012 at 4:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Javier,
>
> On Wed, Feb 15, 2012 at 11:42:52AM +0100, Javier Martinez Canillas wrote:
>> From: Javier Martinez Canillas <martinez.javier@dowhile0.org>
>>
>> In the cyttsp_probe() function the struct device *dev pointer was
>> dereferenced before checking if it was NULL.
>>
>> Now dev is never NULL since both I2C and SPI bus drivers pass a pointer to a
>> member of an previously allocated structure. But others bus drivers can do
>> it differently so is better to sanity check instead of trust in the callers.
>>
>
> I already have a patch that simply removes the checks ofr dev and
> bus_ops - cyttsp_probe is only called by bus-specific code and they are
> not coming form platform data so there is no chance they will be NULL.
> And anyone writing a new bus intefcae will get a nice oops first time
> they try loading the module so they'll see the problem right away too.
>
> Thanks.
>
> --
> Dmitry

Yes, I agree with you. Since cyttsp_probe is only called by bus
specific code, removing the checks is better.

Thanks and best regards,
Javier
