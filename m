From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add NOGET quirk for AXIS 295 Video Surveillance
 Joystick
Date: Fri, 1 Oct 2010 15:28:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010011528170.29535@pobox.suse.cz>
References: <1285881870-5184-1-git-send-email-rok.mandeljc@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51701 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0JAN2b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 09:28:31 -0400
In-Reply-To: <1285881870-5184-1-git-send-email-rok.mandeljc@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rok Mandeljc <rok.mandeljc@gmail.com>
Cc: chatty@enac.fr, cascardo@holoscopio.com, don@syst.com.br, peter.hutterer@who-t.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 30 Sep 2010, Rok Mandeljc wrote:

> This patch adds the NOGET quirk for AXIS 295 Video Surveillance Joystick 
> (despite AXIS brand the vendor is actually CH Products). Without the 
> quirk, the joystick is detected but does not generate any events.
> 
> Signed-off-by: Rok Mandeljc <rok.mandeljc@gmail.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
