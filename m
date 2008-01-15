From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: psmouse: fix potential input register race in
	psmouse_connect()
Date: Tue, 15 Jan 2008 16:48:18 -0500
Message-ID: <20080115164731.ZZRA012@mailhub.coreip.homeip.net>
References: <20080112151345.5d14c104@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:62443 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbYAOVs0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2008 16:48:26 -0500
Received: by py-out-1112.google.com with SMTP id u52so11587pyb.10
        for <linux-input@vger.kernel.org>; Tue, 15 Jan 2008 13:48:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080112151345.5d14c104@ephemeral>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: dtor@mail.ru, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, Jan 12, 2008 at 03:13:45PM -0500, Andres Salomon wrote:
> 
> If we successfully call input_register_device() in
> psmouse_connect but sysfs_create_group() fails, we'll enter the error
> path without ever having called input_unregister_device() (potentially
> leaking memory, or creating a race condition if something else attempts
> to access the new input device).  This calls input_unregister_device
> from the error path, and sets input_dev to NULL so that we don't
> attempt to also call input_free_device on it.
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>

Applied, thank you Andres.

-- 
Dmitry

