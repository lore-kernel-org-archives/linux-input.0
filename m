From: Matthew Garrett <mjg@redhat.com>
Subject: Re: suspend / hibernate nomenclature
Date: Sat, 7 Mar 2009 15:48:42 +0000
Message-ID: <20090307154842.GA3947@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34622 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbZCGPsr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Mar 2009 10:48:47 -0500
Content-Disposition: inline
In-Reply-To: <1235992429.3858.58.camel@hughsie-work.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Mon, Mar 02, 2009 at 11:13:49AM +0000, Richard Hughes wrote:

> After reviewing the platform drivers in ACPI, it appears few of them
> know whether KEY_SLEEP corresponds to suspend or hibernate, and
> KEY_SUSPEND seems to be used for hibernate. Basically, it's a mess.

KEY_SUSPEND has always been pretty clearly used for hibernate for, well, 
forever. I don't think the distinction is a useful one. How many 
machines are going to have both a sleep and a suspend key?

This is a user-visible change in behaviour. I think we're too entrenched 
for it to make much of a difference now. Adding a #define KEY_HIBERNATE 
KEY_SUSPEND sounds fine to me, but I really don't think we need anything 
more.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
