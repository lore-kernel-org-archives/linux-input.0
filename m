From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2 v2] Input: atmel_mxt_ts - fix double free of input
 device
Date: Wed, 10 Sep 2014 11:28:16 -0600
Message-ID: <54108A30.80003@wwwdotorg.org>
References: <541060D8.9020707@itdev.co.uk> <1410359581-16284-1-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46615 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbaIJR2F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 13:28:05 -0400
In-Reply-To: <1410359581-16284-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nick.dyer@itdev.co.uk, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>

On 09/10/2014 08:33 AM, nick.dyer@itdev.co.uk wrote:
> From: Stephen Warren <swarren@wwwdotorg.org>
>
> [reworked after comments by Dmitry Torokhov. Move free of input device into
> separate function. Only call in paths that require it.]
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>

I re-tested this, and see no issues after inserting/removing the module 
a few times.
