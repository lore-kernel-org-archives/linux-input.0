From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add HID's to hid-microsoft driver of Surface Type/Touch
 Cover 2 to fix bug
Date: Tue, 21 Jan 2014 07:47:58 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1401210747120.12934@twin.jikos.cz>
References: <CA+BWVUTkaUt8Ys_40r7zFV_wBtY7iWTTmUUL+bHj=e3NwAtgNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37527 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbaAUGsG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jan 2014 01:48:06 -0500
In-Reply-To: <CA+BWVUTkaUt8Ys_40r7zFV_wBtY7iWTTmUUL+bHj=e3NwAtgNg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 20 Jan 2014, Reyad Attiyat wrote:

> The below patch fixes a bug 64811
> (https://bugzilla.kernel.org/show_bug.cgi?id=64811) of the Microsoft
> Surface Type/Touch cover 2 devices being detected as a multitouch
> device.
> The fix adds the HID of the two devices to hid-microsoft driver. This
> ensures that hid-input will eventually be used for the device and not
> hid-multitouch.

Hi,

your patch is missing hid_have_special_driver[] entry, therefore correct 
driver binding is not guaranteed.

-- 
Jiri Kosina
SUSE Labs

