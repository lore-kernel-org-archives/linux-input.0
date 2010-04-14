From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 14:35:50 +0100
Message-ID: <20100414143550.75def636@lxorguk.ukuu.org.uk>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz>
	<20100414123643.GB9242@srcf.ucam.org>
	<alpine.LNX.2.00.1004141437340.8345@pobox.suse.cz>
	<20100414135350.3b1643c2@lxorguk.ukuu.org.uk>
	<20100414125244.GC10075@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49494 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755440Ab0DNNb5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 09:31:57 -0400
In-Reply-To: <20100414125244.GC10075@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 14 Apr 2010 13:52:44 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, Apr 14, 2010 at 01:53:50PM +0100, Alan Cox wrote:
> 
> > It's not really that unlikely that an AUX handling bug exists and only on
> > one BIOS version given we've seen things as neat as i8042 emulation that
> > only works on CPU #0 8)
> 
> Doubtless, but on the other hand these machines work with versions of 
> Windows that were released well before them, so if there's a difference 
> in behaviour then we have a bug regardless of what the spec says.

I think in this case you are in cloud cuckoo land. Windows doesn't
autoprobe all these mouse types, and some years of careful
experimentation seems to indicate the best you can do is select which
devices break without blacklists.

