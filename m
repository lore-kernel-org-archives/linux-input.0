From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3] input: Add new sun4i-lradc-keys driver
Date: Sat, 20 Dec 2014 11:44:37 +0100
Message-ID: <54955315.3030603@redhat.com>
References: <1418898193-9160-1-git-send-email-hdegoede@redhat.com> <20141218175153.GA34618@dtor-ws>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBHVG2WSAKGQE6PQNDXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141218175153.GA34618@dtor-ws>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 18-12-14 18:51, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Thu, Dec 18, 2014 at 11:23:13AM +0100, Hans de Goede wrote:
>> Allwinnner sunxi SoCs have a low resolution adc (called lradc) which is
>> specifically designed to have various (tablet) keys (ie home, back, search,
>> etc). attached to it using a resistor network. This adds a driver for this.
>>
>> There are 2 channels, currently this driver only supports chan0 since there
>> are no boards known to use chan1.
>>
>> This has been tested on an olimex a10s-olinuxino-micro, a13-olinuxino, and
>> a20-olinuxino-micro.
>>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> --
>> Changes in v2:
>> -Change devicetree bindings to use a per key subnode, like gpio-keys does
>> Changes in v3:
>> -Handle keyup irq flag before irqdown, in case we get both at once
>
> Thank you for making changes. Can you please tell me if the driver still
> works if you drop the patch below on top of it? The changes are:
>
> - split DT parsing into a separate function;
> - make sure keymap is not empty;
> - change 'ret' variable to 'error';

The proposed changes look good, and I've given them a test-spin and everything
still works fine.

Thanks & Regards,

Hans
