From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
  quirky remote
Date: Thu, 18 Mar 2010 11:51:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003181150401.18642@pobox.suse.cz>
References: <4B8902C5.5000508@gmail.com>  <alpine.LNX.2.00.1003151701380.18642@pobox.suse.cz> <3711715e1003171218n2e15438fy6bf5d2615a4cb4ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48678 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab0CRKvC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Mar 2010 06:51:02 -0400
In-Reply-To: <3711715e1003171218n2e15438fy6bf5d2615a4cb4ae@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wayne Thomas <waynethomas69@gmail.com>
Cc: Ben Hardill <b.hardill@gmail.com>, linux-input@vger.kernel.org

On Wed, 17 Mar 2010, Wayne Thomas wrote:

> I have compiled kernel 2.6.33.1 with hid_debug set to 2.
> Below is the output of the appropriate device (the remote presents
> itself as two separate event devices) when pressing some of the
> buttons in question.
> 
> I have attached the output of
> /sys/kernel/debug/hid/0003:046E:5578.0004/rdesc as a text file since
> it is so long, but here is the output of
> /sys/kernel/debug/hid/0003:046E:5578.0004/events (one report for each
> button pressed).
> 
> report (size 7) (numbered)
> 
> 
> 
> report (size 7) (numbered)
> 
> 
> 
> report (size 7) (numbered)
> 
> 
> 

Hmm, this is very odd output. Do you by any chance have messages such as

        undefined report_id <NUMBER> received

appearing in your 'dmesg' output when you are pressing the keys?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
