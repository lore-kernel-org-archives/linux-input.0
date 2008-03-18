From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: GPen 340 Pen Tablet input
Date: Tue, 18 Mar 2008 14:10:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803181409200.30831@jikos.suse.cz>
References: <alpine.LNX.1.00.0803161918260.15404@localhost>
 <Pine.LNX.4.64.0803161957010.19269@twin.jikos.cz> <alpine.LNX.1.00.0803162005320.32475@localhost>
 <Pine.LNX.4.64.0803162244180.30831@jikos.suse.cz> <alpine.LNX.1.00.0803170006240.22151@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:48579 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752622AbYCRNKq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2008 09:10:46 -0400
In-Reply-To: <alpine.LNX.1.00.0803170006240.22151@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrej Gelenberg <andrej.gelenberg@googlemail.com>
Cc: linux-input@vger.kernel.org

On Mon, 17 Mar 2008, Andrej Gelenberg wrote:

> By moving and pressing keys report dmesg right values, but i have 
> problem by using my Tablet under Xorg. Xorg try evdev driver for it and 
> evdev report wrong codes.
> example for move:
> Mar 17 00:03:32 [kernel] [  446.045131] hid-debug: input GenericDesktop.X =
> 6742
> Mar 17 00:03:32 [kernel] [  446.045136] hid-debug: input GenericDesktop.Y =
> 17272
> Mar 17 00:03:32 [kernel] [  446.045139] hid-debug: input
> Digitizers.TipPressure = 0
> Mar 17 00:03:32 [kernel] [  446.048669] hid-debug: input Button.0001 = 0
> Mar 17 00:03:32 [kernel] [  446.048675] hid-debug: input Button.0002 = 0
> Mar 17 00:03:32 [kernel] [  446.048678] hid-debug: input Button.0003 = 0

[ restored linux-input in CC ]

So, and the problem is where? How are the values (mis)interpreted in X? 
Switched axes? Buttons mixup? Please be more specific.

Thanks,

-- 
Jiri Kosina
SUSE Labs
