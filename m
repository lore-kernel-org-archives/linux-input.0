From: ulrik.debie-os@e2big.org
Subject: Re: [Asus K501UW] Focaltech touchpad detected as mouse
Date: Mon, 12 Sep 2016 21:23:58 +0200
Message-ID: <20160912192357.wg3xbzj46mrtoexs@lantern>
References: <CAAm8XAZ4mX77jyQ3DVi8c3w=HJkqDfJYkrcmcOQjUgFJJn-+TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:43096 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752439AbcILTYF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Sep 2016 15:24:05 -0400
Content-Disposition: inline
In-Reply-To: <CAAm8XAZ4mX77jyQ3DVi8c3w=HJkqDfJYkrcmcOQjUgFJJn-+TA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Egor Starkov <eastarkov@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Egor,

Looking at the code of focaltech, the first check is for pnp firmware id.
Can you provide the following:
1) output of grep . /sys/bus/serio/devices/serio*/firmware_id
2) content of /proc/bus/input/devices
3) dmesg after startup 

Thanks,
Ulrik
On Sun, Sep 11, 2016 at 09:18:26PM -0500, Egor Starkov wrote:
> Date:   Sun, 11 Sep 2016 21:18:26 -0500
> From: Egor Starkov <eastarkov@gmail.com>
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Subject: [Asus K501UW] Focaltech touchpad detected as mouse
> X-Mailing-List: linux-input@vger.kernel.org
> 
> Hi,
> 
> The Focaltech touchpad on Asus K501UW laptop is detected as a mouse
> (moving the cursor, tapping and pressing physical touchpad buttons
> works, but touchpad-specific features like two-finger scrolling or
> two-finger tap do not).
> 
> The touchpad is recognized in xinput-list as "FTE1001:00 0B05:0101".
> 
> Latest kernel version tested: "Linux version 4.8.0-040800rc5-generic
> (kernel@tangerine) (gcc version 6.2.0 20160830 (Ubuntu
> 6.2.0-2ubuntu11) ) #201609041832 SMP Sun Sep 4 22:34:01 UTC 2016"
> 
> This bug at Launchpad:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1620811
> 
> Best,
> Egor
> 
> [resending the letter since my first one contained html despite my
> best efforts. Sorry for the repetition, if any.]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
