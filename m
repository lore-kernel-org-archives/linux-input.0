From: Melchior FRANZ <melchior.franz@gmail.com>
Subject: [hidraw] ThrustMaster HOTAS Warthog (success & HW documentation)
Date: Mon, 3 Oct 2011 14:00:37 +0200
Message-ID: <201110031400.38927@rk-nord.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:46272 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754352Ab1JCMH1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Oct 2011 08:07:27 -0400
Received: from smarthub82.res.a1.net (HELO email.aon.at) ([172.18.1.202])
          (envelope-sender <melchior.franz@gmail.com>)
          by fallback43.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 3 Oct 2011 12:00:45 -0000
Received: from 178-190-230-43.adsl.highway.telekom.at (HELO server.gustav.lan) ([178.190.230.43])
          (envelope-sender <melchior.franz@gmail.com>)
          by smarthub82.res.a1.net (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 3 Oct 2011 12:00:42 -0000
Received: from server.localnet (localhost [IPv6:::1])
	by server.gustav.lan (Postfix) with ESMTP id 10A7E5394A33
	for <linux-input@vger.kernel.org>; Mon,  3 Oct 2011 14:00:42 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

For the archive: Because the manufacturer seemed unable to provide any
hardware specification, I've started to reverse engineer this joystick
& throttle combination. Both devices provide some configuration options,
as long as you are on MS Windows (programmable LEDs and backlight on
the throttle, and hardware deadzone on the stick). I've collected some
information here: http://members.aon.at/mfranz/warthog.html (With
contributions from SniffUSB.exe. :-)

The hidraw driver made talking to the devices a pleasure, using a simple
"echo" on the command line, or some of FlightGear's embedded scripting
language Nasal. It proved useful to let udev create persistent "by-id"
hidraw device links. More on that on above page.

m.
