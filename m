From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Introduce light-weight contact tracking
Date: Sun, 07 Nov 2010 21:50:57 +0100
Message-ID: <4CD71131.3080706@euromail.se>
References: <1289161108-32309-1-git-send-email-rydberg@euromail.se> <4CD70FC0.6060503@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:56531 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603Ab0KGUvi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Nov 2010 15:51:38 -0500
In-Reply-To: <4CD70FC0.6060503@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Bagwell <chris@cnpbagwell.com>, Chase Douglas <chasedouglas@gmail.com>, Takashi Iwai <tiwai@suse.de>

On 11/07/2010 09:44 PM, Rafi Rubin wrote:

> On 11/07/2010 03:18 PM, Henrik Rydberg wrote:
>> Some kernel drivers demand the use of contact tracking for proper
>> filtering and pointer emulation. With one exception, these drivers
>> are limited to a maximum of four concurrent contacts. This patch adds
>> a simple matcher for up to four contacts, with these notable properties:
> 
> Tracking in the ntrig driver needs to support a minimum of 6 fingers.  I have
> also seen press releases claiming 10+ eventually.  I don't know if those devices
> will support tracking in the hardware/firmware.


This is the exception I was talking about. The thing is, I can very well see a
driver supporting four fingers even if the device claims to support six. After
all, getting those four fingers working well will still be a big improvement.

Henrik
