From: Arto Jantunen <viiru@iki.fi>
Subject: Touchpad on Asus GL552VW not detected
Date: Sun, 17 Jan 2016 10:20:24 +0200
Message-ID: <8760ysy5vb.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:53390 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbcAQIU2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jan 2016 03:20:28 -0500
Received: from localhost (xdsl-83-145-207-40.nebulazone.fi [83.145.207.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by viiru.iki.fi (Postfix) with ESMTPSA id 76AD41FD89
	for <linux-input@vger.kernel.org>; Sun, 17 Jan 2016 10:20:25 +0200 (EET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

(Please CC me on any replies, I'm not subscribed to the list)

Hi list,

The touchpad on an Asus GL552VW is not detected by Linux 4.2-4.4-rc8 (I
have not tested earlier versions, but booting them on this hardware gets
progressively more difficult and I doubt that the results would
change).

Sadly I don't know what touchpad this machine contains, that information
doesn't seem to be available. The touchpad did work on the pre-installed
Windows image I wiped. Similar generation Asus machines seem to often
have a Focaltech touchpad which has been supported by the kernel for
some time.

Dmesg output when booting with i8042.debug set:

[    0.405193] i8042: PNP: PS/2 Controller [PNP030b:PS2K] at 0x60,0x64 irq 1
[    0.405210] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.405247] i8042: [0] d1 -> i8042 (command)
[    0.405316] i8042: [0] df -> i8042 (parameter)
[    0.405386] i8042: [0] ff -> i8042 (command)
[    0.405587] i8042: [0] 20 -> i8042 (command)
[    0.405827] i8042: [0] 65 <- i8042 (return)
[    0.405883] i8042: [0] 20 -> i8042 (command)
[    0.406847] i8042: [0] 65 <- i8042 (return)
[    0.406859] i8042: [0] 60 -> i8042 (command)
[    0.407096] i8042: [0] 74 -> i8042 (parameter)
[    0.407130] i8042: [0] 60 -> i8042 (command)
[    0.407200] i8042: [0] 65 -> i8042 (parameter)
[    0.407208] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.407303] mousedev: PS/2 mouse device common for all mice
[    0.407334] i8042: [0] f2 -> i8042 (kbd-data)

With i8042.nopnp set:

[    0.400776] i8042: PNP detection disabled
[    0.400799] i8042: [0] d1 -> i8042 (command)
[    0.400868] i8042: [0] df -> i8042 (parameter)
[    0.400938] i8042: [0] ff -> i8042 (command)
[    0.401138] i8042: [0] 20 -> i8042 (command)
[    0.401379] i8042: [0] 65 <- i8042 (return)
[    0.401435] i8042: [0] 20 -> i8042 (command)
[    0.401678] i8042: [0] 65 <- i8042 (return)
[    0.401691] i8042: [0] 60 -> i8042 (command)
[    0.401927] i8042: [0] 74 -> i8042 (parameter)
[    0.401956] i8042: [0] d3 -> i8042 (command)
[    0.402026] i8042: [0] 5a -> i8042 (parameter)
[    0.402110] i8042: [0] 5a <- i8042 (return)
[    0.402117] i8042: [0] a7 -> i8042 (command)
[    0.402346] i8042: [0] 20 -> i8042 (command)
[    0.402478] i8042: [0] 74 <- i8042 (return)
[    0.402485] i8042: [0] a8 -> i8042 (command)
[    0.402714] i8042: [0] 20 -> i8042 (command)
[    0.402846] i8042: [0] 54 <- i8042 (return)
[    0.402867] i8042: [0] 60 -> i8042 (command)
[    0.403102] i8042: [0] 56 -> i8042 (parameter)
[    0.403117] i8042: [0] d3 -> i8042 (command)
[    0.403187] i8042: [0] a5 -> i8042 (parameter)
[    0.403268] i8042: [0] a5 <- i8042 (aux_test_irq, aux)
[    0.403285] i8042: [0] 60 -> i8042 (command)
[    0.403466] i8042: [0] 74 -> i8042 (parameter)
[    0.403550] i8042: [0] d3 -> i8042 (command)
[    0.403786] i8042: [0] f0 -> i8042 (parameter)
[    0.403870] i8042: [0] f0 <- i8042 (return)
[    0.403877] i8042: [0] d3 -> i8042 (command)
[    0.404756] i8042: [1] 56 -> i8042 (parameter)
[    0.404896] i8042: [1] 56 <- i8042 (return)
[    0.404917] i8042: [1] d3 -> i8042 (command)
[    0.405153] i8042: [1] a4 -> i8042 (parameter)
[    0.405237] i8042: [1] 11 <- i8042 (return)
[    0.405238] i8042: Detected active multiplexing controller, rev 1.1
[    0.405260] i8042: [1] 60 -> i8042 (command)
[    0.405496] i8042: [1] 74 -> i8042 (parameter)
[    0.405525] i8042: [1] 90 -> i8042 (command)
[    0.405594] i8042: [1] a8 -> i8042 (command)
[    0.405664] i8042: [1] 91 -> i8042 (command)
[    0.405734] i8042: [1] a8 -> i8042 (command)
[    0.405804] i8042: [1] 92 -> i8042 (command)
[    0.405873] i8042: [1] a8 -> i8042 (command)
[    0.405943] i8042: [1] 93 -> i8042 (command)
[    0.406179] i8042: [1] a8 -> i8042 (command)
[    0.406249] i8042: [1] 60 -> i8042 (command)
[    0.406319] i8042: [1] 56 -> i8042 (parameter)
[    0.406346] i8042: [1] 60 -> i8042 (command)
[    0.406415] i8042: [1] 47 -> i8042 (parameter)
[    0.406423] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.406437] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    0.406454] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    0.406468] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    0.406531] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    0.406659] mousedev: PS/2 mouse device common for all mice
[    0.407220] i8042: [1] f2 -> i8042 (kbd-data)
[    0.410091] i8042: [2] fa <- i8042 (interrupt, 0, 1)
[    0.446451] i8042: [11] f5 -> i8042 (kbd-data)
[    0.449285] i8042: [12] fa <- i8042 (interrupt, 0, 1)
[    0.449316] i8042: [12] ed -> i8042 (kbd-data)
[    0.452935] i8042: [13] fa <- i8042 (interrupt, 0, 1)
[    0.452975] i8042: [13] 00 -> i8042 (kbd-data)
[    0.455932] i8042: [13] fa <- i8042 (interrupt, 0, 1)
[    0.456036] i8042: [13] f3 -> i8042 (kbd-data)
[    0.459595] i8042: [14] fa <- i8042 (interrupt, 0, 1)
[    0.459620] i8042: [14] 00 -> i8042 (kbd-data)
[    0.462583] i8042: [15] fa <- i8042 (interrupt, 0, 1)
[    0.462615] i8042: [15] f4 -> i8042 (kbd-data)
[    0.466255] i8042: [16] fa <- i8042 (interrupt, 0, 1)
[    0.466303] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.467003] i8042: [16] 90 -> i8042 (command)
[    0.467072] i8042: [16] f2 -> i8042 (parameter)
[    0.493711] i8042: [23] MUX error, status is 35, data is fe
[    0.493712] i8042: [23] fe <- i8042 (interrupt, 2, 12, timeout)
[    0.493740] i8042: [23] 90 -> i8042 (command)
[    0.494641] i8042: [23] ed -> i8042 (parameter)
[    0.521296] i8042: [30] MUX error, status is 35, data is fe
[    0.521297] i8042: [30] fe <- i8042 (interrupt, 2, 12, timeout)
[    0.521325] i8042: [30] 91 -> i8042 (command)
[    0.522175] i8042: [30] f2 -> i8042 (parameter)
[    0.522463] i8042: [30] MUX error, status is 75, data is fe
[    0.522464] i8042: [30] fe <- i8042 (interrupt, 3, 12, timeout)
[    0.522492] i8042: [30] 91 -> i8042 (command)
[    0.522711] i8042: [30] ed -> i8042 (parameter)
[    0.522999] i8042: [30] MUX error, status is 75, data is fe
[    0.523021] i8042: [30] fe <- i8042 (interrupt, 3, 12, timeout)
[    0.523044] i8042: [30] 92 -> i8042 (command)
[    0.523247] i8042: [30] f2 -> i8042 (parameter)
[    0.549916] i8042: [37] MUX error, status is b5, data is fe
[    0.549917] i8042: [37] fe <- i8042 (interrupt, 4, 12, timeout)
[    0.549981] i8042: [37] 92 -> i8042 (command)
[    0.550883] i8042: [37] ed -> i8042 (parameter)
[    0.577522] i8042: [44] MUX error, status is b5, data is fe
[    0.577523] i8042: [44] fe <- i8042 (interrupt, 4, 12, timeout)
[    0.577553] i8042: [44] 93 -> i8042 (command)
[    0.578460] i8042: [44] f2 -> i8042 (parameter)
[    0.605342] i8042: [51] MUX error, status is f5, data is fe
[    0.605344] i8042: [51] fe <- i8042 (interrupt, 5, 12, timeout)
[    0.605359] i8042: [51] 93 -> i8042 (command)
[    0.606259] i8042: [51] ed -> i8042 (parameter)
[    0.633160] i8042: [58] MUX error, status is f5, data is fe
[    0.633162] i8042: [58] fe <- i8042 (interrupt, 5, 12, timeout)

