From: =?UTF-8?B?U3VuZSBNw7hsZ2FhcmQ=?= <sune@molgaard.org>
Subject: Re: [PATCH 2/2] HID: hid-logitech-dj, querying_devices was never
 set
Date: Tue, 06 Aug 2013 23:03:33 +0200
Message-ID: <520164A5.2020008@molgaard.org>
References: <1374153691-25100-1-git-send-email-nlopezcasad@logitech.com>	<1374153691-25100-2-git-send-email-nlopezcasad@logitech.com>	<CAN+gG=GcS7pfK9K5FuW9TyX+PJWNkXZWLk8UX9PzLXom2PSpgQ@mail.gmail.com>	<alpine.LNX.2.00.1308020309340.24017@pobox.suse.cz>	<CAN+gG=FV=OjnktkET-_KM_iTPStsWCKdj8fpyktnJczusFz0=w@mail.gmail.com>	<alpine.LNX.2.00.1308051516181.17512@pobox.suse.cz> <CAN+gG=Hjd1Ay0=HrJdV9797DxTMf97_13kdkuHNWi24EfPL-ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=Hjd1Ay0=HrJdV9797DxTMf97_13kdkuHNWi24EfPL-ig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, Andrew de los Reyes <adlr@chromium.org>, joseph.salisbury@canonical.com, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Being affected by this bug, I can confirm that Linux 3.11-rc4 still
exhibits the unwanted behaviour for me, but that commenting out the
single line from the second patch makes it work.

Thus, for requesting a revert on that line, you are most welcome to put
me down as a "Tested-By".

Best regards,

Sune M=C3=B8lgaard

Benjamin Tissoires wrote:
> On Mon, Aug 5, 2013 at 3:22 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Fri, 2 Aug 2013, Benjamin Tissoires wrote:
>>
>>>> Could you please elaborate? (and put an elaborate description to r=
evert
>>>> commit log perhaps?)
>>>
>>> Sure, so here is the revert commit log:
>>>
>>> --
>>>
>>> Commit "HID: hid-logitech-dj, querying_devices was never set" activ=
ate
>>> a flag which guarantees that we do not ask the receiver for too man=
y
>>> enumeration. When the flag is set, each following enumeration call =
is
>>> discarded (the usb request is not forwarded to the receiver). The f=
lag
>>> is then released when the driver receive a pairing information even=
t,
>>> which normally follows the enumeration request.
>>> However, the USB3 bug makes the driver think the enumeration reques=
t
>>> has been forwarded to the receiver. However, it is actually not the
>>> case because the USB stack returns -EPIPE. So, when a new unknown
>>> device appears, the workaround consisting in asking for a new
>>> enumeration is not working anymore: this new enumeration is discard=
ed
>>> because of the flag, which is never reset.
>>>
>>> A solution could be to trigger a timeout before releasing it, but f=
or
>>> now, let's just revert the patch.
>>>
>>> --
>>
>> Thanks Benjamin.
>>
>> I'd like to have a bit more clarification about the USB3 bug, as thi=
s
>> whole issue is not completely clear to me.
>>
>> To be more specific -- when exactly do we receive -EPIPE, why do we
>> receive it and why do we not handle it properly?
>=20
> Sure, I'll try (though the more I think of it, the more it seems
> blurry to me :( ).
>=20
> So the initial probe function in hid-logitech-dj was implemented by
> using a direct call to hid_output_raw_report(). This call was
> synchronous, so we did get the -EPIPE return code. Then, the probe()
> function returns the -EPIPE error, cleaning the receiver and
> unregister it from the hid bus.
>=20
> However, now, we use hid_hw_request(), which is asynchronous (from
> what I can read). At least, this code returns "void" as the set_repor=
t
> command seems to be scheduled for later handling. In usbhid, when the
> queue is flushed, I did not found a way to retrieve the error code...
>=20
> So basically, the -EPIPE is received in usbhid_restart_ctrl_queue(),
> but nothing notifies hid-logitech-dj from the error. In the end, the
> probe() function returns without error code, but the receiver never
> received the notification.
>=20
> Cheers,
> Benjamin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20


--=20
"Testiculos habet et bene pendentes"
See http://www.newint.org/features/1993/06/05/curious/
