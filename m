From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input: keyboard: Set configuration registers
Date: Fri, 09 Dec 2011 13:25:06 -0800
Message-ID: <3849551.l2KNPKMSmh@dtor-d630.eng.vmware.com>
References: <1323415758-16822-1-git-send-email-srasal@nvidia.com> <74CDBE0F657A3D45AFBB94109FB122FF1751860550@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60216 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab1LIVZQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2011 16:25:16 -0500
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1751860550@HQMAIL01.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Shridhar Rasal <srasal@nvidia.com>, "rydberg@euromail.se" <rydberg@euromail.se>, Rakesh Iyer <riyer@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On Friday, December 09, 2011 12:10:43 PM Stephen Warren wrote:
> Shridhar Rasal wrote at Friday, December 09, 2011 12:29 AM:
> > To: dmitry.torokhov@gmail.com
> > Cc: rydberg@euromail.se; Stephen Warren; Rakesh Iyer;
> > linux-kernel@vger.kernel.org; linux- input@vger.kernel.org;
> > linux-tegra@vger.kernel.org; Shridhar Rasal Subject: [PATCH 1/1] input:
> > keyboard: Set configuration registers
> > 
> > -Set only REQUIRED row and column configuration register to
> > PROPER values to avoid continuously generating KBC input events.
> > -Use *en* field in pin_cfg, to check GPIO_x_ROW_EN register
> > should be set or clear.
> > 
> > Signed-off-by: Shridhar Rasal <srasal@nvidia.com>
> 
> I wondered if num==0 could be used instead of a new en field, but 0 is a
> valid row/column number, so no. As such,
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Can we pass in number of pin_cfg instances in pdata and simply do not
mention unneeded pins instead?

Thanks.

-- 
Dmitry
