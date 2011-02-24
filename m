From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: which driver to choose for a GPIO connected switch
Date: Thu, 24 Feb 2011 11:26:21 +0100
Message-ID: <87ipw9u3si.fsf@tac.ki.iif.hu>
References: <201102240958.38401.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:52913 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571Ab1BXK0Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Feb 2011 05:26:24 -0500
In-Reply-To: <201102240958.38401.alexander.stein@systec-electronic.com>
	(Alexander Stein's message of "Thu, 24 Feb 2011 09:58:38 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-input@vger.kernel.org

Alexander Stein <alexander.stein@systec-electronic.com> writes:

> I'm just wondering which existing input driver I can choose to use an GPIO 
> connected switch. The switch I'm talking about is connected via 3 
> (interruptable) GPIOs and those GPIOs can be inverted.

Hi,

How is the switch connected to the three GPIO inputs?

> I think gpio-keys is wrong as they will generate events on each state change.
> Note: The switch is likely to bounce

The gpio-keys driver has debouncing support.

> and the current GPIO state might be invalid (all 3 GPIOs are 0).

Why is this state invalid?

> I also think gpio-keys can't make sure only one switch state is currently 
> present. So I may get a current state 1 on 2 or more GPIOs which is obviously 
> wrong.

Sorry, I don't understand this.

> My use case is the userspace polls the current switch state if it needs to 
> know.

EVIOCGKEY or EVIOCGSW ioctl, perhaps?  You can make it three keys or
switches in the driver, and put the validation logic into user space...

> Do you have any suggestions which driver to use or even write?

Maybe it's just me, but I think you'd better give a clearer description
of your problem to get useful suggestions.
-- 
Regards,
Feri.
