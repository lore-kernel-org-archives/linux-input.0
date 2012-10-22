From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: microsoft, fix invalid rdesc for 3k kbd
Date: Mon, 22 Oct 2012 11:00:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210221059360.12268@pobox.suse.cz>
References: <1350646126-28537-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350646126-28537-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-input@vger.kernel.org

On Fri, 19 Oct 2012, Jiri Slaby wrote:

> Microsoft Digital Media Keyboard 3000 has two interfaces, and the
> second one has a report descriptor with a bug. The second collection
> says:
> 05 01 -- global; usage page -- 01 -- Generic Desktop Controls
> 09 80 -- local; usage -- 80 -- System Control
> a1 01 -- main; collection -- 01 -- application
> 
> 85 03 -- global; report ID -- 03
> 19 00 -- local; Usage Minimum -- 00
> 29 ff -- local; Usage Maximum -- ff
> 15 00 -- global; Logical Minimum -- 0
> 26 ff 00 -- global; Logical Maximum -- ff
> 81 00 -- main; input
> 
> c0 -- main; End Collection
> 
> I.e. it makes us think that there are all kinds of usages of system
> control. That the keyboard is a not only a keyboard, but also a
> joystick, mouse, gamepad, keypad, etc. The same as for the Wireless
> Desktop Receiver, this should be Physical Min/Max. So fix that
> appropriately.
> 
> References: https://bugzilla.novell.com/show_bug.cgi?id=776834
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Added CC to stable and applied, thanks.

-- 
Jiri Kosina
SUSE Labs
