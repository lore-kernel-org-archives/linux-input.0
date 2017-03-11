From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] tps6507x-ts: update to devm_* API
Date: Fri, 10 Mar 2017 16:29:02 -0800
Message-ID: <20170311002902.GA7384@dtor-ws>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
 <1489069869-3849-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35185 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdCKA3G (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 19:29:06 -0500
Received: by mail-pg0-f66.google.com with SMTP id g2so7348943pge.2
        for <linux-input@vger.kernel.org>; Fri, 10 Mar 2017 16:29:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1489069869-3849-2-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-input@vger.kernel.org, lee.jones@linaro.org, robh@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com, nsekhar@ti.com, khilman@baylibre.com

On Thu, Mar 09, 2017 at 03:31:07PM +0100, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Update the code to use devm_* API so that driver
> core will manage resources.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>


Applied, thank you. We can continue discussing DT conversion, but this
patch is good as is.

Thanks.

-- 
Dmitry
