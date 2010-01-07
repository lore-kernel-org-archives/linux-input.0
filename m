From: Bastian Blank <waldi@debian.org>
Subject: Re: [PATCH 7/7] Input: wacom - Fail on missing features
Date: Thu, 7 Jan 2010 20:21:33 +0100
Message-ID: <20100107192133.GB15015@wavehammer.waldi.eu.org>
References: <20100107182553.GA11236@wavehammer.waldi.eu.org> <20100107183009.GA13036@wavehammer.waldi.eu.org> <201001071108.38253.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:39231 "EHLO
	wavehammer.waldi.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab0AGTVe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 14:21:34 -0500
Content-Disposition: inline
In-Reply-To: <201001071108.38253.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Thu, Jan 07, 2010 at 11:08:38AM -0800, Dmitry Torokhov wrote:
> On Thursday 07 January 2010 10:30:09 am Bastian Blank wrote:
> > +	if (!features)
> > +		return -EIO;
> -EINVAL is probably better.

Yes, that is what I was trying to find.

Bastian

-- 
There's a way out of any cage.
		-- Captain Christopher Pike, "The Menagerie" ("The Cage"),
		   stardate unknown.
