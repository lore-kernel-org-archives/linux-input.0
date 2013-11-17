From: Michel Kraus <mksolpa@gmail.com>
Subject: conflict of wiimote and hid-sony
Date: Sun, 17 Nov 2013 02:13:04 +0100
Message-ID: <CADwLDZsUsHduucFXrb218wemsGaWM76BCqQUY_OobuSf0UEP1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:54632 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab3KQBNZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Nov 2013 20:13:25 -0500
Received: by mail-lb0-f182.google.com with SMTP id u14so355800lbd.41
        for <linux-input@vger.kernel.org>; Sat, 16 Nov 2013 17:13:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

commit 86b84167 HID: wiimote: add LEGO-wiimote VID

introduced a VID/PID conflict with its original owner: hid-wiimote got
hid:b0005g*v0000054Cp00000306 added but hid-sony already has this id for
the PS3 Remote.

I think the original and legitimate owner should remain the default for this
VID/PID combination.

Michel Kraus
