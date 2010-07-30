From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 0/9 v3] IR: few fixes, additions and ENE driver
Date: Fri, 30 Jul 2010 16:33:06 -0300
Message-ID: <4C5328F2.8040404@redhat.com>
References: <1280489933-20865-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1280489933-20865-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

Em 30-07-2010 08:38, Maxim Levitsky escreveu:
> Hi,
> 
> This is mostly same patchset.
> 
> I addressed the comments of Andy Walls.
> 
> Now IR decoding is done by a separate thread, and this fixes
> the race, and unnesesary performance loss due to it.
> 
> Best regards,
> 	Maxim Levitsky
> 

Hmm... some change at this changeset is trying to divide a 64 bits integer
at the LIRC driver. This is causing the following error:

Jul 30 16:45:23 agua kernel: [23834.179871] lirc_dev: IR Remote Control driver registered, major 251 
Jul 30 16:45:23 agua kernel: [23834.181884] ir_lirc_codec: Unknown symbol __udivdi3 (err 0)

you should, instead use do_div for doing that. Another fix would be to define the timeout
constants as int or u32.

Cheers,
Mauro
