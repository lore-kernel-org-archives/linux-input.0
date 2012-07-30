From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] Report wake_events for some button presses.
Date: Sun, 29 Jul 2012 22:49:09 -0700
Message-ID: <20120730054909.GA5830@core.coreip.homeip.net>
References: <20120730010746.22579.52841.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120730010746.22579.52841.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 30, 2012 at 11:09:01AM +1000, NeilBrown wrote:
> To avoid racing with suspend, we need to report wakeup events to the
> pm subsystem when they happen.
> These two patches do this for gpio_keys and twl4030-pwrbutton.
> 
> ---
> 
> NeilBrown (2):
>       Input: twl4030-pwrbutton: report a wakeup_event on button press.
>       Input: gpio_keys: report a wakeup_event for a button press on a wake_up button.
> 

Applied both, thanks Neil.

-- 
Dmitry
