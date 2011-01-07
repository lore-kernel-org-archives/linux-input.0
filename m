From: Fabien Marteau <fabien.marteau@armadeus.com>
Subject: Re: [PATCH] input: joystick:   Adding Austria Microsystem AS5011
 joystick driver (third version)
Date: Fri, 07 Jan 2011 20:55:36 +0100
Message-ID: <4D276FB8.7030309@armadeus.com>
References: <4D22ECB6.6090800@armadeus.com> <4D22FE0F.7010206@codeaurora.org> <4D276CAD.5090604@armadeus.com> <20110107195000.GD28875@core.coreip.homeip.net>
Reply-To: fabien.marteau@armadeus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110107195000.GD28875@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 07/01/2011 20:50, Dmitry Torokhov wrote:
> On Fri, Jan 07, 2011 at 08:42:37PM +0100, Fabien Marteau wrote:
>> On 04/01/2011 12:01, Trilok Soni wrote:
>>> Hi Fabien,
>>>
>>> On 1/4/2011 3:17 PM, Fabien Marteau wrote:
>>>> +
>>>> +static irqreturn_t as5011_int_interrupt(int irq, void *dev_id)
>>>> +{
>>>> +	struct as5011_platform_data *plat_dat = dev_id;
>>>> +
>>>> +	mutex_lock(&plat_dat->update_lock);
>>>> +	as5011_update_axes(plat_dat);
>>>> +	mutex_unlock(&plat_dat->update_lock);
>>>
>>> Please explain this lock. Sorry if I have missed out your explanation in the earlier threads.
>>
>> If a second interruption occurs the first update must be finished before update again.
> 
> The ISR handler will not be called simultaneously on several CPUs. What
> else can it race with?
> 
Hum in fact nothing I thinks. I will delete it.

Thanks
Fabien
