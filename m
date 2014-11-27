From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: wacom: Consult the application usage when
 determining field type
Date: Thu, 27 Nov 2014 14:45:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411271445410.23174@pobox.suse.cz>
References: <1416871934-14133-1-git-send-email-killertofu@gmail.com> <1416871934-14133-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37324 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbaK0Nph (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Nov 2014 08:45:37 -0500
In-Reply-To: <1416871934-14133-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, pinglinux@gmail.com

On Mon, 24 Nov 2014, Jason Gerecke wrote:

> It is not necessarily sufficient to look only at the physical and logical
> usages when determining if a field is for the pen or touch. Some fields
> are not contained in a sub-collection and thus only have an application
> usage. Not checking the application usage in such cases causes us to
> ignore the field entirely, which may lead to incorrect behavior.
> 
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Applied.

-- 
Jiri Kosina
SUSE Labs
