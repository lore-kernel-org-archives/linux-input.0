From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: Re: [PATCH] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
	laptops
Date: Fri, 19 Mar 2010 23:10:54 +0800
Message-ID: <20100319151054.GA30664@ywang-moblin2.bj.intel.com>
References: <20100319133924.GA30427@ywang-moblin2.bj.intel.com> <20100319135929.GA29027@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40771 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab0CSPTu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Mar 2010 11:19:50 -0400
Content-Disposition: inline
In-Reply-To: <20100319135929.GA29027@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 19, 2010 at 01:59:29PM +0000, Matthew Garrett wrote:
> 
> This probably ought to use the new sparse keymap code. I know that there 
> are drivers that are currently in the tree that don't, but it's probably 
> preferable to avoid adding new ones.
> 

OK, will take a look at the new interface and revise accordingly.

> > +		if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
> > +			code = NOTIFY_BRNUP_MIN;
> > +		else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
> > +			code = NOTIFY_BRNDOWN_MIN;
> 
> Do the brightness keys just send notifications, or do they actually 
> change the brightness? If they actually change the brightness, we 
> shouldn't send input events.
> 

Yes, hardware and bios change brightness by themselves without software intervention
on my Eee PC 1005 when pressing the hotkeys.

Thanks for the review.

-Yong
