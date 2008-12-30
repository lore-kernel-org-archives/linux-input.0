From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: 2.6.28 thinks that my PS/2 mouse is a touchpad
Date: Tue, 30 Dec 2008 11:03:35 +0500
Message-ID: <4959B9B7.2050800@gmail.com>
References: <gj4r8h$okm$1@ger.gmane.org> <20081229185619.GA18394@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:7708 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYL3GEb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Dec 2008 01:04:31 -0500
In-Reply-To: <20081229185619.GA18394@adopmeer.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Arjan Opmeer wrote:
> On Sat, Dec 27, 2008 at 02:06:29PM +0500, Alexander E. Patrakov wrote:
>> elantech.c: Elantech version query result 0x00, 0x01, 0x64.
>> elantech.c: assuming hardware version 1, firmware version 0.100
>> elantech.c: Synaptics capabilities query result 0x00, 0x02, 0x64.
> 
> However, all version query results I have seen from Elantech touchpads have
> a non-zero first byte and a zero second byte. So we could test for that to
> prevent this mouse from being detected as a touchpad.
> 
> Dmitry, do you think something like this is sufficient?
> 
> --- elantech.c.ORIG	2008-12-29 19:35:01.000000000 +0100
> +++ elantech.c.NEW	2008-12-29 19:38:59.000000000 +0100
> @@ -618,6 +618,10 @@ int elantech_init(struct psmouse *psmous
>  	}
>  	pr_info("elantech.c: Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
>  		param[0], param[1], param[2]);
> +	if (param[0] == 0 || param[1] != 0) {
> +		pr_info("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
> +		goto init_fail;
> +	}
>  	etd->fw_version_maj = param[0];
>  	etd->fw_version_min = param[2];

This is still slightly wrong. The mouse does work, but is misnamed in 
the dmesg output and in /proc/bus/input/devices:

psmouse serio1: ID: 10 00 64<6>elantech.c: Elantech version query result 
0x00, 0x01, 0x64.
elantech.c: Probably not a real Elantech touchpad. Aborting.
input: ImExPS/2 Elantech Touchpad as /class/input/input8

I: Bus=0011 Vendor=0002 Product=0006 Version=0000
N: Name="ImExPS/2 Elantech Touchpad"
P: Phys=isa0060/serio1/input0
S: Sysfs=/class/input/input8
U: Uniq=
H: Handlers=mouse1 event6
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=143

-- 
Alexander E. Patrakov
