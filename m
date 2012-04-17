From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: ALPS v4 Semi-mt Support
Date: Tue, 17 Apr 2012 08:16:18 -0500
Message-ID: <20120417131618.GA14091@thinkpad-t410>
References: <1364401.K99JIOKFyb@vaio>
 <1492453.bjpWEAk9kj@vaio>
 <20120416212407.GE3959@thinkpad-t410>
 <2024920.Dutyu6QMZV@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44205 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175Ab2DQNQV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Apr 2012 09:16:21 -0400
Content-Disposition: inline
In-Reply-To: <2024920.Dutyu6QMZV@vaio>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Pantalos <gpantalos@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 17, 2012 at 01:21:45AM +0300, George Pantalos wrote:
> I have noticed that the sync bit can at times be set in the second packet of 
> the sequence. Couldn't this reset the position to priv->multi_packet=0 when 
> in fact we are in priv->multi_packet=1  position?
> I have also thought about "if((packet[6] & 0x40) && (priv->multi_packet == 
> 0))" so that sync is not lost. 

I think there are two possibilities for when you see the sync bit set in
the second packet.

The first is that the touchpad aborted the previous sequence and started
a new one. In this case you really do want to reset priv->multi_packet.

The other option is that it really isn't a sync bit, and that it has
some other meaning. In that case you'll need to find some other reliable
method for assembling the MT data in the correct order.

The only way you'll be able to tell is by inspecting the packets after
the one with the unexpected sync. I suspect you'll either see one of two
sequences. This one:

  sync -> sync -> non-sync -> non-sync -> sync -> ...

Which would appear to be an aborted sequence followed by the start of a
new one. Or this one:

  sync -> sync -> non-sync -> sync -> ...

Which would appear to indicate that what we're calling the sync bit
isn't really a sync after all.

Seth

