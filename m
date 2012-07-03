From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: [PATCH] Input: MT - Include win8 support
Date: Tue, 3 Jul 2012 19:58:42 +0200
Message-ID: <20120703175842.GA472@polaris.bitmath.org>
References: <1340785690-13652-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:47307 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906Ab2GCR6Z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Jul 2012 13:58:25 -0400
Content-Disposition: inline
In-Reply-To: <1340785690-13652-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, benjamin.tissoires@gmail.com, peter.hutterer@who-t.net, chasedouglas@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 27, 2012 at 10:28:10AM +0200, Henrik Rydberg wrote:
> The newly released HID protocol for win8 multitouch devices is capable
> of transmitting more information about each touch. In particular, it
> includes details useful for touch alignment. This patch completes the
> MT protocol with the ABS_MT_TOOL_X/Y events, and documents how to map
> win8 devices.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi all,
> 
> Here is the patch following the RFC on win8 MT support. An ascii-art
> version of the figure has been included, Peter's orientation text is
> there, and the usage section has been extended with more semantics and
> mappings. Hopefully the similarities and differences between the
> models are clearer now. Also, the usage of azimuth has been left out,
> awaiting an actual device using it.

I would like to have a couple of ACK's on this patch, if
possible. Please? :-)

Thanks,
Henrik
