From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND] [PATCH] Input: add appleir USB driver
Date: Thu, 30 Sep 2010 08:47:41 -0700
Message-ID: <201009300847.43090.dmitry.torokhov@gmail.com>
References: <1285844276.26405.26.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61735 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab0I3Prz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Sep 2010 11:47:55 -0400
In-Reply-To: <1285844276.26405.26.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>

Bastien,

On Thursday, September 30, 2010 03:57:55 am Bastien Nocera wrote:
> This driver was originally written by James McKenzie, updated by
> Greg Kroah-Hartman, further updated by myself, with suspend support
> added.
> 
> More recent versions of the IR receiver are also supported through
> a patch by Alex Karpenko. The patch also adds support for the 2nd
> and 5th generation of the controller, and the menu key on newer
> brushed metal remotes.
> 
> Tested on a MacbookAir1,1
> 

There are no changes from the last time you sent it, right? I'll try
to get the driver in .37 but after that we should probably move it
over to the new IR infrastructure...

Thanks.

-- 
Dmitry
