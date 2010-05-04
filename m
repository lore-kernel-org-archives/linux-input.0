From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: mt: Simplify event bypass logic
Date: Mon, 3 May 2010 23:49:05 -0700
Message-ID: <20100504064905.GB17482@core.coreip.homeip.net>
References: <1272721779-2124-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f202.google.com ([209.85.223.202]:57624 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab0EDGtQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 May 2010 02:49:16 -0400
Content-Disposition: inline
In-Reply-To: <1272721779-2124-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 01, 2010 at 03:49:39PM +0200, Henrik Rydberg wrote:
> The input bypass mechanism is only used by the MT events. Since all
> MT events use bypassing by construction, the current list is a mere
> duplication of input.h. This patch replaces the bypass list by a
> simple range test.
> 

Henrik,

I disagree with the patch. I can not guarantee that we will be able to
maintain continuous range of ABS_MT_* events and thus current scheme is
more flexible.

Thanks.

-- 
Dmitry
