From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: dt-bindings: Add binding for bma150 sensor
Date: Mon, 28 Jan 2019 11:31:07 -0800
Message-ID: <20190128193107.GF34692@dtor-ws>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
 <20190126012802.GD212026@dtor-ws>
 <BYAPR02MB54950EDEEE82D5F06C7131CEA3940@BYAPR02MB5495.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BYAPR02MB54950EDEEE82D5F06C7131CEA3940@BYAPR02MB5495.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Bakker <xc-racer2@live.ca>
Cc: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 26, 2019 at 03:39:17AM +0000, Jonathan Bakker wrote:
> 
> 
> On 2019-01-25 5:28 p.m., Dmitry Torokhov wrote:
> > On Fri, Jan 25, 2019 at 07:44:00PM +0100, Paweł Chmiel wrote:
> >> From: Jonathan Bakker <xc-racer2@live.ca>
> >>
> >> Add device tree bindings for Bosch BMA150 Accelerometer Sensor
> >>
> >> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> >> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> >> ---
> >>  .../bindings/input/bosch,bma150.txt           | 20 +++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/bosch,bma150.txt b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> >> new file mode 100644
> >> index 000000000000..290c60e38c70
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> >> @@ -0,0 +1,20 @@
> >> +* Bosch BMA150 Accelerometer Sensor
> >> +
> >> +Also works for the SMB380 and BMA023 accelerometers
> >> +
> >> +Required properties:
> >> +- compatible : Should be "bosch,bma150"
> >> +- reg : The I2C address of the sensor
> >> +
> >> +Optional properties:
> >> +- interrupt-parent : should be the phandle for the interrupt controller
> >> +- interrupts : Interrupt mapping for IRQ.  If not present device will be polled
> >> +
> >> +Example:
> >> +
> >> +bma150@38 {
> >> +	compatible = "bosch,bma150";
> >> +	reg = <0x38>;
> >> +	interrupt-parent = <&gph0>;
> >> +	interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > Hmm, here you say that IRQ_TYPE_LEVEL_HIGH, so it is level interrupts,
> > but the driver overrides to rising edge unconditionally. Since you are
> > the first to add DT support please make separate patch to driver to drop
> > the ORQ trigger from request_theraded_irq() leaving only IRQF_ONESHOT.
> > 
> This was simply an oversight on my part, my device was using the the polled method as opposed to an interrupt.  I'll correct this in v2.
> > Also please create patch removing platform data support as noone is
> > using it upstream.
> > 
> Will do.
> > What about the rest of config parameters from bma150_cfg? They should be
> > handled as device properties too.
> > 
> Ok, I can add them as well.  I didn't bother as the comment in the source code says that the default values are the ones recommended by Bosch.

OK, if you do not need to handle them then we can leave this task to the
next user ;)

Thanks.

-- 
Dmitry
