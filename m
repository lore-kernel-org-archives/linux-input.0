From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: TMDC Joystick no longer works in kernel 2.6.28
Date: Wed, 14 Jan 2009 00:27:57 -0800
Message-ID: <20090114002757.6ef66074.akpm@linux-foundation.org>
References: <200901101553.40515.andy@asjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43109 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756292AbZANI2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 03:28:07 -0500
In-Reply-To: <200901101553.40515.andy@asjohnson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Andrew S. Johnson" <andy@asjohnson.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

(cc linux-input)

On Sat, 10 Jan 2009 15:53:40 -0600 "Andrew S. Johnson" <andy@asjohnson.com> wrote:

> Up through kernel version 2.6.27.9 I have had no problems with
> my joystick on the game port.  Now with 2.6.28, the game port
> is recognized when the gameport and ns558 modules load, but
> loading the tmdc module doesn't also automatically load joydev,
> and even loading joydev manually doesn't give me a working
> joystick.  There are no error messages in dmesg, /var/log/messages, 
> or /var/log/syslog.  This is on Slackware 12.1, so I don't think
> it's a distro issue.  Do I need to do something different than
> in the past to make it work, or is there some debug I can turn
> on to give more info?
> 

If this doesn't get resolved with a few days, please raise a report at
bugzilla.kernel.org, so that we can not fix it in a more organised
fashion, thanks.

