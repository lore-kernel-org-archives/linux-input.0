From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Modify the qt602240 driver to be compatible with
 mXT1386 device
Date: Mon, 24 Jan 2011 09:07:57 -0800
Message-ID: <20110124170756.GB31066@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60596 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab1AXRIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 12:08:04 -0500
Received: by pva4 with SMTP id 4so709945pva.19
        for <linux-input@vger.kernel.org>; Mon, 24 Jan 2011 09:08:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D3DAE3C.6060806@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: linux-input@vger.kernel.org, jy0922.shim@samsung.com

Hi Iiro,

On Mon, Jan 24, 2011 at 06:52:12PM +0200, Iiro Valkonen wrote:
> 
> This patches the current qt602240 driver to be usable with mXT1386. Also all the qt602240 references are changed to more generic "MXT", as in the future this driver will be kept compatible with all the maXTouch variants.
> 
> 

Thank you for the patch. Could I ask you to split the qt602240->mxt
renames from the functional changes so latter are easier to review?

Thanks!

-- 
Dmitry
