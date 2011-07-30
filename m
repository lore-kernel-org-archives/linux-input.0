From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys - Return proper error code
Date: Sat, 30 Jul 2011 12:08:29 -0700
Message-ID: <20110730190829.GE5686@core.coreip.homeip.net>
References: <1311757847-23132-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36084 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1G3TIe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 15:08:34 -0400
Received: by pzk37 with SMTP id 37so8462949pzk.1
        for <linux-input@vger.kernel.org>; Sat, 30 Jul 2011 12:08:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311757847-23132-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-input@vger.kernel.org

On Wed, Jul 27, 2011 at 11:10:47AM +0200, Tobias Klauser wrote:
> Return -ENOMEM if kzalloc fails in gpio_keys_get_devtree_pdata.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks Tobias.

-- 
Dmitry
