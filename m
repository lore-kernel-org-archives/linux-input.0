From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH v3 1/2] Input: enable i8042-level wakeup
 control
Date: Thu, 28 Jul 2011 11:08:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107281103180.1990-100000@iolanthe.rowland.org>
References: <CAGq3pz6vr2gOq91Cz6KByhF4vdWEZqOOWECZhOCVD38kcyuEFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33783 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754576Ab1G1PIu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 11:08:50 -0400
In-Reply-To: <CAGq3pz6vr2gOq91Cz6KByhF4vdWEZqOOWECZhOCVD38kcyuEFQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org

On Thu, 28 Jul 2011, Daniel Drake wrote:

> On 28 July 2011 15:53, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Shouldn't this also check device_may_wakeup(dev)? =A0The user might
> > disable wakeup for the input device while leaving it enabled for th=
e
> > i8042 device.
>=20
> As far as I'm aware, there aren't any instances where input devices
> are marked as wakeup-capable. So, we're speaking theoretically.

Aren't there?  I have no idea.  But if input devices are never=20
wakeup-capable, why do you name your function "input_may_wakeup()"?

> But, what would this mean? On OLPC for example, we can only control
> i8042 wakeups. This means we don't get to choose that we want keyboar=
d
> wakeups and not mouse. If you enable i8042 wakeups you get both, and
> we can't change that, as the wakeup mechanism revolves around the
> i8042 controller.

I'm using a normal PC with PS/2 mouse and keyboard.  It is set up with
the keyboard as a wakeup source but not the mouse.  Of course, this=20
uses ACPI, which I assume isn't present on OLPC.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
