From: Wayne Thomas <waynethomas69@gmail.com>
Subject: Re: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
	quirky remote
Date: Tue, 20 Apr 2010 20:29:02 +0200
Message-ID: <t2p3711715e1004201129of97bb872u7fe43ec11db1dcdc@mail.gmail.com>
References: <4B8902C5.5000508@gmail.com>
	 <alpine.LNX.2.00.1003151701380.18642@pobox.suse.cz>
	 <3711715e1003171218n2e15438fy6bf5d2615a4cb4ae@mail.gmail.com>
	 <alpine.LNX.2.00.1003181150401.18642@pobox.suse.cz>
	 <alpine.LNX.2.00.1003181200220.18642@pobox.suse.cz>
	 <3711715e1003181303t7b118c2at50aed6b3cd84b2de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58600 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab0DTS3F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Apr 2010 14:29:05 -0400
Received: by wyb39 with SMTP id 39so3499791wyb.19
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 11:29:02 -0700 (PDT)
In-Reply-To: <3711715e1003181303t7b118c2at50aed6b3cd84b2de@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Ben Hardill <b.hardill@gmail.com>, linux-input@vger.kernel.org

On Thu, Mar 18, 2010 at 10:03 PM, Wayne Thomas <waynethomas69@gmail.com=
> wrote:
> On Thu, Mar 18, 2010 at 12:00 PM, Jiri Kosina <jkosina@suse.cz> wrote=
:
>> On Thu, 18 Mar 2010, Jiri Kosina wrote:
>>
>>> > I have compiled kernel 2.6.33.1 with hid_debug set to 2.
>>> > Below is the output of the appropriate device (the remote present=
s
>>> > itself as two separate event devices) when pressing some of the
>>> > buttons in question.
>>> >
>>> > I have attached the output of
>>> > /sys/kernel/debug/hid/0003:046E:5578.0004/rdesc as a text file si=
nce
>>> > it is so long, but here is the output of
>>> > /sys/kernel/debug/hid/0003:046E:5578.0004/events (one report for =
each
>>> > button pressed).
>>> >
>>> > report (size 7) (numbered)
>>> >
>>> >
>>> >
>>> > report (size 7) (numbered)
>>> >
>>> >
>>> >
>>> > report (size 7) (numbered)
>>> >
>>> >
>>> >
>>>
>>> Hmm, this is very odd output. Do you by any chance have messages su=
ch as
>>>
>>> =A0 =A0 =A0 =A0 undefined report_id <NUMBER> received
>>>
>>> appearing in your 'dmesg' output when you are pressing the keys?
>>
>> Does applying the patch below give reasonable output in 'events' deb=
ugfs
>> file please?
>>
>>
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 368fbb0..c49aaa2 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1096,20 +1096,11 @@ int hid_input_report(struct hid_device *hid,=
 int type, u8 *data, int size, int i
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto nomem;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 snprintf(buf, HID_DEBUG_BUFSIZE - 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "\nreport (size %u) (%=
snumbered)\n", size, report_enum->numbered ? "" : "un");
>> - =A0 =A0 =A0 hid_debug_event(hid, buf);
>> -
>> - =A0 =A0 =A0 report =3D hid_get_report(report_enum, data);
>> - =A0 =A0 =A0 if (!report) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(buf);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> - =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0/* dump the report */
>> =A0 =A0 =A0 =A0snprintf(buf, HID_DEBUG_BUFSIZE - 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "report %d (size %u) =3D=
 ", report->id, size);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "\nreport (size %u) (%=
snumbered) =3D ", size, report_enum->numbered ? "" : "un");
>> =A0 =A0 =A0 =A0hid_debug_event(hid, buf);
>> +
>> =A0 =A0 =A0 =A0for (i =3D 0; i < size; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snprintf(buf, HID_DEBUG_BUFSIZE - 1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" %02=
x", data[i]);
>> @@ -1117,6 +1108,13 @@ int hid_input_report(struct hid_device *hid, =
int type, u8 *data, int size, int i
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0hid_debug_event(hid, "\n");
>>
>> + =A0 =A0 =A0 report =3D hid_get_report(report_enum, data);
>> +
>> + =A0 =A0 =A0 if (!report) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(buf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0kfree(buf);
>>
>> =A0nomem:
>>
>
> Jiri,
> nothing at all appears in dmesg in relation to the button presses.
> I manually applied the patch and have retested. =A0The only differenc=
e I
> noticed was the presence of an equals sign in events:
>
> report (size 7) (numbered) =3D
>
>
> rdesc appears identical, but I have attached it just in case.
>
> Also, in the off-chance that it is any use, here is the output of
> dmesg when I plug the receiver in (there is no output when any button=
s
> are pressed).
>
> [ =A0572.392097] usb 3-1: new low speed USB device using uhci_hcd and=
 address 4
> [ =A0572.577199] drivers/hid/usbhid/hid-core.c: HID probe called for =
ifnum 0
> [ =A0572.590688] input: BTC USB MCE Cordless Remote Control. as
> /devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/input/input12
> [ =A0572.590843] generic-usb 0003:046E:5578.0005: input,hidraw0: USB =
HID
> v1.11 Keyboard [BTC USB MCE Cordless Remote Control.] on
> usb-0000:00:1d.1-1/input0
> [ =A0572.590969] drivers/hid/usbhid/hid-core.c: HID probe called for =
ifnum 1
> [ =A0572.611848] drivers/hid/usbhid/hid-core.c: submitting ctrl urb:
> Get_Report wValue=3D0x0101 wIndex=3D0x0001 wLength=3D2
> [ =A0572.614082] drivers/hid/usbhid/hid-core.c: submitting ctrl urb:
> Get_Report wValue=3D0x0102 wIndex=3D0x0001 wLength=3D7
> [ =A0572.617082] drivers/hid/usbhid/hid-core.c: submitting ctrl urb:
> Get_Report wValue=3D0x0103 wIndex=3D0x0001 wLength=3D7
> [ =A0572.621086] drivers/hid/hid-core.c: undefined report_id 0 receiv=
ed
> [ =A0572.621095] drivers/hid/usbhid/hid-core.c: submitting ctrl urb:
> Get_Report wValue=3D0x0303 wIndex=3D0x0001 wLength=3D8
> [ =A0572.625084] drivers/hid/hid-core.c: undefined report_id 0 receiv=
ed
> [ =A0572.625366] input: BTC USB MCE Cordless Remote Control. as
> /devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.1/input/input13
> [ =A0572.625576] generic-usb 0003:046E:5578.0006:
> input,hiddev96,hidraw1: USB HID v1.11 Device [BTC USB MCE Cordless
> Remote Control.] on usb-0000:00:1d.1-1/input1
>
> Cheers
> Wayne
>

Jiri,
I haven't heard anything for quite a while so assume that you have
more pressing priorities than this.
In the meantime it occured to me that it would be relatively simple
for me to patch hid-topseed to support this item (the keymaps are
identical apart from a few extra keys).
If I created this patch would it be accepted as an interim support
solution until the udev method actually works?  I figure hid-topseed
is already in existence so it wouldn't be adding additional quirky
drivers and once the ffbc usage page works under udev there is no
extra effort to migrate to this method.
Thoughts?

Cheers
Wayne
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
