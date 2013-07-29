From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] atkbd: Fix key release for Fn keys on Samsung series
 5 ultra 540UC
Date: Sun, 28 Jul 2013 21:49:09 -0700
Message-ID: <20130729044909.GA8539@core.coreip.homeip.net>
References: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37334 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab3G2EtM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jul 2013 00:49:12 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so445319pbb.5
        for <linux-input@vger.kernel.org>; Sun, 28 Jul 2013 21:49:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: linux-input@vger.kernel.org

Hi Mauro,


On Mon, Jul 29, 2013 at 12:59:35AM -0300, Mauro Carvalho Chehab wrote:
> Samsung series 5 ultra notebooks don't produce release events for certain
> keys (Fn+F1, Fn+F11, Fn+F12 and Fn Lock). Add those keys at the release
> fixup table.
> 

As I mentioned, the force release should be handled by udev instead of
adding kernel driver quirk.

Thanks.

-- 
Dmitry
