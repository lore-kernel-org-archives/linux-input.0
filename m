From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: [PATCH v3 0/3] new driver for Valve Steam Controller
Date: Mon, 26 Feb 2018 12:24:21 +0100
Message-ID: <CAM4jgCpX1OOBqCEvqtyx=ftvnuk3zg_jMsFkxFZXxEfZD-ak5Q@mail.gmail.com>
References: <20180225185250.10759-1-rodrigorivascosta@gmail.com> <CAO-hwJ+PDkR4v5r93KJBCqxfm3FTCkrzaOd-K=HxLMwhoAomXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+PDkR4v5r93KJBCqxfm3FTCkrzaOd-K=HxLMwhoAomXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, Jiri Kosina <jikos@kernel.org>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Cameron Gutman <aicommander@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

2018-02-26 10:50 GMT+01:00 Benjamin Tissoires <benjamin.tissoires@redhat.co=
m>:
> Hi Rodrigo,
>
> On Sun, Feb 25, 2018 at 7:52 PM, Rodrigo Rivas Costa
> <rodrigorivascosta@gmail.com> wrote:
>> This patchset implements a driver for Valve Steam Controller, based on a
>> reverse analysis by myself.
>
> To me, the code looks OK now. I haven't got the time to do a better
> review, so giving my:
> Acked-by: Bnejamin Tissoires <benjamin.tissoires@redhat.com>
>
> However, before we include it, I'd like to have the ACK from
> Pierre-Loup and Cl=C3=A9ment. They should be more qualified than me to sa=
y
> if this will interfere with the official Steam client (I think we are
> good now, but that's just my opinion).

I am not qualified to speak about the steam client, it has been a long
time since I have a look at how it uses the controller and I think it
changed a lot.

I checked the code and I think you are not handling wireless
connection correctly. If a wireless controller is already connected
when the driver is loaded, you will not receive a connection event and
forget to register the controller. You can send a 0xb4 request with
empty parameters (0xb4, 0x00, ... ) to force the receiver to send its
connection status (as the type 3 event you are already parsing). Since
user-space program may also send this request, you should make sure
the driver works if it receives a (dis)connected event when it is
already (dis)connected.

>
> Cheers,
> Benjamin
>
>>
>> This is reroll v3, codenamed "lazy lizard". Changes from v2:
>>  * Use RCU to do the dynamic connec/disconnect of wireless devices. Plea=
se,
>>    to anybody that knows their way around RCU, review.
>>  * Remove entries in hid-quirks.c as they are no longer needed. This all=
ows
>>    this module to be blacklisted without side effects.
>>  * Do not bypass the virtual keyboard/mouse HID devices to avoid breakin=
g
>>    existing use cases (lizard mode). A user-space tool to do that is
>>    linked.
>>  * Fully separated axes for joystick and left-pad. As it happens, there =
are
>>    people with too many fingers.
>>  * Add fuzz values for left/right pad axes, they are a little wiggly.
>>
>> Notable changes from patchset v1:
>>  * Remove references to USB. Now the interesting interfaces are selected=
 by
>>    looking for the ones with feature reports.
>>  * Feature reports buffers are allocated with hid_alloc_report_buf().
>>  * Feature report length is checked, to avoid overflows in case of
>>    corrupt/malicius USB devices.
>>  * Resolution added to the ABS axes.
>>  * A lot of minor cleanups.
>>
>> Rodrigo Rivas Costa (3):
>>   HID: add driver for Valve Steam Controller
>>   HID: steam: add serial number information.
>>   HID: steam: add battery device.
>>
>>  drivers/hid/Kconfig     |   8 +
>>  drivers/hid/Makefile    |   1 +
>>  drivers/hid/hid-ids.h   |   4 +
>>  drivers/hid/hid-steam.c | 777 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  4 files changed, 790 insertions(+)
>>  create mode 100644 drivers/hid/hid-steam.c
>>
>> --
>> 2.16.2
>>
