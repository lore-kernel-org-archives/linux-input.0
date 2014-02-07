From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 05/15] Input: synaptics-rmi4 - remove gpio handling and
 polling
Date: Thu, 6 Feb 2014 17:47:13 -0800
Message-ID: <20140207014712.GP1706@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <52F172F3.7090003@synaptics.com>
 <20140205023113.GE1706@sonymobile.com>
 <52F3EAF1.9000505@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:6480 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751187AbaBGBp3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Feb 2014 20:45:29 -0500
Content-Disposition: inline
In-Reply-To: <52F3EAF1.9000505@synaptics.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linus.walleij@stericsson.com" <linus.walleij@stericsson.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>

On Thu, Feb 06, 2014 at 09:05:05PM +0100, Christopher Heiny wrote:
> On 02/04/2014 06:31 PM, Courtney Cavin wrote:
> > On Wed, Feb 05, 2014 at 12:08:35AM +0100, Christopher Heiny wrote:
> >> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> >>> Since all the configuration needed for an irq can be provided in other
> >>> ways, remove all gpio->irq functionality. This cleans up the code quite
> >>> a bit.
> >>
> >> In certain diagnostic modes, we need to be able to release the IRQ so
> >> the GPIO can be monitored from userspace.  This patch removes that
> >> capability.
> >>
> >
> > Polling a GPIO from userspace is poor design regardless of the use-case, if
> > you ask me.  It certainly doesn't motivate the extra gpio<->IRQ code.
> 
> Fortunately, neither the in-driver polling implementation nor the user
> space diagnostic applications are implemented that way.

I'm missing something here then.  If the userspace diagnostic
applications do not poll the GPIO, then what exactly is the purpose of
them accessing the GPIO at all?
