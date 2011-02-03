From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 12/19] twl4030: mfd_cell is now implicitly
 available to drivers
Date: Thu, 3 Feb 2011 09:31:54 +0000
Message-ID: <20110203093154.GC21591@opensource.wolfsonmicro.com>
References: <20110202195417.228e2656@queued.net>
	<20110202201522.72d37f1e@queued.net>
	<20110203060521.GA25739@core.coreip.homeip.net>
	<20110202223959.244b4a01@queued.net>
	<20110203065339.GA5592@core.coreip.homeip.net>
	<20110202230326.167fe873@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
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
To: Andres Salomon <dilinger@queued.net>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 02, 2011 at 11:03:26PM -0800, Andres Salomon wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > Then they are doing it incorrectly. One possible way is to have parent
> > device carry relevant data in its drvdata and have children get it
> > from there.

> I believe some drivers are even using the parent device already.  See
> drivers/leds/leds-mc13783.c, for example, whose parent device drvdata
> is used to pass around a struct mc13783 to its children.  Sounds
> like a possibility, will need to look into it further.

That's the current best practice approach.
