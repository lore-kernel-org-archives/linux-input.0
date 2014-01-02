From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 12/25] HID: sony: fix error return code
Date: Thu, 2 Jan 2014 13:51:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401021351000.14951@pobox.suse.cz>
References: <1388357260-4843-1-git-send-email-Julia.Lawall@lip6.fr> <1388357260-4843-13-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42473 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbaABMvO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jan 2014 07:51:14 -0500
In-Reply-To: <1388357260-4843-13-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 29 Dec 2013, Julia Lawall wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Currently the return variable ret is always 0.  Set it to other values in
> error cases, as used in the direct return.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
