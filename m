From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input+S3: extra keycodes forgotten after suspend
Date: Fri, 16 May 2008 16:38:07 -0400
Message-ID: <20080516163318.ZZRA012@mailhub.coreip.homeip.net>
References: <200805162225.44284.bonbons@linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:6824 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbYEPUiN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2008 16:38:13 -0400
Received: by py-out-1112.google.com with SMTP id u52so1025927pyb.10
        for <linux-input@vger.kernel.org>; Fri, 16 May 2008 13:38:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200805162225.44284.bonbons@linux-vserver.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno Pr?mont <bonbons@linux-vserver.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>

Hi Bruno,

On Fri, May 16, 2008 at 10:25:43PM +0200, Bruno Pr?mont wrote:
> On my Acer TravelMate 660 I lose keycodes for the extra keys (dritek
> extensions) after resume.
> 
> The system runs setkeycodes during boot sequence to initialize key codes
> for the extra keys as below:
> 
> /usr/bin/setkeycodes KEYCODES="e025 138 e026 141 e027 171 e074 148 e073 149 e055 229 e056 230 e057 227 e058 228"
> # Fn + F1   ~ e025  => 138 [KEY_HELP] (Help)
> # Fn + F2   ~ e026  => 141 [KEY_SETUP] (Notebook Manager)
> # Fn + F3   ~ e027  => 171 [KEY_CONFIG] (Power Options)
> # Mail      ~ e06c  => 155 [KEY_MAIL] (EMail)
> # WWW       ~ e032  => 150 [KEY_WWW] (Browser)
> # P1        ~ e074  => 148 [KEY_PROG1] (P1)
> # P2        ~ e073  => 149 [KEY_PROG2] (P2)
> # Bluetooth ~ e058  => 228 [KEY_BLUETOOTH_DISABLE] (Disable Bluetooth)
> # Bluetooth ~ e057  => 227 [KEY_BLUETOOTH_ENABLE] (Enable Bluetooth)
> # Wireless  ~ e056  => 230 [KEY_WLAN_DISABLE] (Disable WLAN)
> # Wireless  ~ e055  => 229 [KEY_WLAN_ENABLE] (Enable WLAN)
> # Vol UP    ~ e030  => 115 [KEY_VOLUMEUP] (Increase Volume)
> # Vol DOWN  ~ e02e  => 114 [KEY_VOLUMEDOWN] (Decrease Volume)
> # Vol Mute  ~ e020  => 113 [KEY_MUTE] (Mute volume)
> 
> After resume I end up with the following messages when pressing the keys:
> [  779.695675] atkbd.c: Unknown key pressed (translated set 2, code 0xd6 on isa0060/serio0).
> [  779.695675] atkbd.c: Use 'setkeycodes e056 <keycode>' to make it known.
> [  779.705218] atkbd.c: Unknown key released (translated set 2, code 0xd6 on isa0060/serio0).
> [  779.705218] atkbd.c: Use 'setkeycodes e056 <keycode>' to make it known.
> [  781.603912] atkbd.c: Unknown key pressed (translated set 2, code 0xd5 on isa0060/serio0).
> [  781.603912] atkbd.c: Use 'setkeycodes e055 <keycode>' to make it known.
> [  781.613564] atkbd.c: Unknown key released (translated set 2, code 0xd5 on isa0060/serio0).
> [  781.613564] atkbd.c: Use 'setkeycodes e055 <keycode>' to make it known.
> [  782.772662] atkbd.c: Unknown key pressed (translated set 2, code 0xd7 on isa0060/serio0).
> [  782.772662] atkbd.c: Use 'setkeycodes e057 <keycode>' to make it known.
> [  782.782390] atkbd.c: Unknown key released (translated set 2, code 0xd7 on isa0060/serio0).
> [  782.782390] atkbd.c: Use 'setkeycodes e057 <keycode>' to make it known.
> [  783.461807] atkbd.c: Unknown key pressed (translated set 2, code 0xd8 on isa0060/serio0).
> [  783.461807] atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
> [  783.471544] atkbd.c: Unknown key released (translated set 2, code 0xd8 on isa0060/serio0).
> [  783.471544] atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
> 
> 
> Is this kind of issue known, what are the options to get kernel to remember the
> keycode mappings after s2ram?
> 

Do you unload atkbd or perhaps i8042 for s2ram? Or do you see that
keyboard is detected again (in dmesg) after resume?

-- 
Dmitry
