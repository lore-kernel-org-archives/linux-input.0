From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: Modify the qt602240 driver to be compatible
 with mXT1386 device - functional changes
Date: Wed, 2 Feb 2011 23:43:19 -0800
Message-ID: <20110203074318.GA5814@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
 <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47286 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1BCHnZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Feb 2011 02:43:25 -0500
Received: by pxi15 with SMTP id 15so164303pxi.19
        for <linux-input@vger.kernel.org>; Wed, 02 Feb 2011 23:43:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Valkonen, Iiro" <iiro.valkonen@atmel.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org, jy0922.shim@samsung.com

On Tue, Feb 01, 2011 at 08:53:02AM -0000, Valkonen, Iiro wrote:
> Input: qt602240_ts - functional changes to support mXT1386
> 
> From: Iiro Valkonen (iiro.valkonen@atmel.com)
> 
> Functional changes to qt602240_ts to support mXT1386 device.
> 

Iiro,

There appear to be several functional changes mixed into one (using
previously programmed config; CHG pin handling; matrix size check 
suppression, etc). Please split all these logical changes into separate
patches - this is a general requirement around here - one logical change
per patch.

Thank you.

-- 
Dmitry
