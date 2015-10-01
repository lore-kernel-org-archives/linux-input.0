From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH RFC 0/2] Input: Goodix - add axis swapping and inversion
 support
Date: Thu, 01 Oct 2015 02:54:40 +0200
Message-ID: <1443660880.5056.12.camel@hadess.net>
References: <1443652195-7104-1-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53327 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbbJAAys (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 20:54:48 -0400
In-Reply-To: <1443652195-7104-1-git-send-email-merker@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>

On Thu, 2015-10-01 at 00:29 +0200, Karsten Merker wrote:
> Hello,
> 
> the goodix touchscreen driver has gained device-tree support in
> kernel
> 4.1, but doesn't currently support the touchscreen-swapped-x-y,
> touchscreen-inverted-x and touchscreen-inverted-y properties.

Can't test for now, but:

Reviewed-by: Bastien Nocera <hadess@hadess.net>

We'll have to wait until Irina's patchset lands though, and we'll test
at that point.

Cheers
