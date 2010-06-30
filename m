From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 09:57:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006300956370.13809@pobox.suse.cz>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com> <4C2A1FA0.6020704@signal11.us> <AANLkTimpF7h-L-qaR-YCBKwr2xRfkOQwQIXKAZDcdDA0@mail.gmail.com> <AANLkTikzQ93oJc0-TYuAmiYnq-UaNqOW6H80Cg449gS6@mail.gmail.com>
 <AANLkTimeMlK_nciq_dQ0i1VA13KyKfIgC0JYYdQynV20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58810 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab0F3H5m (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 03:57:42 -0400
In-Reply-To: <AANLkTimeMlK_nciq_dQ0i1VA13KyKfIgC0JYYdQynV20@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: Alan Ott <alan@signal11.us>, Xiaofan Chen <xiaofanc@gmail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On Wed, 30 Jun 2010, Amit Nagal wrote:

> 1)
> 
>  it seems no documentation is available in the linux kernel regarding
> hidraw interface usage .
> it should be available like the hiddev interface file hiddev.txt .
> (though  on browising over net i do find hidraw.txt , but it shud be
> there in linux kernel documentation ) .

Alan has written nice documentation which I am going to merge soon. I am 
just waiting for Bluetooth bits to settle down, which is a little bit 
challenging with Bluetooth maintainer having been irresponsive for several 
months apparently. But it's definitely targeted for next merge window.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
