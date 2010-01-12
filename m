From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Support for Acer T230H multitouch panel
Date: Tue, 12 Jan 2010 14:29:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001121428280.30977@pobox.suse.cz>
References: <20100110195805.D573F951DC@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34040 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573Ab0ALN32 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2010 08:29:28 -0500
In-Reply-To: <20100110195805.D573F951DC@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: chatty@enac.fr, linux-input@vger.kernel.org, berthiec@gmail.com, jerom3@free.fr, dmitry.torokhov@gmail.com

On Sun, 10 Jan 2010, Stephane Chatty wrote:

> Added support for the Acer T230H multitouch panel.
> 
> Signed-off-by: Stephane Chatty <chatty@enac.fr>
> Tested-by: Jerome Vidal <jerom3@free.fr>
> Tested-by: Cedric Berthier <berthiec@gmail.com>

[ ... snip ... ]

> +config HID_ACER
> +	tristate "ACER T230H" if EMBEDDED

Hi Stephane,

thanks for the driver. It looks fine, but I will also remove the 'if 
EMBEDDED' part in Kconfig as for other drivers, ok?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
