From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 09:38:37 +0000
Message-ID: <4EC2331D.1040107@edigma.com>
References: <4EC10878.20109@edigma.com> <4EC15CD1.2010409@edigma.com> <201111141057.42310.dmitry.torokhov@gmail.com> <201111150017.17985.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:43520 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378Ab1KOJil (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 04:38:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id 857D937618E0
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:38:40 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5UJ0-tJCQy2B for <linux-input@vger.kernel.org>;
	Tue, 15 Nov 2011 09:38:40 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id E640737618D9
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:38:39 +0000 (WET)
In-Reply-To: <201111150017.17985.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 11/14/2011 11:17 PM, Oliver Neukum wrote:
> Am Montag, 14. November 2011, 19:57:41 schrieb Dmitry Torokhov:
>> On Monday, November 14, 2011 10:24:17 AM Nuno Santos wrote:
>>> Hi,
>>>
>>> I have defined my first attribute in the following way:
>>>
>>> static ssize_t usbtouchscreen_update_sensibility(struct device *dev,
>>>                                           struct device_attribute *attr,
>>>                                           const char *buf, size_t count)
>>> {
>>>
>>>       printk(KERN_INFO "update sensibility called");
>>>
>> Updating sensibility is always a good thing but I gather you mean
>> sensitivity here...
>>
>> BTW this should probably be a per-user setting and belong to the X driver,
>> not kernel driver. I.e. kernel streams all data and userspace (X) decides
>> what data do discard according to current user preferences.
> Hi,
>
> before we define yet another interface specific to a driver, could we discuss
> whether this interface could be applicable to a wider range of devices
Of course. If I can contribute with my little experience for something I 
would have all the pleasure.

Do you guyz want me to describe my case in detail?

With my best regards,

Nuno
