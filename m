From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 3/6] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Fri, 20 Feb 2015 15:36:26 +0100
Message-ID: <1424442986.22910.1.camel@hadess.net>
References: <1424292824.32581.47.camel@hadess.net>
	 <20150220052831.GD790@fury.dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38880 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbbBTOhz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 09:37:55 -0500
In-Reply-To: <20150220052831.GD790@fury.dvhart.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 2015-02-19 at 21:28 -0800, Darren Hart wrote:
> On Wed, Feb 18, 2015 at 09:53:44PM +0100, Bastien Nocera wrote:
> 
> Commit message please.

Added.

> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 71 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 62 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index a6dd017..562d958 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> 
> ...
> 
> > +static struct device_attribute dev_attr_adaptive_kbd_mode =
> > +	__ATTR(adaptive_kbd_mode, S_IWUSR | S_IRUGO,
> > +		adaptive_kbd_mode_show, adaptive_kbd_mode_store);
> > +
> 
> Please use DEVICE_ATTR_RW() macros for new sysfs files.

Done.

> I'd very much like to see a cleanup of the driver to use these as well.
> 
> Henrique, your thoughts / preference?

Looks easy enough. I'll post the patch with the new series.

