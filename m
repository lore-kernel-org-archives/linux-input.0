From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 9/9] HID: add compat support
Date: Sun, 11 May 2008 23:07:08 +0200
Message-ID: <48275FFC.9060305@gmail.com>
References: <1210536043-19812-1-git-send-email-jirislaby@gmail.com> <1210536043-19812-2-git-send-email-jirislaby@gmail.com> <1210536043-19812-3-git-send-email-jirislaby@gmail.com> <1210536043-19812-4-git-send-email-jirislaby@gmail.com> <1210536043-19812-5-git-send-email-jirislaby@gmail.com> <1210536043-19812-6-git-send-email-jirislaby@gmail.com> <1210536043-19812-7-git-send-email-jirislaby@gmail.com> <1210536043-19812-8-git-send-email-jirislaby@gmail.com> <1210536043-19812-9-git-send-email-jirislaby@gmail.com> <20080511204807.GB850@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:43168 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760406AbYEKVHb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 May 2008 17:07:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1557162fgg.17
        for <linux-input@vger.kernel.org>; Sun, 11 May 2008 14:07:29 -0700 (PDT)
In-Reply-To: <20080511204807.GB850@uranus.ravnborg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, akpm@linux-foundation.org

On 05/11/2008 10:48 PM, Sam Ravnborg wrote:
> On Sun, May 11, 2008 at 10:00:43PM +0200, Jiri Slaby wrote:
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index 8a5cbbe..c5bca8f 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -15,3 +15,25 @@ obj-$(CONFIG_USB_HID)		+= usbhid/
>>  obj-$(CONFIG_USB_MOUSE)		+= usbhid/
>>  obj-$(CONFIG_USB_KBD)		+= usbhid/
>>  
>> +targets := hid-dummy.h
>> +
>> +ifdef CONFIG_HID_COMPAT
>> +
>> +obj-m		+= hid-dummy.o
>> +
>> +$(srctree)/$(src)/hid-dummy.c: $(obj)/hid-dummy.h
>> +
>> +$(obj)/hid-dummy.h: $(filter-out $(srctree)/drivers/hid/hid-dummy.c,$(wildcard $(srctree)/drivers/hid/*.c))
>> +	@echo -e 'static void __always_inline hid_dummy_load(void)\n{' > $@
>> +	@FUNS=`grep -h 'HID_COMPAT_LOAD_DRIVER(' $(srctree)/drivers/hid/*.c | \
>> +	sed -e 's/HID_COMPAT_LOAD_DRIVER( *\([^ ]*\) *) *;/\1/'`; \
>> +	for FUN in $$FUNS; do \
>> +		echo -e "\textern void hid_compat_$$FUN(void);"; \
>> +	done >> $@; \
>> +	echo >> $@; \
>> +	for FUN in $$FUNS; do \
>> +		echo -e "\thid_compat_$$FUN();"; \
>> +	done >> $@
>> +	@echo "}" >> $@
> 
> I would prefer to see this done explicit in favour of some magic
> makefile fragment as the above.
> It is much simpler to understand if done explicit.
> And it is not like we are talking 10 or 50 files here.

Sorry, I don't understand you at all. Could you re-formulate what do you want to 
see rather than this? Maybe an example would be good.
