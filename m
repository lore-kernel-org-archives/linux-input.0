From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] Input: ambakmi - Convert to use devm_*()
Date: Sun, 26 Mar 2017 23:23:54 +0800
Message-ID: <20170326152354.GA11555@leoy-linaro>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
 <20170326145023.GO7909@n2100.armlinux.org.uk>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBC4IFTUFXEFBBFN237DAKGQETVTALMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170326145023.GO7909-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Mar 26, 2017 at 03:50:24PM +0100, Russell King - ARM Linux wrote:
> On Sun, Mar 26, 2017 at 10:41:50PM +0800, Leo Yan wrote:
> > Convert driver to use devm_*() APIs so rely on driver model core layer
> > to manage resources. This eliminates error path boilerplate and makes
> > code neat.
> > 
> > This patch also fixes the memory leakage for 'kmi->io' when remove
> > module.
> 
> No, it is not leaked, in fact, your patch introduces a use-after-free
> bug.
> 
> kmi->io is of type "struct serio", and this structure has an embedded
> "struct device".  The lifetime of any structure containing a "struct
> device" is controlled by the lifetime of the struct device.
> 
> Once serio_register_port() has been called on it, it is up to the
> serio layer to free this structure.
> 
> Therefore, your patch creates a bug, and so it gets a NAK.  There is no
> resource leakage here.

Thanks for reviewing. Now I understood and please ignore this patch
and patch 0005.

Thanks,
Leo Yan

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
