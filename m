From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 09/10] Documentation: dt: mfd: da9062/61 MFD binding
Date: Fri, 14 Oct 2016 12:26:07 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE342A@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <7a21f22bd62817b63ba64e11eecadfb78338ee46.1475743411.git.stwiss.opensource@diasemi.com>
 <20161010134235.GA20577@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161010134235.GA20577@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

Hi Rob,

On 10 October 2016 14:43, Rob Herring wrote:
> On Thu, Oct 06, 2016 at 09:43:31AM +0100, Steve Twiss wrote:
[...]
> > @@ -64,10 +89,6 @@ Example:
> >  			compatible = "dlg,da9062-rtc";
> >  		};
> >
> > -		watchdog {
> > -			compatible = "dlg,da9062-watchdog";
> > -		};
> > -
> 
> I don't understand why this is removed?

This MFD binding file now contains a link to a separate watchdog binding file.
I moved the example and the binding information into this new watchdog binding
document. I also updated it for DA9061.

+- watchdog: See ../watchdog/da9062-watchdog.txt

I will add this information into the patch description for V2 to make things clearer.

Regards,
Steve
