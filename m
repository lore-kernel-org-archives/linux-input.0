From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mma8450 - fix module device table type
Date: Mon, 8 Aug 2011 23:46:21 -0700
Message-ID: <20110809064621.GA8017@core.coreip.homeip.net>
References: <1312726487.7287.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:58679 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab1HIGq3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Aug 2011 02:46:29 -0400
Content-Disposition: inline
In-Reply-To: <1312726487.7287.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Eric Miao <eric.miao@linaro.org>, Sammy He <r62914@freescale.com>, linux-input@vger.kernel.org

On Sun, Aug 07, 2011 at 10:14:47PM +0800, Axel Lin wrote:
> The module device table for of_device_id should use "of" type.
> 

Applied, thanks Axel.

-- 
Dmitry
