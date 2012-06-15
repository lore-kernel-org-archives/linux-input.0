From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Thu, 14 Jun 2012 19:27:06 -0500
Message-ID: <20120615002705.GA7140@burratino>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
 <20120614212335.GA4210@burratino>
 <CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51162 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab2FOA1O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jun 2012 20:27:14 -0400
Received: by gglu4 with SMTP id u4so1911949ggl.19
        for <linux-input@vger.kernel.org>; Thu, 14 Jun 2012 17:27:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: dmitry.torokhov@gmail.com, =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>

Ping Cheng wrote:

> I feel very bad about the issue. More testing should have been done
> among us during the development. Since the patch was touched by more
> than one people at linuxwacom.sf.net project, we most likely did not
> test TPC2FG devices after last person's change.

It's not really about testing.  A patch adding MTSCREEN support simply
should not touch the non-MTSCREEN cases at all.  It can make perfect
sense to have some preparatory changes that affect other devices, as
earlier patches in the same series.

And I don't think it's your fault --- others on the linux-input@ list
could have caught it.

[...]
> All in all, I am very sorry about the problem. But reverting back
> isn't as easy as it sounds since we have many patches built on it now.
> Using your patch requires us the same amount of time to test on other
> devices, which does not help us move forward.
>
> So, I propose we make a patch that fixes the issue upstream.

Yeah, that works for me.  But please be more careful in the future.

Thanks,
Jonathan
