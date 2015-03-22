From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3] input: Add support for ChipOne icn8318
 based touchscreens
Date: Sun, 22 Mar 2015 12:00:55 +0100
Message-ID: <550EA0E7.30608@redhat.com>
References: <1426007133-9606-1-git-send-email-hdegoede@redhat.com> <20150322040305.GA40622@dtor-ws>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORB3OBXKUAKGQE5QAESQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150322040305.GA40622@dtor-ws>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 22-03-15 05:03, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Tue, Mar 10, 2015 at 06:05:33PM +0100, Hans de Goede wrote:
>> +	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq,
>> +					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>
> Shouldn't we let DT data tell us what trigger to use? I.e. just leave
> IRQF_ONESHOT here?

That is an interesting question, that new data is available is signalled by
the irq pin of the chip going low is a property of the chip, not the board
layout, so I believe it is best to leave this as is.

Also note that if we want to get this from devicetree, that simply leaving out the
flag is not enough, we must specifically get the data from devicetree and pass
it into request_irq AFAICT. So the above would change to:

	irqflags = irqd_get_trigger_type(irq_get_irq_data(client->irq)) | IRQF_ONESHOT,
	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq, irqflags,

Regards,

Hans
