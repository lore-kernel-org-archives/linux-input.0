From: Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 04 Jun 2011 16:34:43 +0200
Message-ID: <4DEA4283.103@absence.it>
References: <4DE8FC4A.9010401@absence.it> <4DE8FFE0.5070506@absence.it> <20110604084338.GD7194@kamineko.org> <20110604124219.GA14809@srcf.ucam.org> <4DEA3FBD.8020602@absence.it> <20110604143012.GA16615@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aa013-1msr.fastwebnet.it ([62.101.93.133]:60803 "EHLO
	aa013-1msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368Ab1FDOes (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 10:34:48 -0400
In-Reply-To: <20110604143012.GA16615@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Il 04/06/2011 16:30, Matthew Garrett ha scritto:
> No acpi notification at all. There's no good way for userspace to make
> use of them without knowing the hardware they're running on, which is
> far from ideal.

Ok, fine. So, should we forward any event (als events, shock protection, 
hybrid GFX, etc.) to the input core then?

