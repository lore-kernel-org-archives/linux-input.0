From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] uinput: allow events per packet to be specified
Date: Wed, 2 Mar 2011 15:13:05 +0100
Message-ID: <20110302141305.GA1708@polaris.bitmath.org>
References: <20110301154722.32433.45006.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:56981 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750802Ab1CBOLO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Mar 2011 09:11:14 -0500
Content-Disposition: inline
In-Reply-To: <20110301154722.32433.45006.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: aris@cathedrallabs.org, linux-input@vger.kernel.org

Hi Alan,

> Implement an events per packet interface configuration. We do this by
> adding a new ioctl that must be called before creation and follows the
> pattern of the existing API.
> 
> The behaviour is:
> 	Not set:	input default or value computed by the uinput driver
> 	Set:		value used in preference if larger than computed
> 			value
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---

I agree that adding this ioctl is symmetrical from the a device
emulation standpoint, but I was imagining eventually replacing the eep
with an automatic scheme, or at least with a more realtime-oriented
parameter. Fixating the interface as you propose will make such a
transition much harder.

Thanks,
Henrik
