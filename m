From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 04/15] Input: atmel_mxt_ts - implement device tree support
Date: Wed, 23 Jul 2014 15:36:56 -0600
Message-ID: <53D02AF8.5000100@wwwdotorg.org>
References: <1404399697-26484-1-git-send-email-nick.dyer@itdev.co.uk> <1404399697-26484-5-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37487 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386AbaGWVhB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 17:37:01 -0400
In-Reply-To: <1404399697-26484-5-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick.dyer@itdev.co.uk, Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>, Stephen Warren <swarren@nvidia.com>

On 07/03/2014 09:01 AM, nick.dyer@itdev.co.uk wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>

Hmm. It looks like the version of this patch that was actually applied
varies quite a bit from what was posted, in particular in the
implementation and call site of mxt_parse_dt(). It'd be nice if the
commit log had been adjusted to mention this, so it didn't look like *I*
caused all those compile errors and warnings that the 0-day builder just
found:-(
