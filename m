From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] Input: twl4030_keypad - fix potential NULL dereference
 in twl4030_kp_probe()
Date: Fri, 1 Apr 2011 18:18:44 +0300
Message-ID: <20110401151843.GB2164@legolas.emea.dhcp.ti.com>
References: <1301670483.6013.4.camel@phoenix>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:37658 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757193Ab1DAPSv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Apr 2011 11:18:51 -0400
Content-Disposition: inline
In-Reply-To: <1301670483.6013.4.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Apr 01, 2011 at 11:08:03PM +0800, Axel Lin wrote:
> We should first check whether platform data is NULL or not, before
> dereferencing it to get the keymap.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
