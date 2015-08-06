From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/9] Input: atmel_mxt_ts - use deep sleep mode when
 stopped
Date: Thu, 6 Aug 2015 15:57:22 -0700
Message-ID: <20150806225722.GB24261@dtor-ws>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
 <1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk>
 <20150805000212.GB20765@dtor-ws>
 <55C35B4F.2000006@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33681 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbbHFW50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 18:57:26 -0400
Received: by pabyb7 with SMTP id yb7so40579318pab.0
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2015 15:57:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55C35B4F.2000006@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>

On Thu, Aug 06, 2015 at 02:04:15PM +0100, Nick Dyer wrote:
> 
> 
> On 05/08/15 01:02, Dmitry Torokhov wrote:
> > Since the T9 code is for compatibility with old Pixel only I do not think
> > we should be adding it to device tree binding, at least not at the
> > moment. I cut the device tree parsing out and default to deep sleep on
> > DT-based systems. Thanks. 
> 
> That sounds fair enough. We do need something like this eventually to
> support different suspend implementations (eg powering down via regulators).

That does not really need config I think: in ChromeOS tree wee key the
behavior off presence of reset GPIO line: if it sis there (definied via
ACPI, devicetree or board lookup code) then we assume we need to control
the power up sequence with regulators, otherwise we put the controller
into deep sleep mode.

Thanks.

-- 
Dmitry
