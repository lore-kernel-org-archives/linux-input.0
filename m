From: Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sun, 05 Jun 2011 22:13:03 +0200
Message-ID: <4DEBE34F.7030705@absence.it>
References: <4DE8FC4A.9010401@absence.it>	<4DE8FFE0.5070506@absence.it>	<20110604084338.GD7194@kamineko.org>	<20110604124219.GA14809@srcf.ucam.org>	<4DEA3FBD.8020602@absence.it>	<20110604143012.GA16615@srcf.ucam.org>	<4DEA4283.103@absence.it>	<20110604143638.GA16747@srcf.ucam.org>	<4DEA4450.80702@absence.it>	<20110604212249.568e76b6@lxorguk.ukuu.org.uk>	<4DEBC156.1030503@absence.it> <20110605201417.5acfab3e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110605201417.5acfab3e@lxorguk.ukuu.org.uk>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Il 05/06/2011 21:14, Alan Cox ha scritto:
>> that many different implementation are present across different models
>> or brands. We need a solution, now,
>
> We needed a solution last year nothing has changed there other than there
> are now a bazillion more out of tree drivers.
>
> I don't have a solution I just wanted to make sure you understood the
> problem space.

Sure, I was rather expecting a reply from Matthew about what to do now, 
since there is no "rule" to follow regarding the ALS support and it's a 
pity not to support hardware we can make 100% working. But at this point 
perhaps we'd better discuss only on the platform driver mailing list.

Marco
