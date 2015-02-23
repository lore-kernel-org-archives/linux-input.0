From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 3/6] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Mon, 23 Feb 2015 19:18:33 +0100
Message-ID: <1424715513.28361.16.camel@hadess.net>
References: <1424292824.32581.47.camel@hadess.net>
	 <20150220052831.GD790@fury.dvhart.com>
	 <1424710838.3175803.231288777.556EDA1B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40363 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbbBWSUL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 13:20:11 -0500
In-Reply-To: <1424710838.3175803.231288777.556EDA1B@webmail.messagingengine.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 2015-02-23 at 14:00 -0300, Henrique de Moraes Holschuh wrote:
> On Fri, Feb 20, 2015, at 02:28, Darren Hart wrote:
> > On Wed, Feb 18, 2015 at 09:53:44PM +0100, Bastien Nocera wrote:
> > 
> > Commit message please.
> > 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  drivers/platform/x86/thinkpad_acpi.c | 71 +++++++++++++++++++++++++++++++-----
> > >  1 file changed, 62 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > > index a6dd017..562d958 100644
> > > --- a/drivers/platform/x86/thinkpad_acpi.c
> > > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > 
> > ...
> > 
> > > +static struct device_attribute dev_attr_adaptive_kbd_mode =
> > > +	__ATTR(adaptive_kbd_mode, S_IWUSR | S_IRUGO,
> > > +		adaptive_kbd_mode_show, adaptive_kbd_mode_store);
> > > +
> > 
> > Please use DEVICE_ATTR_RW() macros for new sysfs files.
> > 
> > I'd very much like to see a cleanup of the driver to use these as well.
> > 
> > Henrique, your thoughts / preference?
> 
> Converting to DEVICE_ATTR_RW/RO would be welcome.

I've already sent the new patch for that though...

