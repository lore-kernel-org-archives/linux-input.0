From: =?UTF-8?B?Qml0YWkgVGFtw6Fz?= <bitai.tamas@gmail.com>
Subject: ThinkPad X300 touchpad
Date: Thu, 5 Jun 2014 15:36:07 +0200
Message-ID: <CAL6qf2s2H1a5eZF8D0Ww4t3EezMCZWdPh63tp7kaWZXzU0W-3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47515 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaFENgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jun 2014 09:36:09 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so1092110wgg.1
        for <linux-input@vger.kernel.org>; Thu, 05 Jun 2014 06:36:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Dear kernel Developers,

I am trying to get working the touchpad of my ThinkPad X300. Googling
for "thinkpad x300 touchpad alps" gives a number of results from
forums.lenovo.com where people state it is an ALPS touchpad.

I use Arch Linux, kernel version 3.14.4-1, and it is recognized as
PS/2 Generic Mouse.

I have tried everything I found on forums with a reasonable research
effort, without success.

Interestingly, however, at some point (unfortunately, I don't remember
which setup it was with, but I am pretty sure it was when I tried the
patch available at https://github.com/he1per/psmouse-dkms-alpsv7) I
managed to recognize the touchpad as PS/2 ALPS DualPoint Touchpad, or
something similar (unfortunately I didn't take a note of it), then I
changed things in my 50-synaptics.conf, rebooted, and the touchpad was
detected as PS/2 Generic Mouse again! As far as I understand things,
this shouldn't happen!

I saw others reporting that the touchpad works for them under Linux --
for example, here:

https://github.com/tsgates/arch-wiki-markdown/blob/master/wiki/Lenovo_T=
hinkpad_X300.md

So, I guess there must be a solution, and I would be so happy if you
guys could help me finding it.

Thank you in advance,

Tam=C3=A1s
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
