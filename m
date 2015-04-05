From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 9/16] HID: logitech-hidpp: fix error return code
Date: Sun, 5 Apr 2015 22:57:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504052257220.843@pobox.suse.cz>
References: <1428235596-4757-1-git-send-email-Julia.Lawall@lip6.fr> <1428235596-4757-10-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1428235596-4757-10-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 5 Apr 2015, Julia Lawall wrote:

> Return a negative error code on failure.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier ret; expression e1,e2;
> @@
> (
> if (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to for-4.1/logitech, thanks.

-- 
Jiri Kosina
SUSE Labs
