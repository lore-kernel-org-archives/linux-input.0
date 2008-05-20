From: Pau Oliva Fora <pau@eslack.org>
Subject: Re: [PATCH] Add support for HTC Shift Touchscreen
Date: Tue, 20 May 2008 13:02:34 +0200
Message-ID: <4832AFCA.30701@eslack.org>
References: <482ED31E.2000009@eslack.org> <483198F8.3000201@eslack.org> <20080519112104.ZZRA012@mailhub.coreip.homeip.net> <4832087C.6060009@eslack.org> <20080520014937.GA23247@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 81.184.114.62.dyn.user.ono.com ([81.184.114.62]:38551 "EHLO
	pof.eslack.org." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org
	with ESMTP id S1758071AbYETLCp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 May 2008 07:02:45 -0400
In-Reply-To: <20080520014937.GA23247@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Tue, May 20, 2008 at 01:08:44AM +0200, Pau Oliva Fora wrote:
>> +
>> +static int htcpen_open(struct input_dev *dev)
>> +{
>> +	outb_p(DEVICE_ENABLE, HTCPEN_PORT_INIT);
>> +	return 0;
>> +}
>> +
>> +static void htcpen_close(struct input_dev *dev)
>> +{
>> +	free_irq(HTCPEN_IRQ, dev);
>> +}
>> +
> 
> No, this will not work.. next time you open the device you won't have
> IRQ anymore. You need the opposite of outb_p(DEVICE_ENABLE,
> HTCPEN_PORT_INIT); here.
> 

It is actually working; it also works after suspend/resume without any
issues.

I currently do not know a safe way of disabling the device, as HTC did
not offer any specifications or datasheet when I requested, so everything
in the driver has been reverse engineered.

Let me know if you think it's ok to leave it as is, otherwise I'll try
to find the proper way to disable the device (it should not be much
different than the way of enabling it).

Best Regards,

	Pau Oliva
