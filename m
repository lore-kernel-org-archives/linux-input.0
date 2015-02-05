From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: soc_button_array - Use "Windows" key for "Home"
Date: Thu, 05 Feb 2015 14:36:21 +0100
Message-ID: <1423143381.14425.40.camel@hadess.net>
References: <1423143083.14425.34.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51076 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533AbbBENhf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 08:37:35 -0500
In-Reply-To: <1423143083.14425.34.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: lejun.zhu@linux.intel.com, linux-input@vger.kernel.org

On Thu, 2015-02-05 at 14:31 +0100, Bastien Nocera wrote:
> KEY_HOME is the key to go back to the beginning of the line, not
> the key to get into an overview mode, as Windows does. GNOME can already
> make use of the Windows key on multiple form factors, and other
> desktop environments can use it depending on the form factor.
> 
> Using "Windows" as the emitted key also means that the keycode sent out
> matches the symbol on the key itself.
> 
> So switch KEY_HOME to KEY_LEFTMETA ("Windows" key).

Disregard that one, I forgot the SoB...

