From: Timo Aaltonen <tjaalton@cc.hut.fi>
Subject: Re: support for Logitech Wave
Date: Thu, 17 Jan 2008 00:34:43 +0200 (EET)
Message-ID: <alpine.OSF.0.99.0801170002240.326334@replicant.hut.fi>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
 <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost>
 <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-1.hut.fi ([130.233.228.91]:55281 "EHLO smtp-1.hut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758205AbYAPWe7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 17:34:59 -0500
Received: from localhost (putosiko.hut.fi [130.233.228.114])
	by smtp-1.hut.fi (8.13.6/8.12.10) with ESMTP id m0GMYtRL011126
	for <linux-input@vger.kernel.org>; Thu, 17 Jan 2008 00:34:55 +0200
Received: from smtp-1.hut.fi ([130.233.228.91])
 by localhost (putosiko.hut.fi [130.233.228.114]) (amavisd-new, port 10024)
 with LMTP id 19268-39-7 for <linux-input@vger.kernel.org>;
 Thu, 17 Jan 2008 00:34:54 +0200 (EET)
Received: from replicant.hut.fi (replicant.hut.fi [130.233.200.84])
	by smtp-1.hut.fi (8.13.6/8.12.10) with ESMTP id m0GMYhBl011010
	for <linux-input@vger.kernel.org>; Thu, 17 Jan 2008 00:34:46 +0200
In-Reply-To: <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Wed, 16 Jan 2008, Jiri Kosina wrote:

> On Wed, 16 Jan 2008, Taneli V=E4h=E4kangas wrote:
>
>> I tried the same on a Creative Prodikeys keyboard, but can't see any
>> events for some keys (most notably none of the "piano" keys work). I=
s
>> there anything that can be done to make it work?
>
> Hi Taneli,
>
> yes. Could you please grab reasonably recent kernel (2.6.24-rc<anythi=
ng>
> would be ok), compile it with CONFIG_HID_DEBUG, modprobe the 'hid' mo=
dule
> with 'debug=3D1' parameter, and send me the output from the time you =
connect
> the keyboard and from pressing the non-working keys? It should be tri=
vial
> to fix then.

Hi! I managed to get the event codes with evtest. Here's the output,=20
followed by mappings to what the buttons really are. The ones that are=20
mapped below 255 are working on X:

Input driver version is 1.0.0
Input device ID: bus 0x3 vendor 0x46d product 0xc317 version 0x110
Input device name: "Logitech USB Multimedia Keyboard"
Supported events:
   Event type 0 (Reset)
     Event code 0 (Reset)
     Event code 1 (Key)
     Event code 4 (?)
   Event type 1 (Key)
     Event code 113 (Mute)
     Event code 114 (VolumeDown)
     Event code 115 (VolumeUp)
     Event code 140 (Calc)
     Event code 142 (Sleep)
     Event code 155 (Mail)
     Event code 163 (NextSong)
     Event code 164 (PlayPause)
     Event code 165 (PreviousSong)
     Event code 166 (StopCD)
     Event code 171 (Config)
     Event code 172 (HomePage)
     Event code 256 (Btn0)
     Event code 257 (Btn1)
     Event code 258 (Btn2)
     Event code 259 (Btn3)
     Event code 260 (Btn4)
     Event code 261 (Btn5)
     Event code 262 (Btn6)
     Event code 263 (Btn7)
     Event code 264 (Btn8)
     Event code 266 (?)
     Event code 267 (?)
     Event code 268 (?)
     Event code 269 (?)
     Event code 270 (?)
     Event code 271 (?)
     Event code 272 (LeftBtn)
     Event code 273 (RightBtn)


Mappings:

256 (Btn0)	"Word"
257 (Btn1)	"Spreadsheet"
258 (Btn2)	"Calendar"
259 (Btn3)	"custom key a"
260 (Btn4)	"Photos"
261 (Btn5)	"custom key b"
262 (Btn6)	"custom key c"
263 (Btn7)	"Media center"
264 (Btn8)	"Messenger"
266 (?)		"local search"
267 (?)		"Vista Flip 3D" (go through windows, "alt-tab")
268 (?)		"Vista Gadget" (
269 (?)		"internet search"
270 (?)		"zoom -"
271 (?)		"zoom +"
272 (LeftBtn)	"eject"
273 (RightBtn)	"Function key, used for most of the above"

Hope this helps!

t
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
