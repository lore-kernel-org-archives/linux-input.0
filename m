From: simon@mungewell.org
Subject: Re: [PATCH 1/2] HID: hid-lg4ff add support for G27 LEDs
Date: Mon, 12 Mar 2012 14:04:14 -0400
Message-ID: <be2be8d04b58ce75fcba9798fcb4e4fa.squirrel@mungewell.org>
References: <1331565459-1892-1-git-send-email-simon@mungewell.org>
    <alpine.LNX.2.00.1203121645050.18356@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1203121645050.18356@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>
List-Id: linux-input@vger.kernel.org

> On Mon, 12 Mar 2012, Simon Wood wrote:
>
>> This patch adds support for the G27 LEDs. The LEDs are controlled
>> by a 5bit value (0-31) where bit0 is the right most LED, the LEDs
>> are mirrored to the left.
>>
>> Arrangement on wheel is:
>>    G G Y Y R R(bit4) Y Y G G(bit0)
>
> Simon,
>
> is there a usespace application operating on top of this?

At present no; I'd like to add this to Speed Dreams (www.speed-dreams.org)
racing simulator in the future, but this will likely take the form of a
3rd party script to read RPM/Redline and drive the sysfs interface
directly as very few user's setups will be alike.

At the moment you'd just drive the LEDs simply, ie:
$ echo 31 > /sys/bus/hid/devices/.../leds

>
> Also, it'd be necessary to document this properly in Documentation/ABI.

OK, I'll add a description to
'Documention/ABI/testing/sysfs-driver-hid-logitech-lg4ff'.

Should this move to 'stable' now as hid-lg4ff is in mainline now?


>> +	list_for_each(h, &device_list.list) {
>> +		entry = list_entry(h, struct lg4ff_device_entry, list);
>> +		if (strcmp(entry->device_id, (&hid->dev)->kobj.name) == 0)
>> +			break;
>> +	}
>
> Please correct me if I am wrong, but I don't see nothing that'd prevent
> this racing with lg4ff_deinit().
>
> The same applies to already existing sysfs attributes actually.

I believe that Michal is working on some 'spin locking' in this area,
which might meet your requirements. But the patch he sent around last week
(off list) didn't lock on the deinit()...

Simon.
