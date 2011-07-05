From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] input: Initial support for Kionix KXTJ9 accelerometer
Date: Tue, 5 Jul 2011 11:39:17 -0700
Message-ID: <20110705183917.GA15876@core.coreip.homeip.net>
References: <1309288348-30735-1-git-send-email-chris.hudson.comp.eng@gmail.com>
 <20110704162628.GC8144@core.coreip.homeip.net>
 <CAB7Re7X=N8yCCOXvxMAgf8k0y+Mz_+YbJw58tjj69CP24YDhyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38456 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab1GESjX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 14:39:23 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so5430725iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 11:39:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAB7Re7X=N8yCCOXvxMAgf8k0y+Mz_+YbJw58tjj69CP24YDhyw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Cc: linux-input@vger.kernel.org, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

On Tue, Jul 05, 2011 at 02:08:01PM -0400, Christopher Hudson wrote:
> On Mon, Jul 4, 2011 at 12:26 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Chris,
> >
> > On Tue, Jun 28, 2011 at 03:12:28PM -0400, chris.hudson.comp.eng@gma=
il.com wrote:
> >> From: Chris Hudson <chudson@kionix.com>
> >>
> >> - Added Dmitry's changes
> >> - Now using input_polled_dev interface when in polling mode
> >> - IRQ mode provides a separate sysfs node to change the hardware d=
ata rate
> >>
> >
> > I am not happy with the fact that this implementation forces users =
to
> > select polled or interrupt-driven mode at compile time. The patch I
> > proposed had polled mode support optional and would automatically s=
elect
> > IRQ mode for clients that have interrupt assigned and try to activa=
te
> > polled mode if interrupt is not available.
> >
> >> +
> >> +/* kxtj9_set_poll: allows the user to select a new poll interval =
(in ms) */
> >> +static ssize_t kxtj9_set_poll(struct device *dev, struct device_a=
ttribute *attr,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
> >> +{
> >> + =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(to_i2c_cli=
ent(dev));
> >> +
> >> + =A0 =A0 unsigned long interval;
> >> + =A0 =A0 int ret =3D kstrtoul(buf, 10, &interval);
> >> + =A0 =A0 if (ret < 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> >> +
> >> + =A0 =A0 mutex_lock(&tj9->lock);
> >> + =A0 =A0 /* set current interval to the greater of the minimum in=
terval or
> >> + =A0 =A0 the requested interval */
> >> + =A0 =A0 tj9->last_poll_interval =3D max((int)interval, tj9->pdat=
a.min_interval);
> >> + =A0 =A0 mutex_unlock(&tj9->lock);
> >
> > This lock does not make sense. You are protecting update of last_po=
ll_interval
> > field and this update can not be partial (i.e. only LSB or MSB is
> > written) on all our arches, but you do not protect kxtj9_update_odr=
()
> > which alters chip state and does need protection.
> >
> > I tried bringing forward my changes from the older patch into yours=
,
> > please let me know if the patch below works on top of yours.
>=20
> Hi Dmitry,
> Thanks for all your hard work, and yes it works fine.  There were a
> couple of changes proposed by Jonathan that I had already merged into
> my version though; should I submit these in a separate patch or resen=
d
> the merged version?

Cris,

Could you please send the changes proposed by Jonathan as a separate
patch relative to the v5 you posted earlier? Then I can fold v5, mine
and your new patch together and queue the driver for 3.1.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
