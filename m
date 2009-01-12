From: Michael Tokarev <mjt@tls.msk.ru>
Subject: input devices handling
Date: Mon, 12 Jan 2009 23:19:20 +0300
Message-ID: <496BA5C8.5090506@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.33.150]:20984 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbZALUTW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 15:19:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

[Repost for:
Message-ID: <48FF9737.5050207@msgid.tls.msk.ru>
Date:	Thu, 23 Oct 2008 01:12:23 +0400
To: linux-kernel@vger.kernel.org,
which is a repost of earlier message with similar
content/question, both went unanswered]

Hello.

Similar question has been asked already by me in the past,
regarding "conversions" of ACPI button events to "keyboard
events".  The talk is about how one is supposed to handle
various "common" "meta-buttons" like Power, Sleep, and so
on.

Before, there was /proc/acpi/event and /etc/acpid/* stuff,
and it was easy (but somewhat clumsy) to act to system power
down button.  But the "proper way" now is to handle
/dev/input/event* interface, because such "Power" button can
be on a keyboard, on a remote control, and so on.  I understand
the idea, and I like it.

But now the question.  How one supposed to find all the devices
which generate such events?  I mean not about scanning the /dev
directory, which can be done once at startup, but about REscanning
it to find which NEW keyboards and the like appeared since last
(re)scan and which were removed.

For mouse, there is /dev/[input/]mice, which is a meta-device
for all mouse-like devices out there, and it actually works.
For an application that reacts to system button events, there
is no such device, and the only way is to scan all keyboard-like
devices and open them all (well, only ones which actually have
the buttons in question, but that's minor detail).

So now I have to know WHEN to (re)scan the devices.  Should I
depend on udevd/hald for that (i really dislike this way)?
Or should I just rescan periodically, say, every 10 sec or
so?  Or is there other, better way?

The only thing I need so far is to be able to shut down the
machine on a power down button.  Maybe in the future something
like changing audio volume etc will be of interest too, but
that should be pretty similar.

Thanks!

/mjt

