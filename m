From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input : avoid too late kobject_uevent(KOBJ_REMOVE) call
Date: Tue, 19 Feb 2019 10:55:58 -0800
Message-ID: <20190219185558.GA210481@dtor-ws>
References: <1550484563-13217-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550484563-13217-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Kay Sievers <kay@vrfy.org>, syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
List-Id: linux-input@vger.kernel.org

Hi Tetsuo,

On Mon, Feb 18, 2019 at 07:09:23PM +0900, Tetsuo Handa wrote:
> syzbot is hitting use-after-free bug in uinput module [1]. This is because
> kobject_uevent(KOBJ_REMOVE) is called again due to commit 0f4dafc0563c6c49
> ("Kobject: auto-cleanup on final unref") after memory allocation fault
> injection made kobject_uevent(KOBJ_REMOVE) from device_del() from
> input_unregister_device() fail, while uinput_destroy_device() is expecting
> that kobject_uevent(KOBJ_REMOVE) is not called after device_del() from
> input_unregister_device() completed.
> 
> Fix this problem by pretending as if kobject_uevent(KOBJ_REMOVE) from
> device_del() from input_unregister_device() did not fail.
> 
> [1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d
> 
> Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
> Analyzed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Kay Sievers <kay@vrfy.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/input/input.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 3304aaaffe87..6df3c33ef3aa 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2032,6 +2032,19 @@ static void __input_unregister_device(struct input_dev *dev)
>  	mutex_unlock(&input_mutex);
>  
>  	device_del(&dev->dev);
> +	/*
> +	 * Regarding input subsystem, we always take care of sending uevent at
> +	 * "unregister" time, and we do not expect to have uevent sent out at
> +	 * the final "put" time. Therefore, if we failed to send uevent at
> +	 * "unregister" time (due to e.g. fault injection), complain it and
> +	 * do not allow the final "put" time to send the remove uevent again.
> +	 */
> +	if (dev->dev.kobj.state_add_uevent_sent &&
> +	    !dev->dev.kobj.state_remove_uevent_sent) {
> +		dev->dev.kobj.state_remove_uevent_sent = 1;
> +		pr_warn("Failed to send remove uevent for %s\n",
> +			dev_name(&dev->dev));

Input has no business reaching into kobj internals. This should be
solved in lib/kobject_uevent.c, not anywhere else.

Thanks.

-- 
Dmitry
