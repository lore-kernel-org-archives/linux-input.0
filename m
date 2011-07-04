From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2.6.38.7 3/3] xpad: wireless LED setting
Date: Mon, 4 Jul 2011 15:32:28 -0700
Message-ID: <20110704223228.GA2724@core.coreip.homeip.net>
References: <1307926190.8254.21.camel@sabin.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37085 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1GEEgv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 00:36:51 -0400
Received: by iyb12 with SMTP id 12so4900664iyb.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 21:36:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307926190.8254.21.camel@sabin.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Moeller <kode54@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Chris,

On Sun, Jun 12, 2011 at 05:49:49PM -0700, Chris Moeller wrote:
> +	} else if (xpad->xtype == XTYPE_XBOX360W) {
> +		if (command >= 0 && command < 16) {
> +			if (command == 16)
> +				command = 2 + (xpad->interface_number & 6) / 2;

Not commenting on the rest of the patch, but this chunk does not make
sense - you go into this branch only if command is less than 16 so it
can never be equal to 16 in the nested 'if'.

Thanks.

-- 
Dmitry
