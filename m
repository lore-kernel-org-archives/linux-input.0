From: Colin Leitner <colin.leitner@googlemail.com>
Subject: Re: [PATCH] hid: driver for PS2/3 Buzz controllers
Date: Mon, 27 May 2013 19:15:58 +0200
Message-ID: <1369674958.30083.0.camel@roadrunner.fritz.box>
References: <1369587150.4240.4.camel@roadrunner.fritz.box>
	 <alpine.LNX.2.00.1305271628540.3914@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:52862 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3E0RQE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 13:16:04 -0400
In-Reply-To: <alpine.LNX.2.00.1305271628540.3914@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri,

> I this it'd actually make more sense to add this support to one of the two 
> existing drivers (*) we already have for Sony remote controllers -- either 
> hid-sony or hid-ps3remote both seem appropriate.
> 

I'll integrate the buzz code to hid-sony. Unfortunatly I can't test against
the six-axis controller as I don't own a Playstation.

Greetings,
	Colin


