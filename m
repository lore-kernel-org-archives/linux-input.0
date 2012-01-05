From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for monotonic event time
 stamps.
Date: Thu, 05 Jan 2012 15:54:59 -0800
Message-ID: <4F063853.9070206@canonical.com>
References: <1325804465-20612-1-git-send-email-john.stultz@linaro.org> <20120105232853.GA1193@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35732 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448Ab2AEXxh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2012 18:53:37 -0500
In-Reply-To: <20120105232853.GA1193@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, Daniel Kurtz <djkurtz@google.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>

On 01/05/2012 03:28 PM, Dmitry Torokhov wrote:
> Hi John,
> 
> On Thu, Jan 05, 2012 at 03:01:05PM -0800, John Stultz wrote:
>>  
>> +	case EVIOCMONTIME:
>> +		if (copy_from_user(&i, p, sizeof(unsigned int)))
>> +			return -EFAULT;
>> +		client->use_monotonic = i;
>> +		return 0;
> 
> Maybe we should let users pass not boolean but CLOCK_* value (and reject
> ones that we do not support) ? This way if someone wants to use some
> other clock type in the future we won't need new ioctl.

Could we also find a way to specify device time? Apple's Magic Mouse and
Magic Trackpad spit out events with their own timestamps. Maybe there
would be other devices that would support high accuracy timestamps too?

-- Chase
