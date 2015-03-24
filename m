From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] input: Add support for ChipOne icn8318
 based touchscreens
Date: Tue, 24 Mar 2015 11:33:09 -0700
Message-ID: <20150324183309.GA27693@dtor-ws>
References: <1426007133-9606-1-git-send-email-hdegoede@redhat.com>
 <20150322040305.GA40622@dtor-ws>
 <550EA0E7.30608@redhat.com>
 <20150322224214.GA9792@dtor-ws>
 <5511A29F.1010404@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRB2O3Y2UAKGQEP77T4HI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5511A29F.1010404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 24, 2015 at 06:45:03PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 03/22/2015 11:42 PM, Dmitry Torokhov wrote:
> >On Sun, Mar 22, 2015 at 12:00:55PM +0100, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 22-03-15 05:03, Dmitry Torokhov wrote:
> >>>Hi Hans,
> >>>
> >>>On Tue, Mar 10, 2015 at 06:05:33PM +0100, Hans de Goede wrote:
> >>>>+	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq,
> >>>>+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >>>
> >>>Shouldn't we let DT data tell us what trigger to use? I.e. just leave
> >>>IRQF_ONESHOT here?
> >>
> >>That is an interesting question, that new data is available is signalled by
> >>the irq pin of the chip going low is a property of the chip, not the board
> >>layout, so I believe it is best to leave this as is.
> >
> >My concern is that even if pin behavior is property of chip maybe on
> >some boards we want to use level-triggered interrupts instead of edge?
> >And if we indeed want to hard-code the trigger then shouldn't the
> >binding document use onecell mapping (so that users do not attempt to
> >configure triggers from DT)?
> 
> The number of irq cells is specified by the interrupt controller driver
> rather then by the device binding.
> 
> >
> >>
> >>Also note that if we want to get this from devicetree, that simply leaving out the
> >>flag is not enough, we must specifically get the data from devicetree and pass
> >>it into request_irq AFAICT. So the above would change to:
> >>
> >>	irqflags = irqd_get_trigger_type(irq_get_irq_data(client->irq)) | IRQF_ONESHOT,
> >>	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq, irqflags,
> >
> >No, of_irq_get() that i2c core calls before probing driver should
> >already set the trigger type for us. There is no need for the individual
> >drivers to do that.
> 
> Ah I see, ok I've just tested removing the IRQF_TRIGGER_FALLING flag and indeed
> things still work fine, so feel free to merge this patch with that flagged dropped.

OK, thanks, queued for 4.1.

Thanks.

-- 
Dmitry
