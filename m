From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Mon, 18 Jun 2012 17:06:48 -0700
Message-ID: <CAF8JNhLxE08pWqowJXAAPO1LQMZUf3=AWXhxzq+QN5YEa4J0Yw@mail.gmail.com>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
	<20120614212335.GA4210@burratino>
	<CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
	<20120615002705.GA7140@burratino>
	<CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
	<20120616040144.GA4076@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55570 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab2FSAGu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 20:06:50 -0400
Received: by lbbgm6 with SMTP id gm6so5013374lbb.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jun 2012 17:06:48 -0700 (PDT)
In-Reply-To: <20120616040144.GA4076@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dmitry.torokhov@gmail.com, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, nils@kanning.de

On Fri, Jun 15, 2012 at 9:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ping Cheng wrote:
>
>> I downloaded, built and installed 3.5.-rc2 and 3.2.20 from kernel.org
>> without changing anything in the source. 3.5.-rc2 works all right. But
>> I can not boot 3.2.20 on my system (the error has nothing to do with
>> wacom driver).
>
> By the way, if you have time to describe the boot failure in more
> detail to stable@vger.kernel.org (feel free to cc me), that would be
> very useful.

Sorry for not getting back to you sooner.  I am off today. I made
3.2.20 work after rerunning "make config" on Friday.

With the output of lsusb and dmesg from Nils, looks like either
MAXCONTACTS, or device_type, or both are the root cause. MAXCONTACTS
is not 2. The problem is that I do not have an X220T (0xE6) system to
test with. My testing is on an 0xE3 system, which does not report
MAXCONTACTS. So, a patch for upstream is needed.

I'll make a patch tomorrow for Nils to test.

Ping
