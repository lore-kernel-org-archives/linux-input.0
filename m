From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] USBHID: correct start/stop cycle
Date: Wed, 12 Nov 2008 00:22:33 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811120021500.24889@jikos.suse.cz>
References: <1225579306-28524-1-git-send-email-jirislaby@gmail.com> <490D873D.9010005@gmail.com> <490DDA69.4000404@gmx.de> <200811022024.31528.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:42997 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751709AbYKKXWe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 18:22:34 -0500
In-Reply-To: <200811022024.31528.vda.linux@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Helge Deller <deller@gmx.de>, Jiri Slaby <jirislaby@gmail.com>, Jeroen Roovers <jer@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2 Nov 2008, Denys Vlasenko wrote:

> > I fully bisected it, and the final "buggy" patch seems to have been 
> > Denys Vlasenko's patch: cb8f488c33539f096580e202f5438a809195008f (see 
> > http://github.com/jonsmirl/digispeaker/commit/cb8f488c33539f096580e202f5438a809195008f) 
> > Denys: Any reason you removed "!prev" in front of "expand_stack"?
> Looks like I erroneously thought it can't be NULL,
> or that expand_upwards() is ok with getting NULL vma parameter.
> I looked again and neither is true.
> Sorry, looks like I indeed broke this.

Hmm, so ... ? Seems like this didn't get fixed in Linus' tree yet?

-- 
Jiri Kosina
SUSE Labs
