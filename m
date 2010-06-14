From: Melchior FRANZ <mfranz@aon.at>
Subject: Re: [BUG?] hid-core.c: hid->name = dev->manufacturer + dev->product ... why not + dev->serial?
Date: Mon, 14 Jun 2010 23:11:18 +0200
Message-ID: <201006142311.18972@rk-nord.at>
References: <201003071655.06644@rk-nord.at> <20100309082216.GG17288@core.coreip.homeip.net> <201003091342.20273@rk-nord.at>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:65089 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756468Ab0FNVSA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 17:18:00 -0400
Received: from unknown (HELO email.aon.at) ([172.18.1.197])
          (envelope-sender <mfranz@aon.at>)
          by fallback43.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 14 Jun 2010 21:11:19 -0000
In-Reply-To: <201003091342.20273@rk-nord.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org

* Melchior FRANZ -- Tuesday 09 March 2010:
> Anyway, my kernel is "fixed", so it's not about me at all. I just feel a
> bit uncomfortably if I have to hack my kernel. Before the fix I got this
> information from js_demo/JSIOCGNAME:
> 
>   Joystick 0: "Leo Bodnar BU0836A Interface"
>   Joystick 1: "Leo Bodnar BU0836A Interface"
>   Joystick 2: "SAITEK CYBORG 3D USB"
> 
> and now I get:
> 
>   Joystick 0: "Leo Bodnar BU0836A Interface A12107"
>   Joystick 1: "Leo Bodnar BU0836A Interface A12100"
>   Joystick 2: "SAITEK CYBORG 3D USB"

As my fix[1] for this kernel flaw was brushed away without arguments (other than
a disingenious "the joystick interface sucks, anyway, just use something else"),
but people come across this thread and then ask me privatly about solutions,
(which doesn't bother me at all, btw), here again, strictly for the archive:

There's now a preload library[1] available, which overrides ioctl(), watches
for JSIOCGNAME and replaces the retarded generic product name by the actual
device identifier, which is taken from the /dev/input/by-id/ name. For some
reason the latter interface actually thinks the serial number belongs to the
joystick name. I totally agree with it!  :-}

Howto build:

  $ git clone git://gitorious.org/bu0836/bu0836.git
  $ cd bu0836/js_serial_preload/
  $ make
  $ sudo make install

Howto use:

  $ LD_PRELOAD=/usr/local/lib/js_serial_preload.so fgfs --aircraft=bo105

Viola. Everything works as intended without having to patch the broken kernel.

m.


[1] http://members.aon.at/mfranz/bu0836a.html
[2] http://gitorious.org/bu0836/
