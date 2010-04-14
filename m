From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 14:38:01 +0100
Message-ID: <20100414133801.GA11142@srcf.ucam.org>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz> <20100414123643.GB9242@srcf.ucam.org> <alpine.LNX.2.00.1004141437340.8345@pobox.suse.cz> <20100414135350.3b1643c2@lxorguk.ukuu.org.uk> <20100414125244.GC10075@srcf.ucam.org> <20100414143550.75def636@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48046 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab0DNNiG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 09:38:06 -0400
Content-Disposition: inline
In-Reply-To: <20100414143550.75def636@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 02:35:50PM +0100, Alan Cox wrote:

> I think in this case you are in cloud cuckoo land. Windows doesn't
> autoprobe all these mouse types, and some years of careful
> experimentation seems to indicate the best you can do is select which
> devices break without blacklists.

Blacklists which have to vary based on BIOS version? It's pretty obvious 
that this doesn't scale.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
