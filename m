From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2 00/14] Input: ALPS - Clean up and rework driver to
 support newer touchpads
Date: Thu, 14 Feb 2013 10:02:52 -0800
Message-ID: <CAJiQ=7A+STkdy5QAxr8QSh4ONjeD+jQA65BRTKNuZj7HxO+TSg@mail.gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
	<20130214171719.GA4007@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:42136 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758326Ab3BNSCz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Feb 2013 13:02:55 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so2867081oag.31
        for <linux-input@vger.kernel.org>; Thu, 14 Feb 2013 10:02:53 -0800 (PST)
In-Reply-To: <20130214171719.GA4007@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

On Thu, Feb 14, 2013 at 9:17 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Thank you very much, nice work! I applied the first 13 patches; waiting
> for acknowledgements that Dolphin works before I apply it.

Dmitry,

A couple of us were working behind the scenes on a third spin of the
patchset.  There was one change that affected patches #07-13:

 - Remove unused "resp" parameter from alps_enter_command_mode() (minor cleanup)

And several more improvements/fixes to the Dolphin patch #14:

 - Distinguish between Dolphin V1 and V2 in alps_identify() and use
different init sequences
 - Take Dolphin out of the alps_model_data table, so that we can check
the second byte of the EC report
 - Use the Dave T / Florin V1 init sequence verbatim if it's V1
 - Update the V2 init sequence to more closely match the binary
driver, and fix some bugs

#14 should definitely not be applied as-is.  #01-13 should be safe to
apply, or if you want, I'll post the new versions instead.

I believe the new version of the Dolphin patch is working correctly
for Dolphin V1.  Basic Dolphin V2 functionality is "OK" but there
still seems to be an issue properly sensing pressure values at the
edges of the touchpad, which might mean that the reports aren't being
decoded correctly.  As a result, users have reported that edge
scrolling is not working very well.
