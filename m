From: simon@mungewell.org
Subject: Re: [PATCHv2] HID: sony: Send FF commands in non-atomic context
Date: Sun, 17 Nov 2013 16:49:25 -0500
Message-ID: <634673e58b15294f709002d9293e64dd.squirrel@mungewell.org>
References: <1384682880-5960-1-git-send-email-sven@narfation.org>
    <1384717101-7027-1-git-send-email-sven@narfation.org>
    <b5aa869c12a432d275c51f9130ba697b.squirrel@mungewell.org>
    <2281545.UHfeV6KrOG@sven-edge>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39844 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab3KQVt1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 16:49:27 -0500
In-Reply-To: <2281545.UHfeV6KrOG@sven-edge>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

> On Sunday 17 November 2013 14:46:32 simon@mungewell.org wrote:
>> >  drivers/hid/hid-sony.c | 53
>> >
>> > +++++++++++++++++++++++++++++++++++++++-----------
>> >
>> >  1 file changed, 42 insertions(+), 11 deletions(-)
>>
>> Doesn't this miss patching Kconfig (previous changes were reverted).
>> Simon
>
> This was meant as a "replacement"/v2 of the revert patch as said earlier
> (directly bellow the commit message):
>
>> > This patch can replace
>> > 'Revert "HID: sony: Add force feedback support for Dualshock3 USB"'
>
> And if the maintainer doesn't like the work_queue workaround then he can
> still
> apply the revert patch or discuss/propose a different approach.

Patching the original Nov9 patch ([PATCH] HID: sony: Add force feedback
support for Dualshock3 USB) and then the 2nd revert ([PATCHv2] HID: sony:
Send FF commands in non-atomic context) works for me.

Both Sony DualShock2/SixAxis and my wired Itec controller work as expected
with 'testrumble' and 'testhaptic'.

Thanks for getting this fixed.
Simon

Signed-off-by: Simon Wood <simon@mungewell.org>

