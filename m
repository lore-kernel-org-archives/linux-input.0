From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Lost ps/2 input in 3.2.5 (aka PCI: Rework ASPM disable code)
Date: Thu, 23 Feb 2012 17:02:33 +0000
Message-ID: <20120223170233.GA4328@srcf.ucam.org>
References: <4F4540E6.2020708@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39106 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2BWRC4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 12:02:56 -0500
Content-Disposition: inline
In-Reply-To: <4F4540E6.2020708@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: stable <stable@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, "jirisl >> Jiri Slaby" <jirislaby@gmail.com>

Well, bother. Can you give lspci -vvv before and after the patch, along 
with dmesg?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
