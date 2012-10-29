From: "Patil, Rachna" <rachna@ti.com>
Subject: RE: [PATCH 0/3] input: ti_am335x_tsc: Remove hard coded values and
 add variance filter logic
Date: Mon, 29 Oct 2012 08:53:39 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E964DA1@DBDE01.ent.ti.com>
References: <1350900918-17130-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47877 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758063Ab2J2Ixw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Oct 2012 04:53:52 -0400
In-Reply-To: <1350900918-17130-1-git-send-email-rachna@ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

Hi Dmitry,

This is just a gentle reminder for the patch set I had submitted viz.
"[PATCH 0/3] input: ti_am335x_tsc: Remove hard coded values and add variance filter logic"
This patch set does not break anything existing and just enhances the driver.
Can you please pull in if there are no comments.

Thanks & Regards,
Rachna.

On Mon, Oct 22, 2012 at 15:45:15, Patil, Rachna wrote:
> Step configuration enable and the order in which touchscreen expects positive / negative terminals to be connected to analog inputs lines was hard coded.
> Now the user can provide platform data to represent the same.
> 
> Also only fine tuning variance in tslib utility to remove ADC noise does not help. Hence adding logic to eliminate ADC noise and unwanted random signals.
> 
> This patch set is dependent on [1] and has been tested on AM335x EVM.
> 
> [1] Subject: [PATCH RESEND 0/8] TI Touchscreen driver updates and Support for TSC/ADC MFD driver
> (http://www.spinics.net/lists/linux-input/msg22976.html)
> 
> Patil, Rachna (3):
>   input: ti_am335x_tsc: Make steps enable configurable
>   input: ti_am335x_tsc: Order of TSC wires connect, made configurable
>   input: ti_am335x_tsc: Add variance filters
> 
>  drivers/input/touchscreen/ti_am335x_tsc.c |  181 ++++++++++++++++++++++++++---
>  include/linux/input/ti_am335x_tsc.h       |   12 ++
>  include/linux/mfd/ti_am335x_tscadc.h      |   11 +-
>  3 files changed, 181 insertions(+), 23 deletions(-)
> 
> 

