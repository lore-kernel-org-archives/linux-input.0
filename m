From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2] HID: rmi: Write updated F11 control registers after
 reset
Date: Mon, 13 Jul 2015 13:15:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507131314520.7522@pobox.suse.cz>
References: <1436557701-9017-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:52706 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbbGMLPd (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Mon, 13 Jul 2015 07:15:33 -0400
In-Reply-To: <1436557701-9017-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>

On Fri, 10 Jul 2015, Andrew Duggan wrote:

> When a device is reset the values of control registers will be reset to
> the defaults. This patch reapplies the control register values set for F11
> by the driver.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

I have applied this with Gabriele's Tested-by: (please speak up if it 
doesn't hold for v2).

-- 
Jiri Kosina
SUSE Labs
