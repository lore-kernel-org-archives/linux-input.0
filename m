From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] Input-at32psif: Fine-tuning for OOM handling in
 psif_probe()
Date: Wed, 13 Jul 2016 15:01:03 -0700
Message-ID: <20160713220103.GB1799@dtor-ws>
References: <566ABCD9.1060404@users.sourceforge.net>
 <4471604f-f401-bed9-39be-1aff2a92edf6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34902 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbcGMWBK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 18:01:10 -0400
Content-Disposition: inline
In-Reply-To: <4471604f-f401-bed9-39be-1aff2a92edf6@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Sat, Jul 02, 2016 at 09:00:36PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 2 Jul 2016 20:50:09 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Return directly after a failed kzalloc()
>   Remove two OOM messages

I do not see a compelling reason for taking these...

Thanks.

-- 
Dmitry
