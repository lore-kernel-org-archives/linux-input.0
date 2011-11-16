From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 11:17:57 +0100
Message-ID: <CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
References: <20111116095030.GC3335@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64641 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab1KPKSA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 05:18:00 -0500
Received: by wwe5 with SMTP id 5so450106wwe.1
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 02:17:58 -0800 (PST)
In-Reply-To: <20111116095030.GC3335@slate>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cedric Sodhi <manday@gmx.net>
Cc: linux-input@vger.kernel.org

Hi Cedric,

If I understand correctly, your device is an eGalax one with a Wacom
VendorID... ;-)

I assume that you're the first of a long list that will encounter this
kind of problem:

Now, hid (the generic hid input layer) can detect if your device is a
multitouch one (by relying on the ContactID field in the report
descriptor), and it will release it if it's detected.
The counter part of this autodetection (in hid-multitouch) has not
been judged as enough mature to be included in the kernel, and
hid-multitouch can't handle your device automatically.

That's why you don't see any event* unless you add the VID:PID in
hid-multitouch.

I'm currently working on a solution to allow end-user to test more
efficiently their device with hid-multitouch.
If you want to be my guinea pig, it would help me.

Cheers,
Benjamin

On Wed, Nov 16, 2011 at 10:50, Cedric Sodhi <manday@gmx.net> wrote:
> Hello everyone,
>
> the context for this problem is getting the eGalax USB Touchscreen, I=
D
> 056a:0090, to work as such, as it is discussed on the linuxwacom-deve=
l
> list (see [1]).
>
> Quickly summarized:
>
> Adding the device as USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5, in line w=
ith
> the ..._MULTITOUCH[1-4], succeeds in thus far, as that it appears as =
a
> HID Touchscreen. However, as of 3.1.x, clicking, id est touching "jam=
s"
> as in the click is never released.
>
> Updating to 3.2.x-torvalds' kernel should have resolved that jamming,
> but instead no clicks or releases are recognized at all.
>
> The real problem with debugging that, though, is that
>
> /sys/kernel/debug/hid/<eGalax>/events
>
> remains dead, in any kernel, 3.1.x-gentoo, 3.1.x-vanilla and
> 3.2.x-torvalds alike.
>
> I hope that you may have an idea as for any of the problems, especial=
ly
> why there appears no output on the ./events node (the according node =
for
> my keyboard reports events just fine).
>
> Pasted is .config [2] for 3.2.x-torvalds and ./hid/<eGalax>/rdesc [3]=
 on
> 3.2.x-torvalds.
>
> [1]
> http://sourceforge.net/mailarchive/forum.php?thread_name=3DCAGzDe_Y2c=
SMxVPm-rcNSrMsew2V5Y0vbVyhXJBFCKraq7EaZ8g@mail.gmail.com&forum_name=3Dl=
inuxwacom-devel
> [2] http://paste.pocoo.org/show/508548/
> [3] http://paste.pocoo.org/show/508550/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
