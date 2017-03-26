From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] Convert to use devm_*() for amba attached modules
Date: Sun, 26 Mar 2017 23:38:55 +0800
Message-ID: <20170326153855.GA14404@leoy-linaro>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <20170326152050.v47z36eud6xvrcpt@piout.net>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBC4IFTUFXEFBBGWB37DAKGQEIIZ4QRY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170326152050.v47z36eud6xvrcpt-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Mar 26, 2017 at 05:20:50PM +0200, Alexandre Belloni wrote:
> On 26/03/2017 at 22:41:49 +0800, Leo Yan wrote:
> > When review device driver modules which attach to amba bus, found
> > several modules are not using devm_*() apis to manage resource. As
> > result, some drivers have memory leakage or missing iomem unmapping
> > when rmmod module. And the code has many "goto" tags to handle
> > different failures.
> > 
> > So this patch series is to convert to use devm_*() for moudules which
> > are attached to amba bus to manage resource and get more robust and
> > neat code.
> > 
> > Patch 0003 "drivers/rtc/rtc-pl031.c: Convert to use devm_*()" has been
> > verified on 96boards Hikey. Other patches can pass building but have
> > not really tested on hardware.
> > 
> 
> If your plan is to actually remove usage of
> amba_request_regions() and amba_release_regions(), you should do so in
> its own patch sets instead of hiding that in a useless cleanup series.

Just curious, from Russell's replying for patch 0005, IIUC we cannot
totally remove usage of amba_request_regions() and
amba_release_regions(), there have some coner case should use
amba_request_regions() + ioremap().

Does it make sense to remove most usage of amba_request_regions() and
amba_release_regions() but we still keep these two functions in the kernel?

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
