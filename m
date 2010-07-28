From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 8/9] IR: Add ENE input driver.
Date: Wed, 28 Jul 2010 14:10:10 -0300
Message-ID: <4C506472.3080506@redhat.com>
References: <1280330051-27732-1-git-send-email-maximlevitsky@gmail.com> <1280330051-27732-9-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1280330051-27732-9-git-send-email-maximlevitsky@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Em 28-07-2010 12:14, Maxim Levitsky escreveu:
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>

Please, instead of patch 9/9, do a patch moving ENE driver from staging into 
drivers/media/IR, and then a patch porting it into rc-core. This will allow us
to better understand what were done to convert it to rc-core, being an example
for others that may work on porting the other drivers to rc-core.

Cheers,
Mauro.
