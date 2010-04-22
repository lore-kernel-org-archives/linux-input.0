From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [alsa-devel] [PATCH 4/4] snd-maestro3: Make hardware volume
 buttons an input device
Date: Thu, 22 Apr 2010 20:54:26 +0300
Message-ID: <20100422175426.GD6861@sci.fi>
References: <1271862249-22612-1-git-send-email-hdegoede@redhat.com>
 <4BD00176.3000904@redhat.com>
 <20100422151112.GC6861@sci.fi>
 <201004220959.01347.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:52591 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab0DVRya (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Apr 2010 13:54:30 -0400
Content-Disposition: inline
In-Reply-To: <201004220959.01347.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Thu, Apr 22, 2010 at 09:59:00AM -0700, Dmitry Torokhov wrote:
> On Thursday 22 April 2010 08:11:12 am Ville Syrj=E4l=E4 wrote:
> > On Thu, Apr 22, 2010 at 09:57:42AM +0200, Hans de Goede wrote:
> > > On 04/21/2010 06:05 PM, Ville Syrj=E4l=E4 wrote:
> > > > On Wed, Apr 21, 2010 at 11:04:09AM -0400, Hans de Goede wrote:
> > > >> @@ -2524,6 +2494,42 @@ static int m3_resume(struct pci_dev *pc=
i)
> > > >>=20
> > > >>   }
> > > >>   #endif /* CONFIG_PM */
> > > >>=20
> > > >> +#ifdef CONFIG_INPUT
> > > >> +static int __devinit snd_m3_input_register(struct snd_m3 *chi=
p)
> > > >> +{
> > > >> +	struct input_dev *input_dev;
> > > >> +	int err;
> > > >> +
> > > >> +	input_dev =3D input_allocate_device();
> > > >> +	if (!input_dev)
> > > >> +		return -ENOMEM;
> > > >> +
> > > >> +	snprintf(chip->phys, sizeof(chip->phys), "pci-%s/input0",
> > > >> +		 pci_name(chip->pci));
> > > >=20
> > > > What's the proper format of phys? I see gameport stuff uses
> > > > pci%s/gameport0, ir stuff uses pci-%s/ir0. I can't immediately =
find any
> > > > other pci input things.
> > >=20
> > > I've no idea, I took the pci-%s/ part from other pci drivers regi=
stering
> > > input devices and the input0 part is based on doing:
> > > cat /sys/class/input/input?/phys
> > >=20
> > > On my system which yields a string ending in input0 for almost al=
l
> > > input devices.
> >=20
> > Same for me. Unfortunately none start with "pci". Adding Dmitry and
> > linux-input in cc. Dmitry, any official statement about this phys
> > string?
>=20
> Phys can be pretty much anything, it is supposed to aid in identifyin=
g
> particular device by physical connection. DVB guys like phys ending i=
n
> "irX", everywhere else we put "inputX" (normally input0 but if there
> several input devices on the same physical device, like some USB HID
> devices, there could be xxx/input1, xxx/intput2 and so on).

OK. I was mainly worried that perhaps some tool might use it and would
need some specific format. In this case the dash between the bus type
and the device name caught my eye as some drivers have it and some
don't.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
