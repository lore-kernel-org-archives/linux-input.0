From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Fri, 9 Jan 2009 22:01:44 +0000
Message-ID: <20090109220144.6b99ed72@lxorguk.ukuu.org.uk>
References: <20090107005813.GA4987@const.famille.thibault.fr>
	<20090109212358.GG5073@const.famille.thibault.fr>
	<20090109213555.7f9275c9@lxorguk.ukuu.org.uk>
	<20090109214357.GH5073@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40100 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754128AbZAIWCS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2009 17:02:18 -0500
In-Reply-To: <20090109214357.GH5073@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

> > Surely that is just a new keymap ?
> 
> No. That would mean a lot of keymapSSS. Doing it the keymap way

Why - its an  algorithmic question about how to edit them - remember you
can edit keymaps in programs at runtime and live.

> This really is a problem that is orthogonal to keymaps: I'm here talking
> about _physical_ keys remapping, not remapping what is printed on them
> (which is done after that).

Ok so this is analogous to the X key remapping. In which case a notifier
seems as sane as any other way to perform the action if you want it to be
an add on loadable feature.
