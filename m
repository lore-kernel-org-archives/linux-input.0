From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] HID: hidraw: replace printk() with corresponding
 pr_xx() variant
Date: Thu, 19 Sep 2019 09:16:13 -0700
Message-ID: <20190919161613.GR237523@dtor-ws>
References: <20190912203119.GC636@penguin>
 <1568824151-12668-1-git-send-email-gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568824151-12668-1-git-send-email-gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rishi Gupta <gupt21@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Rishi,

On Wed, Sep 18, 2019 at 09:59:11PM +0530, Rishi Gupta wrote:
> This commit replaces direct invocations of printk with
> their appropriate pr_info/warn() variant.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v2:
> - Removed manually adding prefix "hidraw:".
> 
>  drivers/hid/hidraw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 006bd6f..2d082f3 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -197,14 +197,14 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
>  	}
>  
>  	if (count > HID_MAX_BUFFER_SIZE) {
> -		printk(KERN_WARNING "hidraw: pid %d passed too large report\n",
> +		pr_warn("pid %d passed too large report\n",
>  				task_pid_nr(current));

It looks like here and in the instance below you actually have a hid
device, so you can use hid_warn() instead of pr_warn(), similarly to
hidraw_send_report().

The change to pr_info() in hidraw_init() is good.

Thanks.

-- 
Dmitry
