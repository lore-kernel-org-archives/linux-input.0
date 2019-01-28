From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: input: Add documentation for gp2a sensor
Date: Mon, 28 Jan 2019 11:30:02 -0800
Message-ID: <20190128193002.GE34692@dtor-ws>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125175045.22576-5-pawel.mikolaj.chmiel@gmail.com>
 <20190126013237.GF212026@dtor-ws>
 <BYAPR02MB54959FD8A7CF5977B0D4B5B7A3940@BYAPR02MB5495.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BYAPR02MB54959FD8A7CF5977B0D4B5B7A3940@BYAPR02MB5495.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Bakker <xc-racer2@live.ca>
Cc: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "colyli@suse.de" <colyli@suse.de>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "xiaotong.lu@spreadtrum.com" <xiaotong.lu@spreadtrum.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 26, 2019 at 03:14:14AM +0000, Jonathan Bakker wrote:
> Hi Dmitry,
> 
> Thanks for your review of the patches.
> 
> Considering that the light sensor part should be in IIO, should the entire driver be rewritten as an IIO driver?  There's already the driver for gp2ap020a00f there which is presumably the gp2ap002a00f's successor and does the same functions.

I'd be fine with that.

> 
> On 2019-01-25 5:32 p.m., Dmitry Torokhov wrote:
> > On Fri, Jan 25, 2019 at 06:50:45PM +0100, Paweł Chmiel wrote:
> >> From: Jonathan Bakker <xc-racer2@live.ca>
> >>
> >> This commit adds documentation for Sharp GP2AP002A00F.
> >> It's Proximity/Opto Sensor connected over i2c.
> >>
> >> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> >> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> >> ---
> >>  .../bindings/input/sharp,gp2ap002a00f.txt     | 29 +++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt b/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
> >> new file mode 100644
> >> index 000000000000..c524eb7d3d60
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
> >> @@ -0,0 +1,29 @@
> >> +* Sharp GP2AP002A00F I2C Proximity/Opto Sensor
> >> +
> >> +Required properties:
> >> +- compatible : Should be "sharp,gp2ap002a00f"
> >> +- reg : The I2C address of the sensor
> >> +- vout-gpio : The gpio connected to the vout pin
> > 
> > Do you know what it is for?
> > 
> It's the control of the main power supply to the chip.

In this case it should be a power supply (regulator), not gpio.

Thanks.

-- 
Dmitry
