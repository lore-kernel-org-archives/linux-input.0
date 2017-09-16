From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Support new Alps HID Touchpad device
Date: Fri, 15 Sep 2017 17:27:23 -0700 (PDT)
Message-ID: <nycvar.YFH.7.76.1709151719460.4703@jbgna.fhfr.qr>
References: <20170912025414.3784-1-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751143AbdIPA1Z (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Sep 2017 20:27:25 -0400
In-Reply-To: <20170912025414.3784-1-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On Tue, 12 Sep 2017, Masaki Ota wrote:

> This is the patch for support new Alps HID Touchpad device.
> I submitted these patch before, but it was not completed.
> So I separate the patch to some parts and release it again. 

Hi,

I have a few minor comments -- as in the past, I'd like to ask for 
improved changelogs, so that they are up to our kernel standards. As you 
are a regular contributor, it's time to start getting things right :)

Namely:

- please be generally more verbose / detailed in your changelogs
- explain not only what changes are being done, but also why they are 
  being done (what is the motivation). As an example, patch #1 has this:

	-To support Alps T4 device, clean up the source code
	-Delete unnecessary structure

  Please briefly document the cleanups, and also document which structure 
  is being removed and why it is redundant
- you can drop the repeating "Minor changes in hid-alps.c for support new 
  Alps device" prefix for the patche subjects, as it doesn't really 
  provide any extra information
- pathces #4 and #5 do quite a substantial changes to the code, it'd be 
  nice to describe in a few sentnces what are the changes (what are the 
  specifics of the new protocol, etc)

Thanks a lot!

-- 
Jiri Kosina
SUSE Labs

