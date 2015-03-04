From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 1/2] input: goodix: Add device tree support
Date: Wed, 4 Mar 2015 18:12:27 +0100
Message-ID: <20150304181227.19af01a542c4e75f5c5e059c@ao2.it>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	<1425458028-4521-1-git-send-email-mamlinav@gmail.com>
	<1425460886.9384.4.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:31484 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932528AbbCDRMe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2015 12:12:34 -0500
In-Reply-To: <1425460886.9384.4.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Wed, 04 Mar 2015 10:21:26 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Wed, 2015-03-04 at 11:33 +0300, Aleksei Mamlin wrote:
> > This patch adds device tree support for Goodix GT9xx series 
> > touchscreen controller.
> 
> <snip>
> > diff --git a/drivers/input/touchscreen/Kconfig 
> > b/drivers/input/touchscreen/Kconfig
> > index 5891752..7a6ab8c 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -297,7 +297,7 @@ config TOUCHSCREEN_FUJITSU
> >  
> >  config TOUCHSCREEN_GOODIX
> >         tristate "Goodix I2C touchscreen"
> > -       depends on I2C && ACPI
> > +       depends on I2C
> 
> Any way to say depends on I2C && (ACPI || OF) ?
>

Hi Bastien,

I only see something like this in _one_ driver under drivers/:

drivers/net/phy/Kconfig:        depends on (OF || ACPI) && HAS_IOMEM

I guess this is because "depends" is about compilation requirements
rather than runtime ones? The driver should still compile fine without
either ACPI or OF with the appropriate guards in place, so I'd rather
leave this hunk as Aleksei proposed.

Ciao,
   Antonio

> >         help
> >                         Say Y here if you have the Goodix 
> > touchscreen (such as one
> >                         installed in Onda v975w tablets) connected 
> > to your
> 
> Can you update the description to add the newly supported devices to 
> the list?
> 
> Cheers
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
