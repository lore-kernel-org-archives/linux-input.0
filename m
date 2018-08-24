From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
Date: Fri, 24 Aug 2018 11:49:33 +0300
Message-ID: <20180824084933.GA29856@jack.zhora.eu>
References: <20180823231013.254037-1-dbasehore@chromium.org>
 <20180823233028.GC53155@dtor-ws>
 <20180823233211.GD53155@dtor-ws>
 <20180823233424.GE53155@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180823233424.GE53155@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Derek Basehore <dbasehore@chromium.org>, Johnny Chuang <johnny.chuang@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, joe@perches.com, andi@etezian.org, gregkh@linuxfoundation.org, James Chen <james.chen@emc.com.tw>, KT Liao <kt.liao@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Hi Derek,

> > > On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
> > > > We only need to wait 10ms instead of 30ms before starting fastboot or
> > > > sending IAP on the touchscreen. Also, instead of delaying everytime
> > > > sw_reset is called, this delays 10ms in the function that starts
> > > > fastboot. There's also an explicit 20ms delay before sending IAP when
> > > > updating the firmware, so no additional delay is needed there. This
> > > > change also has the benefit of not delaying when wakeup is enabled
> > > > during suspend. This is because sw_reset is called, yet fastboot
> > > > isn't.

...

> > > > -	/*
> > > > -	 * We should wait at least 10 msec (but no more than 40) before
> > > > -	 * sending fastboot or IAP command to the device.
> > > > -	 */
> > > > -	msleep(30);
> > > > -

moving from 30 to 0 is a bit alarming... what does the datasheet
say?

Sometimes delays are implicit in the system where you are testing
the driver, so that without any msleep it might work in your
system but it might not on others.

> +             /*
> +              * We should wait at least 10 msec (but no more than 40) before
> +              * sending IAP command to the device.
> +              */
>               msleep(20);

I agree though that it's not nice to wait twice here (even though
as Dmitry says it doesn't hurt so much). Wouldn't it make more
sense to remove this msleep instead?
This way...

> +     /*
> +      * We should wait at least 10 msec (but no more than 40) before sending
> +      * fastboot command to the device.
> +      */
> +     usleep_range(10 * 1000, 11 * 1000);
> +
>       error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));

... you do not need to add an extra sleep here.

Andi
