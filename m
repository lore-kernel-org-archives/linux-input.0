From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Saving kernel module parameters settings
Date: Tue, 22 Nov 2011 10:02:27 +0000
Message-ID: <4ECB7333.5090202@edigma.com>
References: <4ECA20F4.5040503@edigma.com> <20111121173036.GB2362@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:50700 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000Ab1KVKCc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Nov 2011 05:02:32 -0500
In-Reply-To: <20111121173036.GB2362@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dimitry,

Thanks for your reply.

Just to contextualize. I ended up implementing the communication between 
userspace and kernel space with binary attributes. I have only needed to 
implement two of them.

One of those binary attributes is responsible for getting the state to 
be shown on controlpanel and setting the state back to the device based 
on control panel changes.

Basicly, what I need is to have a copy of that binary attribute saved in 
order to load it into module internal state variable when module loads.

Do you think is possible to achieve this goal?

Thanks,

With my best regards,

Nuno


On 11/21/2011 05:30 PM, Dmitry Torokhov wrote:
> On Mon, Nov 21, 2011 at 09:59:16AM +0000, Nuno Santos wrote:
>> Hi,
>>
>> Is there any mechanism to save kernel module parameters/settings in
>> a persistent way?
>>
> If kernel module is built-in then you'd have to adjust kernel command
> line. If module is built as a loadable module then you can stick needed
> settings in a file in /etc/modprobe.d/
>
> Depending on the parameters (i.e. if they programmed to take effect
> immediately - as opposed to, for example, only during new device
> binding) you can have a program adjust them after you boot.
>
> Thanks.
>

