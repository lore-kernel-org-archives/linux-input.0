From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: mt: add the ABS_MT_PRESSURE event
Date: Thu, 28 Jan 2010 22:36:06 -0800
Message-ID: <20100129063606.GD4177@core.coreip.homeip.net>
References: <1264718569-9772-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:55318 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab0A2GgL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2010 01:36:11 -0500
Content-Disposition: inline
In-Reply-To: <1264718569-9772-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jy0922.shim@samsung.com, mika.kuoppala@nokia.com, peter.hutterer@who-t.net

On Thu, Jan 28, 2010 at 11:42:48PM +0100, Henrik Rydberg wrote:
> For pressure-based multi-touch devices, a direct way to send sensor
> intensity data per finger is needed. This patch adds the ABS_MT_PRESSURE
> event to the MT protocol.
> 
> Requested-by: Yoonyoung Shim <jy0922.shim@samsung.com>
> Requested-by: Mika Kuoppala <mika.kuoppala@nokia.com>
> Requested-by: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Both applied, thank you Henrik.

-- 
Dmitry
