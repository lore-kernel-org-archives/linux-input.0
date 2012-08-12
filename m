From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: 3.5.1 hid_generic causes mouse locking until a button is
 clicked
Date: Sun, 12 Aug 2012 19:53:29 +0200
Message-ID: <20120812195329.2cb454c3@neptune.home>
References: <k06dcc$u9q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:41927 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab2HLRyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Aug 2012 13:54:11 -0400
In-Reply-To: <k06dcc$u9q$1@dough.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On Sat, 11 August 2012 D=C3=A2niel Fraga <fragabr@gmail.com> wrote:
> 	I upgraded from 3.4.4 to 3.5.1 kernel and now I see the new
> hid_generic module is causing problem with my mouse (a regular Logite=
ch
> USB optical mouse).
>=20
> 	The problem is: after 2 seconds without moving the mouse, the
> pointer will NOT move again UNLESS I click a mouse button.
>=20
> 	So now I have to click a button everytime I want to "unlock"
> the mouse pointer. It didn't happen with 3.4.4 so it's clearly a
> regression.
>=20
> Any hints? I can try patches. Thanks.

This might be USB-autosuspend. 2 seconds seems to match the default
delay for autosuspending USB devices.

Have a look at the values under /power/ for your USB devices.
(probably the port to which your mouse is connected and/or the mouse
itself).
Check if disabling USB-autosuspend helps.

Compare the output of:
  grep . /sys/bus/usb/devices/*/power/*
for the time your mouse can move your pointer and when it can't.
Also change the autosuspend delay or disable autosuspend for the
mouse.

See also in your kernel sources:
  Documentation/usb/power-management.txt
  Documentation/ABI/testing/sysfs-bus-usb


Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
