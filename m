From: =?UTF-8?B?UmljaGFyZCBSw7ZqZm9ycw==?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: Re: [PATCH 1/2] tsc2007: remove HR timer
Date: Tue, 14 Jul 2009 10:00:06 +0200
Message-ID: <4A5C3B06.7020207@mocean-labs.com>
References: <4A40C288.2060702@mocean-labs.com> <20090714044957.GD2822@dtor-d630.eng.vmware.com> <20090714070806.GA1619@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753222AbZGNIUe@vger.kernel.org>
In-Reply-To: <20090714070806.GA1619@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kwangwoo.lee@gmail.com, Trilok Soni <soni.trilok@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

On 7/14/09 9:08 AM, Thierry Reding wrote:
> * Dmitry Torokhov wrote:
>> Hi Richard,
>>
>> On Tue, Jun 23, 2009 at 01:54:48PM +0200, Richard R=C3=B6jfors wrote=
:
> [...]
>> +static void tsc2007_free_irq(struct tsc2007 *ts)
>> +{
>> +	free_irq(ts->irq, ts);
>> +	if (cancel_delayed_work_sync(&ts->work)) {
>> +		/*
>> +		 * Work was pending, therefore we need to enable
>> +		 * IRQ here to balance the disable_irq() done in the
>> +		 * interrupt handler.
>> +		 */
>> +		enable_irq(ts->irq);
>> +	}
>> +}
> [...]
>> -static int tsc2007_remove(struct i2c_client *client)
>> +static int __devexit tsc2007_remove(struct i2c_client *client)
>>   {
>>   	struct tsc2007	*ts =3D i2c_get_clientdata(client);
>> -	struct tsc2007_platform_data *pdata;
>> +	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
>>
>> -	cancel_delayed_work_sync(&ts->work);
>> +	free_irq(ts->irq, ts);
>> +	if (cancel_delayed_work_sync(&ts->work)) {
>> +		/*
>> +		 * Work was pending, therefore we need to enable
>> +		 * IRQ here to balance the disabel done in the
>> +		 * interrupt handler.
>> +		 */
>> +		enable_irq(ts->irq);
>> +	}
>
> Shouldn't this be tsc2007_free_irq(ts) as well?

Is this really good enough? The work function might re-enable the IRQ.

Isn't it better to look at penstate, we know that the IRQ is enabled if=
=20
the state is UP, else the IRQ is disabled.

--Richard
