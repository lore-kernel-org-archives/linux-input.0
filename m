From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] ili210x: Add support for Ilitek ILI210x based
 touchscreens
Date: Wed, 7 Mar 2012 08:00:28 +0100
Message-ID: <20120307070027.GA29010@hposo>
References: <20120306135852.GB28206@hposo>
 <1331046093-22160-1-git-send-email-olivier@sobrie.be>
 <20120306155113.GA29723@polaris.bitmath.org>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44669 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2CGHAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 02:00:36 -0500
Received: by eaaq12 with SMTP id q12so2096234eaa.19
        for <linux-input@vger.kernel.org>; Tue, 06 Mar 2012 23:00:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120306155113.GA29723@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>

Hi Henrik,

On Tue, Mar 06, 2012 at 04:51:13PM +0100, Henrik Rydberg wrote:
> Apart from the comments, this looks all good to me.
> 
>     Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
> 
> Thanks.
> Henrik

Argh, sorry for the spinlock I forget to remove...
I send a patch right now with the two fixes.

Thanks a lot for your help !

-- 
Olivier Sobrie
