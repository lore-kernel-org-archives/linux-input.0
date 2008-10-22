From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/4] HID: add hid_type
Date: Wed, 22 Oct 2008 15:02:42 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810221502180.27479@jikos.suse.cz>
References: <1224624363-16471-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:47004 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751638AbYJVNCn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Oct 2008 09:02:43 -0400
In-Reply-To: <1224624363-16471-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Noonan <steven@uplinklabs.net>, Justin Mattock <justinmattock@gmail.com>, Sven Anders <anders@anduras.de>, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org

On Tue, 21 Oct 2008, Jiri Slaby wrote:

> Add type to the hid structure to distinguish to which device type
> (now only mouse) we are talking to. Needed for per device type ignore
> list support.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
