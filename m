From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 11/16 v2] Input: atmel_mxt_ts - refactor reading object table
Date: Fri, 13 Apr 2012 18:10:35 +0800
Message-ID: <CAGS+omCMWqWsALjBd=r5HbKMQ+ZJKayuUEQuL7LXwkbr+xmy1g@mail.gmail.com>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
 <1333039766-8617-12-git-send-email-djkurtz@chromium.org> <20120413091147.GA3923@polaris.bitmath.org>
 <CAGS+omD5WxL4mrt8Czw7M3OAbuBH2CVO-EmFmhG3VucSNRuLCw@mail.gmail.com> <20120413093446.GA4218@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63493 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935062Ab2DMKK4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 06:10:56 -0400
Received: by iagz16 with SMTP id z16so4061476iag.19
        for <linux-input@vger.kernel.org>; Fri, 13 Apr 2012 03:10:56 -0700 (PDT)
In-Reply-To: <20120413093446.GA4218@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

On Fri, Apr 13, 2012 at 5:34 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
>> > Putting this conversion in a function would be nice, it would also
>> > make it clear that the inverse, used for writing, is currently
>> > missing. Alternatively, how about making the object struct actuall=
y
>> > match the read data? To top it off, one could introduce a collecti=
on,
>> > prepending the buffer size, making the write operation trivial.
>>
>> AFAIK, there is no corresponding "object table" write. The "object
>> table" (maybe more aptly named the "object descriptor table") is an
>> immutable blob read from firmware that describes some actual data
>> objects elsewhere in device memory. =A0It is those actual objects th=
at
>> are writable. =A0When they are written, it is the actual size, locat=
ion
>> and number of instances (not their raw '-1' values) that is useful.
>
> I am talking about the data that is being read here and written in
> mxt_check_reg_init(). By matching the struct with that data, all the
> copies you make would go away.

The data read here is a table of object descriptors.  The data written
in mxt_check_reg_init() is configuration data for each of the objects
described by the descriptors.  What copies are you talking about?

>
> Henrik

The size, number and location of "objects" in device memory are device
specific, and are read into struct mxt_data's object_table, by
mxt_get_object_table().  The order, number and size (and even
interpretation) of the objects varies for different devices.  Some of
these objects are "writable" (as defined by mxt_object_writable()),
although this is a misnomer, and really means "must have corresponding
initialization data in the config array in platform_data".

mxt_check_reg_init() uses i2c to write this initialization data, from
the "config" array to the corresponding locations in device memory.

The config array in platform_data is a single big long array that has
to be manually created in a platform file.  It just has blobs of data
for each of the 'writable' objects for a given device, all
concatenated together.  These blobs must be in the correct order
(matching the order in the device specific object_table), and they
must have the correct size and number of instances for that particular
device.

Personally, I find the way this driver handles configuration and
platform_data is a very scary and fraught with peril, but I am not
trying to fix that in this patch set.  I'm just trying to make what it
currently does a bit faster.

I feel like you are trying to suggest that I fix something in this
patch, but I can't figure out what.
Are you suggesting to not cache the object table (i.e. the object
descriptors), and instead read the table from the device whenever we
want to read or write the objects themselves, such as for the object
sysfs entry or at initialization?  I don't see how that would help.

-Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
