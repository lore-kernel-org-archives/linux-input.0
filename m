From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH v3] Input: Add EVIOC mechanism for MT slots
Date: Sun, 05 Feb 2012 23:55:09 +0100
Message-ID: <4F2F08CD.2010806@gmail.com>
References: <1328036403-2827-1-git-send-email-rydberg@euromail.se> <4F2B24AC.1020408@gmail.com> <20120203072725.GA6914@polaris.bitmath.org> <4F2D7730.3090704@gmail.com> <20120205075906.GA7698@polaris.bitmath.org> <4F2EB8C8.9090102@gmail.com> <20120205194036.GA2566@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55923 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489Ab2BEXCW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Feb 2012 18:02:22 -0500
In-Reply-To: <20120205194036.GA2566@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/05/2012 08:40 PM, Henrik Rydberg wrote:
>>> Besides leaving a possible giant stack crash in your code, it assumes
>>> memory is somehow magically allocated. Not good practise in low-level
>>> programming. You wouldn't use a template this way, would you?
>>
>> No, which is why I think this interface is bad. I should be able to
>> dynamically set the size of the array, but it's not possible with this
>> interface.
> 
> It is possible (using num_slots == 0 or creating your own struct), but
> not ideal, granted. The patch serves the purpose of definining the
> binary interface, the rest is up to userland.
> 
>> I think the implementation is fine in terms of how the plumbing works. I
>> just don't think this macro should be included. Make the user create the
>> struct themselves:
>>
>> In linux/input.h:
>>
>> struct input_mt_request {
>> 	__u32 code;
>> 	__s32 values[];
>> };
> 
> The above (the first) version is not ideal either, since it cannot be
> used as it is.
> 
>> It could be argued that we should leave the macro around for people who
>> want to statically define the size of the request, but I think that is
>> leading them down the wrong path. It's easier, but it will lead to
>> broken code if you pick the wrong size.
> 
> Rather than creating both a suboptimal static and a suboptimal dynamic
> version, removing the struct altogether is tempting. All that is
> really needed is a clear definition of the binary interface. The rest
> can easily be set up in userland, using whatever method is preferred.

I'm normally not a fan of static functions in header files, but maybe it
would be a good solution here:

struct input_mt_request {
	__u32 code;
	__s32 values[];
};

static struct input_mt_request *
linux_input_mt_request_alloc(int num_slots) {
	return (struct input_mt_request *)malloc(
		sizeof(__u32) + num_slots * sizeof(__s32));
}

#define EVIOCGMTSLOTS(num_slots) \
	_IOC(_IOC_READ, 'E', 0x0a, \
	     sizeof(__u32) + (num_slots) * sizeof(__s32))

This would lead to userspace code:

struct input_mt_request *req;
int num_slots;

EVIOCGABS call on ABS_MT_SLOT;

num_slots = ABS_MT_SLOT.max - ABS_MT_SLOT.min + 1;
req = linux_input_mt_request_alloc(num_slots);
req->code = ABS_MT_POSITION_X;
if (ioctl(fd, EVIOCGMTSLOTS(num_slots), req) < 0) {
	free(req);
	return -1;
}
for (i = 0; i < 64; i++)
	printf("slot %d: %d\n", i, req.values[i]);
free(req);

Normally, I would recommend adding a free() function too, but the
necessity of a free() function is only when libc's free() won't work or
the implementation may change. Here, however, the implementation would
be codified by the ioctl interface in a way that guarantees libc's
free() to be correct.

-- Chase
