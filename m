From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 4/4] snd-maestro3: Make hardware volume
 buttons an input device
Date: Thu, 22 Apr 2010 18:11:12 +0300
Message-ID: <20100422151112.GC6861@sci.fi>
References: <1271862249-22612-1-git-send-email-hdegoede@redhat.com>
	<1271862249-22612-4-git-send-email-hdegoede@redhat.com>
	<20100421160551.GB6861@sci.fi> <4BD00176.3000904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4BD00176.3000904@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 22, 2010 at 09:57:42AM +0200, Hans de Goede wrote:
> On 04/21/2010 06:05 PM, Ville Syrj=E4l=E4 wrote:
> > On Wed, Apr 21, 2010 at 11:04:09AM -0400, Hans de Goede wrote:
> >> @@ -2524,6 +2494,42 @@ static int m3_resume(struct pci_dev *pci)
> >>   }
> >>   #endif /* CONFIG_PM */
> >>
> >> +#ifdef CONFIG_INPUT
> >> +static int __devinit snd_m3_input_register(struct snd_m3 *chip)
> >> +{
> >> +	struct input_dev *input_dev;
> >> +	int err;
> >> +
> >> +	input_dev =3D input_allocate_device();
> >> +	if (!input_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	snprintf(chip->phys, sizeof(chip->phys), "pci-%s/input0",
> >> +		 pci_name(chip->pci));
> >
> > What's the proper format of phys? I see gameport stuff uses
> > pci%s/gameport0, ir stuff uses pci-%s/ir0. I can't immediately find any
> > other pci input things.
> >
> =

> I've no idea, I took the pci-%s/ part from other pci drivers registering
> input devices and the input0 part is based on doing:
> cat /sys/class/input/input?/phys
> =

> On my system which yields a string ending in input0 for almost all
> input devices.

Same for me. Unfortunately none start with "pci". Adding Dmitry and
linux-input in cc. Dmitry, any official statement about this phys
string?

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
