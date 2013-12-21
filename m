From: "J. Domburg" <jeroen@spritesmods.com>
Subject: Re: T440s Synaptics clickpad: lost sync / KBC bad data
Date: Sun, 22 Dec 2013 00:17:06 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1312220001560.4559@icf1.fcevgrfzbqf.pbz>
References: <alpine.DEB.2.00.1312151507560.6449@icf1.fcevgrfzbqf.pbz> <loom.20131221T224832-537@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from spritesmods.com ([188.40.123.50]:38743 "EHLO spritesmods.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755858Ab3LUXRK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Dec 2013 18:17:10 -0500
In-Reply-To: <loom.20131221T224832-537@post.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heinz Wiesinger <HMWiesinger@liwjatan.at>
Cc: linux-input@vger.kernel.org


On Sat, 21 Dec 2013, Heinz Wiesinger wrote:
> J. Domburg <jeroen <at> spritesmods.com> writes:
> I'm experiencing exactly the same issue. I have my T440s now for a bit more
> than two weeks. No issues with the touchpad until today when it suddenly
> started acting up and I now see messages like these in dmesg
<snip>

Hi Heinz, all,

Always good to know mine is not an isolated case, although in this case, I 
wouldn't want to wish the issue on anyone else...

FYI: I haven't resolved this issue yet, but I'm thinking this may be a 
hardware issue after all. I decided to try and see if Win7 has this issue 
too, and got myself an USB-stick to install it from. I didn't even get 
past the installer. It gave me exactly the same issues as Linux has: 
an erratic and finally hanging cursor when using the clickpad.

I can understand Lenovo not wanting to support a Linux-only-issue so up 
till now I haven't bothered them yet with my issue, but I can't see my 
laptop not having mouse support in something as commonly used and 
well-supported by hardware manufacturers as the Win7 installer. This 
smells like an hardware issue to me, so I filed a warranty case today.

If people here don't mind, I'll keep the list updated, if anything so 
other people running into the same issues will have a reference and know 
this isn't necessarily a kernel thing.

Depending on how Lenovo reacts, I'll either have a working laptop or a 
good reason to go soldering and probing the i2c bus. In any case, I should 
end up with a solution I'd think :) although it'd be good if someone more 
versed in the i8042 and related things would look over my shoulder in the 
latter case.

Cheers,
Jeroen
