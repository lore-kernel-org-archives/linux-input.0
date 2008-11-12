From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [patch]fix memleak in error case of hiddev
Date: Wed, 12 Nov 2008 16:11:11 +0100
Message-ID: <491AF20F.3040908@gmail.com>
References: <200810311031.39083.oliver@neukum.org> <200810311610.11604.oliver@neukum.org> <alpine.LNX.1.10.0811121547400.32143@jikos.suse.cz> <200811121555.48488.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:7686 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbYKLPLR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 10:11:17 -0500
Received: by ey-out-2122.google.com with SMTP id 6so187698eyi.37
        for <linux-input@vger.kernel.org>; Wed, 12 Nov 2008 07:11:15 -0800 (PST)
In-Reply-To: <200811121555.48488.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 11/12/2008 03:55 PM, Oliver Neukum wrote:
> Am Mittwoch, 12. November 2008 15:48:38 schrieb Jiri Kosina:
>> +	if (!list->hiddev->open++) {
>> +		if (list->hiddev->exist) {
> 
> The order of checks is inverted. If the device no longer exists
> opening should fail, even if the device is already opened.
> Didn't I post a patch that does this? My memory is a bit clouded.

This is very old (and broken) version of the patch. I remember I already
commented some issues contained in this one and you did fix them later ;).
