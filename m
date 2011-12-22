From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: signedness bug in cma3000_thread_irq()
Date: Thu, 22 Dec 2011 09:50:20 -0800
Message-ID: <20111222175020.GC21103@core.coreip.homeip.net>
References: <1323672566-16738-1-git-send-email-xi.wang@gmail.com>
 <12775.1323916035@turing-police.cc.vt.edu>
 <ECD4A42B-AC97-417B-99CA-3856B5DAFAC6@gmail.com>
 <3797.1323919260@turing-police.cc.vt.edu>
 <F920F5EE-FA61-4FFC-948C-97D6834823B6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63814 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab1LVRua (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Dec 2011 12:50:30 -0500
Content-Disposition: inline
In-Reply-To: <F920F5EE-FA61-4FFC-948C-97D6834823B6@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 15, 2011 at 05:17:02PM -0500, Xi Wang wrote:
> On Dec 14, 2011, at 10:21 PM, Valdis.Kletnieks@vt.edu wrote:
> > No, the variable that used to be a u8 - was it 8 bits wide for a reason?
> 
> The return value of CMA3000_READ?  I don't see any particular reason.  
> 

The data returned by CMA3000_READ() is a byte, so that's the reason (and
I am guessing here) that the author used u8 to store the result,
forgetting that the range was extended to report error conditions.

-- 
Dmitry
