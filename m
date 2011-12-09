From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH 1/1] input: keyboard: Set configuration registers
Date: Fri, 9 Dec 2011 12:10:43 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1751860550@HQMAIL01.nvidia.com>
References: <1323415758-16822-1-git-send-email-srasal@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:6309 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab1LIUKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2011 15:10:49 -0500
In-Reply-To: <1323415758-16822-1-git-send-email-srasal@nvidia.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shridhar Rasal <srasal@nvidia.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "rydberg@euromail.se" <rydberg@euromail.se>, Rakesh Iyer <riyer@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

Shridhar Rasal wrote at Friday, December 09, 2011 12:29 AM:
> To: dmitry.torokhov@gmail.com
> Cc: rydberg@euromail.se; Stephen Warren; Rakesh Iyer; linux-kernel@vger.kernel.org; linux-
> input@vger.kernel.org; linux-tegra@vger.kernel.org; Shridhar Rasal
> Subject: [PATCH 1/1] input: keyboard: Set configuration registers
> 
> -Set only REQUIRED row and column configuration register to
> PROPER values to avoid continuously generating KBC input events.
> -Use *en* field in pin_cfg, to check GPIO_x_ROW_EN register
> should be set or clear.
> 
> Signed-off-by: Shridhar Rasal <srasal@nvidia.com>

I wondered if num==0 could be used instead of a new en field, but 0 is a
valid row/column number, so no. As such,

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic

