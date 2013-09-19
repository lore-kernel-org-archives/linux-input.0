From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Thu, 19 Sep 2013 06:33:37 +0100
Message-ID: <39ea39e8-2d11-4c84-ac49-33fdcfa870ed@email.android.com>
References: <1379393047-11772-1-git-send-email-zubair.lutfullah@gmail.com> <1379393047-11772-3-git-send-email-zubair.lutfullah@gmail.com> <20130918042726.GB13196@core.coreip.homeip.net> <20130918065406.GA13451@gmail.com> <53771776-0d33-436d-9687-995ed0d6345d@email.android.com> <20130918141533.GA16424@core.coreip.homeip.net> <b37c9a0e-36ed-49bf-bb68-453c7b07b437@email.android.com> <20130918162442.GA14803@core.coreip.homeip.net> <c141b8a3-1e5d-406c-bcc4-ef0abec56192@email.android.com> <20130919051611.GA4363@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130919051611.GA4363-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org



"Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>On Wed, Sep 18, 2013 at 06:05:12PM +0100, Jonathan Cameron wrote:
>> 
>> >> >However in this case such conversion us dangerous. With all but
>IRQ
>> >> >resource managed by the traditional methods they will be released
>> >first
>> >> >with IRQ handler deregistered very last. Therefore if device is
>not
>> >> >properly quiesced IRQ raised during driver unbinding is likely to
>> >> >result
>> >> >in kernel oops.
>> >> >
>> >> >IOW devm_request_irq() is very often evil (it is still useful if
>> >_all_
>> >> >your resources are managed by devm_*).
>> >> >
>> >> >In case of your driver I'd recommend switching to
>> >> >request_irq()/free_irq() instead.
>> >> >
>> >> >Thanks.
>> >> 
>> >> Pretty much all resources are devm managed in here
>> >> 
>> >>
>>
>>https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/drivers/iio/adc/ti_am335x_adc.c?h=togreg&id=7a1aeba7ed0d5a1e83fd5a8ee2a2869430d40347
>> >
>> >
>> >So we are guaranteed that that new kfifo that is being allocated
>just
>> >before we requesting IRQ and will be freed way before we free the
>IRQ
>> >will not be used by the IOTQ handler?
>> >
>> >Thanks.
>> Good point. I forgot about that.  The source of interrupts 'should'
>be disabled before the kfifo is freed but I guess perhaps better to
>play it safe. Would take a fair bit of review to be sure that is not
>going to cause grief.
>> 
>> A few more devm handlers need writing before it is truly useful here.
>> 
>> Thanks for pointing this out.
>> 
>> J
>
>If I understand the conclusion correctly, no devm here?

No devm for the irq. The rest are fine.
>
>Zubair
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
