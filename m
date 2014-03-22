From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Sat, 22 Mar 2014 19:13:36 +0100
Message-ID: <CAOQ7t2Yg5pp_rXYfsdnHpy-zGFGimzT3EW15P_0ugYMtgPtOrw@mail.gmail.com>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
	<1394898225-28452-2-git-send-email-carlo@caione.org>
	<20140318155919.GS25478@lee--X1>
	<20140322165132.GC20668@localhost.fastwebnet.it>
	<20140322173313.GU552@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srv-hp10.netsons.net ([94.141.22.71]:52508 "EHLO
	srv-hp10.netsons.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750831AbaCVTVs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Mar 2014 15:21:48 -0400
In-Reply-To: <20140322173313.GU552@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, linux-sunxi@googlegroups.com

On Sat, Mar 22, 2014 at 6:33 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Mar 22, 2014 at 05:51:32PM +0100, Carlo Caione wrote:
>> On Tue, Mar 18, 2014 at 03:59:19PM +0000, Lee Jones wrote:
>
>> > > + of_id = of_match_device(axp20x_of_match, &i2c->dev);
>> > > + if (!of_id) {
>> > > +         dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
>> > > +         return -ENODEV;
>> > > + }
>> > > + axp20x->variant = (int) of_id->data;
>
>> > No need to cast from void *.
>
>> My compiler says otherwise :)
>
> Are you sure your compiler isn't correctly telling you not to cast away
> const?  If the compiler is complaining about a cast on void then it's
> spotted a definite bug.

[resend since gmail decided to not put broonie in CC]

drivers/mfd/axp20x.c:172:18: warning: assignment makes integer
frompointer without a cast [enabled by default]

-- 
Carlo Caione
