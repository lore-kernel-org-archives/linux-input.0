From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH V10] add 88pm80x onkey driver
Date: Wed, 25 Jul 2012 09:38:44 +0800
Message-ID: <500F4E24.5070603@marvell.com>
References: <1342509459-16976-1-git-send-email-zhouqiao@marvell.com> <20120724223034.GB11304@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:60466 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754418Ab2GYBix (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jul 2012 21:38:53 -0400
In-Reply-To: <20120724223034.GB11304@sortiz-mobl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 07/25/2012 06:30 AM, Samuel Ortiz wrote:
> Hi Zhou
>
> On Tue, Jul 17, 2012 at 03:17:38PM +0800, Qiao Zhou wrote:
>> change log [v10->v9]:
>> 1, change pr_err to dev_err.
>> 2, add device_init_wakeup(,0) when device removes.
>> 3, add ack by Dmitry.
> Patch applied, sorry for the delay.
>
> Cheers,
> Samuel.
>
Samuel,

thanks!

-- 

Best Regards
Qiao
