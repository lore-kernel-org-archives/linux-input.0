From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils
 ?
Date: Mon, 24 Jan 2011 23:13:05 -0500
Message-ID: <4D3E4DD1.60705@teksavvy.com>
References: <4D3C5F73.2050408@teksavvy.com> <20110124175456.GA17855@core.coreip.homeip.net> <4D3E1A08.5060303@teksavvy.com> <20110125005555.GA18338@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:55193 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752186Ab1AYENJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 23:13:09 -0500
In-Reply-To: <20110125005555.GA18338@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On 11-01-24 07:55 PM, Dmitry Torokhov wrote:
>
> No, as far as I know we kept ABI intact.


Okay, I hacked lsinput and input-kbd to ignore the protocol number.
input-kbd is still broken: it thinks my remote control (Hauppauge)
has only ten buttons, and won't allow me to remap codes larger than 10.

I've now hacked around that too, but without determining exactly
where the interface got broken.

Ugh.

Thanks.
