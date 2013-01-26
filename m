From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 2/3] Input: ALPS - Add code to support "Rushmore" touchpads
Date: Sat, 26 Jan 2013 20:12:13 +0100
Message-ID: <87ehh7daia.fsf@dell.be.48ers.dk>
References: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
	<092b691c8e994d31cb235fd7c45afee4@localhost>
	<87zjzwqhxi.fsf@dell.be.48ers.dk>
	<CAJiQ=7DmMAuV8GPvxyUMJbTG8TBPBG8PaaZ5-kED6gFf_5k21Q@mail.gmail.com>
	<87ip6jdbhn.fsf@dell.be.48ers.dk>
	<CAJiQ=7BVPHH2jQL6+uoLm3f+J7PtNzzRK+4vV1r2D8R37k=tzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:54009 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3AZTMS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jan 2013 14:12:18 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so694030eei.7
        for <linux-input@vger.kernel.org>; Sat, 26 Jan 2013 11:12:16 -0800 (PST)
In-Reply-To: <CAJiQ=7BVPHH2jQL6+uoLm3f+J7PtNzzRK+4vV1r2D8R37k=tzA@mail.gmail.com>
	(Kevin Cernekee's message of "Sat, 26 Jan 2013 11:09:45 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: dmitry.torokhov@gmail.com, seth.forshee@canonical.com, linux-input@vger.kernel.org

>>>>> "Kevin" == Kevin Cernekee <cernekee@gmail.com> writes:

Hi,

 Kevin> I hope this code does not fail intermittently...

I'll run some more / do some more reboots and let you know.


 >> What is this trackstick thing?

 Kevin> On other laptops (e.g. Dell E6430) there is a trackstick on the
 Kevin> keyboard between the G/H/B keys, and its reports are handled by the
 Kevin> ALPS driver.

 Kevin> There was a suggestion in the launchpad.net thread to check a register
 Kevin> bit to see if the trackstick is present, but it isn't yet clear
 Kevin> whether this bit actually indicates the presence of the trackstick or
 Kevin> if it just "happens" to be set on the units that have tracksticks.

 Kevin> My suggestion was to avoid registering the trackstick if we have a
 Kevin> foolproof way of knowing it's missing, otherwise just register it
 Kevin> unconditionally to be safe.

yeah, seems like the safest approach.

-- 
Bye, Peter Korsgaard
