From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sun, 5 Jun 2011 20:14:17 +0100
Message-ID: <20110605201417.5acfab3e@lxorguk.ukuu.org.uk>
References: <4DE8FC4A.9010401@absence.it>
	<4DE8FFE0.5070506@absence.it>
	<20110604084338.GD7194@kamineko.org>
	<20110604124219.GA14809@srcf.ucam.org>
	<4DEA3FBD.8020602@absence.it>
	<20110604143012.GA16615@srcf.ucam.org>
	<4DEA4283.103@absence.it>
	<20110604143638.GA16747@srcf.ucam.org>
	<4DEA4450.80702@absence.it>
	<20110604212249.568e76b6@lxorguk.ukuu.org.uk>
	<4DEBC156.1030503@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4DEBC156.1030503@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> that many different implementation are present across different models 
> or brands. We need a solution, now,

We needed a solution last year nothing has changed there other than there
are now a bazillion more out of tree drivers.

I don't have a solution I just wanted to make sure you understood the
problem space. Personally I think the right solution is for someone who
has infinite time to point out the mess and cluebat Linus, I don't have
time for that.

Alan
