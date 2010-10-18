From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [Device-drivers-devel] [PATCH 3/3] Input: touchscreen: ad7877
 filter events where pressure is beyond the maximum
Date: Mon, 18 Oct 2010 09:13:14 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713094520E3C@LIMKCMBX1.ad.analog.com>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
 <1287139250-24777-3-git-send-email-michael.hennerich@analog.com>
 <AANLkTimg2Uv26dcU7noSGCX7SHOn2+p6-LH_q=h9NtWc@mail.gmail.com>
 <20101018040810.GB7782@core.coreip.homeip.net>
 <20101018042428.GA23778@core.coreip.homeip.net>
 <20101018042541.GB23778@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:25887 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab0JRINU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 04:13:20 -0400
In-Reply-To: <20101018042541.GB23778@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier.adi@gmail.com>
Cc: Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry Torokhov wrote on 2010-10-18:
> On Sun, Oct 17, 2010 at 09:24:28PM -0700, Dmitry Torokhov wrote:
>> On Sun, Oct 17, 2010 at 09:08:10PM -0700, Dmitry Torokhov wrote:
>>> On Fri, Oct 15, 2010 at 09:51:12PM -0400, Mike Frysinger wrote:
>>>> On Fri, Oct 15, 2010 at 06:40,  <michael.hennerich@analog.com>
> wrote:
>>>>> Suppress events where pressure > pressure_max.
>>>>> These events come typically along with inaccurate X and Y
> samples.
>>>>
>>>> were you going to commit to the blackfin tree ?
>>>>
>>>>> --- a/drivers/input/touchscreen/ad7877.c
>>>>> +++ b/drivers/input/touchscreen/ad7877.c
>>>>> @@ -360,6 +360,13 @@ static int ad7877_rx(struct ad7877 *ts)
>>>>>                Rt /= z1;
>>>>>                Rt = (Rt + 2047) >> 12;
>>>>>
>>>>> +               /* +                * Sample found inconsistent,
>>>>> pressure is beyond +                * the maximum. Don't report it
>>>>> to user space. +                */ +               if (Rt >
>>>>> ts->pressure_max) +                       return -EINVAL;
>>>>
>>>> this has spaces in the middle of your tab indents ...
>>>
>>> I took care of that on my side...
>>>
>>
>> BTW, I have a couple more small patches to the driver... Here is the
>> first:
>>
>
> And here is second:
>
> Input: ad7877 - switch to using threaded IRQ
>
> Instead of using asynchronous SPI API and then spinning waiting for
> SPI transfer to complete when disabling the device, let's use threaded
> IRQ model and spi_sync().

Tested on hardware - works great!

