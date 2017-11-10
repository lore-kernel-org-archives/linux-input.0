From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 2/5] platform/x86: intel-vbtn: Support separate
 press/release events
Date: Thu, 9 Nov 2017 17:34:17 -0800
Message-ID: <20171110013417.GB9783@fury>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
 <024c7574-12f2-4708-9f90-1192856df401@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40485 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755342AbdKJBeU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 20:34:20 -0500
Content-Disposition: inline
In-Reply-To: <024c7574-12f2-4708-9f90-1192856df401@rwthex-w2-a.rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org

On Thu, Nov 09, 2017 at 11:44:33PM +0100, Stefan Brüns wrote:
> Currently all key events use autorelease, but this forbids use as a
> modifier key.
> 
> As all event codes come in even/odd pairs, we can lookup the key type
> (KE_KEY/KE_IGNORE) for the key up event corresponding to the currently
> handled key down event. If the key up is ignored, we keep setting the
> autorelease flag for the key down.
> 

What is the use-case for using these buttons as modifiers? I'm picturing one of
these devices in tablet mode, with a physical Windows button. What other action
does a user want to modify by holding the Windows button down? Or is there
another scenario we're trying to support here?

-- 
Darren Hart
VMware Open Source Technology Center
