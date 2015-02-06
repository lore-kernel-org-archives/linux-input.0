From: simon@mungewell.org
Subject: Re: [PATCH 0/4] HID: Improve handling of multimode Logitech handling
 wheels
Date: Fri, 6 Feb 2015 12:27:21 -0500
Message-ID: <6e685b15c7cad542141da09c54b8992c.squirrel@mungewell.org>
References: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:56958 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515AbbBFR1Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 12:27:25 -0500
In-Reply-To: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com, =?iso-8859-1?Q?=22Michal_Mal=C3=BD=22?= <madcatxster@devoid-pointer.net>

> This patch series improves handling of various Logitech gaming wheels and
> allows switching between various compatibility modes which might be useful
> to improve compatibility with very old games and testing purposes.

Hi all,
We should note that part 1 performs a very important function of identify
the wheels as per Logitech's schema.

At present our (old detection) uses USB Revision to identify 'fancy'
wheels which can be placed into native mode. This means when Logitech
updates the hardware we are playing catch-up (this has happened 3 times
with the DF-GT wheel so far).

This newer code should automatically cope with new wheels in the future.


Thanks to Michal for undertaking this work. I have been testing the code
over the past weeks and believe it to be working, I will confirm mid-next
week when I can gain access to my wheels.

Simon

