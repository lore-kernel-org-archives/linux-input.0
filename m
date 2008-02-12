From: Peter Stokes <linux@dadeos.co.uk>
Subject: Soft-autorepeat functionality
Date: Tue, 12 Feb 2008 22:01:34 +0000
Message-ID: <200802122201.34643.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+chsHBfcN8snrt1"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.wanadoo.co.uk ([193.252.22.156]:55945 "EHLO
	smtp3.freeserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764672AbYBLXOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2008 18:14:14 -0500
Received: from smtp3.freeserve.com (mwinf3206 [172.22.156.34])
	by mwinf3210.me.freeserve.com (SMTP Server) with ESMTP id 8C6E31C0CC04
	for <linux-input@vger.kernel.org>; Tue, 12 Feb 2008 23:02:18 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3206.me.freeserve.com (SMTP Server) with ESMTP id B792D7000088
	for <linux-input@vger.kernel.org>; Tue, 12 Feb 2008 23:01:35 +0100 (CET)
Received: from RedDwarf.dadeos.co.uk (user-5446c709.lns5-c13.telh.dsl.pol.co.uk [84.70.199.9])
	by mwinf3206.me.freeserve.com (SMTP Server) with ESMTP id 92ED77000081
	for <linux-input@vger.kernel.org>; Tue, 12 Feb 2008 23:01:35 +0100 (CET)
Received: from tuscan.dadeos.co.uk (Tuscan.dadeos.co.uk [10.0.1.252])
	by RedDwarf.dadeos.co.uk (8.14.2/8.14.1) with ESMTP id m1CM1YSw002196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Tue, 12 Feb 2008 22:01:35 GMT
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--Boundary-00=_+chsHBfcN8snrt1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've been experimenting with using the software autorepeat functionality in=
=20
drivers/input/input.c and have the problem that it autorepeats all EV_KEY=20
reported events, this includes mouse buttons etc. which for a combined=20
mouse/keyboard device is undesirable. I appreciate that I could override th=
e=20
functionality by providing my own=A0implementation=A0of software autorepeat=
,=20
which filters such buttons from being repeated, but I was wondering whether=
=20
this is something that should be included in the default implementation?

I'm not sure where the definition of KEY_MIN_INTERESTING comes from but it=
=20
appears to me that it is only keys with codes less than this value that=20
should be repeated?

So, please find attached a patch that implements the functionality I am=20
looking for...

Best regards

Peter Stokes


--Boundary-00=_+chsHBfcN8snrt1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="input_autorepeat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="input_autorepeat.patch"

Signed-off-by: Peter Stokes <linux@dadeos.co.uk>

--- linux-2.6.24-orig/drivers/input/input.c	2008-01-24 22:58:37.000000000 +0000
+++ linux-2.6.24/drivers/input/input.c	2008-02-11 20:02:03.000000000 +0000
@@ -123,6 +123,7 @@
 static void input_start_autorepeat(struct input_dev *dev, int code)
 {
 	if (test_bit(EV_REP, dev->evbit) &&
+	    code < KEY_MIN_INTERESTING &&
 	    dev->rep[REP_PERIOD] && dev->rep[REP_DELAY] &&
 	    dev->timer.data) {
 		dev->repeat_key = code;

--Boundary-00=_+chsHBfcN8snrt1--

