From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Event number sequence
Date: Mon, 22 Feb 2010 10:42:46 -0800
Message-ID: <20100222184245.GB5233@core.coreip.homeip.net>
References: <cb8016981002220846i19399989r946d33cc26d81fe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:34866 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab0BVSnA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2010 13:43:00 -0500
Received: by fg-out-1718.google.com with SMTP id e21so560720fga.1
        for <linux-input@vger.kernel.org>; Mon, 22 Feb 2010 10:42:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cb8016981002220846i19399989r946d33cc26d81fe2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Abraham Arce <abraham.arce.moreno@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Abraham,

On Mon, Feb 22, 2010 at 10:46:28AM -0600, Abraham Arce wrote:
> Hi,
> 
> I have tested the insertion/removel of 2 different drivers (keyboard
> and touchscreen), what I have seen is that the sequence in the number
> of the event is always different aty the time of registering them, I'd
> expect that if I remove a module, the event number is freed, making it
> available for the next time but this is not the case
>

The number you are referring to is not "event number" but just a part of
input device name. It always monotonically increases and is not stable
across reboots.
 
> My output looks like
> 
> #insmod myinputdriver.ko
> /class/input/input0
> #rmmod myinputdriver.ko
> #insmod myinputdriver.ko
> /class/input/input1
> #rmmod myinputdriver.ko
> 
> Is there any specific function from the input subsystem to free it?

No, as we do not track these numbers there is no way to "free" it.

> Do
> we have a limitation on the input subsystem?
> 

Not that I can see (at least not in this particular area ;) ). It would
be helpful to know what kind of issue you are trying to solve.

-- 
Dmitry
