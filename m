From: Anisse Astier <anisse@astier.eu>
Subject: Re: HID: Add MULTI_INPUT quirk for another D-WAV touchscreen
Date: Thu, 23 Dec 2010 17:47:50 +0100
Message-ID: <20101223174750.5eea0e7b@destiny.ordissimo>
References: <1292928918-31264-1-git-send-email-anisse@astier.eu>
	<20101222191926.GA30150@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62089 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0LWQtJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Dec 2010 11:49:09 -0500
Received: by wyb28 with SMTP id 28so6250417wyb.19
        for <linux-input@vger.kernel.org>; Thu, 23 Dec 2010 08:49:08 -0800 (PST)
In-Reply-To: <20101222191926.GA30150@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>

On Wed, 22 Dec 2010 20:19:26 +0100, "Henrik Rydberg" <rydberg@euromail.se> wrote :

> On Tue, Dec 21, 2010 at 10:55:18AM -0000, Anisse Astier wrote:
> > Signed-off-by: Anisse Astier <anisse@astier.eu>
> 
> Thanks for the patch - full multitouch support for this device will be enabled in 2.6.38.
> 
> (@jiri: yes, and it is already queued)

I checked quickly Jiri's tree to see if it was already supported in the
HID branch before sending. How could I check your patch queue or
Stephane's in the future ?
It's not really important if this patch goes in as long it's
supported :-).

I've also had another USB touchscreen with USB id 222a:0001 needing the
MULTI_INPUT quirk, but I don't have the hardware anymore and I don't know
it'll be of useful to anyone.

Regards,
Anisse
