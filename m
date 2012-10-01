From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4] HID: Add support for Sony PS3 BD Remote Control
Date: Mon, 1 Oct 2012 10:12:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210011012200.27440@pobox.suse.cz>
References: <1348584182.27596.28.camel@frustration.ornl.gov> <1348606947-3055-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48403 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab2JAIMo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Oct 2012 04:12:44 -0400
In-Reply-To: <1348606947-3055-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: David Dillow <dave@thedillows.org>, linux-bluetooth@vger.kernel.org, David Herrmann <dh.herrmann@googlemail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

On Tue, 25 Sep 2012, Antonio Ospite wrote:

> From: David Dillow <dave@thedillows.org>
> 
> The Sony PS3 Blue-ray Disc Remote Control used to be supported by the
> BlueZ project's user space, but the code that handled it was recently
> removed as its functionality conflicted with a real HSP implementation
> and the mapping was thought to be better handled in the kernel. This is
> a port of the mapping logic from the fakehid driver by Marcel Holtmann
> to the in-kernel HID layer.
> 
> We also add support for the Logitech Harmony Adapter for PS3, which
> emulates the BD Remote.
> 
> Signed-off-by: David Dillow <dave@thedillows.org>
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
