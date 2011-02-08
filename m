From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: added new driver for Panasonic Elite Panaboard
 UB-T780 and UB-T880
Date: Tue, 8 Feb 2011 10:12:04 -0800
Message-ID: <20110208181204.GF4476@core.coreip.homeip.net>
References: <1297157786-2004-1-git-send-email-kverlin@gmail.com>
 <20110208103923.GA2009@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46873 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1BHSMq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Feb 2011 13:12:46 -0500
Content-Disposition: inline
In-Reply-To: <20110208103923.GA2009@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Anton Chikin <kverlin@gmail.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Chikin <anton.chikin@dataart.com>

On Tue, Feb 08, 2011 at 11:39:23AM +0100, Henrik Rydberg wrote:
> 
> > +int xold = 0, yold = 0;
> 
> static
> 

Not even that. This is an USB device, not a platform one, so it shoudl
be opssible to connect more than one to a box. All state should go into
per-device structure.

This is also does not appear to be a HID driver, really - it does not
use HID infrastucture but does custom parsing.

Calibration - normally we offload this task to userspace (tslib
or other library/driver).

Thanks.

-- 
Dmitry
