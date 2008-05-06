From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] fix apple alu keyboard with numpad
Date: Wed, 7 May 2008 00:43:07 +0100
Message-ID: <20080506234307.GA27714@srcf.ucam.org>
References: <4814612F.5030606@bakke.com> <20080506125406.dc047710.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:41292 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1760018AbYEFXnW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2008 19:43:22 -0400
Content-Disposition: inline
In-Reply-To: <20080506125406.dc047710.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dag Bakke <dag@bakke.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Diego 'Flameeyes' Petteno <flameeyes@gmail.com>

On Tue, May 06, 2008 at 12:54:06PM -0700, Andrew Morton wrote:

> > -static int hid_apple_fnmode = 1;
> > +static int hid_apple_fnmode = 2;

Regardless of anything else, we don't want this hunk.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
