From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Supporting U2F over HID on Linux?
Date: Sun, 2 Nov 2014 19:40:11 -0500
Message-ID: <CAN+gG=H1rdZ=NeQttgmRwHfx4eQdvf2fcoMgqijWX87HW_vO8A@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
	<alpine.LNX.2.00.1411022134120.19451@pobox.suse.cz>
	<CALCETrVtA9rCDqAetaFj=tCo=ebWW43mA4f8n6fMZdCnE9TvgA@mail.gmail.com>
	<alpine.LNX.2.00.1411022229060.19451@pobox.suse.cz>
	<alpine.LNX.2.00.1411022239330.19451@pobox.suse.cz>
	<CAN+gG=HZ+CA3tWbHjG=ULUfztj87mLCoGQXT-5XLd-+vZ1K6VA@mail.gmail.com>
	<CALCETrVdaYnTU--9nmWUhcNeTO9eqheP_OsujVEB8yUM4AgzSg@mail.gmail.com>
	<CAN+gG=FtZqx3WqTEKpjM6CKQ9EBuZqVUNs=TgswtnTtMNrGhcA@mail.gmail.com>
	<CALCETrVrubF0bamF12taJcmkUrp4v2JazEkOxxtXdo0Xc=jimg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:48725 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaKCAkM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Nov 2014 19:40:12 -0500
Received: by mail-qa0-f54.google.com with SMTP id u7so7685609qaz.13
        for <linux-input@vger.kernel.org>; Sun, 02 Nov 2014 16:40:11 -0800 (PST)
In-Reply-To: <CALCETrVrubF0bamF12taJcmkUrp4v2JazEkOxxtXdo0Xc=jimg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jiri Kosina <jkosina@suse.cz>, Kay Sievers <kay@vrfy.org>, Greg KH <gregkh@linuxfoundation.org>, systemd Mailing List <systemd-devel@lists.freedesktop.org>, linux-input <linux-input@vger.kernel.org>

On Sun, Nov 2, 2014 at 6:34 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Sun, Nov 2, 2014 at 3:01 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> On Sun, Nov 2, 2014 at 5:49 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Sun, Nov 2, 2014 at 2:45 PM, Benjamin Tissoires
>>> <benjamin.tissoires@gmail.com> wrote:
>>>> On Sun, Nov 2, 2014 at 4:40 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>>>>> On Sun, 2 Nov 2014, Jiri Kosina wrote:
>>>>>
>>>>>> Alternatively, you can just write udev rule which triggers on HID devices,
>>>>>> issues HIDIOCGRDESC ioctl() on the just-created hidraw node, and decides
>>>>>> afterwards whether node permissions need to be altered ... right?
>>>>>
>>>>> Just to make myself clear here -- this is basically alternative to your
>>>>> 1st option, but for cases where you want to make yourself independent on
>>>>> sysfs existence (I don't what is the craziness level of setups you are
>>>>> considering).
>>>>>
>>>>
>>>> I am a little bit concerned with the user space retrieving the
>>>> descriptor, parsing it and then deciding how to set the permissions.
>>>> It's not that it is super complex, but it will duplicate the parsing
>>>> we already do in the kernel. Wacom tried to do that in their usb
>>>> driver, and they never managed to fully implement one.
>>>>
>>>> I think the HID_GROUP solution is super trivial:
>>>> - add a match on the U2F input report and set the group to
>>>> HID_GROUP_U2F (2 lines in hid_scan_input_usage() in hid-core.c)
>>>> - allow hid-generic to also match HID_GROUP_U2F (1 line in hid-generic.c).
>>>>
>>>> Then, the udev rule would be super trivial.
>>>
>>> I'm confused.  What would the user-visible effect of this be?  Would
>>> the hidraw node still show up?  What is user code supposed to match to
>>> detect a U2F device or to otherwise set permissions?
>>>
>>
>> The only change with what we currently have is that the modalias of
>> the device will be something like
>> MODALIAS=hid:b0003gHID_GROUP_U2Fv0000XXXXp0000XXXX. (replace
>> HID_GROUP_U2F with the proper hex value). So matching against this
>> modalias is trivial, and you can just put the hidraw node rw for
>> users.
>
> Do we really want udev matching against MODALIAS, and do we really
> want udev rules to hardcode hid group constants?

That's a good question. I don't think the hid group will change in the
future and we can guarantee that in the kernel I think.

>
> I'd like this idea better if we added a HID_GROUP uevent property with
> a textual description, or perhaps something a little more specific.

This refers back to Jiri's first remark. Adding such a thing is
doable, but do we really want/need it :/

> The hid group field seems to be used for different types of things.

yes, my proposal is definitively a (ugly) hack around the groups which
are used to select which hid subdriver we use.


An other question which comes to my mind is don't we want logind to
assign the hidraw node to the proper client? We may still need to tag
the device somehow, but if logind prevents untrusted application to
run arbitrary code on the u2f token, that might be a little bit safer
than allowing anybody to read/write.

Sorry to raise more questions than providing answers.

Cheers,
Benjamin
