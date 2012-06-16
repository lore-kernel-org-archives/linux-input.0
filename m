From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Fri, 15 Jun 2012 22:39:18 -0500
Message-ID: <20120616033917.GE3201@burratino>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
 <20120614212335.GA4210@burratino>
 <CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
 <20120615002705.GA7140@burratino>
 <CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35270 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758948Ab2FPDj1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jun 2012 23:39:27 -0400
Received: by yhmm54 with SMTP id m54so3004558yhm.19
        for <linux-input@vger.kernel.org>; Fri, 15 Jun 2012 20:39:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: dmitry.torokhov@gmail.com, =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>

Ping Cheng wrote:
> On Thu, Jun 14, 2012 at 5:27 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> It's not really about testing. =C2=A0A patch adding MTSCREEN support=
 simply
>
> Here is an update on my testing (for hardware, I have to test to be
> sure). The result shows driver in upstream and 3.2.20 both work with
> TPC2FG.

I will ask Nils to test 3.5-rc2 or newer.  For reference, he
reproduced trouble (the driver rejecting his tablet) using 3.4.2 with
the following patches on top:

  9fee619505bd Input: wacom - add basic Intuos5 support
  f860e581fd47 Input: wacom - add Intuos5 Touch Ring/ExpressKey support
  9b5b95dd516a Input: wacom - add Intuos5 Touch Ring LED support
  ae584ca47328 Input: wacom - add Intuos5 multitouch sensor support
  f393ee2b814e Input: wacom - retrieve maximum number of touch points
  1963518b9b1b Input: wacom - add 0xE5 (MT device) support
  a882c932a628 Input: wacom - return proper error if
               usb_get_extra_descriptor() fails

His machine is a Thinkpad x220t.  The built-in tablet has USB id
056a:00e6.  3.4.2 without those patches works fine.  (More details at [=
1].)

I prefer to start with making sure mainline works well first, and then
I'll be happy to work with you on backporting the current driver to
3.2-based kernels if you'd like.

Thanks again for your help,
Jonathan

[1] http://bugs.debian.org/677164
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
