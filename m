From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] hid: only dump report traffic with debug level 2
Date: Sat, 22 Mar 2008 23:36:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803222335270.5541@jikos.suse.cz>
References: <47E4200D.9080904@gmail.com> <Pine.LNX.4.64.0803222248360.5541@jikos.suse.cz>
 <47E58129.7050607@gmail.com> <Pine.LNX.4.64.0803222328590.5541@jikos.suse.cz>
 <47E5892C.9010708@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:47905 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753222AbYCVWgb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Mar 2008 18:36:31 -0400
In-Reply-To: <47E5892C.9010708@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, 23 Mar 2008, Anssi Hannula wrote:

> > I agee. On the other hand, I am currently quite often telling people 
> > who (for example) complain about non-functioning keys on some expotic 
> > keyboard "just modprobe the hid module with debug=1, press the 
> > non-functioning key, and send me dmesg output". This would now be 
> > different depending on the kernel version they use, which I don't like 
> > too much.
> Wouldn't debug=2 work with older kernel versions as well?

Of course it would, I need to have some rest, sorry for the noise :)

I will apply your patch to my tree, thanks.

-- 
Jiri Kosina
SUSE Labs
