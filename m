From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH] HID: Add Support for Setting and Getting Feature   Reports   from hidraw
Date: Wed, 09 Jun 2010 11:20:32 -0400
Message-ID: <4C0FB140.90700@signal11.us>
References: <1275969108-14948-1-git-send-email-alan@signal11.us>	<20100608083226.2dac88d2.ospite@studenti.unina.it>	<4C0E48DF.7000006@signal11.us> <20100609104235.ccce2289.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:59343 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756626Ab0FIPUh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jun 2010 11:20:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 98B801042FD
	for <linux-input@vger.kernel.org>; Wed,  9 Jun 2010 11:20:36 -0400 (EDT)
In-Reply-To: <20100609104235.ccce2289.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Jiri Kosina <jkosina@suse.cz>, Alexey Dobriyan <adobriyan@gmail.com>, Tejun Heo <tj@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Stephane Chatty <chatty@enac.fr>, Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On 06/09/2010 04:42 AM, Antonio Ospite wrote:
> I was only thinking about the interface to userspace,
> HIDIOCGRDESC/HIDIOCSRDESC sounded more general to me (and look like
> HIDIOCGREPORT/HIDIOCSREPORT from hiddev) if they could be made to work
> with different report types, but as I said I didn't look at the
> current code very well, so my remark are surely quite naive.
>    
I see what you mean, re-using the _struct_ not the code. You would have to add
a report_id, like you said, but it would break the current userspace.

Along those lines, I wouldn't be opposed to making the ioctl instead of taking
a variable-length buffer, take a struct. Something like:

struct hidraw_report {
	int report_number;
	int size;
	char data[HID_MAX_BUFFER_SIZE /*or something similar*/];
};

The thing I ran into is that the user would most conveniently create
the entire struct in userspace, using much more space than is probably necessary
(since most reports aren't going to be anywhere close to the max allowable
size, and the max allowable size must be sufficiently large).

The user _could_ do something like:
	char *buf = malloc(sizeof(int)*2 + requried_data_length);
	ioctl(fd, ...SREPORT, (hidraw_report*)buf);
but I don't envision most users doing that as it would be error-prone.

This would require hidraw to copy_from_user() only size bytes from the data
field, not the entire thing.

I'm open to doing it this way if it seems to fit existing paradigms better,
but like I said, it will (for most users) require more memory in userspace.


>>> but I didn't actually implement this, so I don't know if it was
>>> feasible, for instance one problem I didn't investigate further was
>>> about the default value of the aforementioned report_type field in
>>> order to keep the current behavior of HIDIOCGRDESC.
>>>
>>>        
>> I'm not sure what you mean here, as the report_type field is not part of
>> hidraw_report_descriptor.
>>
>>      
> I was thinking about _adding_ that field, but again, pretty arbitrarily
> thought.
>
>    
>> Thanks for testing my patch. Please let me know if you have problems
>> with it.
>>
>>      
> It works basically ok for my needs, thanks again, waiting for comments
> from usb/HID people.
>
> Note that there are some checkpatch.pl errors in the current patch, and
> also a style fix mixed with functional ones (@@ -315,7 +411,7 @@), you
> may want to sort these out in a v2.
>
>    
I didn't worry about the 80 column warnings, because many of them are
copy/paste from existing code in the same file, and fixing them would have
meant either making the code inconsistent in format with the code around it,
or making formatting corrections which would have violated the "make the
patch do only one thing" rule. I would appreciate some guidance as to what
is the best way to handle this kind of thing.

That said, I had fixed the trailing whitespace errors, but apparently messed
up when generating my patch. I'll put out a v2 shortly.


> After this gets in, some more style fixes to hidraw.c could be made,
> I'll do these. Maybe some naming cleanup can be made too,
> hid_output_raw_report could become hid_set_raw_report for instance, but
> I am waiting for the topic to settle first.
>    
Agreed. I've made note of a handful of other (small) things which could
be made a bit better as well. I'm holding off on that stuff until we get this
functionality ironed out.

Thanks,

Alan.



