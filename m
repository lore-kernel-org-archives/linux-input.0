From: bri <bri@abrij.org>
Subject: Re: [PATCH 001/001] hid-sony.c: add sysfs provisioning
Date: Tue, 18 Nov 2014 19:13:53 -0500
Message-ID: <20141119001353.GA635@abrij.org>
References: <20141116181846.GA31516@abrij.org>
 <20141117133518.ee306b3b35a0e0566a255b14@ao2.it>
 <20141118020144.GB32256@abrij.org>
 <20141118234349.7b44949197898390d496f1cd@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [140.232.255.14] ([140.232.255.14]:58848 "EHLO mail.abrij.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932108AbaKSANz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 19:13:55 -0500
Content-Disposition: inline
In-Reply-To: <20141118234349.7b44949197898390d496f1cd@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Frank Praznik <frank.praznik@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>

On Tue, Nov 18, 2014 at 11:43:49PM +0100, Antonio Ospite wrote:
> On Mon, 17 Nov 2014 21:01:44 -0500
> bri <bri@abrij.org> wrote:
> If you can upload a shell script to the target system you may as well
> upload a static binary; and if you can use a modified kernel you can
> compile _for_ the target even if not _on_ the target.
>
> And if you need help to write the program which uses the HID ioctls
> just ask :)

What, no, that's really super easy for me.  I don't prefer to do it that
way, personally so I won't -- I'm going to have to heavily mod things
down through hid-core and up through js to get other behaviors I want,
anyway.

The point of pushing the patch up here, of course, was so that people
who could not do many of the above listed things would have an easy
interface.

Thanks, though.

If I actually end up having the time to get anything working I'll post
a link to a repo so that if anything looks in there looks interesting
someone can ask me for a patch submittal.

