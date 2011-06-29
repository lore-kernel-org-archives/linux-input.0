From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add a input_dev_reset callback
Date: Wed, 29 Jun 2011 00:09:27 -0700
Message-ID: <20110629070927.GA10299@core.coreip.homeip.net>
References: <1309325122.2601.3.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38174 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab1F2HJf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 03:09:35 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so640880pwj.19
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 00:09:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309325122.2601.3.camel@ymzhang>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Cc: linux-input@vger.kernel.org

Hi Yanmin,

On Wed, Jun 29, 2011 at 01:25:22PM +0800, Yanmin Zhang wrote:
> From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
> Date: Tue, 28 Jun 2011 10:48:03 +0800
> Subject: [PATCH] input: add a input_dev_reset callback
> 
> input_polled_dev starts a worker if it's opened. During
> suspend-2-ram, kernel need cancel the worker and restart it
> after resuming.

I do not believe that there is an issue. Polled device implementation
uses freezable workqueue to ensure that work is not being executed
during system sleep transition. The work should restart automatically
when workqueue it thawed.

Thanks.

-- 
Dmitry
