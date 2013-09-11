From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH 1/2] uinput: Support injecting multiple events in one
 write() call
Date: Wed, 11 Sep 2013 10:29:41 +1000
Message-ID: <522FB975.4010508@gmail.com>
References: <1378855973-11595-1-git-send-email-rmallon@gmail.com> <20130911001428.GB5840@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40786 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab3IKA3p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Sep 2013 20:29:45 -0400
In-Reply-To: <20130911001428.GB5840@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, carl@ok-labs.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/09/13 10:14, Dmitry Torokhov wrote:
> Hi Ryan,
>
> On Wed, Sep 11, 2013 at 09:32:52AM +1000, Ryan Mallon wrote:
>> Rework the code in uinput_inject_event so that it matches the code in
>> evdev_write and allows injecting more than one event, or zero events.
>>
>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>> ---
>>  drivers/input/misc/uinput.c |   14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
>> index a0a4bba..6aea346 100644
>> --- a/drivers/input/misc/uinput.c
>> +++ b/drivers/input/misc/uinput.c
>> @@ -434,16 +434,20 @@ static ssize_t uinput_inject_event(struct uinput_device *udev,
>>  				   const char __user *buffer, size_t count)
>>  {
>>  	struct input_event ev;
>> +	size_t bytes = 0;
>>  
>> -	if (count < input_event_size())
>> +	if (count != 0 && count < input_event_size())
>>  		return -EINVAL;
>>  
>> -	if (input_event_from_user(buffer, &ev))
>> -		return -EFAULT;
>> +	while (bytes + input_event_size() <= count) {
>> +		if (input_event_from_user(buffer + bytes, &ev))
>> +			return -EFAULT;
> Unless the failure is in the very first packet we should tell the user
> how many bytes we have transferred successfully instead of returning
> -EFAULT.

Good point. evdev is also broken in this regard, I'll send a follow-up
patch for that once you are happy with this one. Updated patch is below:

~Ryan

---
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index a0a4bba..92ca2c5 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -434,16 +434,20 @@ static ssize_t uinput_inject_event(struct uinput_device *u
                                   const char __user *buffer, size_t count)
 {
        struct input_event ev;
+       size_t bytes = 0;
 
-       if (count < input_event_size())
+       if (count != 0 && count < input_event_size())
                return -EINVAL;
 
-       if (input_event_from_user(buffer, &ev))
-               return -EFAULT;
+       while (bytes + input_event_size() <= count) {
+               if (input_event_from_user(buffer + bytes, &ev))
+                       return bytes ?: -EFAULT;
 
-       input_event(udev->dev, ev.type, ev.code, ev.value);
+               input_event(udev->dev, ev.type, ev.code, ev.value);
+               bytes += input_event_size();
+       }
 
-       return input_event_size();
+       return bytes;
 }
 
 static ssize_t uinput_write(struct file *file, const char __user *buffer,

