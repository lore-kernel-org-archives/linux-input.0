From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 4 Jun 2011 15:36:38 +0100
Message-ID: <20110604143638.GA16747@srcf.ucam.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE8FFE0.5070506@absence.it>
 <20110604084338.GD7194@kamineko.org>
 <20110604124219.GA14809@srcf.ucam.org>
 <4DEA3FBD.8020602@absence.it>
 <20110604143012.GA16615@srcf.ucam.org>
 <4DEA4283.103@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43602 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab1FDOgp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 10:36:45 -0400
Content-Disposition: inline
In-Reply-To: <4DEA4283.103@absence.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sat, Jun 04, 2011 at 04:34:43PM +0200, Marco Chiappero wrote:

> Ok, fine. So, should we forward any event (als events, shock
> protection, hybrid GFX, etc.) to the input core then?

als events and shock protection probably ought to be uevents on the 
appropriate device. Hybrid graphics requests probably ought to be input 
events, but we'll probably want to talk to the graphics people about 
that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
