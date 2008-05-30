From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH/RFC 1/2] Add jack reporting API for ALSA
Date: Fri, 30 May 2008 11:15:57 +0100
Message-ID: <20080530101557.GB7729@sirena.org.uk>
References: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hhccgjjgw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5hhccgjjgw.wl%tiwai@suse.de>
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

On Fri, May 30, 2008 at 10:15:43AM +0200, Takashi Iwai wrote:

> The implementation looks good, simple enough.

Thanks.

> Mark Brown wrote:

> > +config SND_JACK
> > +	tristate
> > +	depends on SND
> > +	depends on INPUT

> The code is small, and I don't see a big merit to make it a module.

I agree - I had meant to flag this up, actually.  I hadn't been sure if
some of the other objects were being built conditionally for size or not
since they seemed relatively small too.  When I respin I'll remove this
option.

> > +	snprintf(jack->name, sizeof(jack->name), "%s %s",
> > +		 card->longname, jack->id);

> The longname field could be sometimes really too long and verbose.
> I guess shortname would match better.

The general style for input device names tends towards the long and
verbose.  For example, on my work laptop I have devices with names like:

   Macintosh mouse button emulation
   AT Translated Set 2 Keyboard
   Lid Switch
   Power Button (CM)
   Sleep Button (CM)
   AlpsPS/2 ALPS GlidePoint

The ALSA long name seems more idiomatic for this context.

> > +int snd_jack_new(struct snd_card *card, const char *id, int type,
> > +		 struct snd_jack **jjack)
> (snip)
> > +	jack->input_dev->phys = "ALSA";
> > +	jack->input_dev->dev.parent = card->dev;

> The card->dev pointer might not be initialized always at this stage.
> You should check rather at register.

Will do.

> Also, someone may want to pass a different device pointer for this.
> Passing struct device * to snd_jack_new would be an alternative.

Good idea, that might be useful for ASoC v2 sound cards.  I'll add
something which allows the caller to optionally specify a parent,
defaulting to the sound card if none is given.

The only issue might be for user space figuring out which sound card
corresponds to which jack but if jacks might be implemented outside of
ALSA anyway (which is possible) that could happen anyway.
