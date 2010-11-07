From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] input: Introduce light-weight contact tracking
Date: Sun, 07 Nov 2010 15:44:48 -0500
Message-ID: <4CD70FC0.6060503@seas.upenn.edu>
References: <1289161108-32309-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:41927 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab0KGU7N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 15:59:13 -0500
In-Reply-To: <1289161108-32309-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Bagwell <chris@cnpbagwell.com>, Chase Douglas <chasedouglas@gmail.com>, Takashi Iwai <tiwai@suse.de>

On 11/07/2010 03:18 PM, Henrik Rydberg wrote:
 > Some kernel drivers demand the use of contact tracking for proper
 > filtering and pointer emulation. With one exception, these drivers
 > are limited to a maximum of four concurrent contacts. This patch adds
 > a simple matcher for up to four contacts, with these notable properties:

Tracking in the ntrig driver needs to support a minimum of 6 fingers.  I have 
also seen press releases claiming 10+ eventually.  I don't know if those devices 
will support tracking in the hardware/firmware.

Rafi
