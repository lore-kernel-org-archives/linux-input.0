From: Sebastian Andrzej Siewior <bigeasy@breakpoint.cc>
Subject: Re: use after free in serport
Date: Sun, 31 Oct 2010 11:41:36 +0100
Message-ID: <20101031104136.GA511@Chamillionaire.breakpoint.cc>
References: <20101030111618.GA29915@Chamillionaire.breakpoint.cc>
 <4CCD33E6.7000104@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:46699 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755174Ab0JaKlk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Oct 2010 06:41:40 -0400
Content-Disposition: inline
In-Reply-To: <4CCD33E6.7000104@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

* Jiri Slaby | 2010-10-31 10:16:22 [+0100]:

>I think so:
>http://lkml.org/lkml/2010/10/21/223
>
>(the updated patch attached)

Thank you very much the patch, it fixes my problem. The commit that is
causing the bug (65b770468e98, ("tty-ldisc: turn ldisc user count into a
proper refcount")) was merged v2.6.31-rc6~66^2~1. Any chance that you
push it stable once it hits mainline?

>regards,

Sebastian
