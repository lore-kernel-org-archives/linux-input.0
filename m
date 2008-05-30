From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] Input - Move KEY_{EURO, DOLLAR} to lower keycodes
Date: Fri, 30 May 2008 20:39:03 +0100
Message-ID: <200805302039.03881.carlos@strangeworlds.co.uk>
References: <200711161341.58696.carlos@strangeworlds.co.uk> <200711161349.02657.carlos@strangeworlds.co.uk> <200712111928.44935.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:36514 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYE3UIj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 May 2008 16:08:39 -0400
In-Reply-To: <200712111928.44935.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tuesday 11 December 2007 19:28:44 Carlos Corbacho wrote:
> On Friday 16 November 2007 13:49:02 Carlos Corbacho wrote:
> > On Friday 16 November 2007 13:47:23 Dmitry Torokhov wrote:
> > > They should stay where they were. We need to change atkbd to use
> > > ushorts in keymaps. I have a patch for it, I'll forward it to you
> > > today or tomorrow.
> >
> > Even better - cheers :)
>
> Any news on this yet?

Dmitry,

Any progress on this front, or are there other problems with this change that 
need to be fixed first?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
