From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] HID: hid-input: default HID_BATTERY_STRENGTH to no
Date: Wed, 18 Apr 2012 18:20:50 +0100
Message-ID: <20120418172050.GA2651@srcf.ucam.org>
References: <20120418140517.GM19507@zod.bos.redhat.com>
 <1334758134.8818.132.camel@novo.hadess.net>
 <20120418141131.GN19507@zod.bos.redhat.com>
 <20120418142450.GA30083@srcf.ucam.org>
 <4F8EF601.1050804@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35111 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2DRRVB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 13:21:01 -0400
Content-Disposition: inline
In-Reply-To: <4F8EF601.1050804@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Josh Boyer <jwboyer@redhat.com>, Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org, Richard Hughes <richard@hughsie.com>

On Wed, Apr 18, 2012 at 10:12:33AM -0700, Jeremy Fitzhardinge wrote:
> Does upower trigger a shutdown/hibernation if *any* power supply is low,
> or just if all of them are?  Are the failing cases ones where the BT
> keyboard is the only visible power supply?

We're seeing shutdowns on desktop machines using bluetooth devices, yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
