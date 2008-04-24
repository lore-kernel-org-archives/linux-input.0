From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: Re: [RFC] ucb1400 touchscreen,
	irq auto probing and	ac97 with its private field
Date: Thu, 24 Apr 2008 17:44:10 +0200
Message-ID: <20080424154410.GE26452@Chamillionaire.breakpoint.cc>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
	<20080424145749.GB22369@sirena.org.uk>
	<20080424150211.GC22369@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20080424150211.GC22369@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

* Mark Brown | 2008-04-24 16:02:12 [+0100]:

>On Thu, Apr 24, 2008 at 03:57:52PM +0100, Mark Brown wrote:
>
>> > - hacking up the ucb1400 [2] (doesn't solve [3] and needs addition code
>> >   to solve [4]).
>
>> [3] is the issue with the WM97xx touchscreen drivers.  That's currently
>> solved by exactly this issue - as far as I can see from the patch you
>
>The second issue should be method.

I don't think that this is the right way in this case:
- this information equals a global variable. You can't have two
  touchscreens without exra hacking.
- if we keep doing this for all drivers (not just ucb1400) they gonna
  look like drivers/usb/host/ehci-hcd.c (look line 998+) once this chip
  spreads across buses.

Sebatian
