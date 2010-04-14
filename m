From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 09:04:31 -0700
Message-ID: <20100414160429.GC2450@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59198 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab0DNQEq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 12:04:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Jiri,

On Wed, Apr 14, 2010 at 02:16:25PM +0200, Jiri Kosina wrote:
> Add HP Compaq 2710p to 'noloop' table. Otherwsie this machine is reported 
> to not report properly to AUX_LOOP command time-to-time, causing 
> non-working keyboard due to messed up i8042.
> 

What is the chassis type for the box in DMI? I am curious why it isn't
caought up by the generic "portable" test...

Thanks.

-- 
Dmitry
