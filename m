From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 22:12:31 +0100
Message-ID: <20111010211231.GA26359@srcf.ucam.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com>
 <20111010210534.GA2223@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60202 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab1JJVMd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 17:12:33 -0400
Content-Disposition: inline
In-Reply-To: <20111010210534.GA2223@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dtor@mail.ru

On Mon, Oct 10, 2011 at 11:05:34PM +0200, Henrik Rydberg wrote:

> With this patch, autosuspend seems to work correctly after boot, while
> keeping a device file open. When all device files are closed, the
> looping suspend/resume behavior is still there. Moreover, when coming
> back from a user suspend, rpm_suspend fails with EBUSY on my machine,
> and the device will not autosuspend thereafter.

Is this with the patch I sent for usbhid earlier applied? Right now the 
keyboard will fail to suspend after system suspend, which will keep the 
entire composite device awake. I'm looking into your other issue now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
