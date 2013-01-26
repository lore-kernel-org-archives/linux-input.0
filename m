From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 2/3] Input: ALPS - Add code to support "Rushmore" touchpads
Date: Sat, 26 Jan 2013 11:09:45 -0800
Message-ID: <CAJiQ=7BVPHH2jQL6+uoLm3f+J7PtNzzRK+4vV1r2D8R37k=tzA@mail.gmail.com>
References: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
	<092b691c8e994d31cb235fd7c45afee4@localhost>
	<87zjzwqhxi.fsf@dell.be.48ers.dk>
	<CAJiQ=7DmMAuV8GPvxyUMJbTG8TBPBG8PaaZ5-kED6gFf_5k21Q@mail.gmail.com>
	<87ip6jdbhn.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:52502 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3AZTJq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jan 2013 14:09:46 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so823394pad.3
        for <linux-input@vger.kernel.org>; Sat, 26 Jan 2013 11:09:45 -0800 (PST)
In-Reply-To: <87ip6jdbhn.fsf@dell.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: dmitry.torokhov@gmail.com, seth.forshee@canonical.com, linux-input@vger.kernel.org

On Sat, Jan 26, 2013 at 10:51 AM, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> Hmm, odd - I rebooted and now it seems ok:
>
> dmesg|egrep -i 'stick|alps'
> input: DualPoint Stick as /devices/platform/i8042/serio1/input/input13
> input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input14

I hope this code does not fail intermittently...

> What is this trackstick thing?

On other laptops (e.g. Dell E6430) there is a trackstick on the
keyboard between the G/H/B keys, and its reports are handled by the
ALPS driver.

There was a suggestion in the launchpad.net thread to check a register
bit to see if the trackstick is present, but it isn't yet clear
whether this bit actually indicates the presence of the trackstick or
if it just "happens" to be set on the units that have tracksticks.

My suggestion was to avoid registering the trackstick if we have a
foolproof way of knowing it's missing, otherwise just register it
unconditionally to be safe.
