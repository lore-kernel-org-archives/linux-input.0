From: Jeremy Huddleston <jeremyhu@freedesktop.org>
Subject: Re: hid_apple bug: arrow keys interpreted as Fn
Date: Wed, 20 May 2009 10:41:03 -0700
Message-ID: <4A1440AF.7090807@freedesktop.org>
References: <3E66E0E0-3B2B-4F78-9A62-87015A842A47@freedesktop.org> <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org> <4A132540.7070409@gmail.com> <B9186545-9C33-4ADA-A3D9-8B5A5DA377CE@freedesktop.org> <alpine.LNX.2.00.0905201615490.13917@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:47994 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbZETRlI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 13:41:08 -0400
In-Reply-To: <alpine.LNX.2.00.0905201615490.13917@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jiri Kosina wrote:

> Looks like the state machine inside the keyboard gets a little bit crazy 
> when you press the third button. The data that HID core sees coming on USB 
> bus really don't represent [right,down,left] being pressed.
> 
> Do you have any chance to verify whether this works properly in a 
> different operating system? It would require very specific handling 
> violating the standard.

I *belive* it worked fine on OSX.  I don't have it installed on this
machine at the moment, so I can't verify right now.  I'll install it on
a firewire drive soon and get back to you.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKFECvjC1Anjf1NmMRAuFOAJ4wwHJi2B27r82e6yB5gfwiG2h/EgCfZ79g
shiwKCxclIpjz1NXodZ0/No=
=Owmi
-----END PGP SIGNATURE-----
