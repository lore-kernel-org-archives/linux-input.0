From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 13:53:46 +0000
Message-ID: <20101203135346.GI3182@sirena.org.uk>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com> <20101202212223.GA9864@core.coreip.homeip.net> <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com> <20101203124240.GH3182@sirena.org.uk> <AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:51242 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab0LCNxr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 08:53:47 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Fri, Dec 03, 2010 at 07:03:12AM -0600, Bill Gatliff wrote:
> On Fri, Dec 3, 2010 at 6:42 AM, Mark Brown

> > The sysfs interface offered by polldev is *mostly* doing the same thing

> True, except that there is still no synchronization of the polling
> events between the driver and application.  For example, if the
> polling interval is once per second then the sample ultimately
> delivered to applications could be almost one second old--- even if
> the application reads from the evdev interface once a second as well.

Surely that's what poll() and whatnot are for?  If userspace has to poll
at all that seems to be a failure in itself.
