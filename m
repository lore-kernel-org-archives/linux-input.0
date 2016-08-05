From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: input: add mic mute key on HP slim keyboard
Date: Fri, 5 Aug 2016 13:31:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608051330540.22028@cbobk.fhfr.pm>
References: <1470277580-5517-1-git-send-email-acelan.kao@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38682 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759623AbcHELbG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Aug 2016 07:31:06 -0400
In-Reply-To: <1470277580-5517-1-git-send-email-acelan.kao@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Thu, 4 Aug 2016, AceLan Kao wrote:

> Add MIC mute key which is found on HP Business Slim Keyboard
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 23 Spd=1.5 MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=03f0 ProdID=2f4a Rev=00.10
> S:  Manufacturer=Chicony
> S:  Product=HP Business Slim Keyboard
> C:  #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
> I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>

Applied to for-4.8/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

