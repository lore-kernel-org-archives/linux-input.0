From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] ads7846: Add possibility to use external vref on ads7846
Date: Thu, 05 May 2011 11:33:53 +0100
Message-ID: <4DC27D11.4040808@cam.ac.uk>
References: <1304584346-10407-1-git-send-email-alexander.stein@systec-electronic.com> <201105051144.08104.alexander.stein@systec-electronic.com> <4DC27575.3010207@cam.ac.uk> <201105051216.47370.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40624 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab1EEKb2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 06:31:28 -0400
In-Reply-To: <201105051216.47370.alexander.stein@systec-electronic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 05/05/11 11:16, Alexander Stein wrote:
> Am Donnerstag, 5. Mai 2011, 12:01:25 schrieb Jonathan Cameron:
>> On 05/05/11 10:44, Alexander Stein wrote:
>>> Am Donnerstag, 5. Mai 2011, 11:08:18 schrieb Jonathan Cameron:
>>>> On 05/05/11 09:32, Alexander Stein wrote:
>>>>> Just set vref_mv in your platform config to use external vref.
>>>>> Otherwise the internal one is used.
>>>>
>>>> Would be nicer to see this done with the regulator framework. But then
>>>> if you have a use case on a board where that isn't available, then fair
>>>> enough.
>>>
>>> Well, for the regulator framework I would redesign the driver a bit.
>>> Currently the analogue inputs are displayed as mV in sysfs. If the
>>> current analogue input voltage is shown via the regulator framework the
>>> ads7846 driver itself can shows the actual ADC values. The latter ones
>>> don't need to know the reference voltage.
>>> But I think this is a different problem than choosing the reference
>>> voltage for an ADC for what this patch is for.
>>
>> I'm somewhat confused by what you mean here.  The regulator framework is
>> all about power supplies.  This device would merely be a consumer that
>> asks for what (if anything) is being uspplied to the external vref line.
>> Basically it's a more general alternative to supplying the value via
>> platform data.
> 
> Maybe I did get you wrong. I thought you meant retrieving the voltage at the 
> analogue input somehow using the regulator framework.
> I don't know much about this framework, so how can you handle this: The 
> external vref is board-specific, e.g. hard-wired to 3,3V? There is no 
> regulator which could adjust the voltage attached to ext vref.
Yup, you specify it as a fixed voltage regulator.  The reason to do this
is that others may well wire it up to a variable regulator (typical
embedded pmic chip for example).
