From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: potential info leak in uiput_ff_upload_to_user()
Date: Fri, 23 Sep 2011 00:30:41 -0700
Message-ID: <20110923073041.GB613@core.coreip.homeip.net>
References: <20110923062240.GG4387@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63091 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab1IWHaq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Sep 2011 03:30:46 -0400
Content-Disposition: inline
In-Reply-To: <20110923062240.GG4387@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pingc@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, Aristeu Rozanski <aris@ruivo.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, Sep 23, 2011 at 09:22:40AM +0300, Dan Carpenter wrote:
> Smatch has a new check for Rosenberg type information leaks where
> structs are copied to the user with uninitialized stack data in them.
> 
> The issue here is that struct uinput_ff_upload_compat has a hole in
> it.
> 
> struct uinput_ff_upload_compat {
>         int                        request_id;           /*     0     4 */
>         int                        retval;               /*     4     4 */
>         struct ff_effect_compat    effect;               /*     8     0 */
> 
>         /* XXX 44 bytes hole, try to pack */
> 
>         struct ff_effect_compat    old;                  /*    52     0 */


44 bytes... doubtful...

Thanks.

-- 
Dmitry
