From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synaptics touchpad on Dell Vostro V13
Date: Tue, 14 Dec 2010 09:00:27 -0800
Message-ID: <20101214170027.GA11318@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1012141547570.15140@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:51347 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759650Ab0LNRAf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Dec 2010 12:00:35 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1012141547570.15140@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 14, 2010 at 03:56:56PM +0100, Jiri Kosina wrote:
> Hi Dmitry,
> 
> I have a bugreport about Synaptics touchpad not working as proper 
> Synaptics, but only being detected as standard PS/2.
> 
> Looking at the i8042.debug output, the device is clearly buggy, as it 
> doesn't identify itself by 0x47 when queried:
> 
> 	91 -> i8042 (command) [58]
> 	e8 -> i8042 (parameter) [58]
> 	fa <- i8042 (interrupt, 3, 12) [59]
> 	91 -> i8042 (command) [59]
> 	00 -> i8042 (parameter) [59]
> 	fa <- i8042 (interrupt, 3, 12) [59]
> 	91 -> i8042 (command) [59]
> 	e8 -> i8042 (parameter) [59]
> 	fa <- i8042 (interrupt, 3, 12) [60]
> 	91 -> i8042 (command) [60]
> 	00 -> i8042 (parameter) [60]
> 	fa <- i8042 (interrupt, 3, 12) [61]
> 	91 -> i8042 (command) [61]
> 	e8 -> i8042 (parameter) [61]
> 	fa <- i8042 (interrupt, 3, 12) [61]
> 	91 -> i8042 (command) [61]
> 	00 -> i8042 (parameter) [61]
> 	fa <- i8042 (interrupt, 3, 12) [62]
> 	91 -> i8042 (command) [62]
> 	e8 -> i8042 (parameter) [62]
> 	fa <- i8042 (interrupt, 3, 12) [63]
> 	91 -> i8042 (command) [63]
> 	00 -> i8042 (parameter) [63]
> 	fa <- i8042 (interrupt, 3, 12) [64]
> 	91 -> i8042 (command) [64]
> 	e9 -> i8042 (parameter) [64]
> 	fa <- i8042 (interrupt, 3, 12) [64]
> 
> ... and here we time out after approximately 0.5s. nomux doesn't really 
> fix it, we start getting a lot of timeouts on i8042 with that.
> 
> Apparently the device works with Synaptics driver in Other OS(TM) though. 
> Do you have any idea what they might be doing differently so that they 
> make the touchpad identify itself properly?

Hi Jiri,

Do you have the device in your possession? If so can you check if the
driver installed in Other OS uses active multiplexing? I think you can
infer whether it does or not by looking at the pointer properties - I
think it would "Synaptics Blah at port X" or something like that...

Also you could try combining nomux with reset and see if it makes any
sense...

Thanks.

-- 
Dmitry
