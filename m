From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: wacom: Add support for three new ISDv4 sensors
Date: Wed, 14 May 2014 11:46:24 -0700
Message-ID: <20140514184624.GH30089@core.coreip.homeip.net>
References: <1399685417-2063-1-git-send-email-killertofu@gmail.com>
 <1399685417-2063-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:65467 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaENSq2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 14:46:28 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so1665857pbc.28
        for <linux-input@vger.kernel.org>; Wed, 14 May 2014 11:46:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1399685417-2063-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, pingc@wacom.com

On Fri, May 09, 2014 at 06:30:17PM -0700, Jason Gerecke wrote:
> This patch adds support for the 0x4004, 0x5000, and 0x5002 sensors found
> on what should be the Motion R12, Fujitsu Q704, and Fujitsu T904. These
> tablets use a new report ID (3) for their touch packets and a slightly
> different HID descriptor format, but are otherwise largely identical in
> protocol to the "MTTPC" tablets.
> 
> Note:
>  * The R12 uses its 0x4004 sensor for touch input only. A pen interface
>    is not present in its HID descriptor, though its possible a 0x4004
>    may be used for pen input by other tablet PCs in the future.
> 
>  * The 0x5002 sensor appears to use a new report ID (8) for its pen
>    packets. The other sensors continue to use the traditional report
>    ID (2).
> 
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Hmm, that does not apply to my next branch, could it be because I pulled
out a patch unifying some reports that Ping asked me to pull out?

Thanks.

-- 
Dmitry
