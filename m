From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Fri, 15 Jun 2012 23:01:44 -0500
Message-ID: <20120616040144.GA4076@burratino>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
 <20120614212335.GA4210@burratino>
 <CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
 <20120615002705.GA7140@burratino>
 <CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:35072 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab2FPEBw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jun 2012 00:01:52 -0400
Received: by ghrr11 with SMTP id r11so2858228ghr.19
        for <linux-input@vger.kernel.org>; Fri, 15 Jun 2012 21:01:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: dmitry.torokhov@gmail.com, =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>

Ping Cheng wrote:

> I downloaded, built and installed 3.5.-rc2 and 3.2.20 from kernel.org
> without changing anything in the source. 3.5.-rc2 works all right. But
> I can not boot 3.2.20 on my system (the error has nothing to do with
> wacom driver).

By the way, if you have time to describe the boot failure in more
detail to stable@vger.kernel.org (feel free to cc me), that would be
very useful.

Thanks much,
Jonathan
