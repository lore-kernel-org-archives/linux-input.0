From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] add antec-branded soundgraph imon devices to
 hid_ignore_list
Date: Wed, 28 Jan 2009 21:24:18 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901282123520.5377@jikos.suse.cz>
References: <200901281049.28799.jarod@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:40703 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751885AbZA1UYU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 15:24:20 -0500
In-Reply-To: <200901281049.28799.jarod@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input@vger.kernel.org

On Wed, 28 Jan 2009, Jarod Wilson wrote:

> hid_ignore_list additions for the Antec-branded SoundGraph iMon VFD and LCD
> devices (0x15c2:0x0044 and 0x0045).

lirc is capable of handling these as well, right?

Thanks for the patch Jarod,

-- 
Jiri Kosina
SUSE Labs
