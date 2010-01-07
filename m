From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/7] Input: wacom - Get features from driver info
Date: Thu, 7 Jan 2010 11:39:50 -0800
Message-ID: <201001071139.50766.dmitry.torokhov@gmail.com>
References: <20100107182553.GA11236@wavehammer.waldi.eu.org> <201001071106.31688.dmitry.torokhov@gmail.com> <20100107192105.GA15015@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53488 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab0AGTkG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 14:40:06 -0500
In-Reply-To: <20100107192105.GA15015@wavehammer.waldi.eu.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastian Blank <waldi@debian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Thursday 07 January 2010 11:21:05 am Bastian Blank wrote:
> On Thu, Jan 07, 2010 at 11:06:30AM -0800, Dmitry Torokhov wrote:
> > On Thursday 07 January 2010 10:29:36 am Bastian Blank wrote:
> > > +	struct wacom_features *features = (void *)id->driver_info;
> >
> > What is this cast for?
> 
> driver_info is an integer.
> 
> > > +	if (!features)
> > > +		features = get_wacom_feature(id);
> >
> > In which cases driver would not have driver_info set up?
> 
> At this stage in the patchset, non have. Later the driver defined ids
> have, the user defined have not.
> 

Ah, OK.  Frankly I would fold patches 2-7 into one since it is one logical 
change. While you are at it, any chance of constifying wacom_features?

Thanks.

-- 
Dmitry