With i8042.nopnp and i8042.nomux set:

[    0.409029] i8042: PNP detection disabled
[    0.409065] i8042: [0] d1 -> i8042 (command)
[    0.409134] i8042: [0] df -> i8042 (parameter)
[    0.410090] i8042: [0] ff -> i8042 (command)
[    0.410290] i8042: [0] 20 -> i8042 (command)
[    0.410532] i8042: [0] 65 <- i8042 (return)
[    0.410588] i8042: [0] 20 -> i8042 (command)
[    0.410831] i8042: [0] 65 <- i8042 (return)
[    0.410844] i8042: [0] 60 -> i8042 (command)
[    0.411080] i8042: [0] 74 -> i8042 (parameter)
[    0.411109] i8042: [0] d3 -> i8042 (command)
[    0.411179] i8042: [0] 5a -> i8042 (parameter)
[    0.411263] i8042: [0] 5a <- i8042 (return)
[    0.411271] i8042: [0] a7 -> i8042 (command)
[    0.411500] i8042: [0] 20 -> i8042 (command)
[    0.411632] i8042: [0] 74 <- i8042 (return)
[    0.411639] i8042: [0] a8 -> i8042 (command)
[    0.411868] i8042: [0] 20 -> i8042 (command)
[    0.412001] i8042: [0] 54 <- i8042 (return)
[    0.412021] i8042: [0] 60 -> i8042 (command)
[    0.412257] i8042: [0] 56 -> i8042 (parameter)
[    0.412271] i8042: [0] d3 -> i8042 (command)
[    0.412345] i8042: [1] a5 -> i8042 (parameter)
[    0.412439] i8042: [1] a5 <- i8042 (aux_test_irq, aux)
[    0.412459] i8042: [1] 60 -> i8042 (command)
[    0.412648] i8042: [1] 74 -> i8042 (parameter)
[    0.412738] i8042: [1] 60 -> i8042 (command)
[    0.412974] i8042: [1] 56 -> i8042 (parameter)
[    0.413000] i8042: [1] 60 -> i8042 (command)
[    0.413070] i8042: [1] 47 -> i8042 (parameter)
[    0.413078] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.413092] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.413225] mousedev: PS/2 mouse device common for all mice
[    0.413257] i8042: [1] f2 -> i8042 (kbd-data)
[    0.416131] i8042: [1] fa <- i8042 (interrupt, 0, 1)
[    0.427665] i8042: [4] ab <- i8042 (interrupt, 0, 1)
[    0.451259] i8042: [10] f5 -> i8042 (kbd-data)
[    0.454093] i8042: [11] fa <- i8042 (interrupt, 0, 1)
[    0.454123] i8042: [11] ed -> i8042 (kbd-data)
[    0.457746] i8042: [12] fa <- i8042 (interrupt, 0, 1)
[    0.457763] i8042: [12] 00 -> i8042 (kbd-data)
[    0.460723] i8042: [13] fa <- i8042 (interrupt, 0, 1)
[    0.460740] i8042: [13] f3 -> i8042 (kbd-data)
[    0.464465] i8042: [14] fa <- i8042 (interrupt, 0, 1)
[    0.464522] i8042: [14] 00 -> i8042 (kbd-data)
[    0.467417] i8042: [14] fa <- i8042 (interrupt, 0, 1)
[    0.467449] i8042: [14] f4 -> i8042 (kbd-data)
[    0.471092] i8042: [15] fa <- i8042 (interrupt, 0, 1)
[    0.471139] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.471860] i8042: [15] d4 -> i8042 (command)
[    0.471930] i8042: [15] f2 -> i8042 (parameter)
[    0.498630] i8042: [22] fe <- i8042 (interrupt, 1, 12, timeout)
[    0.498658] i8042: [22] d4 -> i8042 (command)
[    0.499559] i8042: [22] ed -> i8042 (parameter)
[    0.526256] i8042: [29] fe <- i8042 (interrupt, 1, 12, timeout)
[    0.526272] i8042: [29] 60 -> i8042 (command)
[    0.527269] i8042: [29] 45 -> i8042 (parameter)
[    0.527331] i8042: [29] 60 -> i8042 (command)
[    0.527404] i8042: [29] 47 -> i8042 (parameter)


-- 
Arto Jantunen
