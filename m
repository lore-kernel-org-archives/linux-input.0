From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Introduce the use of the managed version of
 kzalloc
Date: Thu, 8 May 2014 09:04:19 -0700
Message-ID: <20140508160419.GB11672@core.coreip.homeip.net>
References: <20140507044638.GA3447@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41826 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbaEHQEX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 12:04:23 -0400
Content-Disposition: inline
In-Reply-To: <20140507044638.GA3447@himangi-Dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

Hi Himangi,

On Wed, May 07, 2014 at 10:16:38AM +0530, Himangi Saraogi wrote:
> This patch moves data allocated using kzalloc to managed data allocated
> using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
> functions.

I prefer not to mix managed and unmanaged resources in one driver. I.e.
either all (or most) resources are managed or they are all unmanaged,
otherwise it is really hard to track which one should be freed and
which will be freed automatically.

In this very simple driver I do not see converting only memory
allocation to devm as bringing clear benefit,

Thanks.

-- 
Dmitry
