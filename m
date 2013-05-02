From: Ray Dillinger <bear@sonic.net>
Subject: Re: Game Controllers
Date: Wed, 01 May 2013 20:25:23 -0700
Message-ID: <5181DCA3.8040202@sonic.net>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from b.mail.sonic.net ([64.142.19.5]:47197 "EHLO b.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab3EBEGg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 May 2013 00:06:36 -0400
In-Reply-To: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: linux-input@vger.kernel.org

On 04/26/2013 05:13 PM, Todd Showalter wrote:
>      I'm a game developer, and I'm interested in discussing changes in
> the way gamepad input is handled at the evdev and device level; is
> this the correct place to do that?
>
>                                         Todd.
>
> --
>   Todd Showalter, President,
>   Electron Jump Games, Inc.
> --

I sure hope so.  That's why I'm here too, but I still haven't seen any
detailed discussion of it yet.  I have a keyboard with builtin gamepad
that registers as a different USB device, and I'm trying to figure out
how to write a driver that treats the gamepad as being logically a part
of the keyboard so I can use Autokey to record and play back macros.

Autokey does everything that gamepad software usually does, so it's 
ideal for the purpose -- but as far as I can tell, it cannot be made
to "see" something that isn't the same USB device as the keyboard.

				Ray

