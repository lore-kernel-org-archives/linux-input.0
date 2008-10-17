From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Revert "HID: Invert HWHEEL mappings for some Logitech
 mice"
Date: Fri, 17 Oct 2008 11:26:37 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810171125090.28536@jikos.suse.cz>
References: <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz> <1224219974-4216-1-git-send-email-dbn.lists@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:46702 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752683AbYJQJ0i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Oct 2008 05:26:38 -0400
In-Reply-To: <1224219974-4216-1-git-send-email-dbn.lists@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Nicholson <dbn.lists@gmail.com>
Cc: Ander Conselvan de Oliveira <ander@c3sl.ufpr.br>, linux-input@vger.kernel.org, stable@kernel.org

On Thu, 16 Oct 2008, Dan Nicholson wrote:

> This reverts commit 740f370dc61dc478d891d7d47660bb3ae39ddb4f.
> 
> It turned out to be correct in the first place: a positive value should
> be sent when the wheel is moved to the right, and a negative value when
> moved to the left. This is the behavior expected by the Xorg evdev
> driver. I must have had a remapping somewhere else in my system when
> originally testing this. Testing on another system shows that the
> unpatched kernel is correct.

Hi Dan,

thanks. Still I'd like to understand what caused the behavior you were 
seeing. Do you still have the system showing the inverted values 
available?

-- 
Jiri Kosina
SUSE Labs
