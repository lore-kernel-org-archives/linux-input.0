From: Nicole Faerber <nicole.faerber@kernelconcepts.de>
Subject: Synaptics, CAP_FORCEPAD, bad behavior
Date: Thu, 09 Oct 2014 11:34:26 +0200
Message-ID: <543656A2.4080009@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:56583 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbaJIKBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Oct 2014 06:01:22 -0400
Received: from [80.150.9.66] (helo=[192.168.203.91])
	by mail.kernelconcepts.de with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <nicole.faerber@kernelconcepts.de>)
	id 1XcA5x-0007zU-BA
	for linux-input@vger.kernel.org; Thu, 09 Oct 2014 11:33:13 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hi!
Just installed the just released 3.17 kernel and found a bad behavior of
the new Synaptics driver on my Thinkpad Yoga which has the new Synaptics
clickpad enabled touchpad:

psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1,
caps: 0xd002a3/0x940300/0x12f800, board id: 2911, fw id: 2560

The issue is that now a button release is only issued after the finger
has completely left the touchpad and not when releasing the physical
button. Is this physical button now called FORCEPAD? Anyway, this is
pretty annoying. Double clicking become a real pain.
I did comment out the new

	if (SYN_CAP_FORCEPAD(priv->ext_cap_0c)) {
	...

and everything is back to normal again, i.e. when I do release the pad
physical button but keep the finger on the pad, the button release event
is issued properly.

Cheers
  nicole

-- 
kernel concepts GmbH      Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen
http://www.kernelconcepts.de
