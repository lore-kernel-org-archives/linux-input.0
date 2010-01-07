From: Bastian Blank <waldi@debian.org>
Subject: Re: [PATCH 2/7] Input: wacom - Get features from driver info
Date: Thu, 7 Jan 2010 20:21:05 +0100
Message-ID: <20100107192105.GA15015@wavehammer.waldi.eu.org>
References: <20100107182553.GA11236@wavehammer.waldi.eu.org> <20100107182936.GA12913@wavehammer.waldi.eu.org> <201001071106.31688.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:39224 "EHLO
	wavehammer.waldi.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab0AGTVK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 14:21:10 -0500
Content-Disposition: inline
In-Reply-To: <201001071106.31688.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Thu, Jan 07, 2010 at 11:06:30AM -0800, Dmitry Torokhov wrote:
> On Thursday 07 January 2010 10:29:36 am Bastian Blank wrote:
> > +	struct wacom_features *features = (void *)id->driver_info;
> What is this cast for?

driver_info is an integer.

> > +	if (!features)
> > +		features = get_wacom_feature(id);
> In which cases driver would not have driver_info set up?

At this stage in the patchset, non have. Later the driver defined ids
have, the user defined have not.

Bastian

-- 
Bones: "The man's DEAD, Jim!"
