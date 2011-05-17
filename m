From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 35022: hid-magicmouse broken
Date: Tue, 17 May 2011 14:56:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz>
References: <4DD26CB8.7070409@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38086 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708Ab1EQM4V (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 08:56:21 -0400
In-Reply-To: <4DD26CB8.7070409@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Ott <alan@signal11.us>

On Tue, 17 May 2011, Chase Douglas wrote:

> Hi Jiri,
> 
> I've received a few emails about the magicmouse driver being broken on
> 2.6.39:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=35022
> 
> It seems hid_output_raw_report() is returning a different (incorrect?)
> value than in the past. Do you know what might be going on?

So we are getting EIO from the transport-level _raw callback.

Hmm, commit 0825411ade seems like a suspect here. Might be possible that 
magicmouse doesn't send ACK back, right?

Could you please try reverting that commit and re-test?

Adding Alan to CC.

-- 
Jiri Kosina
SUSE Labs