>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>
>  drivers/input/touchscreen/ad7877.c |   65 ++++++++++++++--------------
>  -------- 1 files changed, 25 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7877.c
> b/drivers/input/touchscreen/ad7877.c index 326d733..a1952fc 100644 ---
> a/drivers/input/touchscreen/ad7877.c +++
> b/drivers/input/touchscreen/ad7877.c @@ -191,13 +191,12 @@ struct ad7877
> {
>       struct spi_message      msg;
>
>       struct mutex            mutex;
> -     unsigned                disabled:1;     /* P: mutex */
> -     unsigned                gpio3:1;        /* P: mutex */
> -     unsigned                gpio4:1;        /* P: mutex */
> +     bool                    disabled;       /* P: mutex */
> +     bool                    gpio3;          /* P: mutex */
> +     bool                    gpio4;          /* P: mutex */
>
>       spinlock_t              lock;
>       struct timer_list       timer;          /* P: lock */
> -     unsigned                pending:1;      /* P: lock */
>
>       /*
>        * DMA (thus cache coherency maintenance) requires the @@ -333,7
> +332,7 @@ static int ad7877_read_adc(struct spi_device *spi, unsigned
> command)
>       return status ? : sample;
>  }
> -static int ad7877_rx(struct ad7877 *ts)
> +static int ad7877_process_data(struct ad7877 *ts)
>  {    struct input_dev *input_dev = ts->input;        unsigned Rt; @@ -374,6
>  +373,7 @@ static int ad7877_rx(struct ad7877 *ts)
>               input_report_abs(input_dev, ABS_Y, y);          input_report_abs(input_dev,
>  ABS_PRESSURE, Rt);           input_sync(input_dev); +                return 0;       }
> @@ -392,64 +392,49 @@ static inline void ad7877_ts_event_release(struct
> ad7877 *ts)  static void ad7877_timer(unsigned long handle)  {
>       struct ad7877 *ts = (void *)handle;
> +     unsigned long flags;
>
> +     spin_lock_irqsave(&ts->lock, flags);
>       ad7877_ts_event_release(ts); +  spin_unlock_irqrestore(&ts->lock,
>  flags); }
>
>  static irqreturn_t ad7877_irq(int irq, void *handle)  {
>       struct ad7877 *ts = handle;
>       unsigned long flags;
> -     int status;
> +     int error;
>
> -     /* -     * The repeated conversion sequencer controlled by TMR kicked off
> -      * too fast. We ignore the last and process the sample sequence -        *
> currently in the queue. It can't be older than 9.4ms, and we -         * need
> to avoid that ts->msg doesn't get issued twice while in work. -        */
> +     error = spi_sync(ts->spi, &ts->msg); +  if (error) {
> +             dev_err(&ts->spi->dev, "spi_sync --> %d\n", error); +           goto out; +     }
>
>       spin_lock_irqsave(&ts->lock, flags);
> -     if (!ts->pending) {
> -             ts->pending = 1;
> -
> -             status = spi_async(ts->spi, &ts->msg);
> -             if (status)
> -                     dev_err(&ts->spi->dev, "spi_sync --> %d\n", status);
> -     }
> +     error = ad7877_process_data(ts);
> +     if (!error)
> +             mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
>       spin_unlock_irqrestore(&ts->lock, flags);
> +out:
>       return IRQ_HANDLED;
>  }
> -static void ad7877_callback(void *_ts) -{
> -     struct ad7877 *ts = _ts;
> -
> -     spin_lock_irq(&ts->lock);
> -     if (!ad7877_rx(ts))
> -             mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
> -     ts->pending = 0;
> -     spin_unlock_irq(&ts->lock);
> -}
> -
>  static void ad7877_disable(struct ad7877 *ts)  {
>       mutex_lock(&ts->mutex);
>
>       if (!ts->disabled) {
> -             ts->disabled = 1;
> +             ts->disabled = true;
>               disable_irq(ts->spi->irq);
> -             /* Wait for spi_async callback */
> -             while (ts->pending)
> -                     msleep(1);
> -
>               if (del_timer_sync(&ts->timer))                         ad7877_ts_event_release(ts);    }
> -     /* we know the chip's in lowpower mode since we always
> +     /*
> +      * We know the chip's in lowpower mode since we always
>        * leave it that way after every request
>        */
> @@ -461,7 +446,7 @@ static void ad7877_enable(struct ad7877 *ts)
>       mutex_lock(&ts->mutex);
>
>       if (ts->disabled) {
> -             ts->disabled = 0;
> +             ts->disabled = false;
>               enable_irq(ts->spi->irq);
>       }
> @@ -672,7 +657,6 @@ static void ad7877_setup_ts_def_msg(struct
> spi_device *spi, struct ad7877 *ts)
>
>       spi_message_init(m);
> -     m->complete = ad7877_callback;
>       m->context = ts;
>
>       ts->xfer[0].tx_buf = &ts->cmd_crtl1; @@ -795,8 +779,9 @@ static int
> __devinit ad7877_probe(struct spi_device
> *spi)
>
>       /* Request AD7877 /DAV GPIO interrupt */
> -     err = request_irq(spi->irq, ad7877_irq, IRQF_TRIGGER_FALLING,
> -                     spi->dev.driver->name, ts);
> +     err = request_threaded_irq(spi->irq, NULL, ad7877_irq,
> +                                IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +                                spi->dev.driver->name, ts);
>       if (err) {
>               dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
>               goto err_free_mem;

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif


