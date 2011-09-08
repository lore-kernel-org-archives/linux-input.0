From: "Hans J. Koch" <hjk@hansjkoch.de>
Subject: Re: Driver support for TI's quadrature encoder module
Date: Thu, 8 Sep 2011 17:18:17 +0200
Message-ID: <20110908151817.GA4064@local>
References: <B85A65D85D7EB246BE421B3FB0FBB593025743EEE8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.hansjkoch.de ([178.63.77.200]:38009 "EHLO www.hansjkoch.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148Ab1IHXEG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Sep 2011 19:04:06 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593025743EEE8@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: linux-kernel <linux-input@vger.kernel.org>, "daniel@caiaq.de" <daniel@caiaq.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "gregkh@suse.de" <gregkh@suse.de>, "hjk@hansjkoch.de" <hjk@hansjkoch.de>

On Thu, Sep 08, 2011 at 06:57:04PM +0530, AnilKumar, Chimata wrote:
> Hi All,
> 
> I am developing a driver for TI's enhanced Quadrature Encoder Pulse
> (eQEP) module. Details of the module at
> http://www.ti.com/lit/ug/sprufu8/sprufu8.pdf
> 
> Little description about the module:-
> 
> This module is used for direct interface with a linear or rotary
> incremental encoder.
> 
> Main features of the module:
> a. Provides the direction of the motor (clock or anti-clock)
> b. Provides position count values, which can be used to compute speed
>    of a machine (motor/generator)
> c. Generate a sync output from position compare sub-module
> d. Can be used for High & Low speed measurements
> 
> This module has 4 inputs from external rotary/linear encoder.
> a. Input A (Input from external rotary encoder, a pulse train)
> b. Input B (Input from external rotary encoder, a pulse train)
> c. Index Event (Input from external rotary encoder, a index event.
>    This can be used as output, which can be generated after
>    position compare)
> d. Strobe Event (Input from external rotary encoder, a strobe event.
>    This can be used as output, which can be generated after
>    position compare)
> 
> The module provides pre-analyzed data based on the above four input
> signals. We can use the data directly for knowing the position and
> direction details.
> 
> I have few questions related to this:-
> 
> 1. What subsystem this driver fit into? Input subsystem or UIO
> subsystem?

That depends on which bus your module appears. If it looks like
memory that can be mapped to userspace, then UIO could be the
right subsystem. If it has an i2c, spi, usb or similar interface,
then UIO is not the right choice.

You should also look for similar drivers already in the kernel.
Have a look at the IIO subsystem that is under development in
staging. It was designed for things like that. If there already is
a subsystem that handles similar devices, then it should be
preferred over UIO.

Thanks,
Hans

