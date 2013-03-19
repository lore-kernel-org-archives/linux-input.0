From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC/RFT] Reset bcm5974 into wellspring mode when it forgets
Date: Tue, 19 Mar 2013 23:20:59 +0100
Message-ID: <20130319222059.GA8007@polaris.bitmath.org>
References: <1363271407.4853.52.camel@i7.infradead.org>
 <20130316193143.GA6050@polaris.bitmath.org>
 <1363531802.26810.13.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:55101 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab3CSWQ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Mar 2013 18:16:28 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 4998DE9781
	for <linux-input@vger.kernel.org>; Tue, 19 Mar 2013 23:16:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1363531802.26810.13.camel@shinybook.infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-input@vger.kernel.org

Hi David,

> On Sat, 2013-03-16 at 20:31 +0100, Henrik Rydberg wrote:
> > What do you mean by "fix for this on suspend/resume"? The driver
> > always returns to normal mode at suspend, and sets wellspring mode =
at
> > resume.
>=20
> Yes, that's exactly what I mean. And in the early days when the drive=
r
> didn't have a resume method, users were seeing exactly this 'bad
> trackpad package, length: 8' message on resume. Adding the
> suspend/resume methods fixed that =E2=80=94 and that's why I'm assumi=
ng that a
> switch back into wellspring mode is going to be sufficient to fix wha=
t
> I'm seeing too. Unloading and reloading the module certainly is.

The driver always had suspend/resume, but it is true that the EFI
booting did create a problem with the reset_resume method, so we went
back to rebinding the device. In addition to that problem, there has
been reports in the past that seem to indicate a few exemplars of
faulty hardware.

>=20
> > > +static void bcm5974_mode_workfn(struct work_struct *work)
> > > +{
> > > +	struct bcm5974 *dev =3D container_of(work, struct bcm5974, rese=
t_work);
> > > +
> > > +	dev_info(&dev->intf->dev, "Reset into wellspring mode...\n");
> > > +	bcm5974_wellspring_mode(dev, true);
> > > +}
> > > +
> >=20
> > This looks racy.
>=20
> Racy with what? Oh, I see... we should probably move the
> cancel_work_sync() from bcm5974_disconnect() to bcm5974_pause_traffic=
()?

I was thinking about the work function entering the wellspring_mode
function without the pm lock, but your observation seems correct, too :=
-)

> > In general, It does not really make sense for the transaction mode =
to
> > change under our feet without anything in the usb layer knowing abo=
ut
> > it.
>=20
> If hardware always made sense, the world would be a much better place=
 :)

But it would be good to know why your machine is special. As you say,
the patch is not really tested, so we don't even know if it will fix
the problem.

> >  Maybe there is a reset state cycle which does not get handle
> > properly in the driver?
>=20
> I don't believe so. A USB reset would end up with the bcm5974_probe()
> method being called again, and everything would work fine. The device
> may have reset its mode, but the USB bus doesn't seem to notice
> anything. When it happens, there are no USB messages; it just starts
> spewing the 'bad trackpad package' messages.

Ok, if you manage to hit the problem with a second version of this
patch, I will take it.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
