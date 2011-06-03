From: michael@m-bauer.org
Subject: Re: [PATCH v2] hid: Fix Logitech Driving Force Pro wheel
Date: Fri, 03 Jun 2011 11:25:10 +0200
Message-ID: <20110603112510.18482vx63j4ygmm8@webmail.df.eu>
References: <2b85316d7925dad6c55672d7d9738e18.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:36626 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab1FCJZN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jun 2011 05:25:13 -0400
In-Reply-To: <2b85316d7925dad6c55672d7d9738e18.squirrel@host171.canaca.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>


>> Changes from initial patch:
>> - shorten comment (removed original descriptor)
>> - optimized new descriptor (simpler and shorter)
>
> Concept looks go to me, but I'm getting
> --
> simon@ubuntu:~/linux-2.6$ patch -p 1 <
> ../Downloads/v2-hid-Fix-Logitech-Driving-Force-Pro-wheel.patch
> patching file drivers/hid/hid-lg.c
> patch: **** malformed patch at line 91: USB_DEVICE_ID_LOGITECH_G25_WHEEL), --
>
> Looks like word wrap has been applied to the patch.
>
> It also fails to patch chunk 3 against 3.0rc1 as the G27 wheel has been
> added.
> [...]

Ouch, seems i messed that up :-/

> All that said it appears to build (don't have this wheel to test) and have
> it in a git archive if you'd like be to spin a fixed patch for you.

Simon, it would be great if you could do this - I am quite busy at work
atm :-( If not let me know, then I'll try to squeeze it in on my side.

Thank you and best regards
Michael




