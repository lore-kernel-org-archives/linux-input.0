From: "Alfred Broda" <guaranga@wp.pl>
Subject: Sanmos TWIN SHOCK gamepad Force Feedback
Date: Wed, 26 Aug 2009 13:41:27 +0200
Message-ID: <4a951f67850716.14823285@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.wp.pl ([212.77.101.1]:43606 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756485AbZHZLsJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2009 07:48:09 -0400
Received: from poczta-19.free.wp-sa.pl (HELO localhost) ([10.1.1.98])
          (envelope-sender <guaranga@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with SMTP
          for <linux-input@vger.kernel.org>; 26 Aug 2009 13:41:28 +0200
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello!
    I have a Sanmos TWIN SHOCK gamepad (6 axes, 12 buttons, labeled as=20
"Tracer"). It works great using the default driver, (generic-usb=20
0003:11C0:5400.000D: input,hidraw0: USB HID v1.00 Joystick [Sanmos TWIN=
=20
SHOCK gamepad]), but has no force feedback function that is available=20
with the Windows driver. It has two motors (left, right) with an=20
adjustable strength rumble function. Can anyone point me at a simmiliar=
=20
driver?
    I tried altering the GreenAsia driver, with no luck - I can't get a=
t the=20
debug info from the hid driver either (compiled into the kernel). I=20
think it doesn't even probe the device (no output to dmesg), does the=20
generic-usb driver lock the device somehow?
PS I've done a few USB snoops of the Windows driver so I can attach one=
=20
if that helps.
          pozdrawiam, Alfred Broda

----------------------------------------------------
Wiem, =BFe masz fajne pomys=B3y na komponowanie dodatk=F3w ;)
Pode=B6lij ciekaw=B1 propozycj=EA!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fcorto.www.wp.pl%2Fas%2Fbloogdodat=
ki.html&sid=3D842


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
