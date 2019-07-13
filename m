From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/14] Input: cyapa - Replace devm_add_action() followed
 by failure action with devm_add_action_or_reset()
Date: Sat, 13 Jul 2019 01:52:37 -0700
Message-ID: <20190713085237.GC103820@dtor-ws>
References: <20190708123323.11943-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190708123323.11943-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 08, 2019 at 08:33:23PM +0800, Fuqian Huang wrote:
> devm_add_action_or_reset() is introduced as a helper function which 
> internally calls devm_add_action(). If devm_add_action() fails 
> then it will execute the action mentioned and return the error code.
> This reduce source code size (avoid writing the action twice) 
> and reduce the likelyhood of bugs.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

I'll apply parts of this as the driver should use
devm_device_add_group() for the main sysfs group.

Thanks.

-- 
Dmitry
