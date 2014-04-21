From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add REP_MAX_COUNT to autorepeat parameters
Date: Mon, 21 Apr 2014 13:17:10 -0700
Message-ID: <20140421201710.GA30454@core.coreip.homeip.net>
References: <20140421200008.CBC0F1007B4@puck.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62217 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaDUURO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2014 16:17:14 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so4090691pab.34
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 13:17:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140421200008.CBC0F1007B4@puck.mtv.corp.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: linux-input@vger.kernel.org

Hi Petri,

On Mon, Apr 21, 2014 at 01:00:08PM -0700, Petri Gynther wrote:
> Add REP_MAX_COUNT to autorepeat parameters. This enables an input device to be
> configured for maximum autorepeat count, so that a keypress is not repeated
> forever. This is important for Bluetooth keyboards and remote controls that may
> lose the Bluetooth link at any time, e.g. right after sending a key-down event
> but before sending the corresponding key-up event.

I think this should be solved in the drivers - if link is lost then they
should tear down the device (or generate keyup events if they want to
hand onto the device).

Thanks.

-- 
Dmitry
