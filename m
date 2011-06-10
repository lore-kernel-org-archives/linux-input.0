From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/4] Input: Synaptics: Add INPUT_PROP_SYNAPTICS_T3R2
 property
Date: Fri, 10 Jun 2011 23:13:53 +0200
Message-ID: <20110610211353.GD5925@polaris.bitmath.org>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
 <1307735704-30673-5-git-send-email-derek.foreman@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:45918 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab1FJVHI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 17:07:08 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 4F5CBEA70A
	for <linux-input@vger.kernel.org>; Fri, 10 Jun 2011 23:07:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307735704-30673-5-git-send-email-derek.foreman@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derek Foreman <derek.foreman@collabora.co.uk>
Cc: linux-input@vger.kernel.org

On Fri, Jun 10, 2011 at 03:55:04PM -0400, Derek Foreman wrote:
> This new property indicates that the trackpad is able to track more than two contacts, but can only report the positions of two contacts due to bus bandwidth limitations.
> 
> Signed-off-by: Derek Foreman <derek.foreman@collabora.co.uk>
> ---
>  drivers/input/mouse/synaptics.c |    3 +++
>  include/linux/input.h           |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)

This information is already contained in INPUT_PROP_SEMI_MT, together
with the use of BTN_TRIPLETAP. Please check
Documentation/input/event-codes.txt for further details.

Thanks,
Henrik
