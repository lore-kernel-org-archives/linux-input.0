From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] Input/Joystick Driver: add support AD7142 joystick driver
Date: Wed, 26 Mar 2008 03:47:28 -0700
Message-ID: <386072610803260347l4dd3b82cr1704b6a0a79d6ed8@mail.gmail.com>
References: <1206579622-21915-1-git-send-email-cooloney@kernel.org>
	 <20080326101850.GA9184@ahaupt-debian-vm.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:4717 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbYCZKrc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Mar 2008 06:47:32 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2715747wra.1
        for <linux-input@vger.kernel.org>; Wed, 26 Mar 2008 03:47:28 -0700 (PDT)
In-Reply-To: <20080326101850.GA9184@ahaupt-debian-vm.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andre Haupt <andre@bitwigglers.org>
Cc: dmitry.torokhov@gmail.com, khali@linux-fr.org, linux-input@vger.kernel.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <bryan.wu@analog.com>

>  > diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
>  > index 7c662ee..e65aeb6 100644
>  > --- a/drivers/input/joystick/Kconfig
>  > +++ b/drivers/input/joystick/Kconfig
>  > @@ -282,4 +282,10 @@ config JOYSTICK_XPAD_LEDS
>  >         This option enables support for the LED which surrounds the Big X on
>  >         XBox 360 controller.
>  >
>  > +config JOYSTICK_AD7142
>  > +     tristate "Analog Devices AD7142 Joystick support"
>  > +     depends on BLACKFIN && I2C
>  does this really have to depend on Blackfin?
>
>  regards,
>
>  Andre
>

Right, I think it is ok for other architecture, while I only tested on Blackfin.
I will remove this depends.

Thanks
-Bryan
