From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] ucb1400 touchscreen,
 irq auto probing and ac97 with its private field
Date: Thu, 24 Apr 2008 16:32:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804241625220.7882@tm8103.perex-int.cz>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Cc: Takashi Iwai <tiwai@suse.de>, dtor@mail.ru, ALSA development <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 24 Apr 2008, Sebastian Siewior wrote:

> I've sent a RFC to the alsa mailing list [1] about adding an extra field 
> in order to pass the IRQ from the AC97 driver to the ucb1400 driver. The 
> result was:

The original patch seems to be acceptable. But I would choose a more 
universal name and 'void *' type like 'void *device_private_data' and 
specify more the purpose of this member (add USB1400 as example device).

> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006555.html

Could you change and resend your patch?

				Thanks,
					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
