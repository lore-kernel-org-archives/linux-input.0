From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: usb keyboard translations
Date: Sat, 30 Oct 2010 15:32:09 +0100
Message-ID: <AANLkTin9GHck97EdayM+iySpgPi3s0ZNuRYjqge16DOE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49917 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0J3OcJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Oct 2010 10:32:09 -0400
Received: by vws13 with SMTP id 13so1277799vws.19
        for <linux-input@vger.kernel.org>; Sat, 30 Oct 2010 07:32:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

When I plug a special purpose keyboard into the USB port, it creates a
/dev/input/event9
It then provides input to the terminal as though it was a keyboard.
Unfortunately, the key mappings are all wrong for this keyboard.
Is there some way I can do key translations between the the USB
keyboard and the terminal.
The problem is I only want the translations to occur to events from
/dev/input/event9 and not any other keyboard/mouse device that is also
plugged in.
Alternatively, is there a way that I can get these events to not even
reach the terminal, and allow me to write a daemon that would listen
to /dev/input/event9 and provide a interface to my specific
application.

Kind Regards

James
