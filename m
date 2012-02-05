From: Alban Browaeys <prahal@yahoo.com>
Subject: hid-input behing restrictive about the accepted value leads to
 issues for multimedia LX710 keyboard (resent)
Date: Sun, 05 Feb 2012 23:54:42 +0100
Message-ID: <1328482482.13410.14.camel@penelope>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm38-vm4.bullet.mail.bf1.yahoo.com ([72.30.239.20]:33405 "HELO
	nm38-vm4.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753117Ab2BEXAV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Feb 2012 18:00:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Since commit 6da7066906e977d42104a859c490f5f9a300488c  my multimedia
keys behaves as stuck (ie no release events seen by evdev).

046d:c517 Logitech, Inc. LX710 Cordless Desktop Laser reports a minimum
logical of 1 not 0. This leads to multimedia key press behing
 seen as stuck (as 0 is the returned value for release which is below
minimum reported in rdesc for Consumer).

Enabling hid debug via echo 2 > /sys/module/hid/parameters/debug showed
while pressing the mulitmedia keys:
 drivers/hid/hid-input.c: Ignoring out-of-range 
after the press event (I had also evbug loaded). Then the key will
behave as stuck from evdev point of view (only hidraw and hiddev device
files showing activity, no more from event file).


Just a wild guess, egalaxy also suffers from the same issue and was
hardcoded minimum logical value 0. Could it be that this minimal logical
value is for press events (as here release events all have the value
zero). Or is this a bug in the keyboard reporting its limits.

>From  /sys/kernel/debug/hid/0003\:046D
\:C517.0002/rdesc . The offending input is input3 (ie Consumer.0001) which has logical min 1.

Note this is particularly annoying with regards to the volume up
behaving as stuck .
I also saw a french twitter user reporting the issue but without any
hint on what his keyboard was . Thus the wild guess above that it could
affect all multimedia keyboards.


Best regards
Alban


