From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Date: Mon, 10 Jun 2013 11:15:33 +0200
Message-ID: <51B59935.3010506@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de> <51B4B024.8070102@metafoo.de> <51B582D3.1050501@linutronix.de> <51B59071.9090908@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51B59071.9090908-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/10/2013 10:38 AM, Lars-Peter Clausen wrote:
> 
> You don't need to describe the channels in devicetree, except setting the
> "#io-channel-cells" property of your ADC node to 1. You also need to initialize
> the of_node property of your iio_device's struct's 'dev' field to the your adc
> node.

Aha. So right now I do have in my device tree:

       adc {
               ti,adc-channels = <4>;
       };

for the producer ADC node. But this seems wrong. Correct would be


       adctsc: adc {
               ti,adc-channels = <4>;
               #io-channel-cells = <1>;
       };

And the consumer can then specify everything. This seems to be looking
good. And with this the map piece can die.
Thanks.

> 
> After that it's just a matter of using, e.g.
> 
> 	io-channels = <&adc 1>;
> 	io-channel-names = "voltage";
> 
> in your consumer.
> 
> - Lars

Sebastian
