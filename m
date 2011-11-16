From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 22:22:58 +0100
Message-ID: <CAN+gG=H18JdRBJeXAYPuOa97HbjYsUzTYMvnuAdddjLW30eckg@mail.gmail.com>
References: <20111116095030.GC3335@slate>
	<CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
	<20111116102514.GA3831@slate>
	<CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
	<20111116145518.GA7080@slate>
	<20111116154049.GA8444@slate>
	<CAGzDe_ahR9pVkZa8BQkfCq2zeVCojkX=t6WBcQYkrv3z91fb+Q@mail.gmail.com>
	<4EC3EC63.4020700@gmail.com>
	<20111116204759.GA2153@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54169 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1KPVW7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 16:22:59 -0500
Received: by wyh11 with SMTP id 11so1085297wyh.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 13:22:58 -0800 (PST)
In-Reply-To: <20111116204759.GA2153@slate>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cedric Sodhi <manday@gmx.net>
Cc: Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

Hi Chris,

it looks like the quirks were not taken into account.
Normally, you don't need to manually add the VID:PID with the sysfs as
you already registered your device in the list.

1) What is the value of the quirks sysfs attrib ? (according to your
logs, it should show 1, instead of 18)

2) did you do depmod and are you sure the hid-multitouch module loaded
is the one with USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5?
to be sure, please provide the outputs of:
$ modinfo hid-multitouch
$ modinfo <path to jiri-hid>/drivers/hid/hid-multitouch.ko

If you added your device through the sysfs because it was not taken by
hid-multitouch, replace the last parameter by 104:
$ echo 3 0eef a001 104 > new_id
But again, this is not the right way as you registered it.

Cheers,
Benjamin


On Wed, Nov 16, 2011 at 21:48, Cedric Sodhi <manday@gmx.net> wrote:
> Dear Benjamin,
>
> I applied your patch tp 3.2-jikos (uname shows 3.1, though). The
> diff to jikos' original is now [attached].
>
> Chris says the output of evtest still signifies problems with
> multitouch:
>
>> > http://ompldr.org/iYmIzYw
>>
>> Cedric, can you send these logs to Benjamin for ideas? =A0The HID ev=
ents
>> look good but the evtest log for 2 fingers is not. =A0The two touche=
s
>> are fighting each other. =A0That "-1" value is interrupted as each
>> finger is being lifted in between each new X/Y report.
>>
>> Also, can you send me and Benjamin the source code diff of what your
>> testing against kernel tree?
>>
>> The behavior in your evtest log looks like what would happen if your
>> setting the MT_QUIRK_NOT_SEEN_MEANS_UP. =A0Since your HW only sends =
1
>> fingers worth of data per packet, you do not want that quirk.
>>
>> I'll still hold off on xf86-input-wacom issues until the events comi=
ng
>> are sane. =A0Your current events will cause xf86-input-wacom to do a=
ll
>> kinds of weird stuff thats not worth effort to weed threw.
>>
>> Chris
>
> These logs in that tarfile were created while still manually adding t=
he
> ID via your sysfs interface. You find yet another evtest log for
> two-finger touch attached.
>
> Cedric
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
