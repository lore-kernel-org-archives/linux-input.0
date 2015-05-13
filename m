From: John Horan <knasher@gmail.com>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO
 keyboard
Date: Wed, 13 May 2015 12:48:11 +0100
Message-ID: <1431517691.1582.0@smtp.gmail.com>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
	<alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
	<alpine.LNX.2.00.1505041009331.3081@pobox.suse.cz>
	<alpine.LNX.2.00.1505041010480.3081@pobox.suse.cz>
	<554C262B.5090607@daenzer.net> <1431079408.1420.0@smtp.gmail.com>
	<554DC82D.1030807@daenzer.net> <1431350579.5543.0@smtp.gmail.com>
	<55514CDB.30904@daenzer.net> <1431424549.1489.0@smtp.gmail.com>
	<5551D0AC.5030506@daenzer.net> <1431428747.1489.1@smtp.gmail.com>
	<5552A5F4.2020501@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34405 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbbEMLsP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 07:48:15 -0400
Received: by wgic8 with SMTP id c8so40685004wgi.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2015 04:48:14 -0700 (PDT)
In-Reply-To: <5552A5F4.2020501@daenzer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


> It makes some sense, but OTOH it sounded like in console it's actually
> the external keyboard which is working correctly for you.
I wouldn't say that.  The external keyboard was wrong according to the 
keymap applied to it.
> Also, my Apple keyboard isn't connected to an Apple machine but to an 
> HP
> notebook. How do you suggest such a combination should be configured
> without the ISO quirk?
I'd imagine your HP notebook has an American keyboard.  In your case my 
personal preference would be that the keymaps would match and when I 
press the button next to 1, tilda is printed regardless of the keyboard 
I'm using.  If you prefer to use the keymap which matches the symbols 
printed on the keyboard, then I believe you can specify a per keyboard 
keymap using udev and setxkbmap.  Though to be honest I think this 
would be a clunky solution, as setxkbmap seems to apply to X alone; I 
don't know if there is a better solution.
> Finally, I still find it hard to believe that this issue would only
> affect this particular Apple ISO keyboard model.
I suspect it doesn't.  In particular when googling for this I found a 
lot of people disabling the iso_layout quirk for the MacbookAir2013 
models[1][2].  The ISO keyboard on my laptop definetly requires it, but 
I suspect the quirk has been applied more broadly that it should have 
been.

-John

[1]http://atodorov.org/blog/2015/04/30/fixing-tilde-and-function-keys-mapping-for-macbook-air-on-linux/
[2]https://bugzilla.redhat.com/show_bug.cgi?id=1025041#c2

