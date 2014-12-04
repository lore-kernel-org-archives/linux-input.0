From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v12 02/19] input: cyapa: add device resource management
 infrastructure support
Date: Thu, 4 Dec 2014 09:43:11 -0800
Message-ID: <20141204174311.GA4806@dtor-ws>
References: <1417599025-21681-1-git-send-email-dudley.dulixin@gmail.com>
 <1417599025-21681-3-git-send-email-dudley.dulixin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63277 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344AbaLDRnQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Dec 2014 12:43:16 -0500
Content-Disposition: inline
In-Reply-To: <1417599025-21681-3-git-send-email-dudley.dulixin@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudley.dulixin@gmail.com>
Cc: rydberg@euromail.se, bleung@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 03, 2014 at 05:30:08PM +0800, Dudley Du wrote:
> Remove cyapa_remove() method, add cyapa_open() and cyapa_close() methods for
> input interface, also modified together with driver's memory and IRQ resource
> allocations to support device resource management infrastructure to reduce
> the mistakes of resource management.
> TEST=test on Chromebooks.
> 
> Signed-off-by: Dudley Du <dudley.dulixin@gmail.com>

OK, so this patch (in slightly modified form) has already been applied,
so you can drop it from the next respin.

Thanks.

-- 
Dmitry
