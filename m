From: David Dillow <dave@thedillows.org>
Subject: Re: [PATCH] HID: fold ps3remote driver into generic Sony driver
Date: Sat, 01 Jun 2013 00:55:02 -0400
Message-ID: <1370062502.2606.5.camel@obelisk.thedillows.org>
References: <alpine.LNX.2.00.1305281035370.3914@pobox.suse.cz>
	 <1369747847.3675.3.camel@obelisk.thedillows.org>
	 <alpine.LNX.2.00.1305281538360.3914@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from matrix.voodoobox.net ([75.127.97.206]:49379 "EHLO
	matrix.voodoobox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab3FAEzM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Jun 2013 00:55:12 -0400
In-Reply-To: <alpine.LNX.2.00.1305281538360.3914@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2013-05-28 at 15:45 +0200, Jiri Kosina wrote:
> I'd be glad if you could provide your Tested-by: for the patch below. 
> Thanks a lot.

I tried to test this tonight, but was thwarted by Fedora 16 on the only
readily available test platform -- old bluetoothd w/ the internal
driver. I'll need to upgrade that box, recreate the updated bluetooth
environment I had from some time ago, or try it on my myth frontend
(Ubuntu 13.04). I'll get another chance on the 9th; I won't have access
to the HW again until then. :/

