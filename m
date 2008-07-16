From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [0/2] Jack reporting
Date: Wed, 16 Jul 2008 13:50:53 +0100
Message-ID: <20080716125053.GA17134@rakim.wolfsonmicro.main>
References: <20080703095026.GA652@sirena.org.uk>
	<20080714151058.GF25448@sirena.org.uk>
	<s5hlk02148k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5hlk02148k.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@insightbb.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 16, 2008 at 01:02:35PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Takashi, do you have any comments on these patches?

> I have no strong opinion about this.  Your implementation looks small
> enough.  But, if Dmitry finds the input layer not suitable for such a
> purpose, this isn't a good way to go.

Unfortunately Dimitry hasn't been responding to any of the e-mails on
this subject since his initial one.  :/

> I think the question is how general and how extensible these features
> should be.  If it's just a jack reporting, there are bunch of other

To reiterate points I've previously made:

As well as detecting the presence of a connected device typical jack
detection implementations also support the implementation of at least
one button which would require an input device for at least some jacks
even if something else were done.  This is consistent with existing
usage of the input layer - it's similar to multimedia keys which are
normally reported via the input layer.  Things like sleep and power
buttons are implemented as individual input devices.

We do also already have existing in-kernel users of the input API to
report jack status (usually done via GPIOs outside of ALSA).  From that
point of view this ALSA helper is simply implementing the existing user
space interface for reporting jacks.  I feel that if we want to do
something different we should work out how to transition these existing
users to it too.  We can always add the existing code while working out
what that transition plan might be.

The concern Dmirty raised about requring an ioctl() to get the initial
switch state seems to be something that ought to be addressed anyway
regardless of what happens here.  Similarly, the concerns about the
resouce consumption of the input layer seem to be a general issue (and
to be honest I'm not convinced that they're a practical problem).

Without the existing users of this interface and the button I'd probably
agree with Dmitry but those two factors persuade me otherwise.

> possible implementations.  Even ALSA control API could provide a
> similar functionality.

This has most of the concerns that applied to the existing input API :(
