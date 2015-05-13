From: John Horan <knasher@gmail.com>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO
 keyboard
Date: Wed, 13 May 2015 12:48:17 +0100
Message-ID: <1431517697.1582.1@smtp.gmail.com>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
	<alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35725 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbEMLsT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 07:48:19 -0400
Received: by widdi4 with SMTP id di4so194782704wid.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2015 04:48:18 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>



On Mon, May 4, 2015 at 9:07 , Jiri Kosina <jkosina@suse.cz> wrote:
> Okay, this has been there since 2007, so one would guess there must 
> be a
> reason for noone complaining about this for past 8 years. I'd rather 
> be
> careful here so that we don't introduce any regressions.
Just to follow up on this point specifically.  I actually have been 
able to find a number of people complaining about this issue[1].  
Including a patch that would have removed the quirk from this keyboard 
model, though aimed at a previous version of the code, that I guess was 
either not pushed upstream, or was rejected for some reason[2].
Looking at the code the only effect of the quirk is to swap these too 
keys, and googling for "iso_layout" and "hid_apple" shows that 
disabling this quirk is rather common advice for fixing apple 
keyboards, being mentioned on both the Ubuntu wiki[3] and the Arch 
one[4].

My issue I guess is that I have two keyboards using this module, one 
requiring the quirk, and another not.

[1]https://bugs.launchpad.net/ubuntu/+source/linux/+bug/214786
[2]https://launchpadlibrarian.net/13297091/0001-Remove-faulty-swapping-of-keys-for-Apple-USB-ISO-key.patch
[3]https://help.ubuntu.com/community/AppleKeyboard#Correcting_swapped_keys_and_wrong_keymaps_for_international_.28non-US.29_keyboards
[4]https://wiki.archlinux.org/index.php/Apple_Keyboard#.3C_and_.3E_have_changed_place_with_.5E_and_.C2.B0




