From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: proposal for deletion of drivers/hid/hid-ids.h
Date: Fri, 27 Mar 2015 08:59:35 -0400
Message-ID: <CAN+gG=EAqfZLjsoz+6y9DSMD5msoqFDo8G_aqiWmQVPo1nCm5Q@mail.gmail.com>
References: <1427370288.2075.19.camel@suse.de>
	<CAN+gG=EJUwfzvNeud76RNa-hMQrttbNm03uKYJhqfTeJxjjF5Q@mail.gmail.com>
	<1427446189.5783.29.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34766 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbbC0M7g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 08:59:36 -0400
Received: by qgep97 with SMTP id p97so132264399qge.1
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 05:59:35 -0700 (PDT)
In-Reply-To: <1427446189.5783.29.camel@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, pavel@ucw.cz

On Fri, Mar 27, 2015 at 4:49 AM, Oliver Neukum <oneukum@suse.de> wrote:
> On Thu, 2015-03-26 at 10:06 -0400, Benjamin Tissoires wrote:
>> On Thu, Mar 26, 2015 at 7:44 AM, Oliver Neukum <oneukum@suse.de> wrote:
>> > 2. It serves no purpose and adds work. Anyone who adds a quirk
>> > or a special case for devices needs to operate on the numbers,
>> > as those are what he gets from the descriptors. Looking up or
>> > adding a symbolic name for a device is just more work without
>> > a benefit. These numbers have no intrinsic meaning beyond
>> > being unique and it rarely matters (and should not matter)
>> > for which vendor a particular fix is intended.
>>
>> I disagree. This list might not be useful for the
>> drivers/hid/usbhid/hid-quirks.c by itself in most cases.
>> However, we mainly rely on this list to add the device in
>> hid_have_special_driver and hid_ignore in hid-core and in the
>> submodule that should handle it.
>
> Can you explain how we depend on it? We certainly use it, but
> how do we depend on it? I don't see how just the numbers would
> be worse. In fact they would be better as you again save a lookup.

We simply depend on it because we reuse the symbolic names all over
the place in the HID tree (not for every defined symbol, but a good
part of it).
If you consider the ones used in usbhid/hid-quirks.c and
hid-multitouch.c, yes I agree, it's a pain and they add nothing beside
a little bit of documentation saying "hey, we already handled this
PID".

>
>> Many times, already having the VID/PID registered in hid-ids.h saved
>> some time when debugging and adding a subdriver for a special device
>> because if the VID/PID is already in hid-ids.h, that means that
>
> Again, I see how having the VID/PID pair is an advantage. I don't
> see why having symbolic names for that pair is an advantage.
> Just having the numbers in a list of quirky devices would serve
> the same purpose.

No. Having the number only means you have to also make a check on the
vendor ID, because 0x0001 can be reused by any vendor. OTOH, having
the symbolic name where there is the VENDOR_NAME_PID makes lookups
much easier.

I think you are a little biaised by your recent patches in hid-quirks.c.

To show you my point, I made a quick grep in drivers/hid:

$> grep -r -E "USB_DEVICE_ID(\\w*)" * -o -h | sort | uniq -c
 -> 631 USB PID returned

And then extracting the uniq defines by appearance count:
1 -> 25  -> OK, these could be cleaned up
2 -> 326 -> Those are used only once, so we could remove them
3 -> 165
4 -> 79
5 -> 19
6 -> 7
7 -> 6
8 -> 0
9 -> 2
10 -> 1
11 -> 1

So yes, 55 % of these defines are used only once at most and are useless.
The other 45 % need to be defined somewhere. And given that they are
used in more than one file (at least hid-core.c and the subdriver),
well, hid-ids.h seems to be the place.
Having them defined once prevents accidental typos where we blacklist
a device without adding it to the correct subdriver.

I am not arguing against being more relaxed or removing the unused
once (though I can see them as a benefit somehow), just that it makes
no sense screaming that the list is not used and should be deleted
blindly.

>
>> someone already dealt with it, and it gives us a way to clean it when
>> the quirk was not appropriate. For instance, many multitouch devices
>> were added before the creation of hid-multitouch and were registered
>> with the quirk MULTI_INPUT.
>
> Well, yes, so you needed to grep for MULTI_INPUT. The entries would
> still have been present, just with nummerical IDs.

Don't be silly. That's not the way it works. You have a bug report,
you get the VID/PID, and then you start from it to know what is
happening.
You never know in advanced which quirk has been added and makes your
device behave not correctly (MULTI_INPUT is easy to deduce from the
user space, NO_GET is an other story for instance).

I usually check in hid-ids.h if it the device is known already. Then I
check for the symbolic name in the hid tree to get the exact places
where it is used. So for me having hid-ids.h makes sense.

Note that I already started infringing this rule in some drivers where
it makes no sense: in hid-logitech-hidpp, I used only the numerical
value for the DJ devices because I know that they won't be used
anywhere else.

Cheers,
Benjamin
