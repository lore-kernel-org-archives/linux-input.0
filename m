From: Robert Gerlach <khnz@gmx.de>
Subject: Re: Key mapping question
Date: Sat, 14 Jan 2012 19:07:37 +0100
Message-ID: <20120114190737.49172w3qj2psmi04@kolab.lan>
References: <20120111223550.202a9604@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:57192 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756031Ab2ANSHp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Jan 2012 13:07:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by kolab.lan (Postfix) with ESMTP id 4953E1666A
	for <linux-input@vger.kernel.org>; Sat, 14 Jan 2012 19:07:40 +0100 (CET)
Received: from kolab.lan ([127.0.0.1])
	by localhost (kolab.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aM38Al+hagLF for <linux-input@vger.kernel.org>;
	Sat, 14 Jan 2012 19:07:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by kolab.lan (Postfix) with ESMTP id CDE0F1666E
	for <linux-input@vger.kernel.org>; Sat, 14 Jan 2012 19:07:38 +0100 (CET)
In-Reply-To: <20120111223550.202a9604@pyramind.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org, khnz@users.sourceforge.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arobase CHAC <arobase40@gmail.com>, Ryan Lewis <me@ryanlewis.net>


Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:

> I'm currently adding the Fujitsu Q550 to the fujitsu-tablet driver
> (http://sourceforge.net/projects/fjbtndrv/files/fjbtndrv/)
>
> The Q550 has 3 buttons - a direction flipping button, a keyboard button
> and a ctrl-alt-delete button.
>
> It's labelled as such, it acts as such and I'm tempted to map it as such
> including modifiers but that does rather violate the usual behaviour we
> expect.
>
> So how should it be mapped ?

My Lifebook has 5 buttons - scroll up and down, direction flipping, FN  
and ALT.
I prefer to use the ALT button as modifier for the other buttons (like FN), so
ALT + scroll up could start a program. Press and hold ALT for 3 seconds could
report SAK. The modifier buttons must be sticky for one-finger use. I  
think this
needs userspace support to hold the module clean and simple, but I do not know
how to do this right. Currently, I use KEY_LEFTCTRL and KEY_LEFTALT for the FN
and ALT buttons and grab the entire device in userspace (xinput). I'm open to
suggestions and would be happy to implement a real solution.

> I'll send Robert Gerlach a patch once I have a good answer on that one.
> It would also be nice to get the kernel bits for this driver upstream.
> Barring some trivial printk/pr_debug things it looks to me to be in
> perfectly good shape to go upstream, and it's kind of handy when the
> buttons work on your tablet !

I already improved code cleanness. This version has removed printk's  
and passed
checkpatch. I will send it to platform-driver-x86 list shortly.

   Robert

