From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9 0/9] Goodix touchscreen enhancements
Date: Mon, 26 Oct 2015 16:32:48 -0700
Message-ID: <20151026233248.GB26171@dtor-pixel>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
 <1445871989.31107.4.camel@hadess.net>
 <20151026182112.GA1800@excalibur.cnev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34807 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbJZXcx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 19:32:53 -0400
Content-Disposition: inline
In-Reply-To: <20151026182112.GA1800@excalibur.cnev.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>
Cc: Bastien Nocera <hadess@hadess.net>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Oct 26, 2015 at 07:21:12PM +0100, Karsten Merker wrote:
> On Mon, Oct 26, 2015 at 04:06:29PM +0100, Bastien Nocera wrote:
> > On Mon, 2015-10-12 at 18:24 +0300, Irina Tirdea wrote:
> 
> > > v9 only adds GPIOLIB dependency in Kconfig for patch 2:
> > > "Input: goodix - reset device at init". There are no other code
> > > changes from v8.
> > > 
> > > Thanks for testing these changes, Bastien and Aleksei!
> > > 
> > > Karsten, there is no need to rebase your series on top of v9.
> > 
> > Are we waiting on anything else before merging this? I'd like it to be
> > scheduled to be merged so I can start focusing on the subsequent and
> > dependent patches for that same driver.
> 
> Hello,
> 
> AFAICS there is one open point (cf. 
> http://www.spinics.net/lists/linux-input/msg41567.html) which
> Irina wanted to address in a v10 of the patchset (cf. 
> http://www.spinics.net/lists/linux-input/msg41642.html).

There is also the whole thing about insane handling of named gpios in
ACPI layer, which stops me from merging the reset code since these gpios
should be marked as optional and we should stop ignoring errors coming
from gpiolib.

Thanks.

-- 
Dmitry
