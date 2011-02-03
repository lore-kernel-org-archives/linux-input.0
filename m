From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 12/19] twl4030: mfd_cell is now implicitly
 available to drivers
Date: Thu, 03 Feb 2011 14:23:46 +0200
Message-ID: <4D4A9E52.7010000@nokia.com>
References: <20110202195417.228e2656@queued.net>	<20110202201522.72d37f1e@queued.net>	<20110203060521.GA25739@core.coreip.homeip.net>	<20110202223959.244b4a01@queued.net>	<20110203065339.GA5592@core.coreip.homeip.net>
	<20110202230326.167fe873@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110202230326.167fe873@queued.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Andres Salomon <dilinger@queued.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-input@vger.kernel.org

On 02/03/11 09:03, ext Andres Salomon wrote:
> I believe some drivers are even using the parent device already.  See
> drivers/leds/leds-mc13783.c, for example, whose parent device drvdata
> is used to pass around a struct mc13783 to its children.  Sounds
> like a possibility, will need to look into it further.

I briefly looked at the drivers/leds/leds-mc13783.c, and the related
drivers/mfd/mc13xxx.c drivers.
This also uses the same way to pass the needed platform data to it's
child devices, as the twl4030 (audio/codec/vibra) MFD does.
Also the leds-mc13783.c does not actually uses any config values from
the parent dev. The mc13783_led->master is needed to be locally stored,
since the led driver calls functions from the MFD core, which needs that
as parameter.

I don't really see any need to change the drivers in this regard,
however it would be nicer, if we replace for example the:
	struct twl4030_codec_data *pdata =3D pdev->dev.platform_data;
with
	struct twl4030_codec_data *pdata =3D dev_get_platdata(&pdev->dev);

The information passed to the vibra, and ASoC codec driver is for them
only, so there is no need for the vibra driver to know anything about
things, which concerns only the ASoC codec driver.

-- =

P=E9ter
