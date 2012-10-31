From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Input: introduce managed input devices (add devres
 support)
Date: Wed, 31 Oct 2012 14:38:59 -0700
Message-ID: <20121031213859.GB2945@htj.dyndns.org>
References: <20121023053513.GA15642@core.coreip.homeip.net>
 <20121031210532.GX2945@htj.dyndns.org>
 <5132958.JXBGbd4rj1@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58395 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386Ab2JaVjE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 17:39:04 -0400
Content-Disposition: inline
In-Reply-To: <5132958.JXBGbd4rj1@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Dmitry.

On Wed, Oct 31, 2012 at 02:37:01PM -0700, Dmitry Torokhov wrote:
> Not all drivers use devres for rest of their resources so it makes sense
> to have unmanaged versions (like we have request_irq/devm_request_irq).
> Besides:
> 
> [dtor@dtor-ws vmci]$ grep -r input_allocate_device drivers/ | wc -l
> 298
> 
> so I'd rather not ;)

Whee... didn't know there were that many.

Thanks.

-- 
tejun
