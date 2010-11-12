From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: hgpk - Extend jumpyness detection
Date: Thu, 11 Nov 2010 22:23:31 -0800
Message-ID: <20101112062331.GB5096@core.coreip.homeip.net>
References: <20101107150526.3EB219D401B@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63867 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab0KLGXk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 01:23:40 -0500
Received: by iwn10 with SMTP id 10so3102684iwn.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 22:23:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101107150526.3EB219D401B@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org

On Sun, Nov 07, 2010 at 03:05:26PM +0000, Daniel Drake wrote:
> In addition to forcing recalibrations upon detection of cursor jumps (and
> performing them quicker than before), detect and discard errant 'jump'
> packets caused by a firmware bug, which are then repeated with each one
> being approximately half the delta of the one previously (as if it is
> averaging out)
> 
> Based on original work by Paul Fox
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

All 3 have been committed to my 'next' branch for .38, thanks Daniel.

-- 
Dmitry
