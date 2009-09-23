From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH v3 1/2] Input: Add DaVinci DM365 Keypad support
Date: Wed, 23 Sep 2009 08:58:19 -0600
Message-ID: <4ABA378B.2070800@ridgerun.com>
References: <1253217996-11548-1-git-send-email-miguel.aguilar@ridgerun.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD916A60@dbde02.ent.ti.com> <4AB39A00.8080405@ridgerun.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD991DD8@dbde02.ent.ti.com> <4AB8D89D.6050409@ridgerun.com> <871vlyev8g.fsf@deeprootsystems.com> <20090923034627.GA1458@core.coreip.homeip.net> <B85A65D85D7EB246BE421B3FB0FBB59301DDA2CC8D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:35539 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbZIWO6W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 10:58:22 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2CC8D@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>

Sekhar,

Nori, Sekhar wrote:
> On Wed, Sep 23, 2009 at 09:16:27, Dmitry Torokhov wrote:
>> On Tue, Sep 22, 2009 at 10:37:35AM -0700, Kevin Hilman wrote:
>>> Miguel Aguilar <miguel.aguilar@ridgerun.com> writes:
>>>
>>>> Sekhar,
>>>>
>>>> If you and Sneha agree I will write driver in terms of davinci instead of dm365.
>>>>
>>> I add a vote the davinci* naming instead of dm365*.
>>>
>> Can you guarantee that this will be the only keypad implementation for
>> davinci?
> 
> No. That cannot be guaranteed. Surely there will be attempt to reuse
> this before inventing new. A new implementation will be a probably be
> a new driver (named after what the new implementation is called).
> 
> So, I guess it is better to call this driver "davinci-keyscan" after

[MA] Do you think that it is better naming this driver as Key Scan instead of 
Keypad?

> what the IP has been called (http://focus.ti.com/lit/ug/sprufi8/sprufi8.pdf).
> 
>> If not then I'd say using base model number and updating
>> Kconfig text is fine.
> 
> But hope the other way is okay too. Miguel has already submitted a new
> patch using davinci naming.
> 
> Thanks,
> Sekhar
> 

Thanks,

Miguel Aguilar

