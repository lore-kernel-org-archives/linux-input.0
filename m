From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Default keyboard LEDs
Date: Sun, 13 Jan 2008 19:50:34 -0800
Message-ID: <478ADC0A.7020006@zytor.com>
References: <20080114005219.GA4296@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41469 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbYANDuv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jan 2008 22:50:51 -0500
In-Reply-To: <20080114005219.GA4296@implementation>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> In many cases, one prefers to have e.g. the NumLock on by default.  In
> many cases, one doesn't want to have it by default, e.g. on laptops.
> 
> Distributions actually have a very hard time trying to set this
> correctly after the kernel boot, and that doesn't work for new consoles
> that are created via the openvt(1) command anyway. This hence adds a
> keyboard.default_leds boot parameter that permits to configure the
> default keyboard LEDs.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Actually, what would be perfect would be to use the configuration that
> the BIOS sets at boot by default.  That is device-dependent, however.
> 

It is, but it can be read out either by INT calls at initialization 
time, or by reading out the byte at physical address 0x417:

--------K-M00400017--------------------------
MEM 0040h:0017h - KEYBOARD - STATUS FLAGS 1
Size:   BYTE
SeeAlso: MEM 0040h:0018h,INT 16/AH=02h,MEM 0040h:0096h

Bitfields for keyboard status flags 1:
Bit(s)  Description     (Table M0010)
  7      INSert active
  6      Caps Lock active
  5      Num Lock active
  4      Scroll Lock active
  3      either Alt pressed
  2      either Ctrl pressed
  1      Left Shift pressed
  0      Right Shift pressed
SeeAlso: #M0011,#00587

The same information is available through INT 16h, AH=02h.

	-hpa
