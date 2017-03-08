From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Wed, 08 Mar 2017 19:14:02 +0200
Message-ID: <1488993242.20145.154.camel@linux.intel.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
         <20170202104130.GJ2053@lahna.fi.intel.com>
         <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
         <20170202121018.GN2053@lahna.fi.intel.com>
         <20170202123206.GP2053@lahna.fi.intel.com>
         <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
         <20170202131251.GQ2053@lahna.fi.intel.com>
         <ca2868cf-8c7f-5cdc-e773-ff326dd0cdc6@redhat.com>
         <3f433773-27ba-8d07-3209-6df71d6d4b33@redhat.com>
         <1487778778.20145.22.camel@linux.intel.com>
         <65b7a7ed-3199-84d2-c004-adedadce1d88@redhat.com>
         <1488454727.20145.71.camel@linux.intel.com>
         <e4dfd35b-cf7f-93bb-fb88-fb8d412d922a@redhat.com>
         <1488553076.20145.79.camel@linux.intel.com>
         <3be3837a-a57c-e6bf-538b-e135c1b37ff0@redhat.com>
         <1488554609.20145.81.camel@linux.intel.com>
         <693ce7b3-99e9-eb60-b164-50b27294a239@redhat.com>
         <1488887470.20145.108.camel@linux.intel.com>
         <015d1f87-fcfe-b08d-6934-732145d534ca@redhat.com>
         <a53cdb15-a0b8-5ae5-082c-b5cc8bc40661@redhat.com>
         <1488969002.20145.119.camel@linux.intel.com>
         <b19876e3-f36a-a6cf-453f-b0075ad6fadb@redhat.com>
         <1488973582.20145.125.camel@linux.intel.com>
         <1488992486.20145.151.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27459 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbdCHRRH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 8 Mar 2017 12:17:07 -0500
In-Reply-To: <1488992486.20145.151.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Wed, 2017-03-08 at 19:01 +0200, Andy Shevchenko wrote:
> On Wed, 2017-03-08 at 13:46 +0200, Andy Shevchenko wrote:
> > On Wed, 2017-03-08 at 12:27 +0100, Hans de Goede wrote:
> > > On 08-03-17 11:30, Andy Shevchenko wrote:
> > > > On Wed, 2017-03-08 at 10:08 +0100, Hans de Goede wrote:
> > > > > On 07-03-17 14:55, Hans de Goede wrote:

> Below corrections to my initial view.
> 
> > Just really small pseudo ASL to consider:
> > 
> > _CRS:
> > 
> > GpioIo(...)  { pin #5 }
> > GpioIo(...)  { pin #3, pin #4, pin #2 }
> > GpioIo(...)  { pin #15 }
> > 
> > In Linux (for example) [index, connection ID]:
> > 
> > index 0  "reset"  (pin #2)
> > index 1  "func1"  (pin #4)
> > index 2  "func2"  (pin #3)
> 

> An this is completely reversed, should be
> 
> index 2  "reset"  (pin #2)
> index 1  "func1"  (pin #4)
> index 0  "func2"  (pin #3)

zOMG, since we have *different* connection IDs, they are all 0!!!

I'm really messing up the things in my brain :-(

> 
> > index 3  "enable" (pin #5)
> > index 4  "ready"  (pin #15)
> 
> Both above should have indexes 0 on Linux side!
> 
> > Mapping Linux <-> _CRS (either from _DSD or hard coded mapping
> > table):
> > 
> > index 0  pin #2    to 1,2
> > index 1  pin #4    to 1,1
> > index 2  pin #3    to 1,0
> > index 3  pin #5    to 0,0
> > index 4  pin #15   to 2,0
> 
> Ditto.

Ditto.

-- 8< -- 8< --

Alter scheme to see the different indexes on Linux side is

In Linux (for example) [index, connection ID]:

index 2  "reset"  (pin #2)
index 1  "reset"  (pin #4)
index 0  "reset"  (pin #3)

Mapping Linux <-> _CRS (either from _DSD or hard coded mapping table):

index 2  pin #2    to 1,2
index 1  pin #4    to 1,1
index 0  pin #3    to 1,0

-- 8< -- 8< --

> Sorry for my broken picture.

Sorry again.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
