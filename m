From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Support for touch controller ILI2511: Integrate into ili210x or
 new driver ?
Date: Fri, 2 Feb 2018 12:06:17 -0800
Message-ID: <20180202200617.3z2fcfqgpilkkkjk@dtor-ws>
References: <92137959-654f-79f9-e15f-d9bed2185518@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:45606 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbeBBUGU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Feb 2018 15:06:20 -0500
Received: by mail-pg0-f54.google.com with SMTP id m136so14532490pga.12
        for <linux-input@vger.kernel.org>; Fri, 02 Feb 2018 12:06:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <92137959-654f-79f9-e15f-d9bed2185518@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Olivier Sobrie <olivier@sobrie.be>

Hi Stefan,

On Fri, Feb 02, 2018 at 05:03:10PM +0100, Stefan Roese wrote:
> Hi,
> 
> I'm currently working on supporting the Ilitek ILI2511 touch controller
> in mainline. The 2 choices I have are:
> 
> a) Try to integrate the ILI2511 support into the existing ili210x
>    driver
> 
> or
> 
> b) Create a new driver for ILI2511 which might be suitable for other /
>    future Ilitek controller
> 
> Looking at alternative a), ili210x seems to be pretty unused and in not
> real good shape (only supporting platform-data, not using devm_ calls,
> not using threaded interrupts etc...). I could enhance this driver but
> my main concern here is, that I have no chance to test this driver on
> the currently supported chips.
> 
> Alternative b) sounds more promising to me. Especially since ILI2511
> supports touch protocol v3.x (Ilitek naming), which is quite different
> from the currently supported protocol.
> 
> What's your recommendation here? Is it okay to go with adding a new
> driver, perhaps named something like ili2xxx?

It all depends on how much code can be shared. If protocol is
sufficiently different I do not see why it can't be a separate driver.

OTOH we do not have any users of ili210x in mainline, so I would not
worry too much if we break it - interested parties should have been
working on upstreaming the rest of their code if it is important to
them. I'll gladly take patches converting to devm, dropping platform
data support, using generic device properties, etc.

Thanks.

-- 
Dmitry
