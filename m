From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] ucb1400 touchscreen,
 irq auto probing and ac97 with its private field
Date: Fri, 25 Apr 2008 12:20:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804251218210.7882@tm8103.perex-int.cz>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
	<20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de>
	<20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de>
	<20080425095107.GA22926@rakim.wolfsonmicro.main>
	<s5hej8ukzop.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hej8ukzop.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Sebastian Siewior <al+sa@ml.breakpoint.cc>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 25 Apr 2008, Takashi Iwai wrote:

> In the case of ucb1400, it's just an irq number.  It sounds logical to
> just pass this as an optional info to the driver.
> Now, you want to make it general so that you can use it for other
> purposes -- but what are the other purpose exactly?  IOW, such data
> must be passed through ac97 struct inevitably?

It's good question. But at least for UCB1400 it looks like that driver for 
the AC97 controller should pass this value. But it's only my guess (I 
don't know these hardware internals).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
