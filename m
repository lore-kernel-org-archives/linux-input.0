From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] intel_mid_touch: Resync upstream with the
 development tree
Date: Tue, 31 Aug 2010 23:23:05 -0700
Message-ID: <20100901062305.GE23585@core.coreip.homeip.net>
References: <20100825142200.2831.42013.stgit@localhost.localdomain>
 <20100825142217.2831.18768.stgit@localhost.localdomain>
 <20100831221748.GD14846@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44618 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0IAGXM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2010 02:23:12 -0400
Received: by pvg2 with SMTP id 2so2743474pvg.19
        for <linux-input@vger.kernel.org>; Tue, 31 Aug 2010 23:23:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100831221748.GD14846@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org

On Tue, Aug 31, 2010 at 03:17:48PM -0700, Greg KH wrote:
> On Wed, Aug 25, 2010 at 03:22:22PM +0100, Alan Cox wrote:
> > This merges bits from the two diverging trees including code by Andy Ross
> > and Arjan van de Ven
> 
> But it doesn't apply to my staging tree, odd.
> 
> Care to respin it against linux-next?  Is there something in linux-next
> from Dmitry for this driver that might be getting me confused here?

Well, I collected all patches from Alan and applied to my
mrst-touchscreen branch (based off 2.6.35) and added a patch moving it
out of staging and into input. Please take a look and if you do not see
any issues I'll merge it into my 'next' branch for .37.

BTW, I took the liberty of tagging the move patch as Acked-by by both of you
so please shout if you disagree.

Thanks.

-- 
Dmitry
