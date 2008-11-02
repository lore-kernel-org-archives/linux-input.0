From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 1/1] USBHID: correct start/stop cycle
Date: Sun, 2 Nov 2008 20:24:31 +0100
Message-ID: <200811022024.31528.vda.linux@googlemail.com>
References: <1225579306-28524-1-git-send-email-jirislaby@gmail.com> <490D873D.9010005@gmail.com> <490DDA69.4000404@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:16139 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYKBTam (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Nov 2008 14:30:42 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2474105fkq.5
        for <linux-input@vger.kernel.org>; Sun, 02 Nov 2008 11:30:40 -0800 (PST)
In-Reply-To: <490DDA69.4000404@gmx.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jeroen Roovers <jer@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 02 November 2008 17:50, Helge Deller wrote:
> Jiri Slaby wrote:
> >>> btw. this is not expected to fix that, but if it does, the better ;).
> >> I tried the patch and sadly it didn't fixed the parisc bug.
> > 
> > Could you bisect it?
> 
> I fully bisected it, and the final "buggy" patch seems to have been 
> Denys Vlasenko's patch: cb8f488c33539f096580e202f5438a809195008f
> (see 
> http://github.com/jonsmirl/digispeaker/commit/cb8f488c33539f096580e202f5438a809195008f)
> Denys: Any reason you removed "!prev" in front of "expand_stack"?

Looks like I erroneously thought it can't be NULL,
or that expand_upwards() is ok with getting NULL vma parameter.

I looked again and neither is true.

Sorry, looks like I indeed broke this.
--
vda
