From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: Re: [PATCH] Input: pwm-beeper - fix: scheduling while atomic
Date: Thu, 19 May 2016 09:52:53 +0200
Message-ID: <573D70D5.7070401@gmx.at>
References: <56C4735E.6020300@gmx.at> <20160222194639.GD26177@dtor-ws>
 <20160512121852.GB26824@ulmo.ba.sec> <5735F4E3.20008@gmx.at>
 <573C8761.9070601@gmx.at> <20160518160601.GB5407@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:54076 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbcESHxF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 03:53:05 -0400
In-Reply-To: <20160518160601.GB5407@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016-05-18 18:06, Greg Kroah-Hartman wrote:
> On Wed, May 18, 2016 at 05:16:49PM +0200, Manfred Schlaegl wrote:
>> Pwm config may sleep so defer it using a worker.
>>
>> Trigger:
>> On a Freescale i.MX53 based board we ran into "BUG: scheduling while
>> atomic" because input_inject_event locks interrupts, but
>> imx_pwm_config_v2 sleeps.
>>
>> Tested on Freescale i.MX53 SoC with 4.6.0 and 4.1.24.
>>
>> Unmodified applicable to
>>  * 4.6    (stable)
>>  * 4.5.4  (stable)
>>  * 4.4.10 (longterm)
>>  * 4.1.24 (longterm)
>>
>> Modified applicable to
>>  * 3.18.33 (longterm)
> 
> What does this all mean?  Have you read
> Documentation/stable_kernel_rules.txt for how to mark things for stable
> inclusion?
> 
> thanks,
> 
> greg k-h
> 

Sorry, I'm afraid I missed that. Thanks for the clarification. I will respect that in the future.

Should I resend the patch with a cleaned up message (without "Unmodified applicable to" and "Modified applicable to" stuff)?
Is the rest of message (formally) ok?

thanks,
manfred

