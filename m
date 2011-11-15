From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 09:41:40 +0000
Message-ID: <4EC233D4.1060302@edigma.com>
References: <4EC10878.20109@edigma.com> <201111141057.42310.dmitry.torokhov@gmail.com> <201111150017.17985.oneukum@suse.de> <201111141534.49608.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:54665 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab1KOJlp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 04:41:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id 954413761902
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:41:43 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjIUymidMeQG for <linux-input@vger.kernel.org>;
	Tue, 15 Nov 2011 09:41:43 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id 406593761901
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:41:42 +0000 (WET)
In-Reply-To: <201111141534.49608.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 11/14/2011 11:34 PM, Dmitry Torokhov wrote:
> On Monday, November 14, 2011 03:17:17 PM Oliver Neukum wrote:
>> Am Montag, 14. November 2011, 19:57:41 schrieb Dmitry Torokhov:
>>> On Monday, November 14, 2011 10:24:17 AM Nuno Santos wrote:
>>>> Hi,
>>>>
>>>> I have defined my first attribute in the following way:
>>>>
>>>> static ssize_t usbtouchscreen_update_sensibility(struct device *dev,
>>>>
>>>>                                           struct device_attribute
>>>>                                           *attr, const char *buf,
>>>>                                           size_t count)
>>>>
>>>> {
>>>>
>>>>       printk(KERN_INFO "update sensibility called");
>>> Updating sensibility is always a good thing but I gather you mean
>>> sensitivity here...
>>>
>>> BTW this should probably be a per-user setting and belong to the X
>>> driver, not kernel driver. I.e. kernel streams all data and userspace
>>> (X) decides what data do discard according to current user
>>> preferences.
>> Hi,
>>
>> before we define yet another interface specific to a driver, could we
>> discuss whether this interface could be applicable to a wider range of
>> devices?
> ... and whether it should be a kernel userspace at all...
>

Well, I can't really tell what it should because i'm little aware of all 
the possibilities provided by the linux OS.

I'm a not a specialist in any OS. However, i'm a daily user of all the 
main operating systems Mac, Windows and Linux.

As a kernel developer I have only developed the device driver for 
Windows 7 and now i'm writing it to Linux.


Thanks,

Nuno

