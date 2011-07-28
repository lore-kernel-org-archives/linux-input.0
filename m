From: Daniel Drake <dsd@laptop.org>
Subject: Re: [linux-pm] [PATCH v3 1/2] Input: enable i8042-level wakeup control
Date: Thu, 28 Jul 2011 16:21:08 +0100
Message-ID: <CAGq3pz6J2pma1TxcqUreQ-qi37Tk4VU15uAvH1=dwyAAvxAPLg@mail.gmail.com>
References: <CAGq3pz6vr2gOq91Cz6KByhF4vdWEZqOOWECZhOCVD38kcyuEFQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1107281103180.1990-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33731 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab1G1PVJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 11:21:09 -0400
Received: by fxh19 with SMTP id 19so1361624fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 08:21:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1107281103180.1990-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org

On 28 July 2011 16:08, Alan Stern <stern@rowland.harvard.edu> wrote:
> Aren't there? =A0I have no idea. =A0But if input devices are never
> wakeup-capable, why do you name your function "input_may_wakeup()"?

I guess i8042_may_wakeup() would be a better name for it. In this
case, the only device in the hierarchy (i8042 -> serio -> input) that
is marked wakeup capable is the i8042 device (and only via my
patches). I'd welcome a better design.

> I'm using a normal PC with PS/2 mouse and keyboard. =A0It is set up w=
ith
> the keyboard as a wakeup source but not the mouse. =A0Of course, this
> uses ACPI, which I assume isn't present on OLPC.

It does depend on how the system is designed, yes. I suspect that the
device that is actually marked as wakeup capable on your setup is not
an input device, but rather another part of the /sys tree (perhaps
part of the ACPI tree?). Also, I suspect that if your system is woken
up by the keyboard, it loses the keypress which was used to wake it
up.

I'm definitely open to better ways of doing this. The key consideration=
s are:
1. We only have control over wakeups at the i8042 level; i.e. we
cannot ask for keyboard wakeups but not mouse.
2. Our keyboard and mouse hardware is guaranteed to be powered
throughout suspend
3. The key press or mouse movement or click that woke the system must
not be lost during resume. This means that all 3 layers (i8042, serio,
input) must not reset or really do anything with the device during
suspend/resume.

Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
