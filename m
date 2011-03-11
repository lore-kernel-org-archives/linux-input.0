From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] hid-ntrig: sysfs nodes for modes
Date: Fri, 11 Mar 2011 00:18:43 -0800
Message-ID: <20110311081843.GE10807@core.coreip.homeip.net>
References: <1299829072-19489-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33319 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1CKISv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 03:18:51 -0500
Content-Disposition: inline
In-Reply-To: <1299829072-19489-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, rydberg@euromail.se, chatty@enac.fr

On Fri, Mar 11, 2011 at 02:37:51AM -0500, Rafi Rubin wrote:
> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> 
> ---
> 
> If the code is there, might as well expose a friendly interface to the
> user.

The bigger question is should the user care? If we can make the device
work well without user intervention then we should not really expose
extra attributes.

Thanks.

-- 
Dmitry
