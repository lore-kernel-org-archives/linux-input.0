From: Andy Ross <andy.ross@windriver.com>
Subject: Re: [PATCH 1/2] input: Pegatron Lucid accelerometer
Date: Tue, 18 Jan 2011 09:21:31 -0800
Message-ID: <4D35CC1B.3020808@windriver.com>
References: <1295287011-12849-1-git-send-email-andy.ross@windriver.com> <1295287011-12849-2-git-send-email-andy.ross@windriver.com> <4D3529A1.1030804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from li44-10.members.linode.com ([72.14.181.10]:55127 "EHLO
	plausible.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab1ARRVe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Jan 2011 12:21:34 -0500
In-Reply-To: <4D3529A1.1030804@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On 01/17/2011 09:48 PM, Shubhrajyoti wrote:
> Could you explain why a polling is needed. Is no irq line connected.

It's just an ACPI method interface, so no dedicated IRQ certainly.
The firmware does issue ACPI events on coarse orientation changes
(i.e. which edge is up) that we're catching with acpid, so there's no
reason this needs to poll all the time in typical usage.

Andy


