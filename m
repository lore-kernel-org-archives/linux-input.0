From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: [RFC] ucb1400 touchscreen,
	irq auto probing and ac97 with its	private field
Date: Thu, 24 Apr 2008 16:04:59 +0200
Message-ID: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

I've sent a RFC to the alsa mailing list [1] about adding an extra field in
order to pass the IRQ from the AC97 driver to the ucb1400 driver. The
result was:
- William Pitcock recommended to hack up the ucb1400 driver and save the
  irq there. The result is [2]. What I don't like very much is the
  global variable and the fact that has to be done for every platform.
- Mark Brown has the same problem with his wm97xx driver [3].

and while browsing a dead list archive of linux-input I noticed that a
guy named Peter Ma has the same problem on his AVR32 [4].

I haven't heard anything from the ALSA Maintainer but according to git
he didn't put a sing-of-by line since Thu Jan 31 17:40:18 2008 +0100 so
maybe he is sleeping. That's why I've add Takashi Iwai since he seems to
be in charge some how.

Now I'm curious what solution the people here prefer:
- adding a private field [1] (my favorite)
- hacking up the ucb1400 [2] (doesn't solve [3] and needs addition code
  to solve [4]).
- something totally different what did not come to my attention yet.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006555.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006559.html
[3] http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006564.html
[4] http://www.mail-archive.com/linux-input@vger.kernel.org/msg00307.html

Sebastian
