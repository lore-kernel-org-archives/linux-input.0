From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 8/9] IR: Add ENE input driver.
Date: Wed, 28 Jul 2010 20:13:35 +0300
Message-ID: <1280337215.6590.1.camel@maxim-laptop>
References: <1280330051-27732-1-git-send-email-maximlevitsky@gmail.com>
	 <1280330051-27732-9-git-send-email-maximlevitsky@gmail.com>
	 <4C506472.3080506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60371 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab0G1RNq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jul 2010 13:13:46 -0400
In-Reply-To: <4C506472.3080506@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Wed, 2010-07-28 at 14:10 -0300, Mauro Carvalho Chehab wrote: 
> Em 28-07-2010 12:14, Maxim Levitsky escreveu:
> > Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> 
> Please, instead of patch 9/9, do a patch moving ENE driver from staging into 
> drivers/media/IR, and then a patch porting it into rc-core. This will allow us
> to better understand what were done to convert it to rc-core, being an example
> for others that may work on porting the other drivers to rc-core.

The version in staging is outdated.
Should I first update it, and then move?

Best regards,
Maxim Levitsky

