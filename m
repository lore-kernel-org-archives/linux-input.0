From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH 0/8 V6] Many fixes for in-kernel decoding and for the
 ENE driver
Date: Fri, 15 Oct 2010 12:27:09 -0300
Message-ID: <4CB872CD.4050700@infradead.org>
References: <1287155273-16171-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60782 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083Ab0JOP1m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 11:27:42 -0400
In-Reply-To: <1287155273-16171-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

Em 15-10-2010 12:07, Maxim Levitsky escreveu:
> Hi,
> 
> This is mostly a resend of my patches, although
> I fixed few bugs in the ENE code.
> This exact patchset was tested against ENE devices with all
> features tested.

I've applied most of the patches from your original series.

The pending ones are:

Sep, 6 2010: [7/8] IR: extend ir_raw_event and do refactoring                       lmml_159431_7_8_ir_extend_ir_raw_event_and_do_refactoring.patch        Maxim Levitsky <maximlevitsky@gmail.com>
Sep, 6 2010: [8/8] IR: ene_ir: add support for carrier reports                      lmml_159451_8_8_ir_ene_ir_add_support_for_carrier_reports.patch        Maxim Levitsky <maximlevitsky@gmail.com>

So, this series as-is will probably not apply anymore.

Could you please rebase it against staging/v2.6.37? 

I'll mark the two above as superseed and wait for your update.

Thanks,
Mauro
