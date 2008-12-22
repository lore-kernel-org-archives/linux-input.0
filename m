From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: keyboards and evdev printing multiple keys
Date: Mon, 22 Dec 2008 22:58:24 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0812222256540.11630@twin.jikos.cz>
References: <494FF40A.7000806@ameritech.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:41093 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757971AbYLVV6b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Dec 2008 16:58:31 -0500
In-Reply-To: <494FF40A.7000806@ameritech.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "F. Heitkamp" <heitkamp@ameritech.net>
Cc: linux-input@vger.kernel.org

On Mon, 22 Dec 2008, F. Heitkamp wrote:

> I am not sure this is a bug.
> I have a Apple keyboard connected to a IOGear USB KVM.
> I have installed evdev and the Xorg 1.5.3 server.
> When I use any X apps the keyboard repeats three for one in.  i.e. typing one
> 'L' puts three of them in the input.
> I noticed when looking at /proc/bus/input/devices there are three instanced of
> the keyboard.

Does this also happen when KVM is not used?

Could you please verify with evtest on the respective device nodes in 
/dev/input/event* -- it will show us whether there are really three events 
coming out of the kernel, or whether it is X triplicating the keys.

-- 
Jiri Kosina
SUSE Labs

