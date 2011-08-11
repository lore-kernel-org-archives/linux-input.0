From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] Input: tegra-kbc - correct call to
 input_free_device
Date: Thu, 11 Aug 2011 09:51:34 -0700
Message-ID: <20110811165134.GA24861@core.coreip.homeip.net>
References: <1313052569.2139.1.camel@phoenix>
 <74CDBE0F657A3D45AFBB94109FB122FF04AEA24C0A@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37368 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1HKQvl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2011 12:51:41 -0400
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04AEA24C0A@HQMAIL01.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Axel Lin <axel.lin@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rakesh Iyer <riyer@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Aug 11, 2011 at 09:42:54AM -0700, Stephen Warren wrote:
> Axel Lin wrote at Thursday, August 11, 2011 2:49 AM:
> > If kzalloc for kbc fails, then we have NULL pointer dereference while
> > calling input_free_device(kbc->idev) in the error handling.
> > So it is safer to always use the original name, input_dev.
> > 
> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
> 
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Gah, sorry, already pushed into my public branch so won't be able so
add your reviewed-by...

-- 
Dmitry
