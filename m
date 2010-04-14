From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 13:52:44 +0100
Message-ID: <20100414125244.GC10075@srcf.ucam.org>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz> <20100414123643.GB9242@srcf.ucam.org> <alpine.LNX.2.00.1004141437340.8345@pobox.suse.cz> <20100414135350.3b1643c2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39360 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab0DNMwt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 08:52:49 -0400
Content-Disposition: inline
In-Reply-To: <20100414135350.3b1643c2@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 01:53:50PM +0100, Alan Cox wrote:

> It's not really that unlikely that an AUX handling bug exists and only on
> one BIOS version given we've seen things as neat as i8042 emulation that
> only works on CPU #0 8)

Doubtless, but on the other hand these machines work with versions of 
Windows that were released well before them, so if there's a difference 
in behaviour then we have a bug regardless of what the spec says.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
