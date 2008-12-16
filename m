From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: avoid sparse warning in HID_COMPAT_LOAD_DRIVER
Date: Tue, 16 Dec 2008 14:35:16 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812161434150.21089@jikos.suse.cz>
References: <4947a48f.08b6660a.34ca.ffffa1e8@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:58735 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753038AbYLPNfR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2008 08:35:17 -0500
In-Reply-To: <4947a48f.08b6660a.34ca.ffffa1e8@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tue, 16 Dec 2008, Hannes Eder wrote:

> Impact: include a prototype for the exported function in the macro
> 
> Fix about 20 of this warnings:
> 
>   drivers/hid/hid-a4tech.c:162:1: warning: symbol 'hid_compat_a4tech' was not declared. Should it be static?
> 
> Signed-off-by: Hannes Eder <hannes@hanneseder.net>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
