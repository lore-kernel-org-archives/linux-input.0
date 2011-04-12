From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] INPUT:Change a more clearly name for the input handlers'
 table
Date: Mon, 11 Apr 2011 23:24:16 -0700
Message-ID: <20110412062416.GE1854@core.coreip.homeip.net>
References: <1302265424-4434-1-git-send-email-wanlong.gao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34746 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab1DLGYV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 02:24:21 -0400
Content-Disposition: inline
In-Reply-To: <1302265424-4434-1-git-send-email-wanlong.gao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: wanlong.gao@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 08, 2011 at 08:23:44PM +0800, wanlong.gao@gmail.com wrote:
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Change the input handlers' table name to input_handler_table for
> making more clearly sense .
> 

Sorry but I think the old name is fine. I'd rather see this table
removed altogether and character devices pushed down into input handlers
themselves.

Thanks.

-- 
Dmitry
