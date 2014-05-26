From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: jornada680_kbd: Allocate resources using managed
 interfaces
Date: Sun, 25 May 2014 22:31:40 -0700
Message-ID: <20140526053139.GB12890@core.coreip.homeip.net>
References: <20140524121709.GA6504@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:62312 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbaEZFbm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2014 01:31:42 -0400
Content-Disposition: inline
In-Reply-To: <20140524121709.GA6504@himangi-Dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

On Sat, May 24, 2014 at 05:47:09PM +0530, Himangi Saraogi wrote:
> This patch moves most data allocated in the probe function from
> unmanaged interfaces to managed interfaces. The kfrees and error
> handling code is done away with. Also, the unnecesary labels are
> removed and the function mrstouch_remove is removed as it becomes
> empty after removing the no longer required function calls. Also,
> linux/device.h is added to make sure the devm_*() routine declarations
> are unambiguously available.

Applied, thank you.

-- 
Dmitry
