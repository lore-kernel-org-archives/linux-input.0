From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: input: gpio_keys_polled: Request GPIO pin as input.
Date: Tue, 18 Aug 2015 15:07:56 +0300
Message-ID: <20150818120756.GI1552@lahna.fi.intel.com>
References: <1439846972-32323-1-git-send-email-plr.vincent@gmail.com>
 <db83f62157864df33d254c9ac6050d42c53f9949.1439846897.git.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54376 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbbHRMIA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2015 08:08:00 -0400
Content-Disposition: inline
In-Reply-To: <db83f62157864df33d254c9ac6050d42c53f9949.1439846897.git.plr.vincent@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-input@vger.kernel.org, aaron.lu@intel.com

On Mon, Aug 17, 2015 at 11:29:32PM +0200, Vincent Pelletier wrote:
> Flag was lost in:
> Commit 633a21d80b4a("input: gpio_keys_polled: Add support for GPIO
> descriptors").

You could add a bit more verbose changelog here.

> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

Regardless of that the patch itself looks good,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
