From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Jack reporting v2
Date: Tue, 3 Jun 2008 11:17:26 -0400
Message-ID: <20080603105920.ZZRA012@mailhub.coreip.homeip.net>
References: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080603104048.GA17007@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20080603104048.GA17007@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org
Cc: mjg59@srcf.ucam.org
List-Id: linux-input@vger.kernel.org

Hi Mark,

On Tue, Jun 03, 2008 at 11:40:48AM +0100, Mark Brown wrote:
> The following couple of patches update the jack reporting API I posted
> last week with the feedback I have received so far.  The changes since
> the last submision are:
> 
>  - Addition of snd_jack_set_parent(), allowing drivers to override the
>    default parent for the input device prior to registration.
>  - The jack detection support is now included unconditionally in ALSA,
>    requiring a dependency on the input subsystem.
> 
> I'm not entirely happy with making ALSA depend on input but given that
> it is only optional on embedded systems and that the input core is not
> that large it seemed the best way of ensuring that the input subsystem
> is available for the jack API without hassle for drivers using it,
> especially given the lack of dependency propagation from select.

I think it is a great idea to intoroduce a mechanism treporting state
of a generic connector, it was a long overdue. However I don't think
that using input as a delivery mechanism is the best solution. What is
needed from a connector:

1. A way to query its state
2. A way to notify userspace of state change.

Pros for using input devices:
- we already have them

Cons:
- space consideration. Input_dev structure is quite fat. It has all
  the capabilities strings exported through sysfs, hist of other
  attributes, etc. On top of that we have a character device (evdev)
  plus its own sysfs representation. IOW lots of stuff.
- input device require ioctl to get the switch state, no easy way to
  do it through sysfs.
- As the number of types of connectors grows new switches will need to
  be added to input, potentially completely unrelated. My lacmus test
  for it - does it make sense to add network cable state to inputi
  core?

Do you think that something small that has only one sysfs device per
switch and uses KOBJ_ONLINE/KOBJ_OFFLINE to signal state change would
be better suited here?

BTW, the same goes for the SW_DOCK that Matthew wants to add (CC-ed).

-- 
Dmitry
