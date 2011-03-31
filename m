From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] Add the support of the touchscreen keypad of tsc2007 .
Date: Wed, 30 Mar 2011 22:33:24 -0700
Message-ID: <20110331053324.GB31630@core.coreip.homeip.net>
References: <1301219192-5293-1-git-send-email-wanlong.gao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42745 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab1CaFdb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2011 01:33:31 -0400
Content-Disposition: inline
In-Reply-To: <1301219192-5293-1-git-send-email-wanlong.gao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: wanlong.gao@gmail.com
Cc: w.sang@pengutronix.de, rpurdie@linux.intel.com, broonie@opensource.wolfsonmicro.com, khali@linux-fr.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiaweiwei.xiyou@gmail.com

Hi Wanlong,

On Sun, Mar 27, 2011 at 05:46:32PM +0800, wanlong.gao@gmail.com wrote:
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Many touchscreens support touch-keypad .
> Open the definition of the TOUCHSCREEN_TSC2007_WITH_KEYPAD, you can
> open the support of the touchscreen's keypad .
> We can add the support of the touchscreen keypad in the driver.
> In this patch , add the ts_key_pos array to determine the position
> of the key's X. And the ts_key_sensitivity can use to detemine the
> key's sensitivity. You can modify the ts_key_pos array for you own
> touchscreen keys . And modify the ts_key_sensitivity for you own
> key's sensitivity .
> If you want to modify the ts_key_map, change the position of the
> keys ,too.

No, this kind of data transformation does not belong to a driver (or,
really in kernel). It is in no way TSC2007 specific (any touchscreen
could be used in place of TSC2007 here).

Do it in userspace and either loop the events back into kernel (after
parsing) via uinput or feed directly into your framework.

Thanks.

-- 
Dmitry
