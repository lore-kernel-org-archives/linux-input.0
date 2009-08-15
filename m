From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [patch 0/2] Winbond IR Driver - v2
Date: Sat, 15 Aug 2009 06:02:27 +0300
Message-ID: <1250305347.18122.4.camel@maxim-laptop>
References: <20090809095645.198777507@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:2413 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbZHODCd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Aug 2009 23:02:33 -0400
In-Reply-To: <20090809095645.198777507@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: david@hardeman.nu
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, randy.dunlap@oracle.com

On Sun, 2009-08-09 at 11:56 +0200, david@hardeman.nu wrote:
> Here's a new patch set which should replace all the patches currently in the
> -mm tree for the winbond cir driver. The new series incorporate feedback from
> Bjorn Helgaas (convert the driver from ACPI to PNP) and Randy Dunlap (Kconfig
> fixes).
> 
> The IR decoding can still be improved but the driver works for in daily use
> decoding RC6 commands, so I believe it is ready to go upstream.
> 

Hi.

As I understand, this hardware returns sampled IR signal, so it can be
used with any remote, right?

Then why not to implement lirc driver?

This driver as I understand is a driver for single remote shipped with
the notebook.

I have recently wrote a lirc driver for  my receiver, a lirc driver. Now
I can use all my remotes.

And no, I don't need any software support for that. LIRC happily
forwards all events via uinput to kernel, so I use it a an ordinary
keyboard.

Best regards,
	Maxim Levitsky

