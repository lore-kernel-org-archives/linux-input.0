From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [GIT PULL RFC] directly poll battery strength when reading
 power_supply
Date: Tue, 6 Dec 2011 10:17:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1112061016020.18207@pobox.suse.cz>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
 <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org> <alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz> <CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com> <4ED90E6D.8090402@goop.org>
 <CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com> <4ED9BDF8.3010600@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56489 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901Ab1LFJRU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Dec 2011 04:17:20 -0500
In-Reply-To: <4ED9BDF8.3010600@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>

On Fri, 2 Dec 2011, Jeremy Fitzhardinge wrote:

> This series of patches includes Daniel's patch to directly poll for the battery strength rather than
> hoping the device will happen to send it, along with some cleanup patches from me.
> 
> The only functional change I made from Daniel's patch is keeping the 
> power_supply type as BATTERY rather than USB.
> 
> 	J
> 
> The following changes since commit 1b2bdc70c10f9bf1455ea76a558261d7431b533c:
> 
>   hid-input: add support for HID devices reporting Battery Strength (2011-11-23 00:38:25 -0800)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git hid-battery
> 
> Daniel Nicoletti (1):
>       hid-input: add support for HID devices reporting Battery Strength
> 
> Jeremy Fitzhardinge (7):
>       hid-input: fix compile for !HID_BATTERY_STRENGTH
>       hid-input/battery: remove apparently redundant kmalloc
>       hid-input/battery: add quirks for battery
>       hid-input/battery: deal with both FEATURE and INPUT report batteries
>       hid-input/battery: make the battery setup common for INPUTs and FEATUREs
>       hid-input/battery: power-supply type really *is* a battery
>       hid-input/battery: remove battery_val

I actually like the series. The only objection I'd have is that Daniel's 
patch is not properly Signed-off-by:, and therefore I am not pulling it 
now.

Thanks in advance,

-- 
Jiri Kosina
SUSE Labs
