From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH RFC V2 0/4] Add "scope" to power supplies
Date: Wed, 4 Jan 2012 09:11:39 +0400
Message-ID: <20120104051139.GA8081@oksana.dev.rtsoft.ru>
References: <cover.1323454016.git.jeremy@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33913 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab2ADFLp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jan 2012 00:11:45 -0500
Content-Disposition: inline
In-Reply-To: <cover.1323454016.git.jeremy@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Hughes <hughsient@gmail.com>, Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Fri, Dec 09, 2011 at 02:43:15PM -0800, Jeremy Fitzhardinge wrote:
> This series adds a "scope" attribute to power supplies, to indicate
> whether it powers the whole system ("System") or just some subset of
> the devices ("Device").  This allows upowerd to distinguish between
> system-wide power supplies and self-powered devices such as cordless
> mice.
> 
> This series also adds a "powers" link to power supplies, so that if
> they're scope=Device, they can specifically indicate which device
> tree they power.
> 
> Updates since last post:
>  - Add more complete documentation to scope and "powers" links
>  - Remove unnecessary scopes on System power supplies
>  - Make HID battery supplies Device, and add "powers" pointers
>    for them.
> 
> This can also be pulled from:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git power-supply-scope
> 
> Jeremy Fitzhardinge (4):
>   power_supply: add SCOPE attribute to power supplies
>   power_supply: allow a power supply to explicitly point to powered
>     device
>   power_supply: add scope properties to some self-powered HID devices
>   power_supply: add "powers" links to self-powered HID devices
> 
>  drivers/hid/hid-wacom.c            |   16 ++++++++++++++--
>  drivers/hid/hid-wiimote.c          |   10 +++++++++-
>  drivers/power/power_supply_core.c  |    7 +++++++
>  drivers/power/power_supply_sysfs.c |    6 ++++++
>  include/linux/power_supply.h       |    8 ++++++++
>  5 files changed, 44 insertions(+), 3 deletions(-)

Pulled into battery-2.6.git, thank you!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
