From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wdt87xx_i2c - support new body WDT8752
Date: Fri, 7 Oct 2016 16:46:01 -0700
Message-ID: <20161007234601.GA22149@dtor-ws>
References: <1470219398-10892-1-git-send-email-hn.chen@weidahitech.com>
 <CAKdAkRRH=2ifEs0O8WjNqYUKOcLS6Nigiw=vq2SAB-XKF_7v7g@mail.gmail.com>
 <22498D53301C4D4A8FFA8F02C7C3C7C06DDD7D42@mail02.WHT.local>
 <20160905135545.GL21864@mail.corp.redhat.com>
 <22498D53301C4D4A8FFA8F02C7C3C7C06DDD7F58@mail02.WHT.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22498D53301C4D4A8FFA8F02C7C3C7C06DDD7F58@mail02.WHT.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Hn,

On Tue, Sep 06, 2016 at 11:47:39AM +0000, Hn Chen wrote:
> Hi Benjamin,
> 
> Sorry for my poor English and leading you misunderstanding.
> 
> The FW of WDT8752 can support HIDI2C for Windows products. And then we develop this driver.
> So we "borrowed" something from HIDI2C.
> What I try to mention here is that this driver utilize a part of existed protocol from HIDI2C.
> We thought that the size of FW can be shrunk in that way.
> 
> So, basically, this is still a linux i2c driver with some protocols similar to HIDI2C.

If you already have hardware and firmware that supports HIDI2C, why not
continue using it? Linux's hid-multitouch driver should be able to
handle Win-compatible touchscreens out of the box (or maybe with a small
quirk).

What are the features that require the brand new driver?

Thanks.

> 
> BR,
> Hn.chen
> 
> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com] 
> Sent: Monday, September 05, 2016 9:56 PM
> To: Hn Chen
> Cc: Dmitry Torokhov; linux-input@vger.kernel.org; lkml
> Subject: Re: [PATCH] Input: wdt87xx_i2c - support new body WDT8752
> 
> Hi HN,
> 
> On Sep 05 2016 or thereabouts, Hn Chen wrote:
> > Hi Dmitry,
> > 
> > >> Considering to be compatible with i2c-hid, WDT8752 has the same way 
> > >> in enumerating device.
> > >If it is a HID device then I think you should write a HID driver for it (unless existing driver, such as hid-multitouch can already handle it, possibly >with some changes). I'm addng Benjamin to he can comment as well.
> > The device can be handled by i2c-hid driver (HID over I2C) already but this proprietary driver still is a must-have for more features.
> 
> Then what are those must-have features? From what I can read, only the reflashing firmware is part of it. Unless there is something else, I really don't understand why you can't have a hid-weidatech driver that could handle the specific bits while leaving the rest to i2c-hid.
> 
> Also, I am not sure if your driver doesn't interfere with i2c-hid as you are claiming the device through the ACPI ID "WDHT0001" but there should be some PNP IDs "PNP0C50" if it were declared as i2c-hid. If both are set, then the fact your driver is picked up seems to be pure luck: there will be a race between the probe of your driver and i2c-hid, which is not something you want.
> 
> If there are some issues with i2c-hid, I'd like also to know them because if we fix them for you there  is a high chance other vendors will benefit from those fixes too.
> 
> Cheers,
> Benjamin
> 
> > 
> > >> And also modify the part of FW update to be more efficiency. The 
> > >> main modification is that reducing the amount of data transmitted 
> > >> and using polling for time comsuming operation.
> > >>
> > >> Flash erase will wait 50ms for the operation complete in last driver.
> > >> Extend it to 200ms since the spec says the typical is 30ms but the 
> > >> max is 200ms.
> > >This should be split into a separate patch please.
> > Ok, I will resubmit the part of possible-issue fixing and then the driver patch for supporting WDT8752 again.
> > Please ignore this submission.
> > 
> > Hn.chen

-- 
Dmitry
