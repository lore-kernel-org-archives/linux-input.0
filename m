From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: misc : Introduce the use of the managed version
 of kzalloc
Date: Tue, 20 May 2014 08:20:43 -0700
Message-ID: <20140520152042.GA9444@core.coreip.homeip.net>
References: <20140520150918.GA6269@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49991 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbaETPUr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 May 2014 11:20:47 -0400
Content-Disposition: inline
In-Reply-To: <20140520150918.GA6269@himangi-Dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

Hi Himangi,

On Tue, May 20, 2014 at 08:39:18PM +0530, Himangi Saraogi wrote:
> Would be better to add the definition of a
> devm_input_allocate_polled_device, like there is a
> devm_input_allocate_device defined?

There is one, queued for 3.16. You should see it in linux-next.

Thanks.

-- 
Dmitry
