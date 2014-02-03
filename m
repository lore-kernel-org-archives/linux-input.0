From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 0/6] HID: Add a stable method for retrieving the client
 MAC address of a HID device
Date: Mon, 3 Feb 2014 18:45:52 +0100
Message-ID: <CANq1E4Q+oaovc-G9D07hSKQxE4SO_ziKLbKnRH8cH9NwV3YXnQ@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
	<CAN+gG=EVcVmQ8rr2YtoapfftSHaDeYnSu5rCnuZjL=S-v1xU4Q@mail.gmail.com>
	<52EC01DF.6050309@oh.rr.com>
	<CAN+gG=GxXUU2rNNg7T1o50RPzXopnnqWbhQ4+-uWN3mbLUUyDw@mail.gmail.com>
	<52ED1B8D.80208@gmail.com>
	<CAN+gG=H6A93ozP=Q52GXnEjARC1tX4s6k=Oi6MoHK7Mh6kBPiw@mail.gmail.com>
	<CANq1E4TYrwOhBd6ZVUCzuRyB_8ivaCsZVbBKz6n5hPodHjtOmg@mail.gmail.com>
	<CAH+9E3oNifQgGDOp9POpxMm2uaMo3AUdRttC7L=WtGOyU8_nBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:44782 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbaBCRpw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 12:45:52 -0500
Received: by mail-ie0-f172.google.com with SMTP id e14so6592380iej.3
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 09:45:52 -0800 (PST)
In-Reply-To: <CAH+9E3oNifQgGDOp9POpxMm2uaMo3AUdRttC7L=WtGOyU8_nBA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

Adding Dmitry+Jiri, maybe they can clarify this.

[snip]
>>>
>>> Yes
>>>
>>>> hidp sets it to point to the hci_conn struct from which src address for the
>>>> Bluetooth connection can be obtained, but making assumptions about an opaque
>>>> pointer like that seems dangerous.  Is the parent pointer guaranteed to
>>>> point to the hci_conn struct as long as the bus type is Bluetooth?
>>>
>>> And nope. If you use uhid, then the parent will not be a hci_conn.
>>>
>>> With enough guards, you should be able to use it, but it's not ideal I agree.
>>> I really want to have David's opinion regarding the UNIQ field. IMO,
>>> this seems to be the most transport-agnostic way of doing it.
>>
>> UNIQ is definitely wrong. It is used to assign a run-time *unique*
>> value to the connection. So ideally it should be different if a device
>> is reconnected. The PHYS field is actually used to identify a physical
>> device. So please, if we're doing this, then we should do it via PHYS.
>>
>> I'm fine with hard-coding PHYS as bt-address for BT-HID, but please
>> add a comment to hidp_setup_hid() in net/bluetooth/hidp/core.c before
>> doing the snprintf() there.
>>
>> The reason why I disliked hard-coding this behavior is that if a
>> single BT-device is connected twice to us, we usually want two
>> different PHYS entries for both depending on which service this
>> connection provides. However, this seems like an unlikely and
>> overengineered problem so lets not do that. Furthermore, while BT-HID
>> would allow such setups with some hacks, it isn't supported in a clean
>> way. So yeah, I'm actually fine with using PHYS for that.
>>
>> Thanks
>> David
>
> PHYS should definitely be changed if this is the case because right
> now it is set to the MAC of the host adapter which means that it's the
> same for every Bluetooth device and connection.  I believe that the
> hidraw documentation also specifies that for Bluetooth devices the
> HIDIOCGRAWPHYS ioctl should return a string with the MAC address of
> the associated device rather than that of the host adapter as the
> current behavior does.

Oh, yes, nice catch!
Ok, maybe we need to clear up what PHYS and UNIQ do before relying on
them. I thought, they were defined as:

PHYS: A string describing the physical device. It should be the same
if a device reconnects. It can be used by user-space to track devices
across disconnects

UNIQ: A string describing the current connection to a device. If the
device reconnects, the UNIQ string should change. It can be used by
user-space to track a single device-session.

afaik both strings have no common format and drivers are free to
provide any kind of information, as long as it follows the given
rules. That's why I disliked the idea of relying on them and parsing
them. But maybe I just have no idea what the original intention was
behind them?

Thanks
David
