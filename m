From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Date: Wed, 24 May 2017 08:12:46 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD8D651@SW-EX-MBX02.diasemi.com>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
 <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On 23 May 2017 18:17 Mark Brown
> To: Steve Twiss
> Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator driver
> 
> On Tue, May 23, 2017 at 02:40:45PM +0100, Steve Twiss wrote:
> 
> > This patch was Acked by Mark Brown, a long time ago, way back in Oct 2016
> > (https://patchwork.kernel.org/patch/9397787/).
> > I have kept Mark Brown's Ack attached because there have been no real
> > code changes since then, but I have recently updated the copyright header
> > slightly, rebased the code (no changes necessary) and compile tested it
> > against x86_64.
> 
> > The MFD files which this patch depended on were accepted into linux-next
> > by Lee Jones last week. If there is anything in the way of this patch
> > acceptance, could you please let me know?
> 
> Given that I've acked this and it depends on the MFD changes I'd have
> expected Lee to apply it.  If nothing else happens I can apply it after
> the next merge window, otherwise either Lee needs to send me a pull
> request for the MFD change so I've got the dependency or he needs to
> apply this.

Hi Mark,

Thanks,
No problem, just some minor administration.

@Lee
Could you please send Mark a pull request for the regulator component to the
DA9062/61 changes [PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
driver.

Regards,
Steve
