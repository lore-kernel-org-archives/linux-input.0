From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 4.0-rc4
Date: Thu, 19 Mar 2015 17:17:01 -0700
Message-ID: <20150320001701.GM30732@dtor-ws>
References: <20150319192056.GL30732@dtor-ws>
 <CA+55aFxg4-6vSVPX9vuc2BMujZE9wCe4a3fo8oNg1YHMH-V_uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38633 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbbCTARG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 20:17:06 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFxg4-6vSVPX9vuc2BMujZE9wCe4a3fo8oNg1YHMH-V_uw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, Mar 19, 2015 at 04:45:24PM -0700, Linus Torvalds wrote:
> On Thu, Mar 19, 2015 at 12:20 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Linus,
> >
> > Please pull from:
> >
> >         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> > or
> >         master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> Btw, can you change your script to not use that old ssh-to-master
> line? It hasn't worked in a long time, and even back when it worked it
> was the wrong way to pull things.
> 
> So just have that "git://git.kernel.org.." line.

Sure, I'll zap it.

-- 
Dmitry
