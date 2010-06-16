From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] sound: ac97: Add GPIO manipulation hooks
Date: Wed, 16 Jun 2010 13:52:13 +0100
Message-ID: <20100616125213.GA24491@rakim.wolfsonmicro.main>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
 <1276617347-3522-2-git-send-email-manuel.lauss@googlemail.com>
 <20100615160253.GK14510@rakim.wolfsonmicro.main>
 <s5h1vc7o1i3.wl%tiwai@suse.de>
 <AANLkTik3PHoo-1Is-yrzzTRjeH9G7v8LUgqxBzgVRQDi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60284 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754788Ab0FPMwP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jun 2010 08:52:15 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik3PHoo-1Is-yrzzTRjeH9G7v8LUgqxBzgVRQDi@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Jun 16, 2010 at 10:00:19AM +0200, Manuel Lauss wrote:
> On Wed, Jun 16, 2010 at 9:55 AM, Takashi Iwai <tiwai@suse.de> wrote:

> >> > + =A0 void (*setgpio) (struct snd_ac97 *ac97, unsigned short gpi=
o);
> >> > + =A0 unsigned short (*getgpio) (struct snd_ac97 *ac97);

> > Can this be handled simply in read/write callbacks in the controlle=
r
> > side? =A0In callbacks, you can check whether reg =3D=3D AC97_GPIO_S=
TATUS and
> > handle differently for such an access.

> Interesting Idea, and as a bonus requires no changes to the wm97xx co=
de.

The only thing that worries me there is any non-standard behavior the
chip may implement - it may actually want a write to that register for
some extended functionality.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
