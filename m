From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Add driver to fix Speedlink VAD Cezanne support
Date: Tue, 7 Jun 2011 16:00:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106071600280.22872@pobox.suse.cz>
References: <4DDFD3FD.2060808@stefankriwanek.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55971 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab1FGOAl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jun 2011 10:00:41 -0400
In-Reply-To: <4DDFD3FD.2060808@stefankriwanek.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Kriwanek <mail@stefankriwanek.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, 27 May 2011, Stefan Kriwanek wrote:

> Speedlink VAD Cezanne have a hardware bug that makes the cursor "jump" 
> from one place to another every now and then. The issue are relative 
> motion events erroneously reported by the device, each having a distance 
> value of +256. This 256 can in fact never occur due to real motion, 
> therefore those events can safely be ignored. The driver also drops 
> useless EV_REL events with a value of 0, that the device sends every 
> time it sends an "real" EV_REL or EV_KEY event.

Applied, thank you Stefan.

-- 
Jiri Kosina
SUSE Labs
