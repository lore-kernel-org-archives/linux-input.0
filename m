From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: wacom - fix touch on newer Bamboo's
Date: Fri, 9 Sep 2011 13:41:12 -0700
Message-ID: <20110909204112.GB9157@core.coreip.homeip.net>
References: <1315353406-8564-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:64535 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933201Ab1IIUlS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2011 16:41:18 -0400
Received: by gwb17 with SMTP id 17so1843719gwb.1
        for <linux-input@vger.kernel.org>; Fri, 09 Sep 2011 13:41:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1315353406-8564-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, rydberg@euromail.se

On Tue, Sep 06, 2011 at 06:56:46PM -0500, chris@cnpbagwell.com wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
> 
> Bamboo's with Product ID's > 0xD4 return values unrelated to pressure
> in touch 1 pressure field.  They also report touch 2's X/Y values
> shifted down 1 byte (where pressure was).  This results in jumpy
> 1 finger touch and totally invalid 2nd finger data.
> 
> For touch detection, switch to a Touch Present single bit that
> all versions of Bamboo support.
> 
> For touch 2 offset, calculate offset based on a bit that is set
> different between the two packet layouts.
> 
> Since touch pressure reports were removed from driver, there was
> no need to be reading pressure any more.
> 
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> Reviewed-by: Ping Cheng <pinglinux@gmail.com>

Applied, thanks Chris.

-- 
Dmitry
