From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/14] Input: atmel_mxt_ts - do not pass suspend mode in
 platform data
Date: Thu, 15 Mar 2018 16:56:21 -0700
Message-ID: <20180315235621.GA60361@dtor-ws>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-2-dmitry.torokhov@gmail.com>
 <20180314205123.GA26353@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314205123.GA26353@lava.h.shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 14, 2018 at 08:51:24PM +0000, Nick Dyer wrote:
> Hi Dmitry-
> 
> Thanks for sending these patches!
> 
> On Mon, Mar 12, 2018 at 12:08:54PM -0700, Dmitry Torokhov wrote:
> > The way we are supposed to put controller to sleep and wake it up does not
> > depend on the platform, but rather on controller itself. Controllers using
> > T9 require manipulating T9 control register, while others, using newer
> > T100, should be put to sleep by adjusting T7 power config.
> 
> I'm afraid this is actually a misconception. If you look at object table
> for the older T9 device, you'll find it has the T7 object and it in fact
> works exactly the same way as the T100-based device.
> 
> The MXT_SUSPEND_T9_CTRL is in there because on your older Pixel devices
> the config saved into NVRAM on the touch controller has a zero byte in
> the T9 CTRL setting, meaning the touch controller will never wake up
> unless the driver knows to write 0x83 into it.

Ah, OK, I see. I would really like to drop this pdata->suspend_mode
stuff and I do not want to create "pixel-screwed-up" property either...
I guess for the time being I'll put a DMI quirk for Link to restore T9
control method, and then look into cleaning it all up. We have quite a
bit different code in chromeos kernel trees and I'd like to reconcile
it.

Thanks.

-- 
Dmitry
