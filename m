From: Oliver Neukum <oliver@neukum.org>
Subject: Re: usbhid control queue full, due to stuck control request
Date: Fri, 12 Feb 2010 12:59:08 +0100
Message-ID: <201002121259.08146.oliver@neukum.org>
References: <20100206172051.GA22311@spacedout.fries.net> <201002120835.36908.oliver@neukum.org> <alpine.LNX.2.00.1002121256500.30967@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:54392 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405Ab0BLL7J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 06:59:09 -0500
In-Reply-To: <alpine.LNX.2.00.1002121256500.30967@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Fries <david@fries.net>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Am Freitag, 12. Februar 2010 12:57:11 schrieb Jiri Kosina:
> On Fri, 12 Feb 2010, Oliver Neukum wrote:
> 
> > > Oliver Neukum, this is based on your patch, do you agree with the
> > > changes?
> > 
> > I do agree.
> 
> Thanks a lot guys for tracking this down and fixing it. I have applied the 
> patch.

This being a fix for broken hardware it should go into stable, too.
Would you forward it?

	Regards
		Oliver
