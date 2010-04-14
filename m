From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 13:44:18 +0100
Message-ID: <20100414124418.GB9881@srcf.ucam.org>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz> <20100414123643.GB9242@srcf.ucam.org> <alpine.LNX.2.00.1004141437340.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47794 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab0DNMoV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 08:44:21 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1004141437340.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 02:41:11PM +0200, Jiri Kosina wrote:

> Sending AUX_LOOP is valid thing to do with i8042 controller. If it causes 
> such confusion that the controller doesn't function properly any more, 
> it's clearly broken.

Does Windows send AUX_LOOP? If so, why does it not break the device? If 
not, how does it obtain the same level of functionality?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
