From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/9] HID: hid, make parsing event driven
Date: Wed, 14 May 2008 14:08:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805141407050.11363@jikos.suse.cz>
References: <1210536043-19812-1-git-send-email-jirislaby@gmail.com>
 <1210536043-19812-2-git-send-email-jirislaby@gmail.com>
 <1210536043-19812-3-git-send-email-jirislaby@gmail.com>
 <1210548050.16390.39.camel@violet.holtmann.net> <482AB23C.2090809@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:57388 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757468AbYENMIa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2008 08:08:30 -0400
In-Reply-To: <482AB23C.2090809@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>

On Wed, 14 May 2008, Jiri Slaby wrote:

> Not really. I was only to test non-hid path (i.e. input) of hidp 
> changes. This is why I want it in -mm/-next for some time. If you have 
> some (real) bluetooth HID devices, I would be glad if you could test it.

Hi,

I will of course test the patches (including testing with bluetooth HID 
hardware) before merging them.

Thanks,

-- 
Jiri Kosina
SUSE Labs
