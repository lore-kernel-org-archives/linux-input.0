From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: hid-input: default HID_BATTERY_STRENGTH to no
Date: Wed, 18 Apr 2012 15:08:54 +0100
Message-ID: <1334758134.8818.132.camel@novo.hadess.net>
References: <20120418140517.GM19507@zod.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44068 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2DROI7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 10:08:59 -0400
In-Reply-To: <20120418140517.GM19507@zod.bos.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Boyer <jwboyer@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org, Richard Hughes <richard@hughsie.com>

On Wed, 2012-04-18 at 10:05 -0400, Josh Boyer wrote:
> Commit 4f5ca836b "HID: hid-input: add support for HID devices reporting
> Battery Strength" added the CONFIG_HID_BATTERY_STRENGTH option to report
> the battery strength of HID devices.  The commit log explicitly mentions
> it not working properly with recent userspace, but it is default y
> anyway.  This is rather odd, and actually causes problems on real
> systems.
> 
> This works around Fedora bug
> https://bugzilla.redhat.com/show_bug.cgi?id=806295

Don't. The only bit of user-space that's broken is upower, and it's
getting a fixed release shortly.

Richard?

