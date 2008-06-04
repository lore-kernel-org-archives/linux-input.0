From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 09/10] HID: add compat support
Date: Wed, 4 Jun 2008 10:55:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806041054460.10085@jikos.suse.cz>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-2-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-3-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-4-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-5-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-6-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-7-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-8-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-9-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:48936 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752292AbYFDIzq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Jun 2008 04:55:46 -0400
In-Reply-To: <1210931362-18422-9-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com

On Fri, 16 May 2008, Jiri Slaby wrote:

> Add compat option to hid code to allow loading of all modules on
> systems which don't allow autoloading because of old userspace.
[ ... ]
> +config HID_COMPAT
> +	bool "Load all HID drivers on hid core load"
> +	---help---
> +	Compatible option for older userspace. If you have system without udev
> +	support of module loading through aliases and also old
> +	module-init-tools which can't handle hid bus, choose Y here. Otherwise
> +	say N. If you say N and your userspace is old enough, the only
> +	functionality you loose is modules autoloading.
> +
> +	If unsure, say N.
> +

Hi Jiri,

shouldn't we leave this default to 'Y' for quite some time?

Thanks,

-- 
Jiri Kosina
SUSE Labs
