From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend 2/2] Input: twl6040-vibra: Code cleanup in probe
 with devm_* conversion
Date: Thu, 10 Jan 2013 09:54:21 -0800
Message-ID: <20130110175421.GC2797@core.coreip.homeip.net>
References: <1357824965-30614-1-git-send-email-peter.ujfalusi@ti.com>
 <1357824965-30614-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:59639 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab3AJRyY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jan 2013 12:54:24 -0500
Content-Disposition: inline
In-Reply-To: <1357824965-30614-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Jan 10, 2013 at 02:36:05PM +0100, Peter Ujfalusi wrote:
> Convert the probe to use devm_*. At the same time reorder the calls
> so we will register the input device as the last step when the driver
> is loaded.

If you are doing this please also use devm_input_allocate_device() and
devm_regulator_bulk_get(). I alos think it is high time to get rid of
dedicated work queue - cwq hasn't actually given you a separate therad
for a while now and if you get rid of workqueue you can get ridof entire
twl6040_vibra_remove().

Thanks.

-- 
Dmitry
