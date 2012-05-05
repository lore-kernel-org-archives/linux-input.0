From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 0/1] HID: User-space HID I/O driver (UHID)
Date: Sat, 5 May 2012 17:50:14 +0200
Message-ID: <CANq1E4Qs0sy_c8103i69DxMaWJjvE2-9EGzrXmCGxv-YhLkPBQ@mail.gmail.com>
References: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMabAxO9fVN2DM=5xPJAVk_is3QoS1=+TGZPJAbY3TYHMQ@mail.gmail.com>
	<CANq1E4QaRHtGxt3d=Z2mvqAFhTY2zid20GGNZ2ZzHjStGepc+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59030 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab2EEPuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 May 2012 11:50:16 -0400
In-Reply-To: <CANq1E4QaRHtGxt3d=Z2mvqAFhTY2zid20GGNZ2ZzHjStGepc+A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, marcel@holtmann.org, claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org

Hi Joao

On Thu, May 3, 2012 at 5:33 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Joao
>
> On Wed, May 2, 2012 at 9:09 PM, Joao Paulo Rechi Vita
> <jprvita@openbossa.org> wrote:
>> On Mon, Apr 30, 2012 at 12:27 PM, David Herrmann
>> <dh.herrmann@googlemail.com> wrote:
>>> Hi
>>>
>>> This implements a hid_ll_driver user-space interface similar to uin=
put for the
>>> input devices. It allows to implement the HID transport-layer in us=
er-space as
>>> required by Bluetooth Low-Energy (HoG).
>>>
>>> This is my "first final revision" for the module. Please review and=
 test.
>>> Changes from the previous RFCs include:
>>> =A0- The feature-report mechanism is now implemented
>>> =A0- Several min_t() fixes
>>> =A0- Minor coding-style issues
>>>
>>> I did not change __attribute__((__packed__)) to __packed as the lat=
ter one is
>>> not provided to user-space.
>>>
>>> If there are any more issues, please tell me. And for the record, t=
he HoG devs
>>> told me that they are working since several months with it now so w=
e have a real
>>> user-space application that needs it ;)
>>>
>>> If there are no more issues (which i doubt) I can also resend this =
splitted into
>>> multiple patches.
>>>
>>
>> Thanks for your work, David. I'll test and review this new version.
>> Did you find out the what is the problem when passing BUS_BLUETOOTH =
on
>> the 'bus' field of the create request?
>
> I've spent some time looking into that but I haven't found the
> problem, yet. Maybe Jiri can comment here.

hid-next should fix this:
http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dcommitdif=
f;h=3D8215d557e5f3a70e50e07c857d35c250fee62a73

I actually haven't tested UHID with hid-next. Some core interfaces are
changed and I will update UHID as soon as Linus pulls the HID updates.

The BUS_USB problems should be gone, though.

>> Also, how does the HID subsystem differentiate from HID protocol
>> versions? We've just found out that HoG exposes what HID protocol
>> version the device implements, is it the case of having an extra fie=
ld
>> on the uhid_create_req structure to pass this information, or is it
>> already present on the HID descriptor (sorry for my limited knowledg=
e
>> on the HID protocol itself)?
>
> There is already a "version" field in UHID_CREATE. It isn't mandatory=
,
> though, so setting it to 0 works. I even think the HID core doesn't
> even look into that value except for printk messages.
>
>> --
>> Jo=E3o Paulo Rechi Vita
>> Openbossa Labs - INdT
>
> Thanks
> David

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
