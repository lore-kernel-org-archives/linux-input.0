From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: twl6040-vibra - use devm_regulator_bulk_get()
Date: Thu, 24 Apr 2014 23:36:58 -0700
Message-ID: <20140425063658.GB10433@core.coreip.homeip.net>
References: <1398390004-20535-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:41118 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaDYGhB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 02:37:01 -0400
Received: by mail-pb0-f53.google.com with SMTP id jt11so1124113pbb.12
        for <linux-input@vger.kernel.org>; Thu, 24 Apr 2014 23:37:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398390004-20535-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: peter.ujfalusi@ti.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Thu, Apr 24, 2014 at 10:40:04PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as we
> do not need to call regulator_bulk_free() in the error and remove paths.

Can we complete the conversion and use devm_input_allocate_device() as
well?

Thanks.

-- 
Dmitry
