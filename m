From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Wed, 23 Sep 2009 10:51:05 -0700
Message-ID: <200909231051.05714.david-b@pacbell.net>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <4ABA3638.5070609@ridgerun.com> <20090923163546.GA13435@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.gq1.yahoo.com ([67.195.14.95]:42888 "HELO
	smtp110.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751400AbZIWRvC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 13:51:02 -0400
In-Reply-To: <20090923163546.GA13435@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

On Wednesday 23 September 2009, Dmitry Torokhov wrote:
> >> __devexit?
> > [MA] According to comments from David Brownell to the first version=
 of=20
> > this patch the __exit should be used.
> >
> > " - Use platform_driver_probe() and __exit/__exit_p();
> > =A0 =A0there's no point in keeping that code around in
> > =A0 =A0typical configs, it'd just waste memory. "
>=20
> I am afraid David is wrong here.

No, you're just pointing out a bug introduced in some
unrelated code.  Such bugs happen when folk ignore the
code bloat issues.  (And didn't Linus recently point
out how such code bloat is becoming an issue?)


> Even when we register driver with=20
> platform_driver_probe() we still have "unbind" attribute in sysfs whi=
ch
> may be used to unbind the device from driver. If code is __exit then
> such attempts will cause oops.

That would be a bug in the unbind() code, which doesn't
currently recognize that not every driver or bus supports
hotplugging.  It should probably check for a null release()
pointer in the driver, and politely fail in that case.

That's just about the only place that a third party
(neither the driver nor its hotplug-aware bus framework)
will try to decouple device and driver ... and it's doing
it wrong.  So it's unlikely such bugs will be elsewhere.

It's *ALWAYS* been legit to have a NULL pointer in the
remove() methods.  That's why the __exit_p() -- or for
hotpluggable drivers, __devexit_p() -- macros exist:
for that particular case.

- Dave
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
