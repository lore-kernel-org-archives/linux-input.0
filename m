From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: hid_apple bug: arrow keys interpreted as Fn
Date: Wed, 20 May 2009 16:19:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905201615490.13917@wotan.suse.de>
References: <3E66E0E0-3B2B-4F78-9A62-87015A842A47@freedesktop.org> <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org> <4A132540.7070409@gmail.com> <B9186545-9C33-4ADA-A3D9-8B5A5DA377CE@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50905 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647AbZETOTM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 10:19:12 -0400
In-Reply-To: <B9186545-9C33-4ADA-A3D9-8B5A5DA377CE@freedesktop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@freedesktop.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

On Tue, 19 May 2009, Jeremy Huddleston wrote:

> press right:
> May 19 18:01:14 aeris kernel: [  256.453247] drivers/hid/hid-core.c: report (size 8) (unnumbered)
> May 19 18:01:14 aeris kernel: [  256.453259] drivers/hid/hid-core.c: report 0 (size 8) =  00 00 4f 00 00 00 00 00
[ ... ]
> press down:
> May 19 18:01:17 aeris kernel: [  259.429256] drivers/hid/hid-core.c: report (size 8) (unnumbered)
> May 19 18:01:17 aeris kernel: [  259.429268] drivers/hid/hid-core.c: report 0 (size 8) =  00 00 4f 51 00 00 00 00
[ ... ]
> press left:
> May 19 18:01:20 aeris kernel: [  262.469256] drivers/hid/hid-core.c: report (size 8) (unnumbered)
> May 19 18:01:20 aeris kernel: [  262.469269] drivers/hid/hid-core.c: report 0 (size 8) =  00 00 01 01 01 01 01 01
[ ... ]
> release right:
> May 19 18:01:22 aeris kernel: [  264.981247] drivers/hid/hid-core.c: report (size 8) (unnumbered)
> May 19 18:01:22 aeris kernel: [  264.981258] drivers/hid/hid-core.c: report 0 (size 8) =  00 00 51 50 00 00 00 00
[ ... ]
> release down:
> May 19 18:01:25 aeris kernel: [  267.405254] drivers/hid/hid-core.c: report (size 8) (unnumbered)
> May 19 18:01:25 aeris kernel: [  267.405267] drivers/hid/hid-core.c: report 0 (size 8) =  00 00 50 00 00 00 00 00
[ ... ]
> release left:
> May 19 18:01:26 aeris kernel: [  269.277246] drivers/hid/hid-core.c: report (size 8) (unnumbered)
> May 19 18:01:26 aeris kernel: [  269.277258] drivers/hid/hid-core.c: report 0 (size 8) =  00 00 00 00 00 00 00 00

Looks like the state machine inside the keyboard gets a little bit crazy 
when you press the third button. The data that HID core sees coming on USB 
bus really don't represent [right,down,left] being pressed.

Do you have any chance to verify whether this works properly in a 
different operating system? It would require very specific handling 
violating the standard.

Thanks,

-- 
Jiri Kosina
SUSE Labs
