From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: usbhid control queue full, due to stuck control request
Date: Fri, 12 Feb 2010 12:57:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002121256500.30967@pobox.suse.cz>
References: <20100206172051.GA22311@spacedout.fries.net> <alpine.LRH.2.00.1002111617290.16183@twin.jikos.cz> <20100212004910.GD22311@spacedout.fries.net> <201002120835.36908.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45373 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243Ab0BLL5N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 06:57:13 -0500
In-Reply-To: <201002120835.36908.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: David Fries <david@fries.net>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 12 Feb 2010, Oliver Neukum wrote:

> > Oliver Neukum, this is based on your patch, do you agree with the
> > changes?
> 
> I do agree.

Thanks a lot guys for tracking this down and fixing it. I have applied the 
patch.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
