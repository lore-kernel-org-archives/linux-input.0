From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG] hidraw.c: double mutex_lock
Date: Mon, 12 Oct 2009 11:25:13 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0910121124110.19284@wotan.suse.de>
References: <1255353109.13239.0@pamir>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35721 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755327AbZJLJZu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 05:25:50 -0400
In-Reply-To: <1255353109.13239.0@pamir>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: iceberg <iceberg@ispras.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 12 Oct 2009, iceberg wrote:

> 	KERNEL_VERSION: 2.6.31
> 	DESCRIBE:
> 	In driver ./drivers/hid/hidraw.c in function hidraw_read may be 
> double mutex_lock:
> 
> Path:
> 1. line 50: begin first iteration of "while(ret==0)"
> 2. line 52: first call to mutex_lock
> 3. inner loop "while (list->head == list->tail)" does not change state 
> of mutex, because mutex_lock immediatelly follows mutex_unlock
> 4. if we go to the second iteration of "while(ret == 0)" in 
> line 50 then there are second call to mutex_lock in line 52 (mutex 
> aquired twice).
> 
> Second iteration of loop "while(ret==0)" is possible if local variable 
> ret is not changed at line 94: ret+=len - i.e. len==0;
> Variable len may be zero if hidraw_read is called with count==0 or 
> list->buffer[list->tail].len == 0.

Good catch. I will fix that up by moving the mutex_lock() so that it's 
locked before the loop is entered.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
