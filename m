From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 06/10] Documentation: dt: input: temperature driver
Date: Tue, 11 Oct 2016 11:43:21 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE2CC4@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <313a15d14dd20a8cb8ac99a4cd423798343c5b65.1475743411.git.stwiss.opensource@diasemi.com>
 <20161010133718.GA9643@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.110]:59393 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751736AbcJKLuo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Oct 2016 07:50:44 -0400
In-Reply-To: <20161010133718.GA9643@rob-hp-laptop>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>

Hi,

On 10 October 2016 14:37 Rob Herring wrote:
> On Thu, Oct 06, 2016 at 09:43:30AM +0100, Steve Twiss wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> The subject is wrong.

Copy/paste error -- I will fix that.

> > Add binding information for DA9061 onkey.
> >
> > This patch updates the compatible string "dlg,da9061-onkey" to support
> > DA9061, removes ther reference to KEY_SLEEP (which the driver no longer
> 
> s/ther/the/

And this.

> > supports) and fixes a typo in the example.
> 
> Why is KEY_SLEEP being removed?

Supporting KEY_SLEEP was not the general convention and the typical solution should have been
for KEY_POWER to support both cases of suspend and S/W power off.
I changed the driver, but failed to update the documentation at that time, so am now updating this
as part of the DA9061.

I will add that information in the next V2 patch e-mail.

Regards,
Steve
