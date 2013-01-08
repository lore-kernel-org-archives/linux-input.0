From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Input: Enable STMPE keypad driver for Device Tree
Date: Tue, 8 Jan 2013 01:26:54 -0800
Message-ID: <20130108092653.GA29695@core.coreip.homeip.net>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-5-git-send-email-lee.jones@linaro.org>
 <20130108083803.GY21994@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130108083803.GY21994@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, arnd@arndb.de
List-Id: linux-input@vger.kernel.org

Hi Lee,

On Tue, Jan 08, 2013 at 08:38:03AM +0000, Lee Jones wrote:
> 
> I'm less than pleased that you _stole_ authorship of this patch!
> 
> Especially, as I've been asking you to review it for some time.

My sincere apologies, it was never my intention to claim anyones work as
my own.

It appears that "stg squash" command (I use stacked git to manage my WIP
queue) produces result with authorship changed to the committer and if
you check the thread you will see that I explicitly mentioned that I
folded the device tree binding documentation (that was also authored by
you) into this patch.

Now that I am looking it appears that sysrq keyreset patch by Mathieu
Poirier was also committed as authored by me, and on that patch I aslo
used "stg squash".

OK, I'll now be aware of this behavior and I will rewind my 'next'
branch and correct the authorship on the commits.

Again, I apologize.

-- 
Dmitry
