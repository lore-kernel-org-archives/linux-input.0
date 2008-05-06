From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] fix apple alu keyboard with numpad
Date: Tue, 6 May 2008 22:46:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805062244130.11363@jikos.suse.cz>
References: <4814612F.5030606@bakke.com> <20080506125406.dc047710.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38082 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755241AbYEFUqj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 May 2008 16:46:39 -0400
In-Reply-To: <20080506125406.dc047710.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dag Bakke <dag@bakke.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Diego 'Flameeyes' Petteno <flameeyes@gmail.com>

On Tue, 6 May 2008, Andrew Morton wrote:

> > The nice apple alu keyboards with numpads are pretty much unusable in
> > vanilla 2.6.25.
> > (http://images.apple.com/keyboard/images/gallery/wired_1_20070813.jpg)
> > Hitting the 'clear' key (=numlock) disables the numpad, and maps multiple
> > alphanumeric keys to numpad symbols in typical laptopkeyboard fashion.
> This conflicts rather directly with 
> hid-disable-numlock-emulation-for-apple-aluminium-keyboards.patch below 
> (hm, seems we didn't get a changelog for that one).

Hi,

I have just today applied Diego's patch into my tree [1], he has provided 
the changelog out of list to me.

> Jiri, what should we do here?

Dag, I think Diego's patch should solve the issue you are seeing, right?

[1] http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=commit;h=ffe6f7b799e33f51732520979f9c253a252b9d5e

Thanks,

-- 
Jiri Kosina
