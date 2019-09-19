From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Date: Thu, 19 Sep 2019 09:17:52 -0700
Message-ID: <20190919161752.GS237523@dtor-ws>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568244975-66795-1-git-send-email-decui@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

Hi Dexuan,

On Wed, Sep 11, 2019 at 11:36:20PM +0000, Dexuan Cui wrote:
> We need hv_kbd_pm_notify() to make sure the pm_wakeup_hard_event() call
> does not prevent the system from entering hibernation: the hibernation
> is a relatively long process, which can be aborted by the call
> pm_wakeup_hard_event(), which is invoked upon keyboard events.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> This patch is basically a pure Hyper-V specific change and it has a
> build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
> suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
> Hyper-V tree's hyperv-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
> 
> I request this patch should go through Sasha's tree rather than the
> input subsystemi's tree.
> 
> Hi Dmitry, can you please Ack?
> 
>  drivers/input/serio/hyperv-keyboard.c | 68 ++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 88ae7c2..277dc4c 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -10,6 +10,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/serio.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  
>  /*
>   * Current version 1.0
> @@ -95,6 +96,9 @@ struct hv_kbd_dev {
>  	struct completion wait_event;
>  	spinlock_t lock; /* protects 'started' field */
>  	bool started;
> +
> +	struct notifier_block pm_nb;
> +	bool hibernation_in_progress;

Why do you use notifier block instead of exposing proper PM methods if
you want to support hibernation?

Thanks.

-- 
Dmitry
