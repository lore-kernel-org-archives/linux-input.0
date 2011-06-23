From: Austin Zhang <zhang.austin@gmail.com>
Subject: [questions]touch driver.
Date: Thu, 23 Jun 2011 23:25:57 +0800
Message-ID: <BANLkTinXNa9Uu+d1=pwH6aDJ-wtOVJ+jiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45539 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757484Ab1FWPZ7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 11:25:59 -0400
Received: by iwn6 with SMTP id 6so1639434iwn.19
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2011 08:25:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Chase Douglas <chase.douglas@canonical.com>

hi, team,

I have several questions on touch driver.

1 For touch panel, if it is HID type panel, then for enabling
autosuspend for this device, can we only let its parent device enable
autosuspend as default, don't need do anything within that touch
driver?

2 When setting fuzz parameter by input_set_abs_params, what is the
typical rule/scenarios in general? For example, if one device which
supports logical max sample in X/Y as 4096*3072 and the screen LCD
resolution as 1024*768, then fuzz=100 is meaning that the driver will
not report (by input_event) contact point within 50 sample point
(fuzz/2) to userspace? And if in this case, the high level gesture
recognizer is setting Manhattan length as 60, does it means it is ok
if the Manhattan length of contact point coordinator from driver is
less than 240? (60*4)

3 Seemed few drivers (only egalax and intel-mid-touch) are using this
fuzz param, so in most cases, it is one in-case params to leave to
user for 'tuning' only? Then should it be exported as module
parameter?

Thanks for your answer in advance.
