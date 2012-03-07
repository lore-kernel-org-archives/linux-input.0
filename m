From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: altera_ps2: Store struct serio in struct ps2if
Date: Wed, 7 Mar 2012 09:25:24 -0800
Message-ID: <20120307172523.GA29568@core.coreip.homeip.net>
References: <1331127864-7667-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58935 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab2CGRZd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 12:25:33 -0500
Received: by iagz16 with SMTP id z16so8892195iag.19
        for <linux-input@vger.kernel.org>; Wed, 07 Mar 2012 09:25:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1331127864-7667-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-input@vger.kernel.org

Hi Tobias,

On Wed, Mar 07, 2012 at 02:44:24PM +0100, Tobias Klauser wrote:
> It doesn't make much sense to allocate struct ps2if and struct serio
> separately as they're allocated and used in conjunction.
> 

Actually, it does. Serio is a refcounted structure and has different
lifetime rules than struct ps2if. It may get deleted by
serio_unregister_port() or it may live on until after ps2if is freed and
altera_ps2 module is unloaded and it should stay allocated separately.

> Also ps2if->io wasn't freed in altera_ps2_remove() even tough it should
> have been and thus caused a memory leak. This is also (implicitely)
> fixed by this change.

No, there was't a memory leak as serio core takes care of freeing the
object when refrerence count reaches 0.

Thanks.

-- 
Dmitry
