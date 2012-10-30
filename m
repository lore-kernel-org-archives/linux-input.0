From: Dirk Hohndel <dirk@hohndel.org>
Subject: Re: [PATCH] Add support for the MacBook Pro 10,2 keyboard / touchpad
Date: Tue, 30 Oct 2012 15:28:08 -0700
Message-ID: <13ab3c9f72c.2202.2747.dirk@hohndel.org>
References: <20121030222211.GA20026@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.hohndel.org ([198.145.64.135]:49556 "EHLO mail.hohndel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab2J3W2N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Oct 2012 18:28:13 -0400
In-Reply-To: <20121030222211.GA20026@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

On October 30, 2012 3:22:11 PM "Henrik Rydberg" <rydberg@euromail.se> wrote:
> Hi Dirk,
>
>
>
> The entry in hid_mouse_ignore_list seems to be missing.

Correct. It works fine without that.

I'm on my phone but I think there's a comment somewhere that for 
certain multi-touch devices the ignore wasn't needed.

The keyboard definitely needs it, though.

Let me phrase it this way: the patch, as submitted, happily works on my rMBP 13

/D

--
Sent from my phone
Please excuse brevity and autocorrect mistakes


Sent with AquaMail for Android
http://www.aqua-mail.com


