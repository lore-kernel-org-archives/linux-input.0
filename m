From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/6] Input: elantech - work around EC buffer
Date: Wed, 17 Aug 2011 23:39:18 -0700
Message-ID: <20110818063918.GD10093@core.coreip.homeip.net>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw>
 <1313632629-23603-5-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:51617 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab1HRGjb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 02:39:31 -0400
Content-Disposition: inline
In-Reply-To: <1313632629-23603-5-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On Thu, Aug 18, 2011 at 09:57:07AM +0800, JJ Ding wrote:
> With some EC chips, when we resync due to bad packets, those bad bytes would
> still remain in EC's buffer area. That makes us always get bad data back,
> no matter what.
> 
> So shift packet for 1 byte when encounter bad packet, until we get rid of those
> bytes.

If we want to do this I think it should be done in psmouse core.

Thanks.

-- 
Dmitry
