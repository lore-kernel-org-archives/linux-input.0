From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Fri, 9 Jan 2009 21:35:55 +0000
Message-ID: <20090109213555.7f9275c9@lxorguk.ukuu.org.uk>
References: <20090107005813.GA4987@const.famille.thibault.fr>
	<20090109212358.GG5073@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60851 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754760AbZAIVg3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2009 16:36:29 -0500
In-Reply-To: <20090109212358.GG5073@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Fri, 9 Jan 2009 22:23:58 +0100
Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> Hello,
> 
> Came somebody have a look at this?  The need is real, the only question
> that comes to my mind is whether notifiers are allowed to modify the
> param they are given.  Since they are not marked const, I'd guess it'd
> be ok?

The notifier code doesn't care.

> Make kbd_keycode() read param.value after calling the keyboard notification
> chain, to let the callee change the translation on the fly. This for instance
> permits to remap the physical positions of the keys independently of the
> configured keymap, for e.g. single-handed people.

Surely that is just a new keymap ?

