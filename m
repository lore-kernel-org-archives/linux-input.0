From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 4 Jun 2011 17:04:48 +0200
Message-ID: <BANLkTinu=AU4ro6HjF1JZnomsXwNkoz2hg@mail.gmail.com>
References: <4DE8FC4A.9010401@absence.it>
	<4DE8FFE0.5070506@absence.it>
	<20110604084338.GD7194@kamineko.org>
	<20110604124219.GA14809@srcf.ucam.org>
	<4DEA3FBD.8020602@absence.it>
	<20110604143012.GA16615@srcf.ucam.org>
	<4DEA4283.103@absence.it>
	<20110604143638.GA16747@srcf.ucam.org>
	<4DEA4450.80702@absence.it>
	<20110604144527.GA16911@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60542 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490Ab1FDPEu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 11:04:50 -0400
In-Reply-To: <20110604144527.GA16911@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Marco Chiappero <marco@absence.it>, Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sat, Jun 4, 2011 at 4:45 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sat, Jun 04, 2011 at 04:42:24PM +0200, Marco Chiappero wrote:
>
>> More precisely? As far as I know there is no ALS device class; and I
>> know nothing about the other.
>
> Where there's no generic implementation of a hardware class that's
> present in multiple pieces of hardware, the first step is to define a
> generic implementation :)

The last ALS device class attempt didn't went so well, what's the
current status for this one ?



-- 
Corentin Chary
http://xf.iksaif.net
