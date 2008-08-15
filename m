From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input/keyboard: add uctional power management
	support to Blackfin BF54x keypad driver
Date: Fri, 15 Aug 2008 15:03:23 -0400
Message-ID: <20080815150301.ZZRA012@mailhub.coreip.homeip.net>
References: <1218790959-12694-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:44419 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758080AbYHOTD1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2008 15:03:27 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1163965wri.5
        for <linux-input@vger.kernel.org>; Fri, 15 Aug 2008 12:03:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218790959-12694-1-git-send-email-cooloney@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

On Fri, Aug 15, 2008 at 05:02:39PM +0800, Bryan Wu wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Fix Bug: does nor properply resume after suspend mem
> Fix for PM_SUSPEND_MEM: Save and restore peripheral base registers
> 

Applied to 'next', thank you.

-- 
Dmitry
