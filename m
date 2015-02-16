From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [DIGImend-devel] [PATCH] Fix report descriptor for Genius PenSketch
 M912
Date: Mon, 16 Feb 2015 12:10:19 +0200
Message-ID: <54E1C20B.2090108@gmail.com>
References: <1423903724-18792-1-git-send-email-milan.plzik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37689 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbbBPKKW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 05:10:22 -0500
Received: by mail-wg0-f44.google.com with SMTP id k14so18579047wgh.3
        for <linux-input@vger.kernel.org>; Mon, 16 Feb 2015 02:10:21 -0800 (PST)
In-Reply-To: <1423903724-18792-1-git-send-email-milan.plzik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: milan.plzik@gmail.com, jkosina@suse.cz
Cc: digimend-devel@lists.sourceforge.net, linux-input@vger.kernel.org

On 02/14/2015 10:48 AM, milan.plzik@gmail.com wrote:
> From: Milan Plzik <milan.plzik@gmail.com>
>
> Genius PenSketch M912 digitizer tablet sends incorrect report descriptor by
> default. This patch replaces it with a corrected one.
>
> Signed-off-by: Milan Plzik <milan.plzik@gmail.com>

I reviewed this on digimend-devel a while ago, looks good to me.
Thanks, Milan!

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Nick
