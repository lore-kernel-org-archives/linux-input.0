From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/7] HID: sony: Fix error handling bug when touchpad
 registration fails
Date: Mon, 19 Dec 2016 15:08:26 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191508200.19203@cbobk.fhfr.pm>
References: <1481252996-25288-1-git-send-email-roderick@gaikai.com> <1481252996-25288-2-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753882AbcLSOIa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 09:08:30 -0500
In-Reply-To: <1481252996-25288-2-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 8 Dec 2016, Roderick Colenbrander wrote:

> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> The error handling code in sony_input_configured in general uses goto
> based cleanup. Recently we migrated code from sony_probe to here, but
> we didn't update the existing touchpad registration code, which was
> already here to use the goto.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Applied to for-4.10/upstream-fixes

-- 
Jiri Kosina
SUSE Labs

