From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: Fix check for disabling unsupported key
Date: Tue, 5 Jan 2016 09:24:40 +0200
Message-ID: <568B6FB8.6000101@gmail.com>
References: <1451856076-29045-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160105011942.GD11801@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37597 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbcAEHYp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2016 02:24:45 -0500
In-Reply-To: <20160105011942.GD11801@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: pali.rohar@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On  5.01.2016 03:19, Dmitry Torokhov wrote:
>>   	/* First validate */
>> -	for (i = 0; i < ddata->pdata->nbuttons; i++) {
>> -		struct gpio_button_data *bdata = &ddata->data[i];
>> +	for (i = 0; i < n_events; i++) {
>
> for_each_set_bit()?

Yeah, seems I must have overslept that helper, will send an updated version.

>
> OTOH maybe we should do
>
> 	bitmap = get_bitmap_events_by_type(type); // new, return keybit or swbit

new helper function? or static function in gpio-keys? who 
allocates/frees the bitmap memory? or this is static data? Maybe I don't 
get the idea :) .

> 	if (!bitmap_subset(bits, bitmap, n_events)) {
> 		error = -EINVAL;
> 		goto out;
> 	}
>
> ... and leave the rest of the loop as is?
>

Not sure about that. Unless I miss something, what we want is:

1. make sure that what user has written is within the range of the event 
type. I hope bitmap_parselist already does it for us.

2. Make sure that for every bit in bits set based on what user has 
provided, there is a matching gpio in this particular gpio-keys device.

3. Make sure that every gpio user wants disabled is actually allowed to 
be disabled.

I don't see how 2 is achieved with ^^^ code.

So, shall I send a new version of the patch with for_each_set_bit() 
used, or you'll fix the $subject problem with whatever magic you think 
is needed?

Thanks,
Ivo
