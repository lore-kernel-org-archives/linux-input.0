From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/6] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Mon, 23 Feb 2015 14:00:38 -0300
Message-ID: <1424710838.3175803.231288777.556EDA1B@webmail.messagingengine.com>
References: <1424292824.32581.47.camel@hadess.net>
 <20150220052831.GD790@fury.dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46831 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072AbbBWRAi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 12:00:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 864E220942
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2015 12:00:37 -0500 (EST)
In-Reply-To: <20150220052831.GD790@fury.dvhart.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Bastien Nocera <hadess@hadess.net>
Cc: ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Feb 20, 2015, at 02:28, Darren Hart wrote:
> On Wed, Feb 18, 2015 at 09:53:44PM +0100, Bastien Nocera wrote:
> 
> Commit message please.
> 
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
> 
> I'd very much like to see a cleanup of the driver to use these as well.
> 
> Henrique, your thoughts / preference?

Converting to DEVICE_ATTR_RW/RO would be welcome.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
