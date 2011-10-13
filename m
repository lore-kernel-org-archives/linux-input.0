From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [v2] input/imx_keypad: add pm suspend and resume functions
Date: Wed, 12 Oct 2011 21:13:29 -0700
Message-ID: <20111013041328.GA11763@core.coreip.homeip.net>
References: <1318412356-19719-1-git-send-email-jason77.wang@gmail.com>
 <4E956271.3040002@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49783 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1JMENg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 00:13:36 -0400
Received: by iaek3 with SMTP id k3so791411iae.19
        for <linux-input@vger.kernel.org>; Wed, 12 Oct 2011 21:13:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E956271.3040002@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Hui Wang <jason77.wang@gmail.com>, s.hauer@pengutronix.de, maramaopercheseimorto@gmail.com, linux-input@vger.kernel.org

On Wed, Oct 12, 2011 at 05:48:33PM +0800, Wanlong Gao wrote:
> On 10/12/2011 05:39 PM, Hui Wang wrote:
> 
> > The imx_keypad driver is set wake capable in the imx_keypad_probe(),
> > but it doesn't implement suspend and reusme callback interface.
> > 
> >>From the i.MX series MCU Reference Manual, the kpp (keypad port) is
> > a major wake up source which can detect any key press even in low
> > power modes and even when there is no clock.
> > 
> > Now add suspend and resume callback functions for this driver.
> > 
> > Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> 
> 
> Looks good to me. Thanks
> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Applied, thanks.

-- 
Dmitry
