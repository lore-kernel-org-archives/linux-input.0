From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] Input - Move KEY_{EURO, DOLLAR} to lower keycodes
Date: Fri, 30 May 2008 22:55:35 +0100
Message-ID: <200805302255.35901.carlos@strangeworlds.co.uk>
References: <200711161341.58696.carlos@strangeworlds.co.uk> <200805302039.03881.carlos@strangeworlds.co.uk> <20080530202856.GA20935@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:36152 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbYE3V4E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 May 2008 17:56:04 -0400
In-Reply-To: <20080530202856.GA20935@anvil.corenet.prv>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Friday 30 May 2008 21:28:57 Dmitry Torokhov wrote:
> Argh, forgot all about it, terribly sorry. How about the patch below?

Works fine here.

> Input: atkbd - use ushort instead of uchar keymap
>
> Since some of the keycodes defined in input.h have values greater
> than 255 we should use unsigned shorts in keymaps.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Tested-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
