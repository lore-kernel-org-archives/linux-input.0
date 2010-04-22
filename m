From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/4] snd-maestro3: Make hardware volume buttons an input device
Date: Thu, 22 Apr 2010 09:59:00 -0700
Message-ID: <201004220959.01347.dmitry.torokhov@gmail.com>
References: <1271862249-22612-1-git-send-email-hdegoede@redhat.com> <4BD00176.3000904@redhat.com> <20100422151112.GC6861@sci.fi>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41373 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab0DVQ7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Apr 2010 12:59:12 -0400
Received: by wyb39 with SMTP id 39so4987108wyb.19
        for <linux-input@vger.kernel.org>; Thu, 22 Apr 2010 09:59:11 -0700 (PDT)
In-Reply-To: <20100422151112.GC6861@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Thursday 22 April 2010 08:11:12 am Ville Syrj=E4l=E4 wrote:
> On Thu, Apr 22, 2010 at 09:57:42AM +0200, Hans de Goede wrote:
> > On 04/21/2010 06:05 PM, Ville Syrj=E4l=E4 wrote:
> > > On Wed, Apr 21, 2010 at 11:04:09AM -0400, Hans de Goede wrote:
> > >> @@ -2524,6 +2494,42 @@ static int m3_resume(struct pci_dev *pci)
> > >>=20
> > >>   }
> > >>   #endif /* CONFIG_PM */
> > >>=20
> > >> +#ifdef CONFIG_INPUT
> > >> +static int __devinit snd_m3_input_register(struct snd_m3 *chip)
> > >> +{
> > >> +	struct input_dev *input_dev;
> > >> +	int err;
> > >> +
> > >> +	input_dev =3D input_allocate_device();
> > >> +	if (!input_dev)
> > >> +		return -ENOMEM;
> > >> +
> > >> +	snprintf(chip->phys, sizeof(chip->phys), "pci-%s/input0",
> > >> +		 pci_name(chip->pci));
> > >=20
> > > What's the proper format of phys? I see gameport stuff uses
> > > pci%s/gameport0, ir stuff uses pci-%s/ir0. I can't immediately fi=
nd any
> > > other pci input things.
> >=20
> > I've no idea, I took the pci-%s/ part from other pci drivers regist=
ering
> > input devices and the input0 part is based on doing:
> > cat /sys/class/input/input?/phys
> >=20
> > On my system which yields a string ending in input0 for almost all
> > input devices.
>=20
> Same for me. Unfortunately none start with "pci". Adding Dmitry and
> linux-input in cc. Dmitry, any official statement about this phys
> string?

Phys can be pretty much anything, it is supposed to aid in identifying
particular device by physical connection. DVB guys like phys ending in
"irX", everywhere else we put "inputX" (normally input0 but if there
several input devices on the same physical device, like some USB HID
devices, there could be xxx/input1, xxx/intput2 and so on).

The piece in the quoted patch segment seems to be just fine.

Hope this helps.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
