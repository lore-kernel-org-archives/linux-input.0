From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Modify the qt602240 driver to be compatible
 with mXT1386 device - renames
Date: Wed, 2 Feb 2011 23:29:41 -0800
Message-ID: <20110203072941.GA1851@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA706.4020308@atmel.com>
 <4D3EAD67.7030707@codeaurora.org>
 <4D4157C4.1070702@codeaurora.org>
 <F619927BD5260540BACE9E197A0F2A699CF0EC@hammb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36460 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1BCH3s (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Feb 2011 02:29:48 -0500
Received: by yib18 with SMTP id 18so357830yib.19
        for <linux-input@vger.kernel.org>; Wed, 02 Feb 2011 23:29:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <F619927BD5260540BACE9E197A0F2A699CF0EC@hammb01.corp.atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Valkonen, Iiro" <iiro.valkonen@atmel.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org, jy0922.shim@samsung.com

On Tue, Feb 01, 2011 at 08:45:43AM -0000, Valkonen, Iiro wrote:
> Hi Trilok,
> 
> > -----Original Message-----
> > From: Trilok Soni [mailto:tsoni@codeaurora.org]
> > Sent: Thursday, January 27, 2011 1:32 PM
> > 
> > As mentioned above, it would be nice if you can re-submit your changes as
> > patches,
> > and not just copying them under the signature. Thanks.
> > 
> 
> Sorry about the delayed answer. Hopefully this format is now ok.
> 
> -- 
> Iiro
> 
> 
> Input: qt602240_ts - renames from qt602240 to mxt
> 
> From: Iiro Valkonen (iiro.valkonen@atmel.com)
> 
> This patch replaces the "qt602240" references with more generic "mxt" or "maxtouch", as the driver should support all the mXT devices.
> 
> Signed-off-by: Iiro Valkonen (iiro.valkonen@atmel.com)

The e-mail address should be in <>. Also please check the rest of the
tree to make sure platform data rename does not break existing drivers
(I adjusted arch/arm/mach-s5pv210/mach-goni.c for you).

Applied.

-- 
Dmitry
