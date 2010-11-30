From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: Bug 18122 - Support Lenovo S10-3t's 2-button
 ClickPad
Date: Mon, 29 Nov 2010 23:50:26 -0800
Message-ID: <20101130075026.GA15731@core.coreip.homeip.net>
References: <aefc1833eeede37ae6ea4a9ddeaa602eb7d31101.1290823698.git.yan.i.li@intel.com>
 <ddb890ce98e91c7422da64168b1624c1e62a02ee.1291101955.git.yan.i.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59330 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab0K3Huf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 02:50:35 -0500
Content-Disposition: inline
In-Reply-To: <ddb890ce98e91c7422da64168b1624c1e62a02ee.1291101955.git.yan.i.li@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yan Li <yan.i.li@intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, "Ding, Jian-feng" <jian-feng.ding@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "meego-kernel@lists.meego.com" <meego-kernel@lists.meego.com>

On Tue, Nov 30, 2010 at 03:44:06PM +0800, Yan Li wrote:
> This is for kernel bug #18122 and MeeGo bug #4807, version 2.
> 
> Lenovo S10-3t's ClickPad is a 2-button ClickPad that reports BTN_LEFT
> and BTN_RIGHT as normal touchpad, unlike the 1-button ClickPad used in
> HP mini 210 that reports solely BTN_MIDDLE.
> 
> Of c0-cap response, the 1-button ClickPad has the 20-bit set while
> 2-button ClickPad has the 8-bit set.
> 
> This patch makes the kernel only handle 1-button ClickPad specially,
> and treat 2-button ClickPad as same as other normal touchpads.
> 

As Takashi mentioned, HP Clickpads have the same 0x0c signature than
Lenovos non-clickpads so this is not that simple. We need to wait and
see if Christopher will shed some light here...

Thanks.

-- 
Dmitry
